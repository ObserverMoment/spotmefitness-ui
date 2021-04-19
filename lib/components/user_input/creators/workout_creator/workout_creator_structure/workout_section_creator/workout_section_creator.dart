import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:spotmefitness_ui/blocs/workout_creator_bloc.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/menus.dart';
import 'package:spotmefitness_ui/components/tags.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/note_editor.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/round_picker.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/timecap_picker.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/text_row_click_to_edit.dart';
import 'package:spotmefitness_ui/components/user_input/creators/workout_creator/workout_creator_structure/workout_section_creator/section_type_creators/free_session_creator.dart';
import 'package:spotmefitness_ui/components/user_input/selectors/workout_section_type_selector.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/services/utils.dart';

class WorkoutSectionCreator extends StatefulWidget {
  final Key key;
  final int sectionIndex;
  final bool isCreate;
  WorkoutSectionCreator(
      {required this.key, required this.sectionIndex, this.isCreate = false})
      : super(key: key);

  @override
  _WorkoutSectionCreatorState createState() => _WorkoutSectionCreatorState();
}

class _WorkoutSectionCreatorState extends State<WorkoutSectionCreator> {
  late WorkoutCreatorBloc _bloc;
  late PageController _pageController;
  late WorkoutSection _workoutSection;

  void _checkForNewData() {
    if (_bloc.workoutData.workoutSections.length > widget.sectionIndex) {
      final updated = _bloc.workoutData.workoutSections[widget.sectionIndex];

      if (_workoutSection != updated) {
        setState(() {
          _workoutSection = WorkoutSection.fromJson(updated.toJson());
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _bloc = context.read<WorkoutCreatorBloc>();
    _pageController = PageController(initialPage: widget.isCreate ? 0 : 1);

    _workoutSection = WorkoutSection.fromJson(
        _bloc.workoutData.workoutSections[widget.sectionIndex].toJson());
    _bloc.addListener(_checkForNewData);

    _pageController.addListener(() {
      setState(() {});
    });
    // Hack so that the pageView controller check in build method below (hasClients) works.
    // Detemines if the menu ellipsis displays.
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      setState(() {});
    });
  }

  void _updateSection(Map<String, dynamic> data) {
    _bloc.updateWorkoutSection(widget.sectionIndex, data);
  }

  Widget _buildSectionTypeCreator(
    WorkoutSectionType workoutSectionType,
  ) {
    switch (workoutSectionType.name) {
      case 'Free Session':
        return FreeSessionCreator(
          widget.sectionIndex,
        );
      case 'EMOM':
        return FreeSessionCreator(
          widget.sectionIndex,
        );
      default:
        return Container();
    }
  }

  String _buildTitle(WorkoutSection workoutSection) {
    final first = 'Section ${(workoutSection.sortPosition + 1).toString()}';
    final second =
        workoutSection.name != null ? ' - ${workoutSection.name}' : '';
    return '$first $second';
  }

  @override
  void dispose() {
    _pageController.dispose();
    _bloc.removeListener(_checkForNewData);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: BasicNavBar(
        middle: NavBarTitle(_buildTitle(_workoutSection)),
        trailing: _pageController.hasClients && _pageController.page != 0
            ? NavBarEllipsisMenu(
                items: [
                  ContextMenuItem(
                    text: Utils.textNotNull(_workoutSection.name)
                        ? 'Edit name'
                        : 'Add name',
                    iconData: CupertinoIcons.pencil,
                    onTap: () => context.push(
                        child: FullScreenTextEditing(
                      title: 'Name',
                      inputValidation: (text) => true,
                      initialValue: _workoutSection.name,
                      onSave: (text) => _updateSection({'name': text}),
                    )),
                  ),
                  ContextMenuItem(
                    text: 'Change type',
                    iconData: CupertinoIcons.arrow_left_right,
                    onTap: () => _pageController.toPage(0),
                  ),
                ],
              )
            : null,
      ),
      child: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                Column(
                  children: [
                    MyText('What do you want to create?'),
                    WorkoutSectionTypeSelector((WorkoutSectionType type) {
                      _updateSection({'WorkoutSectionType': type.toJson()});
                      _pageController.toPage(1);
                    }),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        WorkoutSectionTypeTag(
                            _workoutSection.workoutSectionType.name),
                        RoundPicker(
                          rounds: _workoutSection.rounds,
                          saveValue: (value) =>
                              _updateSection({'rounds': value}),
                          modalTitle: 'How many rounds?',
                        ),
                        TimecapPicker(
                          timecap: _workoutSection.timecap != null
                              ? Duration(seconds: _workoutSection.timecap!)
                              : null,
                          saveTimecap: (duration) =>
                              _updateSection({'timecap': duration?.inSeconds}),
                        ),
                        NoteEditor(
                          title: 'Section Note',
                          note: _workoutSection.note,
                          saveNote: (note) => _updateSection({'note': note}),
                        )
                      ],
                    ),
                    _buildSectionTypeCreator(_workoutSection.workoutSectionType)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
