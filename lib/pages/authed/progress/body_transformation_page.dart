import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/cards/card.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/media/images/full_screen_image_gallery.dart';
import 'package:spotmefitness_ui/components/media/images/image_viewer.dart';
import 'package:spotmefitness_ui/components/media/images/sized_uploadcare_image.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:json_annotation/json_annotation.dart' as json;
import 'package:spotmefitness_ui/model/enum.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/services/uploadcare.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:uploadcare_flutter/uploadcare_flutter.dart';

class _SingleDayOfTransformPhotos {
  final DateTime date;
  final List<BodyTransformationPhoto> photos;
  _SingleDayOfTransformPhotos(this.date, this.photos);
}

class BodyTransformationPage extends StatefulWidget {
  const BodyTransformationPage({Key? key}) : super(key: key);

  @override
  _BodyTransformationPageState createState() => _BodyTransformationPageState();
}

class _BodyTransformationPageState extends State<BodyTransformationPage> {
  bool _processing = false;
  bool _deleteMode = false;
  List<BodyTransformationPhoto> _selectedTransformationPhotos = [];

  void _enterDeleteMode() {
    setState(() => _deleteMode = true);
  }

  void _exitDeleteMode() {
    setState(() {
      _selectedTransformationPhotos = [];
      _deleteMode = false;
    });
  }

  void _toggleSelectedBodyTransformationPhoto(
      BodyTransformationPhoto transformationPhoto) {
    setState(() => _selectedTransformationPhotos = _selectedTransformationPhotos
        .toggleItem<BodyTransformationPhoto>(transformationPhoto));
  }

  void _openPhotoViewer(List<BodyTransformationPhoto> photos) {
    final fileUris = photos
        .sortedBy<DateTime>((p) => p.takenOnDate)
        .reversed
        .map((p) => p.photoUri)
        .toList();

    context.push(
        child: Stack(
          children: [
            FullScreenImageGallery(
              fileUris,
              withTopNavBar: false,
            ),
            SafeArea(
              child: CupertinoButton(
                child: CircularBox(
                    padding: const EdgeInsets.all(10),
                    color: context.readTheme.primary,
                    child: Icon(
                      CupertinoIcons.arrow_left,
                      color: context.readTheme.background,
                    )),
                onPressed: () => context.pop(rootNavigator: true),
              ),
            )
          ],
        ),
        rootNavigator: true);
  }

  void _openImagePickerModal() => showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
            actions: [
              CupertinoActionSheetAction(
                child: MyText('From Camera'),
                onPressed: () async {
                  context.pop();
                  _pickImage(ImageSource.camera);
                },
              ),
              CupertinoActionSheetAction(
                child: MyText('From library'),
                onPressed: () {
                  context.pop();
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              child: MyText(
                'Cancel',
              ),
              onPressed: () {
                context.pop();
              },
            )),
      );

