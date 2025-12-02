import 'dart:io';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
Future<void> openAppNotificationSettings() async {
  const intent = AndroidIntent(
    action: 'android.settings.REQUEST_SCHEDULE_EXACT_ALARM',
  );
  await intent.launch();
}
class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  /// Khởi tạo plugin thông báo
  static Future<void> init() async {
    tz.initializeTimeZones();

    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('@drawable/icon');

    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
    );
    final timeZoneInfo = await FlutterTimezone.getLocalTimezone();

    // Trích xuất tên múi giờ (String) từ thuộc tính 'identifier'
    final String timeZoneName = timeZoneInfo.identifier;
    tz.setLocalLocation(tz.getLocation(timeZoneName));
    await _notificationsPlugin.initialize(initSettings);

    if (Platform.isAndroid) {
      final androidPlugin = _notificationsPlugin
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();

      // 🔴 THÊM DÒNG NÀY: Yêu cầu quyền thông báo cơ bản
      await androidPlugin?.requestNotificationsPermission();

      // Tạo Notification Channel (Nếu bạn muốn đảm bảo Channel được tạo)
      await androidPlugin?.createNotificationChannel(
        const AndroidNotificationChannel(
          'task_channel_id_v2',
          'Task Notifications',
          description: 'Channel for task reminders',
          importance: Importance.max,
        ),
      );
      final canSchedule =
          await androidPlugin?.canScheduleExactNotifications() ?? false;

      if (!canSchedule) {
        await AndroidIntent(
          action: 'android.settings.REQUEST_SCHEDULE_EXACT_ALARM',
        ).launch();
      }
    }
  }

  /// Đặt lịch thông báo
  static Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
  }) async {
    await _notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'task_channel_id',
          'Task Notifications',
          channelDescription: 'Channel for task reminders',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),

      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: 'task_payload',
      matchDateTimeComponents: null,
    );
  }

  static Future<void> cancelNotification(int id) async {
    await _notificationsPlugin.cancel(id);
  }
}