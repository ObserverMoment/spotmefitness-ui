import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/cards/card.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/media/images/full_screen_image_gallery.dart';
import 'package:spotmefitness_ui/components/media/images/sized_uploadcare_image.dart';
import 'package:spotmefitness_ui/components/text.dart';
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
  /// TODO!!!
  bool _uploading = false;

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
          setState(() => _uploading = true);
          await _uploadFile(croppedFile);
          setState(() => _uploading = false);
        } catch (e) {
          await context.showErrorAlert(e.toString());
        } finally {
          setState(() => _uploading = false);
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
    setState(() => _uploading = true);
    final variables = CreateBodyTransformationPhotosArguments(data: [
      CreateBodyTransformationPhotoInput(
          takenOnDate: DateTime.now(), photoUri: uri)
    ]);

    final result = await context.graphQLStore.create(
        mutation: CreateBodyTransformationPhotosMutation(variables: variables),
        addRefToQueries: [BodyTransformationPhotosQuery().operationName]);

    setState(() => _uploading = false);

    if (result.hasErrors || result.data == null) {
      context.showToast(
          message: 'Sorry, there was a problem saving the photo',
          toastType: ToastType.destructive);
    }
  }

  void _resetState() => setState(() {
        _uploading = false;
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

          return CupertinoPageScaffold(
              navigationBar: BorderlessNavBar(
                key: Key('BodyTransformationPage - BorderlessNavBar'),
                middle: NavBarTitle('Body Transformation'),
                trailing: InfoPopupButton(
                    infoWidget:
                        MyText('Info about the body transformation feature')),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: MyText(
                            'Timeline',
                            weight: FontWeight.bold,
                          ),
                        ),
                        BorderButton(
                            mini: true,
                            prefix: Icon(CupertinoIcons.fullscreen, size: 20),
                            text: 'Photo Viewer',
                            onPressed: () =>
                                _openPhotoViewer(data.bodyTransformationPhotos))
                      ],
                    ),
                  ),
                  Expanded(
                    child: _TimeLine(
                        sortedData: sortedData,
                        openImagePickerModal: _openImagePickerModal),
                  ),
                ],
              ));
        });
  }
}

class _TimeLine extends StatelessWidget {
  final List<_SingleDayOfTransformPhotos> sortedData;
  final void Function() openImagePickerModal;
  const _TimeLine(
      {Key? key, required this.sortedData, required this.openImagePickerModal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StackAndFloatingButton(
        pageHasBottomNavBar: true,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: sortedData.length,
            itemBuilder: (c, i) => TimelineTile(
                  isFirst: i == 0,
                  isLast: i == sortedData.length - 1,
                  alignment: TimelineAlign.manual,
                  lineXY: 0.15,
                  indicatorStyle: IndicatorStyle(
                      padding: const EdgeInsets.all(8),
                      drawGap: true,
                      width: 60,
                      indicator: MyText(
                        sortedData[i].date.compactDateString,
                        size: FONTSIZE.SMALL,
                        weight: FontWeight.bold,
                        lineHeight: 1.3,
                      )),
                  beforeLineStyle: LineStyle(
                      thickness: 2,
                      color: context.theme.primary.withOpacity(0.7)),
                  afterLineStyle: LineStyle(
                      thickness: 2,
                      color: context.theme.primary.withOpacity(0.7)),
                  endChild: Container(
                    height: 140,
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: sortedData[i]
                          .photos
                          .reversed
                          .map((p) => Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Card(
                                  padding: const EdgeInsets.all(3),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(9),
                                    child: SizedUploadcareImage(
                                      p.photoUri,
                                      displaySize: Size(120, 120),
                                    ),
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                )),
        buttonIconData: CupertinoIcons.plus,
        onPressed: openImagePickerModal);
  }
}
