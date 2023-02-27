import 'core/constants.dart';
import 'supported_packages/better_player.dart';
import 'supported_packages/camera.dart';
import 'supported_packages/firebase_core.dart';
import 'supported_packages/firebase_messaging.dart';
import 'supported_packages/flutter_audio_recorder2.dart';
import 'supported_packages/flutter_inappwebview.dart';
import 'supported_packages/flutter_local_notifications.dart';
import 'supported_packages/flutter_sound.dart';
import 'supported_packages/gallery_saver.dart';
import 'supported_packages/geolocator.dart';
import 'supported_packages/google_maps_flutter.dart';
import 'supported_packages/image_gallery_saver.dart';
import 'supported_packages/image_picker.dart';
import 'supported_packages/just_audio.dart';
import 'supported_packages/network_info_plus.dart';
import 'supported_packages/permission_handler.dart';
import 'supported_packages/record.dart';
import 'supported_packages/record_mp3.dart';
import 'supported_packages/video_editor.dart';
import 'supported_packages/video_player.dart';
import 'supported_packages/video_trimmer.dart';
import 'supported_packages/webview_flutter.dart';
import 'supported_packages/youtube_player_flutter.dart';

class SupportedPackagesManager {
  // handle configuration.
  static Future<void> configure({
    required packageName,
  }) async {
    switch (packageName) {
      case Constants.IMAGE_PICKER:
        await ImagePicker.configure();
        return;
      case Constants.FIREBASE_CORE:
        await FirebaseCore.configure();
        return;
      case Constants.FIREBASE_MESSAGING:
        await FirebaseMessaging.configure();
        return;
      case Constants.FLUTTER_LOCAL_NOTIFICATIONS:
        await FlutterLocalNotifications.configure();
        return;
      case Constants.GOOGLE_MAPS_FLUTTER:
        await GoogleMapsFlutter.configure();
        return;
      case Constants.GEOLOCATOR:
        await Geolocator.configure();
        return;
      case Constants.BETTER_PLAYER:
        await BetterPlayer.configure();
        return;
      case Constants.FLUTTER_SOUND:
        await FlutterSound.configure();
        return;
      case Constants.JUST_AUDIO:
        await JustAudio.configure();
        return;
      case Constants.NETWORK_INFO_PLUS:
        await NetworkInfoPlus.configure();
        return;
      case Constants.PERMISSION_HANDLER:
        await PermissionHandler.configure();
        return;
      case Constants.WEBVIEW_FLUTTER:
        await WebviewFlutter.configure();
        return;
      case Constants.YOUTUBE_PLAYER_FLUTTER:
        await YoutubePlayerFlutter.configure();
        return;
      case Constants.RECORD:
        await Record.configure();
        return;
      case Constants.FLUTTER_AUDIO_RECORDER2:
        await FlutterAudioRecorder2.configure();
        return;
      case Constants.RECORD_MP3:
        await RecordMp3.configure();
        return;
      case Constants.VIDEO_PLAYER:
        await VideoPlayer.configure();
        return;
      case Constants.VIDEO_EDITOR:
        await VideoEditor.configure();
        return;
      case Constants.VIDEO_TRIMMER:
        await VideoTrimmer.configure();
        return;
      case Constants.CAMERA:
        await Camera.configure();
        return;
      case Constants.FLUTTER_INAPPWEBVIEW:
        await FlutterInappwebview.configure();
        return;
      case Constants.IMAGE_GALLERY_SAVER:
        await ImageGallerySaver.configure();
        return;
      case Constants.GALLERY_SAVER:
        await GallerySaver.configure();
        return;
    }
  }
}
