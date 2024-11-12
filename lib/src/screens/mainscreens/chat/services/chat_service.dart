import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:phsycho/src/imports.dart';
import 'package:uuid/uuid.dart';

import '../widgets/message_data_builder.dart';

class ChatService {
  //obetener instacias
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //obtener user stream
  Stream<List<Map<String, dynamic>>> getUsers() {
    return _firestore.collection('Usuarios-E').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });

    //enviar mensaje

    //obetener mensjae
  }

  String getDate(String camp) {
    return SignInState.infoUser[camp];
  }

  Future<void> sendMessage(
      String message, String receilverid, String nameSender) async {
    //usar info del usuario
    final String currentUserID = SignInState.infoUser["id"];
    final Timestamp timestamp = Timestamp.now();

    //crear mensaje
    Message newMessage = Message(
        nameSender: nameSender,
        messageText: message,
        senderID: currentUserID,
        receilverid: receilverid,
        timestamp: timestamp,
        messageID: generateUniqueId());
    List<String> ids = [currentUserID, receilverid];
    ids.sort();
    String chatRoomId = ids.join("_");

    await _firestore
        .collection("chatRoom")
        .doc(chatRoomId)
        .collection("message")
        .add(newMessage.toMap());
    await _firestore.collection("chatRoom").doc(chatRoomId).set({
      'estado': true,
    });

//obetener los putos mensajes (9horas haciendo esta mrd)
  }

  Stream<QuerySnapshot> getMessages(String userID, String otherUserID) {
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomId = ids.join("_");
    return _firestore
        .collection("chatRoom")
        .doc(chatRoomId)
        .collection("message")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }

  String generateUniqueId() {
    var uuid = const Uuid();
    return uuid.v4(); // Genera un UUID v4
  }

  Future<bool> actualizarestado(
      String messageID, String receiverId, String senderID) async {
    try {
      // Crear la ID de la sala de chat a partir de los IDs del remitente y el receptor
      List<String> ids = [senderID, receiverId];
      ids.sort(); // Ordenar los IDs para mantener consistencia
      String chatRoomId = ids.join("_");

      // Obtener la referencia a la colección de mensajes
      CollectionReference messageCollection = _firestore
          .collection("chatRoom")
          .doc(chatRoomId)
          .collection("message");

      // Obtener todos los mensajes ordenados por timestamp en orden ascendente (más antiguos primero)
      QuerySnapshot mensajes =
          await messageCollection.orderBy('timestamp', descending: true).get();

      // Verificar si hay mensajes en la colección
      if (mensajes.docs.isEmpty) {
        print("No hay mensajes en la sala de chat.");
        return false;
      }

      // Encontrar el mensaje con el messageID específico y su timestamp
      DocumentSnapshot? mensajeActual;
      for (var mensaje in mensajes.docs) {
        if (mensaje["messageID"] == messageID) {
          mensajeActual = mensaje;
          break;
        }
      }

      // Verificar si el mensaje con el ID fue encontrado
      if (mensajeActual == null) {
        print("El mensaje con ID $messageID no fue encontrado.");
        return false;
      }
      await FirebaseFirestore.instance
          .collection("chatRoom")
          .doc(chatRoomId)
          .collection("message")
          .doc(mensajeActual.id)
          .update({"isRead": true});
      var messageUlt = await FirebaseFirestore.instance
          .collection('chatRoom')
          .doc(chatRoomId)
          .collection("message")
          .orderBy('timestamp',
              descending:
                  true) // Orden descendente para obtener el más reciente
          .limit(1) // Limita el resultado a un mensaje
          .get();
      var recentMessage = messageUlt.docs.first.data();
      // Verificar si el mensaje con el messageID tiene isRead en true
      if (recentMessage['isRead'] == true) {
        // Iniciar una batch para realizar las actualizaciones en bloque
        WriteBatch batch = _firestore.batch();

        // Recorrer todos los mensajes anteriores o iguales a este y actualizarlos
        for (var mensaje in mensajes.docs) {
          if (mensaje['timestamp'] <= mensajeActual['timestamp'] &&
              mensaje['isRead'] == false &&
              mensaje["senderID"] != SignInState.infoUser["id"]) {
            batch.update(mensaje.reference, {"isRead": true});
          }
        }

        // Ejecutar la batch para aplicar las actualizaciones
        await batch.commit();

        print("Todos los mensajes anteriores han sido marcados como leídos.");
        return true;
      } else {
        print("El mensaje más reciente no ha sido leído.");
        return false;
      }
    } catch (e) {
      // Imprimir el error para ayudar en la depuración
      print("Error al actualizar el estado de lectura de los mensajes: $e");
      return false;
    }
  }


  Stream<List<Map<String, dynamic>>> obtenerpsicologa(String jornada) {
    return _firestore
        .collection('Usuarios-E')
        .where('jornada', isEqualTo: jornada)
        .where("role", isEqualTo: "0")
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  Stream<Map<String, dynamic>?> streamLastMessage(String infoU) {
    try {
      // Reference to the messages collection for a specific conversation
      List<String> ids = [SignInState.infoUser["id"], infoU];
      ids.sort();

      String chatRoomId = ids.join("_");
      CollectionReference messagesRef = FirebaseFirestore.instance
          .collection('chatRoom')
          .doc(chatRoomId)
          .collection("message");

      // Return a stream of the last message, ordered by timestamp
      return messagesRef
          .orderBy('timestamp',
              descending: true) // Sort by timestamp in descending order
          .limit(1) // Limit to the last message
          .snapshots() // Listen for real-time changes
          .map((snapshot) {
        if (snapshot.docs.isNotEmpty) {
          // Return the last message as a Map
          return snapshot.docs.first.data() as Map<String, dynamic>?;
        }
        return null; // If no messages, return null
      });
    } catch (e) {
      print("Error getting last message: $e");
      return Stream.value(null); // Return an empty stream in case of error
    }
  }

  Future<String?> obtenerIdMensaje(String chatRoomId, String id) async {
    try {
      // Consultar en la colección de mensajes de la sala de chat
      QuerySnapshot querySnapshot = await _firestore
          .collection("chatRoom")
          .doc(chatRoomId)
          .collection("message")
          .where("messageID", isEqualTo: id)
          .limit(1) // Limitar a un resultado
          .get();

      // Verificar si la consulta devolvió algún resultado
      if (querySnapshot.docs.isNotEmpty) {
        // Retornar la ID del primer documento encontrado
        return querySnapshot.docs.first.id;
      } else {
        print("No se encontró ningún mensaje con el contenido especificado.");
        return null;
      }
    } catch (e) {
      // Manejar errores y mostrar mensaje en consola
      print("Error al obtener la ID del mensaje: $e");
      return null;
    }
  }
}
