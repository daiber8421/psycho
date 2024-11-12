import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:phsycho/src/imports.dart';

import 'show_info_screen.dart';

class AppointmentBuilder extends StatelessWidget {
  final String name;
  final String important;
  final String motivo;
  final String grado;
  final String course;
  final String description;
  final String status;
  final String id;
  final String fech;
  final String type;
  final String studentid;
  final String jornada;
  final String psicologaid;


  const AppointmentBuilder({
    super.key,
 
    required this.type,
    required this.studentid,
    required this.name,
    required this.important,
    required this.motivo,
    required this.grado,
    required this.course,
    required this.fech,
    required this.jornada,
    required this.psicologaid,
    required this.description,
    required this.status,
    required this.id,
  });
  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'studentid': studentid,
      'name': name,
      'course': course,
      'grado': grado,
      'important': important,
      'description': description,
      'fech': fech,
      'motivo': motivo,
      'jornada': SignInState.infoUser["jornada"],
      'id': id,
      'status': status,
      'psicologaid': psicologaid,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: OpenContainer(
        transitionDuration: const Duration(milliseconds: 500),
        closedElevation: 0,
        closedBuilder: (ctx, action) => ListTile(
          contentPadding: const EdgeInsets.all(15),
          leading: CircleAvatar(
            backgroundColor: Colors.blueAccent,
            child: Text(
              name[0].toUpperCase(),
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          title: Row(
            children: [
              Text(
                name,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(width: 10),
              Text(
                "$grado - $course",
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailText("Importancia: ", important, Colors.blueAccent),
                _buildStatusText(status),
                _buildDetailText("Motivo: ", motivo),
                _buildDetailText("Fecha: ", formatDateTo12Hour(fech)),
              ],
            ),
          ),
          trailing: const Icon(Icons.keyboard_arrow_right, color: Colors.grey),
        ),
        openBuilder: (ctx, action) => AppointmentInfoScreen(
    
          psicologaid: psicologaid,
          jornada: jornada,
          studenid: studentid,
          id: id,
          name: name,
          important: important,
          motivo: motivo,
          grade: grado,
          course: course,
          description: description,
          status: status,
          fech: fech,
        ),
      ),
    );
  }

  // Construir texto detallado con estilos personalizados
  Widget _buildDetailText(String label, String value, [Color? color]) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
              fontWeight: FontWeight.w600, color: color ?? Colors.black87),
        ),
        Text(value),
      ],
    );
  }

  // Construir texto de estado con colores y estilo según el estado
  Widget _buildStatusText(String status) {
    Color statusColor;
    String statusText;

    switch (status) {
      case "Pendiente":
        statusColor = Colors.orange;
        statusText = "Pendiente";
        break;
      case "Resuelta":
        statusColor = Colors.green;
        statusText = "Resuelta";
        break;
      case "Cancelada":
        statusColor = Colors.red;
        statusText = "Cancelada";
        break;
      case "Activa":
        statusColor = Colors.blue;
        statusText = "Activa";
        break;
      default:
        statusColor = Colors.grey;
        statusText = "Desconocido";
    }

    return Row(
      children: [
        Icon(
          Icons.circle,
          color: statusColor,
          size: 12,
        ),
        const SizedBox(width: 5),
        Text(
          "Estado: $statusText",
          style: TextStyle(fontWeight: FontWeight.w600, color: statusColor),
        ),
      ],
    );
  }
}
