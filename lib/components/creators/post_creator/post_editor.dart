import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:spotmefitness_ui/blocs/auth_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/social/feeds_and_follows/model.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/text_input.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/model/enum.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:stream_feed/stream_feed.dart' as feed;
import 'package:stream_feed/src/client/flat_feed.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

/// Edit a post (activity) and update the activity on getStream. makes no calls to out API.
/// Cannot change the referenced object here.
/// Can only update the caption and the tags.
class PostEditorPage extends StatefulWidget {
  final ActivityWithObjectData activityWithObjectData;
  const PostEditorPage({Key? key, required this.activityWithObjectData})
      : super(key: key);

  @override
  _PostEditorPageState createState() => _PostEditorPageState();
}

class _PostEditorPageState extends State<PostEditorPage> {
  late AuthedUser _authedUser;
  bool _formIsDirty = false;

  /// Users always post to their feed [kUserFeedName]
  late FlatFeed _feed;
  late feed.Activity _activity;
  late final TextEditingController _captionController = TextEditingController();

  /// Tags are text input one at at time via _tagsController
  final TextEditingController _tagInputController = TextEditingController();

  /// List of strings. Added to Activity as a comma separated list.
  /// "tag1,tag2,tag3".
  List<String> _tags = <String>[];

  bool _loading = false;

  @override
  void initState() {
    super.initState();
    if (widget.activityWithObjectData.objectData == null) {
      throw Exception(
          'PostEditorPage.initState: activityWithObjectData.objectData should never be null!');
    }
    if (widget.activityWithObjectData.activity.id == null) {
      throw Exception(
          'PostEditorPage.initState: activityWithObjectData.activity.id should never be null!');
    }

    _activity = widget.activityWithObjectData.activity;

    _authedUser = GetIt.I<AuthBloc>().authedUser!;
    _feed = context.streamFeedClient.flatFeed(kUserFeedName, _authedUser.id);

    _captionController.text = _activity.extraData?['caption'].toString() ?? '';

    /// Ignore wrong format data from getStream.
    if (_activity.extraData?['tags'] is List) {
      _tags = (_activity.extraData!['tags'] as List)
          .map((t) => t.toString())
          .toList();
    }

    _captionController.addListener(() {
      setState(() {
        _formIsDirty = true;
      });
    });
    _tagInputController.addListener(() {
      setState(() {});
    });
  }

  void _addTag() {
    if (_tags.contains(_tagInputController.text)) {
      context.showToast(message: 'Tag already being used.');
    } else {
      setState(() {
        _tags.add(_tagInputController.text);
        _tagInputController.text = '';
        _formIsDirty = true;
      });
    }
  }

  void _removeTag(String tag) {
    setState(() {
      _tags.remove(tag);
      _formIsDirty = true;
    });
  }

  void _editPost() async {
    setState(() {
      _loading = true;
    });
    try {
      await _feed.updateActivityById(id: _activity.id!, set: {
        'caption': _captionController.text,
        // Try and ensure we alwasy pass a list of strings.
        // There is no type checking on the getStream side and ints, bools, objects etc will all be allowed.
        'tags': _tags.whereType<String>().toList()
      });

      context.pop();
    } catch (e) {
      print(e);
      context.showToast(
          message: 'There was a problem editing the post.',
          toastType: ToastType.destructive);
      setState(() {
        _loading = false;
      });
    }
  }

  Widget? get _buildTrailing =>
      Utils.textNotNull(_captionController.text) && _formIsDirty
          ? _loading
              ? NavBarTrailingRow(
                  children: [
                    NavBarLoadingDots(),
                  ],
                )
              : NavBarSaveButton(
                  _editPost,
                  text: 'Save',
                )
          : null;

  @override
  void dispose() {
    _captionController.dispose();
    _tagInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MyPageScaffold(
        navigationBar: BottomBorderNavBar(
            bottomBorderColor: context.theme.navbarBottomBorder,
            customLeading: NavBarCancelButton(context.pop),
            middle: NavBarTitle('Edit Post'),
            trailing: _buildTrailing),
        child: ListView(
          shrinkWrap: true,
          children: [
            MyTextAreaFormFieldRow(
                placeholder: 'Description (required)',
                autofocus: _captionController.text.isEmpty,
                backgroundColor: context.theme.cardBackground,
                keyboardType: TextInputType.text,
                controller: _captionController),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: MyTextFormFieldRow(
                      backgroundColor: context.theme.cardBackground,
                      controller: _tagInputController,
                      // Don't allow any spaces or special chracters.
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            RegExp("[a-zA-Z0-9]")),
                      ],
                      placeholder: 'Tag...',
                      keyboardType: TextInputType.text),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: IconButton(
                      disabled: _tagInputController.text.length == 0,
                      iconData: CupertinoIcons.add,
                      onPressed: _addTag),
                )
              ],
            ),
            GrowInOut(
                show: _tags.isNotEmpty,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: _tags
                        .map((t) => CupertinoButton(
                              padding: EdgeInsets.zero,
                              onPressed: () => _removeTag(t),
                              child: MyText(
                                '#${t}',
                                size: FONTSIZE.SMALL,
                              ),
                            ))
                        .toList(),
                  ),
                )),
            SizedBox(height: 10),
            HorizontalLine(),
          ],
        ));
  }
}
