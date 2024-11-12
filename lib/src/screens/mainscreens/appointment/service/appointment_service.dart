import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../../../imports.dart';
import '../widgets/show/show_card.dart';

class AppoinmentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addAppointment(
    String name,
    String important,
    String motivo,
    String grado,
    String course,
    String description,
    String type,
    String psicologid,
    String jornada,
    String id1,
    String status,
    String studentid,
    String fech,
    //jornada de la semana
  ) async {
    //usar info del usuario

    AppointmentBuilder appo = AppointmentBuilder(
      type: type,
      studentid: studentid,
      course: course,
      name: name,
      important: important,
      grado: grado,
      description: description,
      fech: fech,
      motivo: motivo,
      id: id1,
      status: status,
      psicologaid: psicologid,
      jornada: jornada,
    );

    //crear mensaje

    List<String> ids = [psicologid];
    ids.sort();
    String id = ids.join("_");
    await _firestore
        .collection(type == "SP" ? "Appointments" : 'Solicitudes')
        .doc('sede principal')
        .collection("Appoinments-Jornada $jornada")
        .doc("Psicologa $id")
        .collection("Appointments")
        .add(appo.toMap());

//obetener los putos mensajes (9horas haciendo esta mrd)
  }

  Stream<List<Map<String, dynamic>>> getAppointment() {
    return _firestore.collection('Appontment').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final appointment = doc.data();
        return appointment;
      }).toList();
    });

    //enviar mensaje

    //obetener mensjae
  }

  String getFormattedDate(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate(); // Convierte el Timestamp a DateTime
    Intl.defaultLocale = 'es_ES'; // Configura el locale en español
    return DateFormat('d MMMM yyyy, h:mm a')
        .format(dateTime); // Formato con mes y hora 12h AM/PM
  }

  String generateuuid() {
    Uuid uuid = Uuid();
    return uuid.v4();
  }

 void actualizarestado(String estado, String psicologaid, String jornada,
    String idp, String? opcion) async {
  try {
    // Construir la referencia de la colección
    CollectionReference appointmentsRef = _firestore
        .collection('Appointments')
        .doc('sede principal')
        .collection("Appoinments-Jornada $jornada")
        .doc("Psicologa $psicologaid")
        .collection("Appointments");

    if (opcion == "1") {
      // Actualización directa usando el documento específico
      await appointmentsRef.doc(idp).update({"status": estado});
      print("Estado actualizado correctamente para el documento con id: $idp");
    } else {
      // Buscar el documento por 'id'
      QuerySnapshot querySnapshot = await appointmentsRef.where("id", isEqualTo: idp).limit(1).get();
      
      if (querySnapshot.docs.isNotEmpty) {
        await querySnapshot.docs.first.reference.update({"status": estado});
        print("Estado actualizado correctamente para el documento con id: $idp");
      } else {
        print("No se encontró ningún documento con id: $idp");
      }
    }
  } catch (e) {
    // Manejo de errores
    print("Error al actualizar el estado: ${e.toString()}");
  }
}


  Future<List<String>> getBlockedHoursForDate(
      DateTime date, String jornada, String psicologa) async {
    // Definir el inicio y el fin del día como Strings
    String startOfDayString =
        "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} 00:00:00.000";
    String endOfDayString =
        "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} 23:59:59.999";

    try {
      QuerySnapshot snapshot = await _firestore
          .collection('Appointments')
          .doc('sede principal')
          .collection("Appoinments-Jornada $jornada")
          .doc("Psicologa $psicologa")
          .collection("Appointments")
          .where('fech', isGreaterThanOrEqualTo: startOfDayString)
          .where('fech', isLessThanOrEqualTo: endOfDayString)
          .get();

      // Procesa el snapshot para extraer las horas bloqueadas en formato de texto
      return snapshot.docs.map((doc) {
        String fech = doc['fech'].trim(); // Asegúrate de usar trim()
        DateTime dateTime = DateTime.parse(fech);
        return DateFormat.jm()
            .format(dateTime)
            .trim(); // Asegúrate de usar trim()
      }).toList();
    } catch (e) {
      print("Error fetching data: $e");
      return []; // Retorna una lista vacía en caso de error
    }
  }

  Future<void> acceptRequest(
      String idDoc,
      String id,
      String psicologa,
      String jornada,
      String reason,
      String name,
      String grado,
      String course,
      String motivo,
      String id1,
      String fech,
      String importancia) async {
    try {
      await _firestore
          .collection('Solicitudes')
          .doc('sede principal')
          .collection("Appoinments-Jornada $jornada")
          .doc("Psicologa $psicologa")
          .collection("Appointments")
          .doc(idDoc)
          .delete();
      await addAppointment(
        name,
        importancia,
        motivo,
        grado,
        course,
        reason,
        "SP",
        psicologa,
        jornada,
        id1,
        "Pendiente",
        id,
        fech,
      );
      print(idDoc);
    } catch (e) {}
  }

  Future<String?> obtenerDocAppo(
      String id, String psicologa, String jornada, String idDoc) async {
    // Obtener los documentos que coinciden con la consulta
    QuerySnapshot snapshot = await _firestore
        .collection('Appointments')
        .doc('sede principal')
        .collection("Appoinments-Jornada $jornada")
        .doc("Psicologa $psicologa")
        .collection("Appointments")
        .where("id", isEqualTo: idDoc)
        .get();

    // Comprobar si se encontraron documentos y retornar el doc.id del primero
    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs.first.id; // Retorna el id del primer documento
    } else {
      return null; // Retorna null si no se encontró ningún documento
    }
  }
}
