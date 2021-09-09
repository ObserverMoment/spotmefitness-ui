import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/pickers/date_time_pickers.dart';
import 'package:spotmefitness_ui/components/user_input/pickers/duration_picker.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/text_row_click_to_edit.dart';
import 'package:spotmefitness_ui/components/user_input/number_input.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/model/enum.dart';
import 'package:spotmefitness_ui/services/graphql_operation_names.dart';
import 'package:spotmefitness_ui/extensions/enum_extensions.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/services/utils.dart';

class PersonalBestEntryCreator extends StatefulWidget {
  final UserBenchmark userBenchmark;
  final UserBenchmarkEntry? userBenchmarkEntry;
  PersonalBestEntryCreator({
    this.userBenchmarkEntry,
    required this.userBenchmark,
  });
  @override
  _PersonalBestEntryCreatorState createState() =>
      _PersonalBestEntryCreatorState();
}

class _PersonalBestEntryCreatorState extends State<PersonalBestEntryCreator> {
  TextEditingController _scoreController = TextEditingController();
  DateTime _completedOn = DateTime.now();

  /// If the score is a time then it is always in seconds.
  double _score = 0.0;
  String? _note;

  bool _formIsDirty = false;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    if (widget.userBenchmarkEntry != null) {
      final e = widget.userBenchmarkEntry;
      _completedOn = e!.completedOn;
      _score = e.score;
      _note = e.note;
    }

