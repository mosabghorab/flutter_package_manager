class Utils {
  // print info.
  static void printInfo({
    required String text,
  }) {
    print('\x1B[33m$text\x1B[0m');
  }

  // print success.
  static void printSuccess({
    required String text,
  }) {
    print('\x1B[32m$text\x1B[0m');
  }

  // print error.
  static void printError({
    required String text,
  }) {
    print('\x1B[31m$text\x1B[0m');
  }

  // show loading.
  // static Function showLoading({
  //   required String text,
  // }) {
  //   bool loading = true;
  //   void stop() {
  //     loading = false;
  //   }
  //
  //   load();
  //   return stop;
  // }
  //
  // static void load() async {
  //   for (int j = 0; j < 3; j++) {
  //     for (int i = 0; i <= 100; i++) {
  //       print('gfdgfdgd');
  //       print('gfdgfdgd');
  //       print('gfdgfdgd');
  //       drawProgressBar(i / 100.0, 20);
  //       await Future.delayed(const Duration(milliseconds: 25));
  //     }
  //   }
  // }
  //
  // static void drawProgressBar(double amount, int size) {
  //   final limit = (size * amount).toInt();
  //   stdout.write(
  //     '\r\x1b[38;5;75;51m' +
  //         String.fromCharCodes(List.generate(size, (int index) {
  //           if (index < limit) {
  //             return 0x2593;
  //           }
  //           return 0x2591;
  //         })) +
  //         '\x1b[0m',
  //   );
  // }
}
