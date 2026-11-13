import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

import 'notification_service.dart';

const String syncTaskName = 'sync_fake_task';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    if (taskName == syncTaskName) {
      await runFakeSync();
    }
    return true;
  });
}

Future<void> initializeBackgroundSync() async {
  Workmanager().initialize(callbackDispatcher);
  await Workmanager().registerOneOffTask(
    syncTaskName,
    syncTaskName,
    initialDelay: const Duration(seconds: 10),
  );
}

Future<void> runFakeSync() async {
  final prefs = await SharedPreferences.getInstance();
  final storedMessages = prefs.getStringList('chat_messages') ?? const [];
  final timestamp = DateTime.now().toIso8601String();

  final syncMessage = {
    'sender': 'Sistema',
    'text': 'Sincronização fake concluída às $timestamp',
    'createdAt': timestamp,
  };

  storedMessages.add(jsonEncode(syncMessage));
  await prefs.setStringList('chat_messages', storedMessages);

  await NotificationService.showNotification(
    id: 101,
    title: 'Sincronização concluída',
    body: 'A conversa foi atualizada em background.',
    payload: '/chat',
  );
}
