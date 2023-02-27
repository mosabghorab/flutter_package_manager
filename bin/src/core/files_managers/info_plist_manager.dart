import 'dart:io';

import '../constants.dart';
import '../utils.dart';

class InfoPlistManager {
  static InfoPlistManager? _instance;

  // private constructor.
  InfoPlistManager._();

  // singleton pattern.
  static InfoPlistManager get instance =>
      _instance ?? (_instance = InfoPlistManager._());

  // add permissions.
  Future<void> addPermissions({
    required List<String> permissions,
  }) async {
    String generatedPermissions = '';
    File infoPListFile = File(Constants.INFO_PLIST_PATH);
    String infoPListFileString = await infoPListFile.readAsString();
    for (String permission in permissions) {
      if (!infoPListFileString.contains(permission)) {
        generatedPermissions += '''
\t<key>$permission</key>
\t<string>[WRITE A GOODE REASON WHY YOU NEED TO ACCESS THIS PERMISSION]</string>
''';
      }
    }
    if (generatedPermissions.isNotEmpty) {
      generatedPermissions += '</dict>';
      final int lastIndex = infoPListFileString.lastIndexOf('</dict>');
      String newContent = infoPListFileString.substring(0, lastIndex) +
          generatedPermissions +
          infoPListFileString.substring(lastIndex + '</dict>'.length);
      await infoPListFile.writeAsString(newContent);
      permissions.forEach((permission) {
        if (generatedPermissions.contains(permission))
          Utils.printSuccess(
              text:
                  '- We added [$permission] PERMISSION in ${Constants.INFO_PLIST_PATH} file.[✓]');
      });
    }
  }

  // add array.
  Future<void> addArray({
    required String key,
    required List<String> values,
  }) async {
    String generatedContent = '';
    File infoPListFile = File(Constants.INFO_PLIST_PATH);
    String infoPListFileString = await infoPListFile.readAsString();
    if (!infoPListFileString.contains('>$key<')) {
      generatedContent += '''\t<key>$key</key>\n\t<array>\n''';
      generatedContent += '''
${List.generate(values.length, (index) => index == values.length - 1 ? '\t\t<string>${values[index]}</string>' : '\t\t<string>${values[index]}</string>\n').join()}
''';
      generatedContent += '\t</array>\n';
    }
    if (generatedContent.isNotEmpty) {
      generatedContent += '</dict>';
      final int lastIndex = infoPListFileString.lastIndexOf('</dict>');
      String newContent = infoPListFileString.substring(0, lastIndex) +
          generatedContent +
          infoPListFileString.substring(lastIndex + '</dict>'.length);
      await infoPListFile.writeAsString(newContent);
      Utils.printSuccess(
          text:
              '- We added [$key] key in ${Constants.INFO_PLIST_PATH} file.[✓]');
    }
  }

  // add dict.
  Future<void> addDict({
    required String key,
    required List<Map<String, dynamic>> attributes,
  }) async {
    String generatedContent = '';
    File infoPListFile = File(Constants.INFO_PLIST_PATH);
    String infoPListFileString = await infoPListFile.readAsString();
    if (!infoPListFileString.contains('>$key<')) {
      generatedContent += '''\t<key>$key</key>\n\t<dict>\n''';
      generatedContent += '''
${List.generate(attributes.length, (index) => index == attributes.length - 1 ? '${attributes[index]['value'] is bool ? '\t<key>${attributes[index]['name']}</key>\n\t<${attributes[index]['value']}/>' : '\t<key>${attributes[index]['name']}</key>\n\t<string>${attributes[index]['value']}</string>'}' : '${attributes[index]['value'] is bool ? '\t<key>${attributes[index]['name']}</key>\n\t<${attributes[index]['value']}/>\n' : '\t<key>${attributes[index]['name']}</key>\n\t<string>${attributes[index]['value']}</string>\n'}').join()}
''';
      generatedContent += '\t</dict>\n';
    }
    generatedContent += '</dict>';
    final int lastIndex = infoPListFileString.lastIndexOf('</dict>');
    String newContent = infoPListFileString.substring(0, lastIndex) +
        generatedContent +
        infoPListFileString.substring(lastIndex + '</dict>'.length);
    await infoPListFile.writeAsString(newContent);
    Utils.printSuccess(
        text: '- We added [$key] key in ${Constants.INFO_PLIST_PATH} file.[✓]');
  }
}
