import '../core/files_managers/manifest_manager.dart';
import '../core/utils.dart';

class FirebaseMessaging {
  static Future<void> configure() async {
    // android.
    Utils.printInfo(text: 'Handling [Android] configurations...');
    Utils.printInfo(text: '------------------------------------');
    await ManifestManager.instance.addPermissions(
      permissions: [
        'INTERNET',
        'POST_NOTIFICATIONS',
      ],
    );
    await ManifestManager.instance.addIntentFilter(
      actionName: 'FLUTTER_NOTIFICATION_CLICK',
      categoryName: 'android.intent.category.DEFAULT',
    );

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
