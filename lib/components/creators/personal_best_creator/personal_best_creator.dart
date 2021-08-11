import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/tags.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/sliding_select.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/tappable_row.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/text_row_click_to_edit.dart';
import 'package:spotmefitness_ui/components/user_input/selectors/user_benchmark_tags_selector.dart';
import 'package:spotmefitness_ui/components/user_input/selectors/user_benchmark_type_selector.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/extensions/enum_extensions.dart';
import 'package:spotmefitness_ui/model/enum.dart';
import 'package:spotmefitness_ui/services/graphql_operation_names.dart';
import 'package:spotmefitness_ui/services/store/store_utils.dart';

class PersonalBestCreatorPage extends StatefulWidget {
  final UserBenchmark? userBenchmark;
  PersonalBestCreatorPage({this.userBenchmark});

  @override
  _PersonalBestCreatorPageState createState() =>
      _PersonalBestCreatorPageState();
}

class _PersonalBestCreatorPageState extends State<PersonalBestCreatorPage> {
  bool _formIsDirty = false;
  bool _loading = false;

  BenchmarkType? _benchmarkType;

  String? _name;
  String? _description;
  String? _equipmentInfo;
  LoadUnit _loadUnit = LoadUnit.kg;
  List<UserBenchmarkTag> _tags = [];

  @override
  void initState() {
    super.initState();
    if (widget.userBenchmark != null) {
      _benchmarkType = widget.userBenchmark!.benchmarkType;
      _name = widget.userBenchmark!.name;
      _description = widget.userBenchmark!.description;
      _equipmentInfo = widget.userBenchmark!.equipmentInfo;
      _loadUnit = widget.userBenchmark!.loadUnit;
      _tags = widget.userBenchmark!.userBenchmarkTags;
    }

    if (widget.userBenchmark != null &&
        widget.userBenchmark!.userBenchmarkEntries.isNotEmpty) {
      // Warn the user that making changes to the benchmark can easily mess up the benchmark entries.
      WidgetsBinding.instance!.addPostFrameCallback((_) async {
        final numEntries = widget.userBenchmark!.userBenchmarkEntries.length;
        context.showConfirmDialog(
            title: 'Editing a PB Definition',
            content: MyText(
              'This PB has $numEntries ${numEntries == 1 ? "entry" : "entries"}. Changing certain details could affect these scores...continue?',
              lineHeight: 1.4,
              maxLines: 4,
              textAlign: TextAlign.center,
            ),
            onConfirm: () {},
            onCancel: context.pop);
      });
    }
  }

  void _setStateWrapper(void Function() cb) {
    _formIsDirty = true;
    setState(cb);
  }

  Future<void> _saveAndClose() async {
    setState(() => _loading = true);
    if (widget.userBenchmark != null) {
      final variables = UpdateUserBenchmarkArguments(
          data: UpdateUserBenchmarkInput(
              id: widget.userBenchmark!.id,
              benchmarkType: _benchmarkType!,
              name: _name!,
              description: _description,
              equipmentInfo: _equipmentInfo,
              loadUnit: _loadUnit,
              userBenchmarkTags:
                  _tags.map((t) => ConnectRelationInput(id: t.id)).toList()));

      final result = await context.graphQLStore.mutate(
          mutation: UpdateUserBenchmarkMutation(variables: variables),
          broadcastQueryIds: [
            GQLOpNames.userBenchmarksQuery,
            getParameterizedQueryId(UserBenchmarkByIdQuery(
                variables:
                    UserBenchmarkByIdArguments(id: widget.userBenchmark!.id)))
          ]);

      setState(() => _loading = false);

      if (result.hasErrors || result.data == null) {
        context.showToast(
            message: "Sorry, that didn't work",
            toastType: ToastType.destructive);
      } else {
        context.pop();
      }
    } else {
      final variables = CreateUserBenchmarkArguments(
          data: CreateUserBenchmarkInput(
              benchmarkType: _benchmarkType!,
              name: _name!,
              description: _description,
              equipmentInfo: _equipmentInfo,
              loadUnit: _loadUnit,
              userBenchmarkTags:
                  _tags.map((t) => ConnectRelationInput(id: t.id)).toList()));

      final result = await context.graphQLStore.create(
          mutation: CreateUserBenchmarkMutation(variables: variables),
          addRefToQueries: [GQLOpNames.userBenchmarksQuery]);

      setState(() => _loading = false);

      if (result.hasErrors || result.data == null) {
        context.showToast(
            message: "Sorry, that didn't work",
            toastType: ToastType.destructive);
      } else {
        context.pop();
      }
    }
  }

