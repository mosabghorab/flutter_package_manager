import '../core/files_managers/info_plist_manager.dart';
import '../core/files_managers/podfile_manager.dart';
import '../core/utils.dart';

class VideoTrimmer {
  static Future<void> configure() async {
    // android.
    Utils.printInfo(text: 'Handling [Android] configurations...');
    Utils.printInfo(text: '------------------------------------');
    Utils.printSuccess(text: 'No configurations required for android.');

    // ios.
    Utils.printInfo(text: '------------------------------------');
    Utils.printInfo(
        text:
            '\n////////////////////////////////////////////////////////////////////\n');
    Utils.printInfo(text: 'Handling [Ios] configurations...');
    Utils.printInfo(text: '------------------------------------');
    await InfoPlistManager.instance.addPermissions(permissions: [
      'NSCameraUsageDescription',
      'NSPhotoLibraryUsageDescription',
      'NSMicrophoneUsageDescription'
    ]);
    await PodfileManager.instance.upgradeIosPlatform(iosPlatform: 10.0);
  }
}
