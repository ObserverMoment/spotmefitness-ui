// import 'package:flutter/cupertino.dart';
// import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
// import 'package:spotmefitness_ui/components/animated/mounting.dart';
// import 'package:spotmefitness_ui/components/icons.dart';
// import 'package:spotmefitness_ui/components/user_input/click_to_edit/text_row_click_to_edit.dart';
// import 'package:spotmefitness_ui/extensions/context_extensions.dart';
// import 'package:spotmefitness_ui/services/utils.dart';

// /// Displays a note icon which when clicked will open up [FullScreenTextEditing].
// class EditableNoteIconDisplay extends StatelessWidget {
//   final String? title;
//   final String? note;
//   final void Function(String note) saveNote;
//   final void Function(String note)? inputValidation;
//   EditableNoteIconDisplay(
//       {this.title,
//       required this.saveNote,
//       required this.note,
//       this.inputValidation});
//   @override
//   Widget build(BuildContext context) {
//     return CupertinoButton(
//         onPressed: () => context.push(
//                 child: FullScreenTextEditing(
//               title: title ?? 'Note',
//               inputValidation: inputValidation ?? (text) => true,
//               initialValue: note,
//               onSave: saveNote,
//             )),
//         child: Stack(
//           clipBehavior: Clip.none,
//           children: [
//             NotesIcon(),
//             if (Utils.textNotNull(note))
//               Positioned(
//                 right: -4,
//                 top: -9,
//                 child: FadeIn(
//                     child: Icon(CupertinoIcons.check_mark_circled_solid,
//                         color: Styles.infoBlue, size: 16)),
//               ),
//           ],
//         ));
//   }
// }