  void _handleCancel() {
    if (_formIsDirty) {
      context.showConfirmDialog(
          title: 'Close without saving?', onConfirm: context.pop);
    } else {
      context.pop();
    }
  }

  bool get _validToSubmit => _name != null && _benchmarkType != null;

  @override
  Widget build(BuildContext context) {
    return MyPageScaffold(
      navigationBar: BorderlessNavBar(
          customLeading: NavBarCancelButton(_handleCancel),
          middle: NavBarTitle(widget.userBenchmark == null
              ? 'New Personal Best'
              : 'Edit Personal Best'),
          trailing: _formIsDirty && _validToSubmit
              ? FadeIn(
                  child: NavBarSaveButton(
                    _saveAndClose,
                    loading: _loading,
                  ),
                )
              : null),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyText('How will you score this PB?'),
                  InfoPopupButton(infoWidget: MyText('Info about the PB types'))
                ],
              ),
              Container(
                padding: const EdgeInsets.only(left: 4),
                height: 60,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: BenchmarkType.values
                      .where((v) => v != BenchmarkType.artemisUnknown)
                      .map((type) => Padding(
                            padding: const EdgeInsets.only(right: 6.0),
                            child: SelectableTag(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 9),
                                fontSize: FONTSIZE.BIG,
                                isSelected: type == _benchmarkType,
                                onPressed: () =>
                                    setState(() => _benchmarkType = type),
                                text: type.display),
                          ))
                      .toList(),
                ),
              ),
              SizedBox(height: 16),
              GrowInOut(
                show: _benchmarkType != null,
                child: Column(
                  children: [
                    EditableTextFieldRow(
                        title: 'Name',
                        isRequired: true,
                        text: _name ?? '',
                        onSave: (t) => _setStateWrapper(() => _name = t),
                        validationMessage: 'Min 4, max 30 characters',
                        inputValidation: (t) => t.length > 3 && t.length < 31),
                    EditableTextAreaRow(
                        title: 'Description',
                        text: _description ?? '',
                        maxDisplayLines: 6,
                        onSave: (t) => _setStateWrapper(() => _description = t),
                        inputValidation: (t) => true),
                    EditableTextAreaRow(
                        title: 'Equipment Info',
                        text: _equipmentInfo ?? '',
                        maxDisplayLines: 6,
                        onSave: (t) =>
                            _setStateWrapper(() => _equipmentInfo = t),
                        inputValidation: (t) => true),
                  ],
                ),
              ),
              GrowInOut(
                show: _benchmarkType == BenchmarkType.maxload,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    children: [
                      H3('Max Load PB'),
                      SizedBox(height: 8),
                      MyText('Submit your score in:'),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SlidingSelect<LoadUnit>(
                              value: _loadUnit,
                              children: {
                                for (final v in LoadUnit.values.where((v) =>
                                    v != LoadUnit.artemisUnknown &&
                                    v != LoadUnit.percentmax))
                                  v: MyText(v.display)
                              },
                              updateValue: (loadUnit) =>
                                  _setStateWrapper(() => _loadUnit = loadUnit)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              GrowInOut(
                show: _benchmarkType != null,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: TappableRow(
                      title: 'Tags',
                      display: _tags.isEmpty
                          ? MyText(
                              'Add some tags...',
                              subtext: true,
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  child: Wrap(
                                    alignment: WrapAlignment.end,
                                    spacing: 4,
                                    runSpacing: 4,
                                    children: _tags
                                        .map((t) => Tag(
                                              tag: t.name,
                                              color: Styles.colorOne,
                                              textColor: Styles.white,
                                            ))
                                        .toList(),
                                  )),
                            ),
                      onTap: () => context.push(
                          child: UserBenchmarkTagsSelector(
                              selectedUserBenchmarkTags: _tags,
                              updateSelectedUserBenchmarkTags: (tags) =>
                                  _setStateWrapper(() => _tags = tags)))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
