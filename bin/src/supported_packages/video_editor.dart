import '../core/files_managers/app_build_gradle_manager.dart';
import '../core/files_managers/podfile_manager.dart';
import '../core/utils.dart';

class VideoEditor {
  static Future<void> configure() async {
    // android.
    Utils.printInfo(text: 'Handling [Android] configurations...');
    Utils.printInfo(text: '------------------------------------');
    await AppBuildGradleManager.instance
        .upgradeMinSdkVersion(minSdkVersion: 24);

    // ios.
    Utils.printInfo(text: '------------------------------------');
    Utils.printInfo(
        text:
            '\n////////////////////////////////////////////////////////////////////\n');
    Utils.printInfo(text: 'Handling [Ios] configurations...');
    Utils.printInfo(text: '------------------------------------');
    await PodfileManager.instance.upgradeIosPlatform(iosPlatform: 12.1);
  }
}
