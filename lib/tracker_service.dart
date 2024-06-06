import 'dart:convert';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sleep_diary_mobile/models/user_model.dart';
import 'package:sleep_diary_mobile/repositories/user/user_repository.dart';

class TrackerService {
  static const String trackerEndpoint = '/api/v1/products/{PRODUCT_ID}/track';

  Future track(
    String target, {
    Map content = const {},
    bool withDeviceInfo = false,
  }) async {
    final environment = dotenv.get('APP_ENV');
    final user = await getUser();

    final productId = dotenv.get('PRODUCT_ID');
    final endpoint = trackerEndpoint.replaceFirst('{PRODUCT_ID}', productId);
    final url = getUrl(endpoint);

    if (withDeviceInfo) {
      content = {}
        ..addAll(content)
        ..addAll({
          'device_info': await getDeviceInfo(),
        });
    }

    content = {}
      ..addAll(content)
      ..addAll({
        "app_info": await getAppInfo(),
      });

    final response = await (Dio()).post(
      url,
      data: {
        'environment': environment,
        'target': target,
        'content': jsonEncode(content),
        'user': jsonEncode(user),
      },
    );

    print(response.data);
    print(response.statusCode);
  }

  Future<Map> getUser() async {
    
    var user = UserModel.empty();
    if (FirebaseAuth.instance.currentUser != null) {
      user = await UserRepository().fetchUserDetails();
    }

    return {
      'id': FirebaseAuth.instance.currentUser?.uid ?? "belum-login",
      'name': user.name,
      'email': FirebaseAuth.instance.currentUser?.email ?? "belum-login",
    };
  }

  String getUrl(String endpoint) {
    final baseUrl = dotenv.get('BASE_URL');

    return baseUrl + endpoint;
  }

  Future<Map> getAppInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    return {
      'app_name': packageInfo.appName,
      'package_name': packageInfo.packageName,
      'version': packageInfo.version,
      'build_number': packageInfo.buildNumber,
    };
  }

  dynamic getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

    return androidInfo.data;
  }
}
