import 'dart:io';

import '../constants.dart';
import '../utils.dart';

class PodfileManager {
  static PodfileManager? _instance;

  // private constructor.
  PodfileManager._();

  // singleton pattern.
  static PodfileManager get instance =>
      _instance ?? (_instance = PodfileManager._());

  // upgrade ios platform.
  Future<void> upgradeIosPlatform({
    required double iosPlatform,
  }) async {
    final file = File(Constants.PODFILE_PATH);
    String contents = await file.readAsString();
    contents = contents.replaceFirst('# platform', 'platform');
    final RegExp regex = RegExp(r"platform :ios, \'(\d+\.\d+)\'");
    final RegExpMatch? match = regex.firstMatch(contents);
    if (match != null) {
      final double currentVersion = double.parse(match.group(1)!);
      if (iosPlatform > currentVersion) {
        contents =
            contents.replaceAll(regex, 'platform :ios, \'$iosPlatform\'');
      }
      await file.writeAsString(contents);
      if (iosPlatform > currentVersion) {
        Utils.printSuccess(
            text:
                '- We upgraded the ios platform from $currentVersion to $iosPlatform in [${Constants.PODFILE_PATH}] file.');
      }
    }
  }
}
