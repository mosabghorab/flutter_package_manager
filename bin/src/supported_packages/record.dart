import '../core/files_managers/app_build_gradle_manager.dart';
import '../core/files_managers/info_plist_manager.dart';
import '../core/files_managers/manifest_manager.dart';
import '../core/files_managers/podfile_manager.dart';
import '../core/utils.dart';

class Record {
  static Future<void> configure() async {
    // android.
    Utils.printInfo(text: 'Handling [Android] configurations...');
    Utils.printInfo(text: '------------------------------------');
    await ManifestManager.instance.addPermissions(
      permissions: [
        'RECORD_AUDIO',
        'WRITE_EXTERNAL_STORAGE',
      ],
    );
    await AppBuildGradleManager.instance
        .upgradeMinSdkVersion(minSdkVersion: 19);

    // ios.
    Utils.printInfo(text: '------------------------------------');
    Utils.printInfo(
        text:
            '\n////////////////////////////////////////////////////////////////////\n');
    Utils.printInfo(text: 'Handling [Ios] configurations...');
    Utils.printInfo(text: '------------------------------------');
    await InfoPlistManager.instance.addPermissions(
      permissions: [
        'NSMicrophoneUsageDescription',
      ],
    );
    await PodfileManager.instance.upgradeIosPlatform(iosPlatform: 11.0);
  }
}
