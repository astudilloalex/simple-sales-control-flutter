import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// The function showErrorSnackbar displays a error snackbar with an error message based on the provided
/// error code.
///
/// The [context] parameter is the BuildContext object, which represents the
/// location in the widget tree where the SnackBar should be displayed. It is typically obtained from
/// the build method of a widget or from the context parameter of a callback function.
///
/// The [errorCode] parameter is a string that represents the error code. It is
/// used to retrieve the corresponding error message using the [messageFromCode] function.
void showErrorSnackbar(BuildContext context, String errorCode) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: SelectableText(messageFromCode(errorCode, context)),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
    ),
  );
}

String messageFromCode(String code, BuildContext context) {
  final AppLocalizations localizations = AppLocalizations.of(context)!;
  final Map<String, String> errorMessages = {
    'sign-in-with-google': localizations.signInWithGoogle,
  };
  return errorMessages[code] ?? code;
}
