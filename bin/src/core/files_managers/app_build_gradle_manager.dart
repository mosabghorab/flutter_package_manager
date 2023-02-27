import 'dart:io';

import '../constants.dart';
import '../utils.dart';

class AppBuildGradleManager {
  static AppBuildGradleManager? _instance;

  // private constructor.
  AppBuildGradleManager._();

  // singleton pattern.
  static AppBuildGradleManager get instance =>
      _instance ?? (_instance = AppBuildGradleManager._());

  // add google services plugin.
  Future<void> addGoogleServicesPlugin() async {
    File appBuildGradleFile = File(Constants.APP_BUILD_GRADLE_PATH);
    String appBuildGradleFileString = await appBuildGradleFile.readAsString();
    if (!appBuildGradleFileString.contains('com.google.gms.google-services')) {
      await appBuildGradleFile.writeAsString('''
apply plugin: 'com.google.gms.google-services'
          ''', mode: FileMode.append);
      Utils.printSuccess(
          text:
              "- We added google-services plugin in [${Constants.APP_BUILD_GRADLE_PATH}] file.[✓]");
    }
  }

  // upgrade min sdk version.
  Future<void> upgradeMinSdkVersion({
    required int minSdkVersion,
  }) async {
    File appBuildGradleFile = File(Constants.APP_BUILD_GRADLE_PATH);
    String appBuildGradleFileString = await appBuildGradleFile.readAsString();
    final regexp = RegExp(r'minSdkVersion\s+(\d+)');
    final match = regexp.firstMatch(appBuildGradleFileString);
    if (match != null) {
      final currentMinSdkVersion = int.parse(match.group(1)!);
      if (currentMinSdkVersion >= minSdkVersion) return;
      final newContents = appBuildGradleFileString.replaceFirst(
          regexp, 'minSdkVersion $minSdkVersion');
      await appBuildGradleFile.writeAsString(newContents);
      Utils.printSuccess(
          text:
              "- We upgraded the min sdk version from $currentMinSdkVersion to $minSdkVersion in [${Constants.APP_BUILD_GRADLE_PATH}] file.[✓]");
    }
  }

  // upgrade compile sdk version.
  Future<void> upgradeCompileSdkVersion({
    required int compileSdkVersion,
  }) async {
    File appBuildGradleFile = File(Constants.APP_BUILD_GRADLE_PATH);
    String appBuildGradleFileString = await appBuildGradleFile.readAsString();
    final regexp = RegExp(r'compileSdkVersion\s+(\d+)');
    final match = regexp.firstMatch(appBuildGradleFileString);
    if (match != null) {
      final currentCompileSdkVersion = int.parse(match.group(1)!);
      if (currentCompileSdkVersion >= compileSdkVersion) return;
      final newContents = appBuildGradleFileString.replaceFirst(
          regexp, 'compileSdkVersion $compileSdkVersion');
      await appBuildGradleFile.writeAsString(newContents);
      Utils.printSuccess(
          text:
              "- We upgraded the compile sdk version from $currentCompileSdkVersion to $compileSdkVersion in [${Constants.APP_BUILD_GRADLE_PATH}] file.[✓]");
    }
  }

  // enable multi Dex.
  Future<void> enableMultiDex() async {
    final File appBuildGradleFile = File(Constants.APP_BUILD_GRADLE_PATH);
    final String contents = await appBuildGradleFile.readAsString();
    if (!contents.contains('multiDexEnabled')) {
      final String defaultConfigBlock = RegExp(
              r"defaultConfig\s*\{(?:[^{}]*\{[^{}]*\}[^{}]*)*[^{}]*\}",
              multiLine: true)
          .firstMatch(contents)!
          .group(0)!;
      String modifiedBlock =
          defaultConfigBlock.replaceFirst('}', '\tmultiDexEnabled true\n\t}');
      final String newContent =
          contents.replaceFirst(defaultConfigBlock, modifiedBlock);
      await appBuildGradleFile
          .writeAsString(contents.replaceFirst(contents, newContent));
      Utils.printSuccess(
          text:
              "- We enabled the multidex in [${Constants.APP_BUILD_GRADLE_PATH}] file.[✓]");
    }
  }
}
