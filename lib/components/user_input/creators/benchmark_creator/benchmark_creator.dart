import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/text_row_click_to_edit.dart';
import 'package:spotmefitness_ui/components/user_input/creators/benchmark_creator/benchmark_move_creator.dart';
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
  Move? _move;
  Equipment? _equipment;
  double? _reps;
  WorkoutMoveRepType? _repType;
  DistanceUnit? _distanceUnit;
  double? _load;
  LoadUnit? _loadUnit;
  TimeUnit? _timeUnit;

  @override
  void initState() {
    super.initState();
    if (widget.userBenchmark != null) {
      _benchmarkType = widget.userBenchmark!.benchmarkType;
      _name = widget.userBenchmark!.name;
      _description = widget.userBenchmark!.description;
      _move = widget.userBenchmark!.move;
      _equipment = widget.userBenchmark!.equipment;
      _reps = widget.userBenchmark!.reps;
      _repType = widget.userBenchmark!.repType;
      _distanceUnit = widget.userBenchmark!.distanceUnit;
      _load = widget.userBenchmark!.load;
      _loadUnit = widget.userBenchmark!.loadUnit;
      _timeUnit = widget.userBenchmark!.timeUnit;
    }

    if (widget.userBenchmark != null &&
        widget.userBenchmark!.userBenchmarkEntries.isNotEmpty) {
      // Warn the user that making changes to the benchmark can easily mess up the benchmark entries.
      WidgetsBinding.instance!.addPostFrameCallback((_) async {
        final numEntries = widget.userBenchmark!.userBenchmarkEntries.length;
        context.showConfirmDialog(
            title: 'Editing a Benchmark',
            content: MyText(
              'This benchmark has $numEntries ${numEntries == 1 ? "entry" : "entries"}. Changing the benchmark details may mess these up...continue?',
              maxLines: 4,
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

  void _updateMove(Move move) {
    _setStateWrapper(() {
      _move = move;
      _equipment = null;
      _repType = move.validRepTypes.contains(WorkoutMoveRepType.reps)
          ? WorkoutMoveRepType.reps
          : move.validRepTypes[0];
    });
  }

  Future<void> _saveAndClose() async {
    /// Reset / remove any values that are not needed for the combination of settings that the user has chosen.
    /// E.g if they have chosen max load then we do not want to send a value for [load]
    if (_benchmarkType == BenchmarkType.maxload) {
      _load = null;
    }

    /// These benchmark types do 'as many as possible' so specifying reps does not make sense.
    if ([BenchmarkType.unbrokenreps, BenchmarkType.unbrokentime]
        .contains(_repType)) {
      _reps = null;
    }

    setState(() => _loading = true);
    if (widget.userBenchmark != null) {
      final variables = UpdateUserBenchmarkArguments(
          data: UpdateUserBenchmarkInput(
              id: widget.userBenchmark!.id,
              benchmarkType: _benchmarkType!,
              move: _move != null && _move != widget.userBenchmark!.move
                  ? ConnectRelationInput(id: _move!.id)
                  : null,
              name: _name!,
              description: _description,
              load: _load,
              loadUnit: _loadUnit,
              distanceUnit: _distanceUnit,
              equipment: _equipment != null &&
                      _equipment != widget.userBenchmark!.equipment
                  ? ConnectRelationInput(id: _equipment!.id)
                  : null,
              reps: _reps,
              repType: _repType));

      final result = await context.graphQLStore.mutate(
          mutation: UpdateUserBenchmarkMutation(variables: variables),
          broadcastQueryIds: [
            GQLNullVarsKeys.userBenchmarksQuery,
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
              move: ConnectRelationInput(id: _move!.id),
              name: _name!,
              description: _description,
              load: _load,
              loadUnit: _loadUnit,
              distanceUnit: _distanceUnit,
              equipment: _equipment != null
                  ? ConnectRelationInput(id: _equipment!.id)
                  : null,
              reps: _reps,
              repType: _repType));

      final result = await context.graphQLStore.create(
          mutation: CreateUserBenchmarkMutation(variables: variables),
          addRefToQueries: [GQLNullVarsKeys.userBenchmarksQuery]);

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

  bool get _validToSubmit =>
      _name != null &&
      _move != null &&
      (_move!.selectableEquipments.isEmpty || _equipment != null);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: BasicNavBar(
          heroTag: 'BenchmarkCreatorPage',
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
              Container(
                decoration: BoxDecoration(
                  gradient: Styles.colorOneGradient,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Wrap(
                  spacing: 1,
                  runSpacing: 1,
                  alignment: WrapAlignment.center,
                  children: BenchmarkType.values
                      .where((v) => v != BenchmarkType.artemisUnknown)
                      .map((t) => SelectableBenchmarkType(
                          selectBenchmarkType: (t) =>
                              _setStateWrapper(() => _benchmarkType = t),
                          benchmarkType: t,
                          isSelected: _benchmarkType == t))
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
                  ],
                ),
              ),
              if (_benchmarkType != null && Utils.textNotNull(_name))
                GrowIn(
                    child: BenchmarkMoveCreator(
                  benchmarkType: _benchmarkType!,
                  move: _move,
                  updateMove: _updateMove,
                  equipment: _equipment,
                  updateEquipment: (e) =>
                      _setStateWrapper(() => _equipment = e),
                  repType: _repType,
                  updateRepType: (repType) =>
                      _setStateWrapper(() => _repType = repType),
                  reps: _reps,
                  updateReps: (r) => _setStateWrapper(() => _reps = r),
                  distanceUnit: _distanceUnit,
                  updateDistanceUnit: (distanceUnit) =>
                      _setStateWrapper(() => _distanceUnit = distanceUnit),
                  load: _load,
                  updateLoad: (l) => _setStateWrapper(() => _load = l),
                  loadUnit: _loadUnit,
                  updateLoadUnit: (loadUnit) =>
                      _setStateWrapper(() => _loadUnit = loadUnit),
                  timeUnit: _timeUnit,
                  updateTimeUnit: (timeUnit) =>
                      _setStateWrapper(() => _timeUnit = timeUnit),
                )),
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
        padding: const EdgeInsets.symmetric(vertical: 4),
        alignment: Alignment.center,
        duration: kStandardAnimationDuration,
        decoration: BoxDecoration(
            color: isSelected ? Styles.colorOne : context.theme.background),
        child: MyText(
          benchmarkType.display,
          textAlign: TextAlign.center,
          size: FONTSIZE.BIG,
          color: isSelected ? Styles.white : null,
          weight: FontWeight.bold,
        ),
      ),
    );
  }
}
