import 'dart:io';

import '../constants.dart';
import '../utils.dart';

class ManifestManager {
  static ManifestManager? _instance;

  // private constructor.
  ManifestManager._();

  // singleton pattern.
  static ManifestManager get instance =>
      _instance ?? (_instance = ManifestManager._());

  // add permissions.
  Future<void> addPermissions({
    required List<String> permissions,
  }) async {
    String generatedPermissions = '';
    File mainManifestFile = File(Constants.MAIN_MANIFEST_PATH);
    String mainManifestFileString = await mainManifestFile.readAsString();
    for (String permission in permissions) {
      if (!mainManifestFileString.contains(permission)) {
        generatedPermissions += '''
\t<uses-permission android:name="android.permission.$permission"/>
''';
      }
    }
    if (generatedPermissions.isNotEmpty) {
      generatedPermissions += '\n\t<application';
      mainManifestFileString = mainManifestFileString.replaceAll(
          '<application', generatedPermissions);
      await mainManifestFile.writeAsString(mainManifestFileString);
      permissions.forEach((permission) {
        if (generatedPermissions.contains(permission))
          Utils.printSuccess(
              text:
                  '- We added [$permission] PERMISSION in ${Constants.MAIN_MANIFEST_PATH} file.[✓]');
      });
    }
  }

  // add intent filter.
  Future<void> addIntentFilter({
    required String actionName,
    required String categoryName,
  }) async {
    String notificationClickIntentFilterString = '''
</intent-filter>
            <intent-filter>
                <action android:name="$actionName" />
                <category android:name="$categoryName" />
            </intent-filter>''';
    File mainManifestFile = File(Constants.MAIN_MANIFEST_PATH);
    String mainManifestFileString = await mainManifestFile.readAsString();
    if (!mainManifestFileString.contains(actionName)) {
      mainManifestFileString = mainManifestFileString.replaceFirst(
          '</intent-filter>', notificationClickIntentFilterString);
      await mainManifestFile.writeAsString(mainManifestFileString);
      Utils.printSuccess(
          text:
              "- We added [$actionName] intent filter in [${Constants.MAIN_MANIFEST_PATH}] file.[✓]");
    }
  }

  // add meta data.
  Future<void> addMetaData({
    required String name,
    required String value,
  }) async {
    String metaDataString = '''
\t<meta-data android:name="$name"
\t\t\tandroid:value="${value.isEmpty ? '[WRITE YOUR VALUE HERE]' : value}"/>
\t</application>''';
    File mainManifestFile = File(Constants.MAIN_MANIFEST_PATH);
    String mainManifestFileString = await mainManifestFile.readAsString();
    if (!mainManifestFileString.contains(name)) {
      mainManifestFileString =
          mainManifestFileString.replaceFirst('</application>', metaDataString);
      await mainManifestFile.writeAsString(mainManifestFileString);
      Utils.printSuccess(
          text:
              "- We added some meta data in [${Constants.MAIN_MANIFEST_PATH}] file.[✓]");
    }
  }

  // add attribute to application tag.
  Future<void> addAttributeToApplicationTag({
    required String name,
    required String value,
  }) async {
    final File manifestFile = File(Constants.MAIN_MANIFEST_PATH);
    // Read the contents of the AndroidManifest.xml file.
    final String manifestXmlString = await manifestFile.readAsString();
    // Define the regular expression to find the <application> node.
    final RegExp applicationNodeRegex = RegExp(r'<application([\s\S]*?)>');
    // Use the regular expression to find the <application> node.
    final RegExpMatch? applicationNodeMatch =
        applicationNodeRegex.firstMatch(manifestXmlString);
    if (applicationNodeMatch != null) {
      // Get the matched text for the <application> node.
      final String applicationNodeText = applicationNodeMatch.group(0)!;
      // Check if the attribute is already present in the <application> node.
      final RegExp attributeRegex = RegExp('android:$name="$value"');
      if (!attributeRegex.hasMatch(applicationNodeText)) {
        // Add the attribute to the <application> node.
        final String modifiedApplicationNodeText =
            applicationNodeText.replaceFirst(
          '>',
          '\n\t\tandroid:$name="$value">',
        );
        // Replace the original <application> node with the modified one.
        final String modifiedManifestXmlString = manifestXmlString.replaceFirst(
          applicationNodeText,
          modifiedApplicationNodeText,
        );
        // Write the updated AndroidManifest.xml file back to disk.
        await manifestFile.writeAsString(modifiedManifestXmlString);
        Utils.printSuccess(
            text:
                '- We added android:$name="$value" attribute inside application tag in [${Constants.MAIN_MANIFEST_PATH}] file.[✓]');
      }
    }
  }
}
