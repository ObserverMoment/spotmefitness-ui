// https://stackoverflow.com/questions/49172746/is-it-possible-extend-themedata-in-flutter
import 'dart:ui';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/components/text.dart';

extension BuildContextExtension on BuildContext {
  ThemeBloc get theme {
    return watch<ThemeBloc>();
  }

  ThemeBloc get readTheme {
    return read<ThemeBloc>();
  }

  GraphQLClient get graphQLClient => GraphQLProvider.of(this).value;

  Future<T?> openBlurModalPopup<T>(Widget child,
      {double? width,
      double? height,
      double sigmaX = 8,
      double sigmaY = 8}) async {
    T? returned = await showCupertinoModalPopup(
      filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
      context: this,
      builder: (context) => Center(
          child: Container(
              width: width ?? MediaQuery.of(context).size.width * 0.90,
              height: height,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              decoration: BoxDecoration(
                  color: this.theme.cardBackground.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(16)),
              child: child)),
    );
    return returned;
  }

  Future<T> push<T>(
      {required Widget child,
      bool fullscreenDialog = false,
      rootNavigator = false}) async {
    final BuildContext context = this;
    final T res = await Navigator.of(context, rootNavigator: rootNavigator)
        .push(MaterialWithModalsPageRoute(
            fullscreenDialog: fullscreenDialog, builder: (context) => child));
    return res;
  }

  Future<T> showDialog<T>(
      {String? title,
      Widget? content,
      required List<CupertinoDialogAction> actions}) async {
    final BuildContext context = this;
    final T res = await showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
            title: title != null ? H3(title) : null,
            content: content,
            actions: actions));
    return res;
  }

  /// Standardise dialog with two options - Confirm or Cancel
  Future<T> showConfirmDialog<T>({
    String? title,
    Widget? content,
    required void Function() onConfirm,
    required void Function() onCancel,
  }) async {
    final BuildContext context = this;
    final T res = await showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
                title: title != null ? H3(title) : null,
                content: content,
                actions: [
                  CupertinoDialogAction(
                    child: MyText(
                      'Confirm',
                      color: context.theme.primary,
                    ),
                    onPressed: () {
                      onConfirm();
                      context.pop();
                    },
                  ),
                  CupertinoDialogAction(
                    child: MyText(
                      'Cancel',
                      color: context.theme.primary,
                    ),
                    onPressed: () {
                      onCancel();
                      context.pop();
                    },
                  ),
                ]));
    return res;
  }

  /// Dialog checking if the user wants to delete the item. Includes the Item type
  // and the item name.
  Future<T> showConfirmDeleteDialog<T>({
    required String itemType,
    required String itemName,
    required void Function() onConfirm,
  }) async {
    final BuildContext context = this;
    final T res = await showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
                title: H3(
                  'Delete $itemType!',
                  textAlign: TextAlign.center,
                ),
                content: Column(
                  children: [
                    SizedBox(height: 6),
                    MyText('"$itemName"'),
                    SizedBox(height: 4),
                    MyText(
                      'Are you sure?',
                    ),
                  ],
                ),
                actions: [
                  CupertinoDialogAction(
                    isDestructiveAction: true,
                    child: MyText(
                      'Confirm',
                    ),
                    onPressed: () {
                      onConfirm();
                      context.pop();
                    },
                  ),
                  CupertinoDialogAction(
                    child: MyText(
                      'Cancel',
                      color: context.theme.primary,
                    ),
                    onPressed: context.pop,
                  ),
                ]));
    return res;
  }

  Future<T?> showBottomSheet<T>({required Widget child}) async {
    final BuildContext context = this;
    final T? result = await showCupertinoModalBottomSheet(
        context: context,
        barrierColor: Styles.black.withOpacity(0.5),
        builder: (context) => child);
    return result;
  }

  Future<void> showErrorAlert(
    String message,
  ) async {
    final BuildContext context = this;
    await showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
                title: H3('Oops, it went wrong...'),
                content: MyText(
                  message,
                  color: Styles.errorRed,
                  maxLines: 8,
                ),
                actions: [
                  CupertinoDialogAction(
                    child: MyText('Ok'),
                    onPressed: () => context.pop(),
                  ),
                ]));
  }

  void showToast({required String message, Widget? icon}) => Flushbar(
        backgroundColor: CupertinoColors.darkBackgroundGray,
        icon: icon,
        maxWidth: 500,
        animationDuration: Duration(milliseconds: 300),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12), topRight: Radius.circular(12)),
        messageText: MyText(
          message,
          color: Styles.white,
          weight: FontWeight.bold,
        ),
        duration: Duration(seconds: 3),
      )..show(this);

  dynamic pop({dynamic? result}) => Navigator.of(this).pop(result);
}
