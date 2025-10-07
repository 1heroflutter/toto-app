abstract class NotificationRepository {
  Future<void> init({Function(String? payload)? onTap});

  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime date,
    String? payload,
  });

  Future<void> cancelNotification(int id);

  Future<void> cancelAll();
}