    _scoreController.text = _score.stringMyDouble();
    _scoreController.selection = TextSelection(
        baseOffset: 0, extentOffset: _scoreController.value.text.length);
    _scoreController.addListener(() {
      if (Utils.textNotNull(_scoreController.text)) {
        _setStateWrapper(() => _score = double.parse(_scoreController.text));
      } else {
        _setStateWrapper(() => _score = 0.0);
      }
    });
  }

  void _setStateWrapper(void Function() cb) {
    _formIsDirty = true;
    setState(cb);
  }

  Future<void> _saveAndClose() async {
    setState(() => _loading = true);

    if (widget.userBenchmarkEntry != null) {
      _update();
    } else {
      _create();
    }
  }

  Future<void> _create() async {
    final variables = CreateUserBenchmarkEntryArguments(
        data: CreateUserBenchmarkEntryInput(
            note: _note,
            completedOn: _completedOn,
            score: _score,
            userBenchmark: ConnectRelationInput(id: widget.userBenchmark.id)));

    /// Run the update on the network - no client side writes until data can be merged with the parent benchmark.
    final result = await context.graphQLStore.mutate(
        writeToStore: false,
        mutation: CreateUserBenchmarkEntryMutation(variables: variables));

    setState(() => _loading = false);

    if (result.hasErrors || result.data == null) {
      context.showToast(
          message: "Sorry, that didn't work.",
          toastType: ToastType.destructive);
    } else {
      /// As the benchmarkEntry exists both normalized and also as a nested object ({$ref}) within a field of the parent benchmark, we will need to overwrite the entire benchmark in the store, with the new entry added to field [UserBenchmarkEntries] so that when we rebroadcast the queries it is included in the retireved data.
      final parentBenchmarkData = context.graphQLStore.readDenomalized(
        '$kUserBenchmarkTypename:${widget.userBenchmark.id}',
      );

      final entry = result.data!.createUserBenchmarkEntry;
      final parentBenchmark = UserBenchmark.fromJson(parentBenchmarkData);
      parentBenchmark.userBenchmarkEntries.add(entry);

      final success = context.graphQLStore.writeDataToStore(
        data: parentBenchmark.toJson(),
        broadcastQueryIds: [
          GQLVarParamKeys.userBenchmarkByIdQuery(widget.userBenchmark.id),
          GQLOpNames.userBenchmarksQuery
        ],
      );

      if (!success) {
        context.showToast(
            message: kDefaultErrorMessage, toastType: ToastType.destructive);
      } else {
        context.pop();
      }
    }
  }

  Future<void> _update() async {
    /// If an update then we can just update the root normalized [UserBenchmarkEntry] object then rebroadcast the userBenchmarksQuery and the specific query for the parent UserBenchmark.
    final variables = UpdateUserBenchmarkEntryArguments(
        data: UpdateUserBenchmarkEntryInput(
      id: widget.userBenchmarkEntry!.id,
      note: _note,
      completedOn: _completedOn,
      score: _score,
      // No media editing is done on this page.
      // Can't leave the media fields null as sending null will result in the video being deleted.
      videoUri: widget.userBenchmarkEntry!.videoUri,
      videoThumbUri: widget.userBenchmarkEntry!.videoThumbUri,
    ));

    final result = await context.graphQLStore.mutate(
        mutation: UpdateUserBenchmarkEntryMutation(variables: variables),
        broadcastQueryIds: [
          GQLOpNames.userBenchmarksQuery,
          GQLVarParamKeys.userBenchmarkByIdQuery(widget.userBenchmark.id)
        ]);

    setState(() => _loading = false);

    if (result.hasErrors || result.data == null) {
      context.showToast(
          message: kDefaultErrorMessage, toastType: ToastType.destructive);
    } else {
      context.pop();
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
      Utils.textNotNull(_scoreController.text) && _formIsDirty;

  String _buildScoreHeaderText() {
    switch (widget.userBenchmark.benchmarkType) {
      case BenchmarkType.maxload:
        return 'Max Load';
      case BenchmarkType.fastesttime:
        return 'Fastest Time';
      case BenchmarkType.unbrokenreps:
        return 'Unbroken Reps';
      case BenchmarkType.unbrokentime:
        return 'Unbroken Time';
      case BenchmarkType.amrap:
        return 'AMRAP';
      default:
        throw Exception(
            'PersonalBestEntryCreator._buildScoreHeaderText: No method defined for ${widget.userBenchmark.benchmarkType}.');
    }
  }

  String _buildScoreUnit() {
    switch (widget.userBenchmark.benchmarkType) {
      case BenchmarkType.maxload:
        return widget.userBenchmark.loadUnit.display.capitalize;
      case BenchmarkType.fastesttime:
      case BenchmarkType.unbrokentime:
        return 'SECONDS';
      case BenchmarkType.amrap:
      case BenchmarkType.unbrokenreps:
        return 'REPS';
      default:
        throw Exception(
            'PersonalBestEntryCreator._buildScoreUnit: No method defined for ${widget.userBenchmark.benchmarkType}.');
    }
  }

  Widget _buildNumberInput() => Column(
        children: [
          MyNumberInput(
            _scoreController,
            allowDouble: true,
            autoFocus: true,
          ),
          SizedBox(height: 6),
          MyText(
            _buildScoreUnit(),
            size: FONTSIZE.BIG,
            weight: FontWeight.bold,
          ),
        ],
      );

  Widget _buildDurationInput() {
    final duration = Duration(seconds: _score.round());
    return GestureDetector(
      onTap: () => context.showBottomSheet(
          child: DurationPicker(
        duration: duration,
        updateDuration: (d) =>
            _setStateWrapper(() => _score = d.inSeconds.toDouble()),
        title: _buildScoreHeaderText(),
      )),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: UnRaisedButtonContainer(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
            child: MyText(
              duration.compactDisplay(),
              size: FONTSIZE.DISPLAY,
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MyPageScaffold(
      navigationBar: MyNavBar(
        customLeading: NavBarCancelButton(_handleCancel),
        middle: NavBarTitle(widget.userBenchmark.name),
        trailing: _loading
            ? Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  LoadingDots(
                    size: 12,
                    color: Styles.infoBlue,
                  ),
                ],
              )
            : _validToSubmit
                ? FadeIn(child: NavBarSaveButton(_saveAndClose))
                : null,
      ),
      child: ListView(
        shrinkWrap: true,
        children: [
          DateTimePickerDisplay(
            dateTime: _completedOn,
            saveDateTime: (DateTime d) {
              _setStateWrapper(() {
                _completedOn = d;
              });
            },
          ),
          SizedBox(height: 12),
          H3(_buildScoreHeaderText()),
          SizedBox(height: 12),
          if ([
            BenchmarkType.maxload,
            BenchmarkType.unbrokenreps,
            BenchmarkType.amrap
          ].contains(widget.userBenchmark.benchmarkType))
            _buildNumberInput()
          else
            _buildDurationInput(),
          EditableTextAreaRow(
              title: 'Note',
              text: _note ?? '',
              maxDisplayLines: 6,
              onSave: (t) => _setStateWrapper(() => _note = t),
              inputValidation: (t) => true)
        ],
      ),
    );
  }
}
