import 'package:flutter/material.dart';

import '../services/notification_service.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificações'),
      ),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () async {
            await NotificationService.showNotification(
              id: 42,
              title: 'Exercício 4',
              body: 'Notificação disparada com payload /chat',
              payload: '/chat',
            );

            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notificação disparada!')),
              );
            }
          },
          icon: const Icon(Icons.notifications_active_outlined),
          label: const Text('Simular push local'),
        ),
      ),
    );
  }
}
