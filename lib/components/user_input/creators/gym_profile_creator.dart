import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive/hive.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
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

  void _handleSave() {
    if (widget.gymProfile != null) {
      // Update
    } else {
      // Create
      final args = CreateGymProfileArguments(
          data: CreateGymProfileInput.fromJson({
        ..._activeGymProfile.toJson(),
        'Equipments': _activeGymProfile.equipments.map((e) => e.id).toList()
      }));

      final String fragment = '''
          fragment GymProfile on GymProfile {
            name
            description
            Equipments
          }
        ''';

      GraphQL.mutateWithFragmentUpdate(
        client: context.graphQLClient,
        document: CreateGymProfileMutation().document,
        variables: args.toJson(),
        fragment: fragment,
        operationName: CreateGymProfileMutation().operationName,
        onCompleted: (_) => context.pop(),
      );
    }
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
      navigationBar: CupertinoNavigationBar(
          leading: Align(
              alignment: Alignment.centerLeft,
              child: NavBarTitle('Gym Profile')),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_formIsDirty)
                FadeIn(
                  child: TextButton(
                      destructive: true,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      text: 'Undo all',
                      underline: false,
                      onPressed: _handleUndo),
                ),
              AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: _inputValid()
                    ? TextButton(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        confirm: true,
                        underline: false,
                        text: 'Save',
                        onPressed: _handleSave)
                    : TextButton(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        underline: false,
                        text: 'Close',
                        onPressed: _handleClose),
              ),
              TextButton(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  underline: false,
                  text: 'Close',
                  onPressed: _handleClose),
            ],
          )),
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
                  ),
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
  _GymProfileCreatorDetails(
      {required this.nameController, required this.descriptionController});
  @override
  Widget build(BuildContext context) {
    return Container(
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
