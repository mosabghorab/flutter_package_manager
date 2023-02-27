import 'dart:io';

import '../constants.dart';
import '../utils.dart';

class AppDelegateManager {
  static AppDelegateManager? _instance;

  // private constructor.
  AppDelegateManager._();

  // singleton pattern.
  static AppDelegateManager get instance =>
      _instance ?? (_instance = AppDelegateManager._());

  // add un user notification center delegate.
  Future<void> addUNUserNotificationCenterDelegate() async {
    String generatedCode = '''Bool {
\tif #available(iOS 10.0, *) {
  \t\tUNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
\t}''';
    File appDelegateFile = File(Constants.APP_DELEGATE_PATH);
    String appDelegateFileString = await appDelegateFile.readAsString();
    if (!appDelegateFileString
        .contains('UNUserNotificationCenter.current().delegate')) {
      appDelegateFileString =
          appDelegateFileString.replaceFirst('Bool {', generatedCode);
      await appDelegateFile.writeAsString(appDelegateFileString);
      Utils.printSuccess(
          text:
              "- We added some configurations in [${Constants.APP_DELEGATE_PATH}] file.[✓]");
    }
  }

  // add GMS service.
  Future<void> addGMSService({
    required String apikey,
  }) async {
    String generatedCode = '''Bool {
 \tGMSServices.provideAPIKey("${apikey.isEmpty ? '[WRITE YOUR VALUE HERE]' : apikey}")''';
    File appDelegateFile = File(Constants.APP_DELEGATE_PATH);
    String appDelegateFileString = await appDelegateFile.readAsString();
    if (!appDelegateFileString.contains('GMSServices.provideAPIKey')) {
      appDelegateFileString =
          appDelegateFileString.replaceFirst('Bool {', generatedCode);
      await appDelegateFile.writeAsString(appDelegateFileString);
      Utils.printSuccess(
          text:
              "- We added some configurations in [${Constants.APP_DELEGATE_PATH}] file.[✓]");
    }
  }
}
