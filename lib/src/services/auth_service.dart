import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart' show kIsWeb; // detecta si es web
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart'; // usa este en lugar de widgets si estás usando Material design
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../screens/signin/signin.dart';

// para evitar errores en plataformas móviles o desktop(gey el que lo borre jonerick mlp)
import 'package:universal_html/html.dart' if (dart.library.html) 'dart:html'
    as html;

final FirebaseAuth _auth = FirebaseAuth.instance;

class AuthService {
  // Cerrar sesión
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
 final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // Función para obtener el token y guardarlo en Firestore
  Future<void> saveTokenToFirestore(String userId) async {
    try {
      // Obtener el token FCM
      String? token = await _firebaseMessaging.getToken();

      if (token != null) {
        // Referencia a la colección donde se guardarán los tokens
        DocumentReference userDoc = FirebaseFirestore.instance
            .collection('Usuarios-E') // Cambia por el nombre de tu colección
            .doc(userId); // El documento del usuario

        // Actualizar o agregar el token FCM en el campo 'fcmToken'
        await userDoc.update({
          'fcmToken': token,
        });

        print("Token guardado exitosamente en Firestore.");
      } else {
        print("No se pudo obtener el token.");
      }
    } catch (e) {
      print("Error al guardar el token en Firestore: $e");
    }
  }
   void requestPermissions() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
   }


Future<Map<String, dynamic>> checkIfUserExists(
    String id, String codigoInstitucional, String password) async {
  try {
    print(
        'Iniciando verificación de usuario con ID: $id, Código Institucional: $codigoInstitucional y Password: $password');

    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await firestore
        .collection('Usuarios-E')
        .where('id', isEqualTo: id)
        .where('codigoInstitucional', isEqualTo: codigoInstitucional)
        .where('password', isEqualTo: password)
        .get();

    print('Consulta realizada con ${querySnapshot.docs.length} resultados');

    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot idUsuario = querySnapshot.docs.first;
        if (!kIsWeb) {
          requestPermissions();
          saveTokenToFirestore(idUsuario.id);
        }
      
      
      print('Usuario encontrado: ${idUsuario.id}');
      return {
        "exists": true,
        "documentID": idUsuario.id,
        "name": idUsuario.get("name"),
        'jornada':idUsuario.get("jornada"),
        "age": idUsuario.get("age"),
        "gender": idUsuario.get("gender"),
        "role": idUsuario.get("role"),
        'id': idUsuario.get("id"),
        'course': idUsuario.get('course'),
        'grade': idUsuario.get('grade'),
        'psicologaid':idUsuario.get('role')=="0"? idUsuario.get('psicologaid'): "NONE"
      };
    } else {
      print('Usuario no encontrado');
      return {"exists": false, "error": "Usuario no encontrado"};
    }
  } catch (e) {
    print('Error encontrado: $e');
    return {"exists": false, "error": e.toString()};
  }
}

// Funciones relacionadas con el almacenamiento local (solo web)

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<void> guardarToken(String key, Map<String, dynamic> token) async {
    String jsonString = jsonEncode(token);
    if (kIsWeb) {
      html.window.localStorage[key] = jsonString;
    } else {
      await _secureStorage.write(key: key, value: jsonString);
    }
  }

  Future <Map<String, dynamic>> obtenerToken(String key) async {
    if (kIsWeb) {
      String? jsonString = html.window.localStorage[key];
      if (jsonString != null) {
        return jsonDecode(jsonString) as Map<String, dynamic>;
      }
    } else {
      String? jsonString = await _secureStorage.read(key: key);
      if (jsonString != null) {
        return jsonDecode(jsonString) as Map<String, dynamic>;
      }
    }
    return {}; // Retornar null si no se encuentra el token
  }

  Future<void> eliminarToken(String key) async {
    if (kIsWeb) {
            html.window.localStorage.remove(key);
       html.window.localStorage.clear();

    } else {
      await _secureStorage.delete(key: key);
      await _secureStorage.deleteAll();
      
    }
  }



Future<void> refreshUserInfo(
    String userId, BuildContext context, String id) async {
  final firestore = FirebaseFirestore.instance;

  try {
    // Obtener el documento del usuario
    final doc = await firestore.collection('Tokens').doc(userId).get();

    if (doc.exists) {
      // Llenar `infoUser` con la información del documento
      SignInState.infoUser = {
        'exists': true,
        'documentID': doc.id,
        'jornada':doc.get("jornada"),
        'name': doc.get('name'),
        'age': doc.get('age'),
        'gender': doc.get('gender'),
        'role': doc.get('role'),
        'id': doc.get('id'),
        'course': doc.get('course'),
        'grade': doc.get('grade'),
        'psicologaid':doc.get('role')=="0"? doc.get('psicologaid'): "NONE"
      };
    } else {
      // Si el documento no existe, vacía `infoUser` y redirige a login
      SignInState.infoUser = {
        'exists': false,
        'documentID': '',
        'name': '',
        'age': '',
        'gender': '',
        'role': '',
        'id': ''
      };
      Navigator.pushReplacementNamed(context, 'signin');
    }
  } catch (e) {
    print('Error al obtener la información del usuario: $e');
    // Manejo de errores, por ejemplo, redirigir a login
    SignInState.infoUser = {
      'exists': false,
      'documentID': '',
      'name': '',
      'age': '',
      'gender': '',
      'role': '',
      'id': 'id'
    };
    Navigator.pushReplacementNamed(context, 'signin');
  }
}
