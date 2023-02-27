import 'dart:io';

import '../constants.dart';
import '../utils.dart';

class BuildGradleManager {
  static BuildGradleManager? _instance;

  // private constructor.
  BuildGradleManager._();

  // singleton pattern.
  static BuildGradleManager get instance =>
      _instance ?? (_instance = BuildGradleManager._());

  // add google services classpath.
  Future<void> addGoogleServicesClasspath() async {
    File buildGradleFile = File(Constants.BUILD_GRADLE_PATH);
    String buildGradleFileString = await buildGradleFile.readAsString();
    if (!buildGradleFileString.contains('com.google.gms:google-services')) {
      List<String> list = buildGradleFileString.split('dependencies {');
      await buildGradleFile.writeAsString(
          '''${list[0]}dependencies {\n\t\tclasspath 'com.google.gms:google-services:4.3.3'${list[1]}
          ''');
      Utils.printSuccess(
          text:
              "- We added google-services classpath in [${Constants.BUILD_GRADLE_PATH}] file.[✓]");
    }
  }

  // upgrade kotlin version.
  Future<void> upgradeKotlinVersion({
    required String kotlinVersion,
  }) async {
    File buildGradleFile = File(Constants.BUILD_GRADLE_PATH);
    String buildGradleFileString = await buildGradleFile.readAsString();
    final regexp = RegExp(r"ext\.kotlin_version\s*=\s*'([^']+)'\s*");
    final match = regexp.firstMatch(buildGradleFileString);
    if (match != null) {
      final currentKotlinVersion = match.group(1);
      final currentParts =
          currentKotlinVersion!.split('.').map(int.parse).toList();
      final desiredParts = kotlinVersion.split('.').map(int.parse).toList();
      int comparison = 0;
      for (int i = 0; i < currentParts.length && i < desiredParts.length; i++) {
        comparison = currentParts[i].compareTo(desiredParts[i]);
        if (comparison != 0) {
          break;
        }
      }
      if (comparison < 0) {
        final newContents = buildGradleFileString.replaceFirst(
            regexp, "ext.kotlin_version = '$kotlinVersion'\n\t");
        await buildGradleFile.writeAsString(newContents);
        Utils.printSuccess(
            text:
                "- We upgraded the kotlin version from $currentKotlinVersion to $kotlinVersion in [${Constants.BUILD_GRADLE_PATH}] file.[✓]");
      }
    }
  }
}
