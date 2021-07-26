import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/tappable_row.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/text_row_click_to_edit.dart';
import 'package:spotmefitness_ui/components/user_input/selectors/user_benchmark_type_selector.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/extensions/enum_extensions.dart';
import 'package:spotmefitness_ui/model/enum.dart';
import 'package:spotmefitness_ui/services/graphql_operation_names.dart';
import 'package:spotmefitness_ui/services/store/store_utils.dart';
import 'package:spotmefitness_ui/services/utils.dart';

class BenchmarkCreatorPage extends StatefulWidget {
  final UserBenchmark? userBenchmark;
  BenchmarkCreatorPage({this.userBenchmark});

  @override
  _BenchmarkCreatorPageState createState() => _BenchmarkCreatorPageState();
}

class _BenchmarkCreatorPageState extends State<BenchmarkCreatorPage> {
  bool _formIsDirty = false;
  bool _loading = false;

  BenchmarkType? _benchmarkType;

  String? _name;
  String? _description;
  String? _equipmentInfo;
  LoadUnit? _loadUnit;

  @override
  void initState() {
    super.initState();
    if (widget.userBenchmark != null) {
      _benchmarkType = widget.userBenchmark!.benchmarkType;
      _name = widget.userBenchmark!.name;
      _description = widget.userBenchmark!.description;
      _equipmentInfo = widget.userBenchmark!.equipmentInfo;
      _loadUnit = widget.userBenchmark!.loadUnit;
    }

    if (widget.userBenchmark != null &&
        widget.userBenchmark!.userBenchmarkEntries.isNotEmpty) {
      // Warn the user that making changes to the benchmark can easily mess up the benchmark entries.
      WidgetsBinding.instance!.addPostFrameCallback((_) async {
        final numEntries = widget.userBenchmark!.userBenchmarkEntries.length;
        context.showConfirmDialog(
            title: 'Editing a Benchmark',
            content: MyText(
              'This benchmark has $numEntries ${numEntries == 1 ? "entry" : "entries"}. Changing certain benchmark details could affect these scores...continue?',
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
      ));

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
      ));

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

  bool get _validToSubmit => _name != null;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: BorderlessNavBar(
          customLeading: NavBarCancelButton(_handleCancel),
          middle: NavBarTitle(widget.userBenchmark == null
              ? 'New Benchmark'
              : 'Edit Benchmark'),
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
          padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InfoPopupButton(
                      infoWidget: MyText('Info about the benchmark types'))
                ],
              ),
              TappableRow(
                  onTap: () => context.push(
                          child: BenchmarkTypeSelector(
                        updateBenchmarkType: (t) =>
                            _setStateWrapper(() => _benchmarkType = t),
                      )),
                  display: MyText(_benchmarkType.toString()),
                  title: 'Choose Type of PB'),
              // Container(
              //   decoration: BoxDecoration(
              //     gradient: Styles.colorOneGradient,
              //     borderRadius: BorderRadius.circular(4),
              //   ),
              //   child: Wrap(
              //     spacing: 1,
              //     runSpacing: 1,
              //     alignment: WrapAlignment.center,
              //     children: BenchmarkType.values
              //         .where((v) => v != BenchmarkType.artemisUnknown)
              //         .map((t) => SelectableBenchmarkType(
              //             selectBenchmarkType: (t) =>
              //                 _setStateWrapper(() => _benchmarkType = t),
              //             benchmarkType: t,
              //             isSelected: _benchmarkType == t))
              //         .toList(),
              //   ),
              // ),
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
              if (_benchmarkType != null && Utils.textNotNull(_name))
                GrowIn(child: MyText('Type specific settings?')),
            ],
          ),
        ),
      ),
    );
  }
}

class SelectableBenchmarkType extends StatelessWidget {
  final void Function(BenchmarkType benchmarkType) selectBenchmarkType;
  final BenchmarkType benchmarkType;
  final bool isSelected;
  SelectableBenchmarkType(
      {required this.benchmarkType,
      required this.isSelected,
      required this.selectBenchmarkType});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => selectBenchmarkType(benchmarkType),
      child: AnimatedContainer(
        width: 150,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
        alignment: Alignment.center,
        duration: kStandardAnimationDuration,
        decoration: BoxDecoration(
            color: isSelected ? Styles.colorOne : context.theme.background),
        child: MyText(
          benchmarkType.display,
          textAlign: TextAlign.center,
          size: FONTSIZE.BIG,
          color: isSelected ? Styles.white : null,
        ),
      ),
    );
  }
}
