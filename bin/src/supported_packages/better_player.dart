import '../core/files_managers/app_build_gradle_manager.dart';
import '../core/files_managers/build_gradle_manager.dart';
import '../core/files_managers/info_plist_manager.dart';
import '../core/files_managers/podfile_manager.dart';
import '../core/utils.dart';

class BetterPlayer {
  static Future<void> configure() async {
    // android.
    Utils.printInfo(text: 'Handling [Android] configurations...');
    Utils.printInfo(text: '------------------------------------');
    await AppBuildGradleManager.instance
        .upgradeCompileSdkVersion(compileSdkVersion: 31);
    await BuildGradleManager.instance
        .upgradeKotlinVersion(kotlinVersion: '1.5.31');
    await AppBuildGradleManager.instance.enableMultiDex();

    // ios.
    Utils.printInfo(text: '------------------------------------');
    Utils.printInfo(
        text:
            '\n////////////////////////////////////////////////////////////////////\n');
    Utils.printInfo(text: 'Handling [Ios] configurations...');
    Utils.printInfo(text: '------------------------------------');
    await PodfileManager.instance.upgradeIosPlatform(iosPlatform: 11.0);
    await InfoPlistManager.instance
        .addArray(key: 'UISupportedInterfaceOrientations', values: [
      'UIInterfaceOrientationPortrait',
      'UIInterfaceOrientationLandscapeLeft',
      'UIInterfaceOrientationLandscapeRight',
    ]);
  }
}