  Future<void> _pickImage(ImageSource source) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      File? croppedFile = await ImageCropper.cropImage(
        cropStyle: CropStyle.rectangle,
        sourcePath: pickedFile.path,
      );
      if (croppedFile != null) {
        try {
          setState(() => _processing = true);
          await _uploadFile(croppedFile);
          setState(() => _processing = false);
        } catch (e) {
          await context.showErrorAlert(e.toString());
        } finally {
          setState(() => _processing = false);
        }
      }
    }
  }

  Future<void> _uploadFile(File file) async {
    await GetIt.I<UploadcareService>().uploadFile(
        file: SharedFile(file),
        onComplete: (uri) {
          _resetState();
          _createBodyTranformationPhoto(uri);
        },
        onFail: (e) => throw new Exception(e));
  }

  Future<void> _createBodyTranformationPhoto(String uri) async {
    setState(() => _processing = true);
    final variables = CreateBodyTransformationPhotosArguments(data: [
      CreateBodyTransformationPhotoInput(
          takenOnDate: DateTime.now(), photoUri: uri)
    ]);

    final result = await context.graphQLStore.create(
        mutation: CreateBodyTransformationPhotosMutation(variables: variables),
        addRefToQueries: [BodyTransformationPhotosQuery().operationName]);

    setState(() => _processing = false);

    if (result.hasErrors || result.data == null) {
      context.showToast(
          message: 'Sorry, there was a problem saving the photo',
          toastType: ToastType.destructive);
    }
  }

  void _confirmDeletePhotos() {
    context.showConfirmDeleteDialog(
        itemType: 'Transformation Photos',
        message:
            'Delete ${_selectedTransformationPhotos.length} ${_selectedTransformationPhotos.length == 1 ? "photo" : "photos"}?',
        onConfirm: _deleteBodyTransformPhotosById);
  }

  Future<void> _deleteBodyTransformPhotosById() async {
    setState(() => _processing = true);

    final idsToDelete = _selectedTransformationPhotos.map((p) => p.id).toList();

    final variables =
        DeleteBodyTransformationPhotosByIdArguments(ids: idsToDelete);

    final result = await context.graphQLStore.deleteMultiple(
        mutation:
            DeleteBodyTransformationPhotosByIdMutation(variables: variables),
        removeRefsFromQueries: [BodyTransformationPhotosQuery().operationName],
        objectIds: idsToDelete,
        typename: kBodyTransformationPhotoTypename);

    setState(() => _processing = false);

    if (result.hasErrors || result.data == null) {
      context.showToast(
          message: 'Sorry, there was a problem deleting the photos',
          toastType: ToastType.destructive);
    } else {
      context.showToast(
        message:
            '${idsToDelete.length} ${idsToDelete.length == 1 ? "photo" : "photos"} deleted',
      );
      setState(() {
        _selectedTransformationPhotos = [];
      });
    }
  }

  void _resetState() => setState(() {
        _processing = false;
      });

  @override
  Widget build(BuildContext context) {
    return QueryObserver<BodyTransformationPhotos$Query, json.JsonSerializable>(
        key: Key(
            'BodyTransformationPage - ${BodyTransformationPhotosQuery().operationName}'),
        query: BodyTransformationPhotosQuery(),
        loadingIndicator: ShimmerListPage(),
        builder: (data) {
          final photosByDay = data.bodyTransformationPhotos.groupListsBy((p) =>
              DateTime(
                  p.takenOnDate.year, p.takenOnDate.month, p.takenOnDate.day));

          final sortedData = photosByDay.keys
              .sortedBy<DateTime>((k) => k)
              .reversed
              .map((k) => _SingleDayOfTransformPhotos(k, photosByDay[k]!))
              .toList();

          return MyPageScaffold(
              navigationBar: MyNavBar(
                key: Key('BodyTransformationPage - MyNavBar'),
                middle: NavBarTitle('Transformation'),
                trailing: NavBarTrailingRow(
                  children: [
                    CreateIconButton(onPressed: _openImagePickerModal),
                    InfoPopupButton(
                        infoWidget: MyText(
                            'Info about the body transformation feature')),
                  ],
                ),
              ),
              child: Column(
                children: [
                  if (_processing)
                    FadeIn(
                        child: Container(
                      height: 60,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          MyText('Working on it...'),
                          SizedBox(width: 8),
                          LoadingDots(
                            size: 14,
                          )
                        ],
                      ),
                    ))
                  else
                    FadeIn(
                      child: Container(
                        height: 60,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: _deleteMode
                            ? Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AnimatedSwitcher(
                                      duration: kStandardAnimationDuration,
                                      child: _selectedTransformationPhotos
                                              .isEmpty
                                          ? MyText(
                                              'Select photos to delete',
                                              subtext: true,
                                              size: FONTSIZE.SMALL,
                                            )
                                          : TextButton(
                                              text:
                                                  'Delete ${_selectedTransformationPhotos.length} ${_selectedTransformationPhotos.length == 1 ? "photo" : "photos"}',
                                              underline: false,
                                              destructive: true,
                                              onPressed: _confirmDeletePhotos),
                                    ),
                                    TextButton(
                                        text: 'Cancel',
                                        underline: false,
                                        onPressed: _exitDeleteMode)
                                  ],
                                ),
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  BorderButton(
                                      mini: true,
                                      withBorder: false,
                                      prefix: Icon(CupertinoIcons.fullscreen,
                                          size: 18),
                                      text: 'Viewer',
                                      onPressed: () => _openPhotoViewer(
                                          data.bodyTransformationPhotos)),
                                  CupertinoButton(
                                    onPressed: _enterDeleteMode,
                                    child: Icon(
                                      CupertinoIcons.delete,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  data.bodyTransformationPhotos.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(32),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  MyText('Not photos yet...'),
                                ],
                              ),
                              SizedBox(height: 20),
                              ContentBox(
                                child: BorderButton(
                                    withBorder: false,
                                    mini: true,
                                    prefix:
                                        Icon(CupertinoIcons.photo_on_rectangle),
                                    text: 'Add Your First Photo',
                                    onPressed: _openImagePickerModal),
                              ),
                            ],
                          ),
                        )
                      : Expanded(
                          child: _TimeLine(
                            sortedData: sortedData,
                            openImagePickerModal: _openImagePickerModal,
                            selectedTransformationPhotos:
                                _selectedTransformationPhotos,
                            toggleSelectedBodyTransformationPhoto:
                                _toggleSelectedBodyTransformationPhoto,
                            isDeleteMode: _deleteMode,
                          ),
                        ),
                ],
              ));
        });
  }
}

