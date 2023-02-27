import '../core/files_managers/app_build_gradle_manager.dart';
import '../core/files_managers/info_plist_manager.dart';
import '../core/files_managers/manifest_manager.dart';
import '../core/files_managers/podfile_manager.dart';
import '../core/utils.dart';

class VideoPlayer {
  static Future<void> configure() async {
    // android.
    Utils.printInfo(text: 'Handling [Android] configurations...');
    Utils.printInfo(text: '------------------------------------');
    await AppBuildGradleManager.instance
        .upgradeMinSdkVersion(minSdkVersion: 16);
    await ManifestManager.instance.addPermissions(
      permissions: [
        'INTERNET',
      ],
    );

    // ios.
    Utils.printInfo(text: '------------------------------------');
    Utils.printInfo(
        text:
            '\n////////////////////////////////////////////////////////////////////\n');
    Utils.printInfo(text: 'Handling [Ios] configurations...');
    Utils.printInfo(text: '------------------------------------');
    await PodfileManager.instance.upgradeIosPlatform(iosPlatform: 9.0);
    await InfoPlistManager.instance
        .addDict(key: 'NSAppTransportSecurity', attributes: [
      {
        'name': 'NSAllowsArbitraryLoads',
        'value': true,
      }
    ]);
  }
}
