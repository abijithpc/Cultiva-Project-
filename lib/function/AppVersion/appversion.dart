import 'package:package_info_plus/package_info_plus.dart';

class Appversion {
  static Future<String> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return '${packageInfo.version} (Build ${packageInfo.buildNumber})';
  }
}
