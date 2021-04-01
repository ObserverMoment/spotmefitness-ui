import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/navigation.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/selectors/equipment_selector.dart';
import 'package:spotmefitness_ui/components/user_input/text_input.dart';
import 'package:spotmefitness_ui/components/wrappers.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions.dart';
import 'package:spotmefitness_ui/services/graphql_client.dart';
import 'package:spotmefitness_ui/services/utils.dart';

class GymProfileCreator extends StatefulWidget {
  final GymProfile? gymProfile;
  GymProfileCreator({this.gymProfile});
  @override
  _GymProfileCreatorState createState() => _GymProfileCreatorState();
}

class _GymProfileCreatorState extends State<GymProfileCreator> {
  bool _formIsDirty = false;

  Map<String, dynamic>? _backupJson;
  late GymProfile _activeGymProfile;

  int _activeTabIndex = 0;
  final PageController _pageController = PageController();

  // Text field controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _backupJson = widget.gymProfile?.toJson();
    _activeGymProfile = _initGymProfile();

    _nameController.addListener(() {
      if (_activeGymProfile.name != _nameController.text) {
        _checkDirtyAndSetState(() {
          _activeGymProfile.name = _nameController.text;
        });
      }
    });
    _descriptionController.addListener(() {
      if (_activeGymProfile.description != _descriptionController.text) {
        _checkDirtyAndSetState(() {
          _activeGymProfile.description = _descriptionController.text;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _checkDirtyAndSetState(void Function() fn) {
    _formIsDirty = true;
    setState(fn);
  }

  GymProfile _initGymProfile() {
    final _initGymProfile = _backupJson != null
        ? GymProfile.fromJson(_backupJson!)
        : GymProfile.fromJson({
            '__typename': 'GymProfile',
            'id': 'temmp_id',
            'name': 'Profile X',
            'description': '',
            'Equipments': <Equipment>[]
          });
    _nameController.text = _initGymProfile.name;
    _descriptionController.text = _initGymProfile.description ?? '';
    _formIsDirty = false;
    setState(() {});
    return _initGymProfile;
  }

  void _handleUndo() {
    context.showConfirmDialog(
        title: 'Undo all changes?',
        content: MyText(
          'This will revert back to where you first started.',
          maxLines: 3,
        ),
        onConfirm: () => setState(() {
              _activeGymProfile = _initGymProfile();
            }),
        onCancel: () => {});
  }

  void _handleClose() {
    /// Avoids keybooard bouncing in an out of the user hits confirm.
    Utils.hideKeyboard(context);
    if (_formIsDirty) {
      context.showConfirmDialog(
          title: 'Close without saving?',
          onConfirm: context.pop,
          onCancel: () => {});
    } else {
      context.pop();
    }
  }

  void _handleSave() async {
    if (widget.gymProfile != null) {
      // Update
      final args = UpdateGymProfileArguments(
          data: UpdateGymProfileInput.fromJson({
        ..._activeGymProfile.toJson(),
        'Equipments': _activeGymProfile.equipments.map((e) => e.id).toList()
      }));

      final String fragment = '''
        fragment updateGymProfile on GymProfile {
          name
          description
          Equipments {
            id
          }
        }
      ''';

      await GraphQL.updateObjectWithOptimisticFragment(
        client: context.graphQLClient,
        document: UpdateGymProfileMutation().document,
        operationName: UpdateGymProfileMutation().operationName,
        objectId: args.data.id,
        objectType: 'GymProfile',
        variables: args.toJson(),
        fragment: fragment,
        optimisticData: _activeGymProfile.toJson(),
        onCompleteOptimistic: context.pop,
      );
    } else {
      // Create
      final args = CreateGymProfileArguments(
          data: CreateGymProfileInput.fromJson({
        ..._activeGymProfile.toJson(),
        'Equipments': _activeGymProfile.equipments.map((e) => e.id).toList()
      }));

      await GraphQL.createWithQueryUpdate(
        client: context.graphQLClient,
        mutationDocument: CreateGymProfileMutation().document,
        mutationOperationName: CreateGymProfileMutation().operationName,
        mutationVariables: args.toJson(),
        queryDocument: GymProfilesQuery().document,
        queryOperationName: GymProfilesQuery().operationName,
        onCompleted: (_) => context.pop(),
      );
    }
  }

  void _handleDelete() {
    context.showConfirmDeleteDialog(
      itemType: 'Gym Profile',
      itemName: _activeGymProfile.name,
      onConfirm: _deleteGymProfile,
    );
  }

  void _deleteGymProfile() {
    GraphQL.deleteObjectByIdOptimistic(
      client: context.graphQLClient,
      mutationDocument: DeleteGymProfileByIdMutation().document,
      mutationOperationName: DeleteGymProfileByIdMutation().operationName,
      queryDocument: GymProfilesQuery().document,
      queryOperationName: GymProfilesQuery().operationName,
      objectId: _activeGymProfile.id,
      objectType: 'GymProfile',
      onCompleteOptimistic: context.pop,
    );
  }

  void _toggleEquipment(Equipment e) =>
      _checkDirtyAndSetState(() => _activeGymProfile.equipments =
          _activeGymProfile.equipments.toggleItem(e));

  void _clearAllEquipment() => _checkDirtyAndSetState(
      () => _activeGymProfile.equipments = <Equipment>[]);

  void _handleTabChange(int index) {
    _pageController.jumpToPage(
      index,
    );
    Utils.hideKeyboard(context);
    setState(() => _activeTabIndex = index);
  }

  bool _inputValid() => _nameController.text.length > 1;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CreateEditPageNavBar(
        formIsDirty: _formIsDirty,
        handleClose: _handleClose,
        handleSave: _handleSave,
        handleUndo: _handleUndo,
        inputValid: _inputValid(),
        title: 'GymProfiles',
      ),
      child: Column(
        children: [
          MyTabBarNav(
              activeTabIndex: _activeTabIndex,
              titles: ['Details', 'Equipment'],
              handleTabChange: _handleTabChange),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: _handleTabChange,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: _GymProfileCreatorDetails(
                      nameController: _nameController,
                      descriptionController: _descriptionController,
                      handleDelete: _handleDelete),
                ),
                _GymProfileCreatorEquipment(
                  clearAllEquipment: _clearAllEquipment,
                  handleSelection: _toggleEquipment,
                  selectedEquipments: _activeGymProfile.equipments,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _GymProfileCreatorDetails extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final void Function() handleDelete;
  _GymProfileCreatorDetails(
      {required this.nameController,
      required this.descriptionController,
      required this.handleDelete});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: CupertinoFormSection.insetGrouped(children: [
            MyTextFormFieldRow(
                placeholder: 'Name (Required - min 2 chars)',
                keyboardType: TextInputType.text,
                controller: nameController),
            MyTextAreaFormFieldRow(
                placeholder: 'Description',
                keyboardType: TextInputType.text,
                controller: descriptionController),
          ]),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DestructiveButton(
                prefix: Icon(
                  CupertinoIcons.delete,
                  color: Styles.white,
                  size: 18,
                ),
                text: 'Delete',
                withMinWidth: false,
                onPressed: handleDelete)
          ],
        )
      ],
    );
  }
}

class _GymProfileCreatorEquipment extends StatelessWidget {
  final List<Equipment> selectedEquipments;
  final void Function(Equipment equipment) handleSelection;
  final void Function() clearAllEquipment;
  _GymProfileCreatorEquipment(
      {required this.selectedEquipments,
      required this.handleSelection,
      required this.clearAllEquipment});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyText(
                '${selectedEquipments.length} selected',
                weight: FontWeight.bold,
              ),
              if (selectedEquipments.length > 0)
                FadeIn(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: TextButton(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        destructive: true,
                        text: 'Clear all',
                        onPressed: clearAllEquipment),
                  ),
                )
            ],
          ),
        ),
        Expanded(
          child: Query(
            options: QueryOptions(
                document: EquipmentsQuery().document,
                fetchPolicy: FetchPolicy.cacheFirst),
            builder: (result, {fetchMore, refetch}) => QueryResponseBuilder(
                result: result,
                builder: () {
                  final List<Equipment> equipments =
                      Equipments$Query.fromJson(result.data ?? {}).equipments;
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 6),
                    child: EquipmentMultiSelector(
                      showIcon: true,
                      crossAxisCount: 4,
                      equipments: equipments,
                      scrollDirection: Axis.vertical,
                      handleSelection: handleSelection,
                      selectedEquipments: selectedEquipments,
                    ),
                  );
                }),
          ),
        ),
      ],
    );
  }
}
