// https://stackoverflow.com/questions/49172746/is-it-possible-extend-themedata-in-flutter
import 'dart:ui';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/icons.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/model/enum.dart';
import 'package:spotmefitness_ui/services/store/graphql_store.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:stream_feed/stream_feed.dart';
import 'package:stream_feed/src/client/notification_feed.dart';

extension BuildContextExtension on BuildContext {
  ThemeBloc get theme {
    return watch<ThemeBloc>();
  }

  ThemeBloc get readTheme {
    return read<ThemeBloc>();
  }

  StreamChatClient get streamChatClient {
    return read<StreamChatClient>();
  }

  OwnUser get streamChatUser {
    return read<OwnUser>();
  }

  StreamFeedClient get streamFeedClient {
    return read<StreamFeedClient>();
  }

  NotificationFeed get notificationFeed {
    return read<NotificationFeed>();
  }

  GraphQLStore get graphQLStore => read<GraphQLStore>();

  Future<T?> openBlurModalPopup<T>(Widget child,
      {double? width,
      double? height,
      double sigmaX = 8,
      double sigmaY = 8,
      bool barrierDismissible = true}) async {
    T? returned = await showCupertinoModalPopup(
      filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
      context: this,
      barrierDismissible: barrierDismissible,
      builder: (context) => Center(
          child: Container(
              width: width ?? MediaQuery.of(context).size.width * 0.90,
              height: height,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              decoration: BoxDecoration(
                  color: this.readTheme.cardBackground.withOpacity(0.8),
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
      bool useRootNavigator = false,
      bool barrierDismissible = false,
      required List<CupertinoDialogAction> actions}) async {
    final BuildContext context = this;
    final T res = await showCupertinoDialog(
        useRootNavigator: useRootNavigator,
        barrierDismissible: barrierDismissible,
        context: context,
        builder: (context) => CupertinoAlertDialog(
            title: title != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: MyHeaderText(title, textAlign: TextAlign.center),
                  )
                : null,
            content: content,
            actions: actions));
    return res;
  }

  Future<void> showLoadingAlert(String message,
      {Widget? icon,
      BuildContext? customContext,
      bool useRootNavigator = false}) async {
    final BuildContext context = this;
    await showCupertinoDialog(
        useRootNavigator: useRootNavigator,
        context: customContext ?? context,
        builder: (context) => CupertinoAlertDialog(
            title: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null)
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: icon,
                  ),
                MyText(message, textAlign: TextAlign.center),
              ],
            ),
            content: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: LoadingCircle(
                  size: 18,
                ),
              ),
            ),
            actions: []));
  }

  /// Standardise dialog with two options - Confirm or Cancel.
  Future<T> showConfirmDialog<T>({
    String? title,
    Widget? content,
    String? confirmText,
    String? cancelText,
    required void Function() onConfirm,
    void Function()? onCancel,
  }) async {
    final BuildContext context = this;
    final T res = await showCupertinoDialog(
        useRootNavigator: true,
        context: context,
        builder: (context) => CupertinoAlertDialog(
                title: title != null
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: MyHeaderText(title, textAlign: TextAlign.center),
                      )
                    : null,
                content: content,
                actions: [
                  CupertinoDialogAction(
                    child: MyText(
                      confirmText ?? 'Confirm',
                      color: context.readTheme.primary,
                    ),
                    onPressed: () {
                      context.pop(rootNavigator: true);
                      onConfirm();
                    },
                  ),
                  CupertinoDialogAction(
                    child: MyText(
                      cancelText ?? 'Cancel',
                      color: context.readTheme.primary,
                    ),
                    onPressed: () {
                      context.pop(rootNavigator: true);
                      if (onCancel != null) onCancel();
                    },
                  ),
                ]));
    return res;
  }

  /// Dialog checking if the user wants to delete the item. Includes the Item type
  // and the item name.
  Future<T> showConfirmDeleteDialog<T>({
    required String itemType,
    String? itemName,
    String? message,
    String? verb,
    required void Function() onConfirm,
  }) async {
    final BuildContext context = this;
    final T res = await showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
                title: MyHeaderText(
                  '${verb ?? "Delete"} $itemType',
                  textAlign: TextAlign.center,
                ),
                content: Column(
                  children: [
                    if (itemName != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: MyText(
                          '"$itemName"',
                          lineHeight: 1.5,
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: MyText(
                        message ?? 'Are you sure?',
                        maxLines: 3,
                        textAlign: TextAlign.center,
                        lineHeight: 1.5,
                      ),
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
                      context.pop(rootNavigator: true);
                      onConfirm();
                    },
                  ),
                  CupertinoDialogAction(
                    child: MyText(
                      'Cancel',
                      color: context.readTheme.primary,
                    ),
                    onPressed: () => context.pop(rootNavigator: true),
                  ),
                ]));
    return res;
  }

  /// Opens a bottom sheet with a drag handle (can be set false) at the top to indicate it can be drag dismissed.
  Future<T?> showBottomSheet<T>({
    required Widget child,
    bool expand = true,
    bool showDragHandle = true,
  }) async {
    final BuildContext context = this;
    final T? result = await showCupertinoModalBottomSheet(
        expand: expand,
        context: context,
        useRootNavigator: true,
        barrierColor: Styles.black.withOpacity(0.75),
        builder: (context) => showDragHandle
            ? Column(
                mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DragBarHandle(),
                  ),
                  Flexible(child: child),
                ],
              )
            : child);
    return result;
  }

  Future<void> showSuccessAlert(
    String title,
    String? message,
  ) async {
    final BuildContext context = this;
    await showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
                title: Column(
                  children: [
                    Icon(
                      CupertinoIcons.checkmark_alt,
                      color: Styles.infoBlue,
                    ),
                    SizedBox(height: 6),
                    MyHeaderText(title),
                  ],
                ),
                content: message != null
                    ? MyText(
                        message,
                        maxLines: 8,
                        textAlign: TextAlign.center,
                      )
                    : null,
                actions: [
                  CupertinoDialogAction(
                    child: MyText('Ok'),
                    onPressed: () => context.pop(rootNavigator: true),
                  ),
                ]));
  }

  Future<void> showErrorAlert(
    String message,
  ) async {
    final BuildContext context = this;
    await showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
                title: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: MyHeaderText(
                    'Oops, it went wrong!',
                    color: Styles.errorRed,
                    textAlign: TextAlign.center,
                  ),
                ),
                content: MyText(
                  message,
                  maxLines: 8,
                  textAlign: TextAlign.center,
                  lineHeight: 1.3,
                ),
                actions: [
                  CupertinoDialogAction(
                    child: MyText('Ok'),
                    onPressed: () => context.pop(rootNavigator: true),
                  ),
                ]));
  }

  void showToast({
    required String message,
    Widget? icon,
    ToastType toastType = ToastType.standard,
    TextAlign textAlign = TextAlign.center,
    FlushbarPosition flushbarPosition = FlushbarPosition.TOP,
  }) =>
      Flushbar(
        backgroundColor: toastType == ToastType.destructive
            ? Styles.errorRed.withOpacity(0.99)
            : toastType == ToastType.success
                ? Styles.infoBlue.withOpacity(0.99)
                : CupertinoColors.darkBackgroundGray.withOpacity(0.99),
        icon: icon,
        maxWidth: 400,
        flushbarPosition: flushbarPosition,
        animationDuration: Duration(milliseconds: 300),
        borderRadius: BorderRadius.circular(6),
        margin: const EdgeInsets.only(left: 18, right: 18),
        messageText: MyText(message,
            color: Styles.white,
            weight: FontWeight.bold,
            size: FONTSIZE.SMALL,
            textAlign: textAlign),
        duration: Duration(seconds: 3),
        blockBackgroundInteraction: false,
        isDismissible: true,
      )..show(this);

  /// Toast + more text and a button for interactivity.
  void showNotification({
    required String title,
    required String message,
    String? buttonText,
    VoidCallback? onPressed,
    Widget? icon,
    TextAlign textAlign = TextAlign.start,
    FlushbarPosition flushbarPosition = FlushbarPosition.TOP,
  }) =>
      Flushbar(
        backgroundColor: CupertinoColors.darkBackgroundGray.withOpacity(0.99),
        icon: icon,
        maxWidth: 460,
        flushbarPosition: flushbarPosition,
        animationDuration: Duration(milliseconds: 300),
        borderRadius: BorderRadius.circular(6),
        margin: const EdgeInsets.only(left: 18, right: 18),
        title: title,
        messageText: MyText(
          message,
          color: Styles.white,
          textAlign: textAlign,
          lineHeight: 1.3,
          maxLines: 3,
        ),
        mainButton: onPressed != null
            ? TextButton(
                text: buttonText ?? 'View',
                onPressed: onPressed,
                color: Styles.white,
                underline: false,
              )
            : null,
        duration: Duration(seconds: 3),
        blockBackgroundInteraction: false,
        isDismissible: true,
      )..show(this);

  dynamic pop({dynamic result, bool rootNavigator = false}) =>
      Navigator.of(this, rootNavigator: rootNavigator).pop(result);
}
