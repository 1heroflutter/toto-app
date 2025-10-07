import '../repositories/notifcation_repository.dart';

class ScheduleNotificationParams {
  final int id;
  final String title;
  final String body;
  final DateTime date;
  final String? payload;

  ScheduleNotificationParams({
    required this.id,
    required this.title,
    required this.body,
    required this.date,
    this.payload,
  });
}

class ScheduleNotificationUseCase {
  final NotificationRepository repo;

  ScheduleNotificationUseCase(this.repo);

  Future<void> call(ScheduleNotificationParams params) =>
      repo.scheduleNotification(
        id: params.id,
        title: params.title,
        body: params.body,
        date: params.date,
        payload: params.payload,
      );
}

class CancelNotificationUseCase {
  final NotificationRepository repo;

  CancelNotificationUseCase(this.repo);

  Future<void> call(int id) => repo.cancelNotification(id);
}
