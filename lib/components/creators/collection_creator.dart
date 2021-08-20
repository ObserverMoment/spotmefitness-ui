import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/text_input.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/services/graphql_operation_names.dart';

class CollectionCreator extends StatefulWidget {
  final Collection? collection;
  final void Function(Collection collection)? onComplete;
  const CollectionCreator({
    Key? key,
    this.collection,
    this.onComplete,
  }) : super(key: key);

  @override
  _CollectionCreatorState createState() => _CollectionCreatorState();
}

class _CollectionCreatorState extends State<CollectionCreator> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  bool _loading = false;
  late bool _isCreate;

  @override
  void initState() {
    _isCreate = widget.collection == null;

    _nameController = TextEditingController(text: widget.collection?.name);
    _descriptionController =
        TextEditingController(text: widget.collection?.description);

    _nameController.addListener(() {
      setState(() {});
    });
    _descriptionController.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  void _handleSave() {
    if (_nameController.text.length > 2) {
      if (widget.collection != null) {
        _updateCollection();
      } else {
        _createCollection();
      }
    }
  }

  Future<void> _updateCollection() async {
    setState(() => _loading = true);

    final variables = UpdateCollectionArguments(
        data: UpdateCollectionInput(
            id: widget.collection!.id,
            name: _nameController.text,
            description: _descriptionController.text));

    final result = await context.graphQLStore
        .mutate<UpdateCollection$Mutation, UpdateCollectionArguments>(
      mutation: UpdateCollectionMutation(variables: variables),
      broadcastQueryIds: [
        UserCollectionsQuery().operationName,
        GQLVarParamKeys.userCollectionByIdQuery(widget.collection!.id)
      ],
    );

    setState(() => _loading = false);

    if (result.hasErrors || result.data == null) {
      context.showErrorAlert(
          'Sorry there was a problem, the collection was not created.');
    } else {
      if (widget.onComplete != null) {
        widget.onComplete!(result.data!.updateCollection);
      }
      context.pop();
    }
  }

  Future<void> _createCollection() async {
    setState(() => _loading = true);

    final variables = CreateCollectionArguments(
        data: CreateCollectionInput(
            name: _nameController.text,
            description: _descriptionController.text));

    final result = await context.graphQLStore
        .mutate<CreateCollection$Mutation, CreateCollectionArguments>(
            mutation: CreateCollectionMutation(variables: variables),
            addRefToQueries: [UserCollectionsQuery().operationName]);

    setState(() => _loading = false);

    if (result.hasErrors || result.data == null) {
      context.showErrorAlert(
          'Sorry there was a problem, the collection was not created.');
    } else {
      if (widget.onComplete != null) {
        widget.onComplete!(result.data!.createCollection);
      }
      context.pop();
    }
  }

  void _cancel() {
    context.pop();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MyPageScaffold(
      navigationBar: BottomBorderNavBar(
        bottomBorderColor: context.theme.navbarBottomBorder,
        customLeading: NavBarCancelButton(_cancel),
        middle:
            NavBarTitle(_isCreate ? 'Create Collection' : 'Edit Collection'),
        trailing: AnimatedSwitcher(
            duration: Duration(milliseconds: 250),
            child: _loading
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
                : _nameController.text.length > 2
                    ? NavBarSaveButton(_handleSave)
                    : Container(width: 0)),
      ),
      // Use SafeArea as this screen is opened as a bottom sheet.
      child: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: Column(
          children: [
            MyTextFormFieldRow(
              autofocus: true,
              backgroundColor: context.theme.cardBackground,
              controller: _nameController,
              placeholder: 'Name',
              keyboardType: TextInputType.text,
              validator: () =>
                  _nameController.text.length > 2 &&
                  _nameController.text.length < 21,
              validationMessage: 'Min 3, max 20 characters',
            ),
            SizedBox(height: 10),
            MyTextAreaFormFieldRow(
                placeholder: 'Description (optional)',
                backgroundColor: context.theme.cardBackground,
                keyboardType: TextInputType.text,
                controller: _descriptionController),
          ],
        ),
      ))),
    );
  }
}
