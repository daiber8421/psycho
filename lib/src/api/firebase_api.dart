import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> initializeNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  final InitializationSettings initializationSettings =
      const InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

class NotiferService {
  final List<StreamSubscription> _subscriptions = [];

  Future<void> listenForMessages(String currentUserId) async {
    _subscriptions.clear();
    print("Iniciando escucha de mensajes para el usuario: $currentUserId");

    try {
      QuerySnapshot chatRoomsSnapshot = await FirebaseFirestore.instance.collection('chatRoom').get();
      
      if (chatRoomsSnapshot.docs.isEmpty) {
        print("No se encontraron salas de chat.");
        return;
      }

      _subscriptions.clear(); // Limpiar suscripciones anteriores

      for (var chatRoomDoc in chatRoomsSnapshot.docs) {
        String chatRoomId = chatRoomDoc.id;
        List<String> participants = chatRoomId.split('_');

        if (participants.contains(currentUserId)) {
          var subscription = FirebaseFirestore.instance
              .collection("chatRoom")
              .doc(chatRoomId)
              .collection('message')
              .snapshots()
              .listen((messageSnapshot) {
            for (var messageChange in messageSnapshot.docChanges) {
              if (messageChange.type == DocumentChangeType.added) {
                var messageDoc = messageChange.doc;
                String messageContent = messageDoc.data()!.containsKey('messageText') ? messageDoc['messageText'] : "Mensaje sin contenido";

                if (messageDoc['senderID'] != currentUserId && !messageDoc['isNotify'] && messageDoc["isRead"] != true) {
                  _showNotification("Nuevo mensaje de ${messageDoc["nameSender"]}", messageContent, chatRoomId);
                  FirebaseFirestore.instance
                      .collection("chatRoom")
                      .doc(chatRoomId)
                      .collection('message')
                      .doc(messageDoc.id)
                      .update({'isNotify': true});
                }
              }
            }
          });
          _subscriptions.clear();
          cancelSubscriptions();

          _subscriptions.add(subscription);
        }
      }
    } catch (e) {
      print("Excepción durante la escucha de mensajes: $e");
    }
  }

  void cancelSubscriptions() {
    for (var subscription in _subscriptions) {
      subscription.cancel();
    }
    _subscriptions.clear();
  }
}

int _notificationId = 0;
int _groupedNotificationCount = 0;

Future<void> _showNotification(String title, String message, String chatID) async {
  const String groupKey = 'com.example.yourapp.NOTIFICATION_GROUP';

  AndroidNotificationDetails androidPlatformChannelSpecifics = const AndroidNotificationDetails(
    'your_channel_id', 
    'your_channel_name', 
    channelDescription: 'your_channel_description', 
    importance: Importance.max,
    priority: Priority.high,
    ticker: 'ticker',
    groupKey: groupKey,
    setAsGroupSummary: false,
  );

  NotificationDetails platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
  );

  await flutterLocalNotificationsPlugin.show(
    _notificationId++, 
    title,
    message,
    platformChannelSpecifics,
    payload: chatID,
  );

  _groupedNotificationCount++; 

  await flutterLocalNotificationsPlugin.show(
    0, 
    'Tienes nuevas notificaciones',
    'Has recibido $_groupedNotificationCount mensajes.',
    const NotificationDetails(
      android: AndroidNotificationDetails(
        'your_channel_id',
        'your_channel_name',
        channelDescription: 'your_channel_description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        groupKey: groupKey,
        setAsGroupSummary: true,
      ),
    ),
  );
}

void resetNotificationCount() {
  _groupedNotificationCount = 0;
}

