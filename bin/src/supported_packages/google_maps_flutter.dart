import 'dart:io';

import '../core/files_managers/app_build_gradle_manager.dart';
import '../core/files_managers/app_delegate_manager.dart';
import '../core/files_managers/info_plist_manager.dart';
import '../core/files_managers/manifest_manager.dart';
import '../core/files_managers/podfile_manager.dart';
import '../core/utils.dart';

class GoogleMapsFlutter {
  static Future<void> configure() async {
    print(
        'Enter your google map api key here. [press enter if you do not have one yet]:');
    String apiKey = await stdin.readLineSync() ?? '';
    // android.
    Utils.printInfo(text: 'Handling [Android] configurations...');
    Utils.printInfo(text: '------------------------------------');
    await ManifestManager.instance.addPermissions(
      permissions: [
        'INTERNET',
        'ACCESS_COARSE_LOCATION',
        'ACCESS_FINE_LOCATION',
      ],
    );
    await ManifestManager.instance.addMetaData(
      name: 'com.google.android.geo.API_KEY',
      value: apiKey,
    );
    await AppBuildGradleManager.instance
        .upgradeMinSdkVersion(minSdkVersion: 20);

    // ios.
    Utils.printInfo(text: '------------------------------------');
    Utils.printInfo(
        text:
            '\n////////////////////////////////////////////////////////////////////\n');
    Utils.printInfo(text: 'Handling [Ios] configurations...');
    Utils.printInfo(text: '------------------------------------');
    await InfoPlistManager.instance.addPermissions(
      permissions: [
        'NSLocationAlwaysUsageDescription',
        'NSLocationWhenInUseUsageDescription',
      ],
    );
    await AppDelegateManager.instance.addGMSService(apikey: apiKey);
    await PodfileManager.instance.upgradeIosPlatform(iosPlatform: 9.0);
  }
}
