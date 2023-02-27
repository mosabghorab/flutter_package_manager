import 'dart:io';

import 'core/constants.dart';
import 'core/utils.dart';
import 'supported_packages_manager.dart';

class Startup {
  // process.
  static void process() async {
    Utils.printSuccess(
        text: 'Welcome to flutter package manager(fpm) tool >>>');
    do {
      String? command = await stdin.readLineSync();
      if (command!.startsWith('fpm -i')) {
        String? packageName = command.substring(command.lastIndexOf(' ') + 1);
        Utils.printInfo(text: 'Running flutter pub add $packageName...');
        ProcessResult flutterPubAddProcessResult = await Process.run(
          'flutter',
          ['pub', 'add', packageName],
        );
        print(flutterPubAddProcessResult.stdout);
        Utils.printInfo(text: 'Running flutter pub get...');
        ProcessResult flutterPubGetProcessResult = await Process.run(
          'flutter',
          ['pub', 'get'],
        );
        print(flutterPubGetProcessResult.stdout);
        if (Constants.supportedPackages.contains(packageName)) {
          await SupportedPackagesManager.configure(packageName: packageName);
        }
        Utils.printInfo(text: '------------------------------------');
        Utils.printSuccess(text: 'Package installed successfully 👍👍');
      } else if (command.startsWith('fpm -r')) {
        String? packageName = command.substring(command.lastIndexOf(' ') + 1);
        Utils.printInfo(text: 'Running flutter pub remove $packageName...');
        ProcessResult flutterPubAddProcessResult = await Process.run(
          'flutter',
          ['pub', 'remove', packageName],
        );
        print(flutterPubAddProcessResult.stdout);
        Utils.printInfo(text: 'Running flutter pub get...');
        ProcessResult flutterPubGetProcessResult = await Process.run(
          'flutter',
          ['pub', 'get'],
        );
        print(flutterPubGetProcessResult.stdout);
        Utils.printInfo(text: '------------------------------------');
        Utils.printSuccess(text: 'Package removed successfully 👍👍');
      } else if (command.startsWith('fpm -sp')) {
        Utils.printInfo(
            text:
                'All the supported packages for configurations(${Constants.supportedPackages.length}):-');
        Constants.supportedPackages.forEach((package) {
          print(package);
        });
      } else {
        Utils.printError(text: 'Command not found , try another one 😔😔');
      }
    } while (true);
  }
}
