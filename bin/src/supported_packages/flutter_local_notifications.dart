import '../core/files_managers/app_delegate_manager.dart';
import '../core/utils.dart';

class FlutterLocalNotifications {
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
    await AppDelegateManager.instance.addUNUserNotificationCenterDelegate();
  }
}