class _TimeLine extends StatelessWidget {
  final List<_SingleDayOfTransformPhotos> sortedData;
  final void Function() openImagePickerModal;

  final bool isDeleteMode;
  final List<BodyTransformationPhoto> selectedTransformationPhotos;
  final void Function(BodyTransformationPhoto transformationPhoto)
      toggleSelectedBodyTransformationPhoto;

  const _TimeLine(
      {Key? key,
      required this.sortedData,
      required this.openImagePickerModal,
      required this.selectedTransformationPhotos,
      required this.toggleSelectedBodyTransformationPhoto,
      required this.isDeleteMode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: sortedData.length,
        itemBuilder: (c, i) => TimelineTile(
              isFirst: i == 0,
              isLast: i == sortedData.length - 1,
              alignment: TimelineAlign.manual,
              lineXY: 0.1,
              indicatorStyle: IndicatorStyle(
                  padding: const EdgeInsets.all(8),
                  drawGap: true,
                  width: 60,
                  indicator: MyText(
                    sortedData[i].date.minimalDateStringYear,
                    size: FONTSIZE.SMALL,
                    weight: FontWeight.bold,
                    lineHeight: 1.3,
                  )),
              beforeLineStyle: LineStyle(
                  thickness: 2, color: context.theme.primary.withOpacity(0.7)),
              afterLineStyle: LineStyle(
                  thickness: 2, color: context.theme.primary.withOpacity(0.7)),
              endChild: Container(
                height: 140,
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: sortedData[i].photos.reversed.map((p) {
                    final isSelected = selectedTransformationPhotos.contains(p);
                    return GestureDetector(
                      onTap: isDeleteMode
                          ? () => toggleSelectedBodyTransformationPhoto(p)
                          : () =>
                              openFullScreenImageViewer(context, p.photoUri),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Card(
                          padding: const EdgeInsets.all(3),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(9),
                            child: Stack(
                              children: [
                                AnimatedOpacity(
                                  duration: kStandardAnimationDuration,
                                  opacity: isSelected ? 0.5 : 1.0,
                                  child: SizedUploadcareImage(
                                    p.photoUri,
                                    displaySize: Size(120, 120),
                                  ),
                                ),
                                if (isSelected)
                                  Positioned(
                                      bottom: 5,
                                      right: 5,
                                      child: FadeIn(
                                          child: Icon(
                                              CupertinoIcons.circle_fill,
                                              size: 30,
                                              color: Styles.white))),
                                if (isSelected)
                                  Positioned(
                                      bottom: 5,
                                      right: 5,
                                      child: FadeIn(
                                          child: Icon(
                                              CupertinoIcons
                                                  .checkmark_alt_circle,
                                              size: 30,
                                              color: Styles.errorRed))),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ));
  }
}
