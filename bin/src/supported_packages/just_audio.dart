import '../core/files_managers/info_plist_manager.dart';
import '../core/files_managers/manifest_manager.dart';
import '../core/utils.dart';

class JustAudio {
  static Future<void> configure() async {
    // android.
    Utils.printInfo(text: 'Handling [Android] configurations...');
    Utils.printInfo(text: '------------------------------------');
    await ManifestManager.instance.addPermissions(
      permissions: [
        'INTERNET',
      ],
    );
    await ManifestManager.instance.addAttributeToApplicationTag(
        name: 'usesCleartextTraffic', value: 'true');

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
    await InfoPlistManager.instance
        .addDict(key: 'NSAppTransportSecurity', attributes: [
      {
        'name': 'NSAllowsArbitraryLoads',
        'value': true,
      }
    ]);
  }
}
