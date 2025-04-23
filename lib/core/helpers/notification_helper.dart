import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:transcation_app/core/helpers/secure_storage_helper.dart';
import 'package:transcation_app/core/networking/api_constant.dart';
import 'package:transcation_app/core/networking/http_services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:googleapis/servicecontrol/v1.dart' as servicecontrol;

// This must be a top-level function
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you need to do any initialization here
  // await Firebase.initializeApp();

  // Print the message for debugging
  debugPrint('Handling a background message: ${message.messageId}');

  // The system will automatically show the notification from FCM
}

class NotificationHelper {
  static final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;

  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
  );

  static Future<void> init() async {
    // Register background handler first
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    // Request permission for iOS
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // Set foreground notification presentation options
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Allow system alert in foreground
      badge: true, // Update the app badge
      sound: true, // Allow sound
    );

    // Initialize local notifications
    await _initLocalNotifications();

    // Initialize FCM handlers
    await _initFCM();
  }

  static Future<void> _initLocalNotifications() async {
    const androidSettings =
        AndroidInitializationSettings('@mipmap/launcher_icon');
    const iosSettings = DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );

    const initializationSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        // Handle notification tap
        final payload = details.payload;
        if (payload != null) {
          final data = json.decode(payload);
          _handleNotificationTap(data);
        }
      },
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);
  }

  static Future<void> _initFCM() async {
    // Get FCM token
    String? token = await _firebaseMessaging.getToken();
    debugPrint('FCM Token: $token');

    // Handle token refresh
    _firebaseMessaging.onTokenRefresh.listen((token) async {
      debugPrint('FCM Token Refreshed: $token');
      await submitDeviceTokenToBackend(token);
    });

    // Handle FCM messages when app is in foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Show a custom notification when in foreground
      if (message.notification != null) {
        _showNotification(
          title: message.notification?.title ?? 'New Message',
          body: message.notification?.body ?? '',
          payload: json.encode(message.data),
        );
      }
    });

    // Handle FCM messages when app is in background and user taps notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleNotificationTap(message.data);
    });
  }

  static Future<void> _showNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    final androidDetails = AndroidNotificationDetails(
      _channel.id,
      _channel.name,
      channelDescription: _channel.description,
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/launcher_icon',
    );

    final iosDetails = const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    final details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    // Generate a more unique notification ID
    final notificationId =
        DateTime.now().millisecondsSinceEpoch.remainder(100000);

    await _localNotifications.show(
      notificationId,
      title,
      body,
      details,
      payload: payload,
    );
  }

  static void _handleNotificationTap(Map<String, dynamic> data) {
    // TODO: Handle notification tap based on data
    debugPrint('Notification tapped with data: $data');
  }

  // Public method to show local notification
  static Future<void> showLocalNotification({
    required String title,
    required String body,
    Map<String, dynamic>? payload,
  }) async {
    await _showNotification(
      title: title,
      body: body,
      payload: payload != null ? json.encode(payload) : null,
    );
  }

  // Get FCM token
  static Future<String?> getFCMToken() async {
    return await _firebaseMessaging.getToken();
  }

  // Subscribe to topic
  static Future<void> subscribeToTopic(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic);
  }

  // Unsubscribe from topic
  static Future<void> unsubscribeFromTopic(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
  }

  static Future<void> submitDeviceTokenToBackend(String deviceToken) async {
    try {
      final String? accessToken = await SecureStorageHelper.getAccessToken();
      print("@@@@@@@@@@@@$accessToken");
      await HttpServices.instance.post(ApiConstant.deviceTokenEndPoint,
          body: {"device_token": deviceToken, "token": accessToken});
    } on Exception catch (e) {
      print('Error submitting device token: $e');
    }
  }

  static Future<String> getAccessToken() async {
    final serviceAccountJson = {
  "type": "service_account",
  "project_id": "ethraawallet-a1ed5",
  "private_key_id": "23b9823c6c4913828ffef3f646d4c2e14426a832",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDl5jno/2pRM2QM\nZB+ZjbgZuOwDwk4BwslDO5EfiJ+R03GWUlFv+UcqZio8NQCkNkuUZtryhvLQn8Jp\npWEvHu7XAWvPYzYVqLDzwwqkMyswxdQYHkw7mDJQPepITSe1SFUP6VU4C7ObvU3g\nDw3jsF1+fFaoCAG1WA4on0sXPykkfnt7Vt6mhKeLK9i71yh6MEgRhenuPPnFb1RZ\nGLEISeQe9sJ3Np+TVEs4cdq3KeV7Kzj4LfNybNeeLEyvSmO5JiFtpGkqPtiVI/Tk\ncBnGFRWPnFO/FdzsZIuh73zx5j9hiaEtMaoKtW5gIN+VPtVmgiHOUMII1q4bC0+P\nIer+aM/nAgMBAAECggEAOyTLaSGsXE94QafQaVSINDXaoezu3I0b8ev1HcOsKXvY\nEPAEe2YJ5OJ7oxmPnK9LKlZ7pUEKXpl7Dmq5YcH3d+Cpt6SyWUgYnd1jc3Kmfdmn\nAr1opzw0VWhYSVlwCbceCwXgIpcAEeTVj/rPe+/3XX7nXDsTFXAd1F2Gl+hr0TMr\n5uUBeMoIr8wUiLvkLiQuM81RPh/cqDu4ol+WQMga/SlV5qvg/Ob+j4flfdcZuQbe\nYRXEuybmuPYoZYLpStF9BPBxKEQQgesTsxdXkdMp8zY6gMXLYNfR0L/On6os6GbY\n+pJEEblpordFYkW8hVnoHFxORzYnjpmVWvNg091rwQKBgQD9ntMZzAvDfalsrOka\nfmPDek6s9mVv8FZLNzkDZKdJgu9HYGSFonFeMud4AL81XqTCUzQ8Mdn/flSfqie/\nQpeodkYWjzef1VSDwDo1RkNmhU5o+Wjb1caLD9NT4iYHQWx+3N2A831EkoeOWd/J\nxSR43VazYIOHHVnZhp4DVKfIHwKBgQDoDmztRqZMbeKPspsD7m5+hHSvxELBSE6m\n5CnEGxDnLXxZn7EBc+Sidfw/w2e38cIs6YsmUszB5bSM1dU5Dnl15ISs+B38WRzq\ndT8F8mKpqNI7zva8HRE831dD+bEWYM0AxCmqlDDDZrMBxDi9Wy3129Wi+xnGpzBH\nBBIHf/6fOQKBgQD8OS+HwD0Sta4AvhU0m+1rQf9sU76djE7Fjq3MihU0Llr4iQxv\nOhW0sLsxxMxjrzP7bfPMyWcbh+9wui+9LeTVTIp3dQbElcvvGwTIZpAxLPHFxARc\nXEWPlrV7/rQDEzVrFQvUalJyF6doEklUyBJ1gOnwilND1BS/F/mdJluV0QKBgFby\nCLgCT461YTzr847OiBHZOQseItDecbGwLUHvzi5/6WZ/Icfkj1ablE6jvTm7WECR\npHRQc612jmZyO/irxrB4VYmlUT7aeK4UDfABeBwPR+3mxqWG0o2XNNAgPsyeqlDO\nLrpd2cNsuEdCKOwxvI+wtWPiZy76N2l0SfkLaPBpAoGAQWR442FwmCOl5o0b08Am\nxDtWk7WXEoml2NzqmIYZXUAxB9yDv21XOC/U6mkg1DfCS/s4WUuZrmnd0MSqJwS9\nNQGxPH/2rK2SNRgXI1fAT2hCRm6uNWKxIBvukjsTQfY2+X58WK0Lc3TON3wfXClO\naS5XxcqntmAQJtQqNU8ynm8=\n-----END PRIVATE KEY-----\n",
  "client_email": "firebase-adminsdk-fbsvc@ethraawallet-a1ed5.iam.gserviceaccount.com",
  "client_id": "101354279660916476520",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-fbsvc%40ethraawallet-a1ed5.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
};

    List<String> scopes = [
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/firebase.messaging"
    ];
    http.Client client = await auth.clientViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
      scopes,
    );
    auth.AccessCredentials credentials =
        await auth.obtainAccessCredentialsViaServiceAccount(
            auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
            scopes,
            client);
    client.close();
    return credentials.accessToken.data;
  }

  static Future<void> sendNotification(
      String deviceToken, String title, String body) async {
    final String accessToken = await getAccessToken();
    String endpointFCM =
        'https://fcm.googleapis.com/v1/projects/ethraawallet-a1ed5/messages:send';
    final Map<String, dynamic> message = {
      "message": {
        "token": deviceToken,
        "notification": {"title": title, "body": body},
        "data": {
          "route": "serviceScreen",
        }
      }
    };

    final http.Response response = await http.post(
      Uri.parse(endpointFCM),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      },
      body: jsonEncode(message),
    );

    if (response.statusCode == 200) {
      print('Notification sent successfully');
    } else {
      print('Failed to send notification');
    }
  }
}
