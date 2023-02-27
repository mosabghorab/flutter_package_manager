import '../core/files_managers/app_build_gradle_manager.dart';
import '../core/files_managers/info_plist_manager.dart';
import '../core/files_managers/manifest_manager.dart';
import '../core/utils.dart';

class Geolocator {
  static Future<void> configure() async {
    // android.
    Utils.printInfo(text: 'Handling [Android] configurations...');
    Utils.printInfo(text: '------------------------------------');
    await ManifestManager.instance.addPermissions(
      permissions: [
        'INTERNET',
        'ACCESS_FINE_LOCATION',
        'ACCESS_COARSE_LOCATION',
        'ACCESS_BACKGROUND_LOCATION',
      ],
    );
    await AppBuildGradleManager.instance
        .upgradeCompileSdkVersion(compileSdkVersion: 33);

    // ios.
    Utils.printInfo(text: '------------------------------------');
    Utils.printInfo(
        text:
            '\n////////////////////////////////////////////////////////////////////\n');
    Utils.printInfo(text: 'Handling [Ios] configurations...');
    Utils.printInfo(text: '------------------------------------');
    await InfoPlistManager.instance.addPermissions(
      permissions: [
        'NSLocationWhenInUseUsageDescription',
        'NSLocationAlwaysUsageDescription',
      ],
    );
    await InfoPlistManager.instance.addDict(
        key: 'NSLocationTemporaryUsageDescriptionDictionary',
        attributes: [
          {
            'name': 'YourPurposeKey',
            'value':
                'The example App requires temporary access to the device&apos;s precise location.'
          }
        ]);
  }
}
