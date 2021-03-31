import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/text.dart';

import 'generated/api/graphql_api.graphql.dart';

// https://stackoverflow.com/questions/49172746/is-it-possible-extend-themedata-in-flutter
extension BuildContextExtension on BuildContext {
  ThemeBloc get theme {
    return watch<ThemeBloc>();
  }

  GraphQLClient get graphQLClient => GraphQLProvider.of(this).value;

  Future<T> push<T>(
      {required Widget child, bool fullscreenDialog = false}) async {
    final BuildContext context = this;
    final T res = await Navigator.of(context).push(CupertinoPageRoute(
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
            title: title != null ? H2(title) : null,
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
                title: title != null ? H2(title) : null,
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

  Future<void> showErrorAlert(
    String message,
  ) async {
    final BuildContext context = this;
    await showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
                title: H2('Oops, it went wrong...'),
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

  Size get size => MediaQuery.of(this).size;

  dynamic pop({dynamic? result}) => Navigator.of(this).pop(result);
}

extension DoubleExtension on double {
  double roundMyDouble(
    double x,
    int decimalPlaces,
  ) {
    int i = x.truncate();
    if (x == i) {
      return i.toDouble();
    }
    // Returns to max of [decimalPlaces] decimal places
    return ((x * pow(10, decimalPlaces)).truncate() / 100);
  }
}

extension DateTimeFormatting on DateTime {
  /// Date only - July 10, 1996
  String get dateString => DateFormat.yMMMMd().format(this);
}

extension ListExtension on List {
  /// If not in list, add it, else remove it.
  /// Assumes Equatable functionality if item is non scalar.
  List<T> toggleItem<T>(T item) {
    return (this as List<T>).contains(item)
        ? (this as List<T>).where((e) => e != item).toList()
        : <T>[...this, item];
  }
}

/// Enum extensions
extension GenderExtension on Gender {
  String get display {
    switch (this) {
      case Gender.male:
        return 'Male';
      case Gender.female:
        return 'Female';
      case Gender.nonbinary:
        return 'Non-binary';
      case Gender.none:
        return 'None';
      default:
        throw new Exception('This is not a valid Gender enum: $this');
    }
  }

  String get apiValue {
    switch (this) {
      case Gender.male:
        return 'MALE';
      case Gender.female:
        return 'FEMALE';
      case Gender.nonbinary:
        return 'NONBINARY';
      case Gender.none:
        return 'NONE';
      default:
        throw new Exception('This is not a valid Gender enum: $this');
    }
  }
}
