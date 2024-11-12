import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderID;
  final String receilverid;
  final String messageText;
  final Timestamp timestamp;
  final String nameSender;
  final String messageID;

  Message({
    required this.messageText,
    required this.senderID,
    required this.receilverid,
    required this.timestamp,
    required this.nameSender,
    required this.messageID,

  });
  Map<String, dynamic> toMap(){
    return {
      'nameSender' : nameSender,
     'messageText': messageText,
     'senderID': senderID,
     'receilverid': receilverid,
      'timestamp': timestamp.toDate(),
      'isNotify':false,
      'isRead':false,
      'messageID':messageID,

    };
  }






}