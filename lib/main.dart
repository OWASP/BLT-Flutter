import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'src/app.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

// Application's entry point
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const SENTRY_DSN = "https://example-234234324.com/4504877879197696";
  await SentryFlutter.init(
    (options) {
      options.dsn = SENTRY_DSN;
      options.tracesSampleRate = 1.0;
    },
    appRunner: () => runApp(BLT()),
  );
}

const platform = MethodChannel('com.apps.blt/image_paste');

Future<Uint8List?> _getImageFromClipboard() async {
  try {
    final Uint8List? imageBytes = await platform.invokeMethod('getImageFromClipboard');
    return imageBytes;
  } on PlatformException catch (e) {
    print('Failed to get image from clipboard: ${e.message}');
    return null;
  }
}
