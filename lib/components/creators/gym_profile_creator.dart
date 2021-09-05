import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/navigation.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/selectors/equipment_selector.dart';
import 'package:spotmefitness_ui/components/user_input/text_input.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/services/store/graphql_store.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:json_annotation/json_annotation.dart' as json;

class GymProfileCreatorPage extends StatefulWidget {
  final GymProfile? gymProfile;
  GymProfileCreatorPage({this.gymProfile});
  @override
  _GymProfileCreatorPageState createState() => _GymProfileCreatorPageState();
}

class _GymProfileCreatorPageState extends State<GymProfileCreatorPage> {
  bool _formIsDirty = false;
  late bool _isCreate;
  bool _loading = false;

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
    _isCreate = widget.gymProfile == null;
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

  void _checkDirtyAndSetState(void Function() fn) {
    _formIsDirty = true;
    setState(fn);
  }

  GymProfile _initGymProfile() {
    final _initGymProfile = _backupJson != null
        ? GymProfile.fromJson(_backupJson!)
        : GymProfile.fromJson({
            '__typename': 'GymProfile',
            'id': 'temp_id',
            'name': 'Profile ${DateTime.now().dateString}',
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
          textAlign: TextAlign.center,
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
    setState(() => _loading = true);
    if (widget.gymProfile != null) {
      // Update
      final input = UpdateGymProfileInput.fromJson(_activeGymProfile.toJson())
        ..equipments = _activeGymProfile.equipments
            .map((e) => ConnectRelationInput(id: e.id))
            .toList();

      final variables = UpdateGymProfileArguments(data: input);

      await context.graphQLStore.mutate(
          mutation: UpdateGymProfileMutation(variables: variables),
          broadcastQueryIds: [GymProfilesQuery().operationName]);
    } else {
      // Create
      final input = CreateGymProfileInput.fromJson(_activeGymProfile.toJson())
        ..equipments = _activeGymProfile.equipments
            .map((e) => ConnectRelationInput(id: e.id))
            .toList();

      final variables = CreateGymProfileArguments(data: input);

      await context.graphQLStore.create(
          mutation: CreateGymProfileMutation(variables: variables),
          addRefToQueries: [GymProfilesQuery().operationName]);
    }
    setState(() => _loading = false);
    context.pop();
  }

  void _handleDelete() {
    context.showConfirmDeleteDialog(
      itemType: 'Gym Profile',
      itemName: _activeGymProfile.name,
      onConfirm: _deleteGymProfile,
    );
  }

  void _deleteGymProfile() async {
    setState(() => _loading = true);
    final variables = DeleteGymProfileByIdArguments(id: _activeGymProfile.id);

    await context.graphQLStore.delete(
        typename: kGymProfileTypename,
        objectId: _activeGymProfile.id,
        mutation: DeleteGymProfileByIdMutation(variables: variables),
        removeRefFromQueries: [GymProfilesQuery().operationName]);

    setState(() => _loading = false);
    context.pop();
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
  void dispose() {
    _pageController.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MyPageScaffold(
      navigationBar: CreateEditPageNavBar(
        formIsDirty: _formIsDirty,
        handleClose: _handleClose,
        handleSave: _handleSave,
        handleUndo: _handleUndo,
        inputValid: _inputValid(),
        loading: _loading,
        title: widget.gymProfile == null ? 'New Profile' : 'Edit Profile',
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
                  child: _GymProfileCreatorPageDetails(
                      nameController: _nameController,
                      descriptionController: _descriptionController,
                      handleDelete: _isCreate ? null : _handleDelete),
                ),
                _GymProfileCreatorPageEquipment(
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

class _GymProfileCreatorPageDetails extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final void Function()? handleDelete;
  _GymProfileCreatorPageDetails(
      {required this.nameController,
      required this.descriptionController,
      this.handleDelete});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            MyTextFormFieldRow(
              placeholder: 'Name (Required - min 2 chars)',
              keyboardType: TextInputType.text,
              controller: nameController,
              backgroundColor: context.theme.cardBackground,
            ),
            MyTextAreaFormFieldRow(
              placeholder: 'Description',
              keyboardType: TextInputType.text,
              controller: descriptionController,
              backgroundColor: context.theme.cardBackground,
            ),
          ],
        ),
        if (handleDelete != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Row(
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
                    onPressed: handleDelete!)
              ],
            ),
          )
      ],
    );
  }
}

class _GymProfileCreatorPageEquipment extends StatelessWidget {
  final List<Equipment> selectedEquipments;
  final void Function(Equipment equipment) handleSelection;
  final void Function() clearAllEquipment;
  _GymProfileCreatorPageEquipment(
      {required this.selectedEquipments,
      required this.handleSelection,
      required this.clearAllEquipment});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyText(
                '${selectedEquipments.length} selected',
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
          child: QueryObserver<Equipments$Query, json.JsonSerializable>(
              key: Key(
                  'GymProfileCreatorPage - ${EquipmentsQuery().operationName}'),
              query: EquipmentsQuery(),
              fetchPolicy: QueryFetchPolicy.storeFirst,
              builder: (data) {
                final List<Equipment> equipments = data.equipments;

                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
                  child: EquipmentMultiSelectorGrid(
                    showIcon: true,
                    crossAxisCount: 4,
                    equipments: equipments,
                    handleSelection: handleSelection,
                    selectedEquipments: selectedEquipments,
                    fontSize: FONTSIZE.TINY,
                  ),
                );
              }),
        ),
      ],
    );
  }
}
