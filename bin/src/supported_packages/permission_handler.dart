import '../core/files_managers/app_build_gradle_manager.dart';
import '../core/utils.dart';

class PermissionHandler {
  static Future<void> configure() async {
    // android.
    Utils.printInfo(text: 'Handling [Android] configurations...');
    Utils.printInfo(text: '------------------------------------');
    await AppBuildGradleManager.instance
        .upgradeCompileSdkVersion(compileSdkVersion: 33);

    // ios.
    Utils.printInfo(text: '------------------------------------');
    Utils.printInfo(
        text:
            '\n////////////////////////////////////////////////////////////////////\n');
    Utils.printInfo(text: 'Handling [Ios] configurations...');
    Utils.printInfo(text: '------------------------------------');
    Utils.printSuccess(text: 'No configurations required for ios.');
  }
}
