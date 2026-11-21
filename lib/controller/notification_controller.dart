import 'package:dev_path/services/notification_helper.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class NotificationController extends GetxController {
  final GetStorage _box = GetStorage();

  static const String _notificationsKey = 'notifications_enabled';
  static const String _soundKey = 'sound_enabled';

  final RxBool isNotificationsEnabled = true.obs;
  final RxBool isSoundEnabled = true.obs;

  @override
  void onInit() {
    super.onInit();
    // Load persisted preferences (defaults to true)
    isNotificationsEnabled.value = _box.read<bool>(_notificationsKey) ?? true;
    isSoundEnabled.value = _box.read<bool>(_soundKey) ?? true;

    _syncSchedule();
  }

  Future<void> toggleNotifications(bool enabled) async {
    isNotificationsEnabled.value = enabled;
    await _box.write(_notificationsKey, enabled);

    if (enabled) {
      await NotificationHelper.requestPermission();
      await NotificationHelper.scheduleDailyReminder(
        playSound: isSoundEnabled.value,
      );
    } else {
      await NotificationHelper.cancelAll();
    }
  }

  Future<void> toggleSound(bool enabled) async {
    isSoundEnabled.value = enabled;
    await _box.write(_soundKey, enabled);

    // If notifications are active, update schedule with sound preference
    if (isNotificationsEnabled.value) {
      await NotificationHelper.scheduleDailyReminder(
        playSound: enabled,
      );
    }
  }

  Future<void> sendTestNotification({
    String title = 'Learning Path 🚀',
    String body = 'Notifications are active! Keep growing every day.',
  }) async {
    if (!isNotificationsEnabled.value) return;
    await NotificationHelper.showNotification(
      title: title,
      body: body,
      playSound: isSoundEnabled.value,
    );
  }

  void _syncSchedule() {
    if (isNotificationsEnabled.value) {
      NotificationHelper.scheduleDailyReminder(
        playSound: isSoundEnabled.value,
      );
    } else {
      NotificationHelper.cancelAll();
    }
  }
}
