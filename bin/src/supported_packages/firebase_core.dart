import '../core/files_managers/app_build_gradle_manager.dart';
import '../core/files_managers/build_gradle_manager.dart';
import '../core/files_managers/manifest_manager.dart';
import '../core/utils.dart';

class FirebaseCore {
  static Future<void> configure() async {
    // android.
    Utils.printInfo(text: 'Handling [Android] configurations...');
    Utils.printInfo(text: '------------------------------------');
    await ManifestManager.instance.addPermissions(
      permissions: [
        'INTERNET',
      ],
    );
    await AppBuildGradleManager.instance.addGoogleServicesPlugin();
    await AppBuildGradleManager.instance.enableMultiDex();
    await BuildGradleManager.instance.addGoogleServicesClasspath();

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
