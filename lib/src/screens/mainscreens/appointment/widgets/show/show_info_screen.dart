import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:phsycho/src/data/vars.dart';
import 'package:phsycho/src/screens/mainscreens/appointment/service/appointment_service.dart';
import 'package:phsycho/src/screens/mainscreens/appointment/widgets/show/show_card.dart';
import 'package:phsycho/src/screens/mainscreens/other/historial/historial.dart';
//Necesito el asignador de citas
import '../../../../../imports.dart';
import 'package:flutter/material.dart';

class AppointmentInfoScreen extends StatelessWidget {
  final String name;
  final String grade;
  final String course;
  final String important;
  final String motivo;
  final String description;
  final String fech;
  final String status;
  final String psicologaid;
  final String jornada;
  final String id;
  final String studenid;
  

  AppointmentInfoScreen({
   
    required this.name,
    required this.grade,
    required this.course,
    required this.important,
    required this.motivo,
    required this.description,
    required this.fech,
    required this.status,
    required this.psicologaid,
    required this.jornada,
    required this.id,
    required this.studenid,
  });

  final AppoinmentService service = AppoinmentService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cita de $name"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.lightBlue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 6,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Detalles de la Cita",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                Divider(),
                _buildDetailItem(Icons.person, "Nombre del estudiante:", name),
                _buildDetailItem(Icons.school, "Grado:", grade),
                _buildDetailItem(Icons.class_, "Curso:", course),
                _buildDetailItem(
                    Icons.priority_high, "Importancia:", important),
                _buildDetailItem(Icons.description, "Motivo:", motivo),
                _buildDetailItem(Icons.note, "Descripción:", description),
                _buildDetailItem(
                    Icons.calendar_today, "Fecha:", formatDateTo12Hour(fech)),
                _buildStatusItem(status),
                const SizedBox(height: 20),
                Center(
                  child: Wrap(
                    spacing: 8, // Espaciado horizontal entre los botones
                    runSpacing: 8, // Espaciado vertical entre las filas
                    alignment:
                        WrapAlignment.center, // Alineación de los botones
                    children: [
                      if(SignInState.infoUser["role"]=="0")
                      if(status!="Resuelta")
                      _buildActionButton("Cancelar cita", Colors.red, () {
                        service.actualizarestado(
                            "Cancelada", psicologaid, jornada, id, "2");
                        Navigator.pop(context);
                      }),
                      if(SignInState.infoUser["role"]=="0")
                      if(status!="Resuelta")
                      _buildActionButton("Resolver cita", Colors.green, () async{
                        String? idCita = await service.obtenerDocAppo(studenid, psicologaid, jornada, id);
                      
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HistorialScreen(
                              idCita: idCita??"1",
                              studentName: name,
                              studentCourse: course,
                              studentGrade: grade,
                              studentId: studenid,
                            ),
                          ),
                        );
                      }),
                      if(SignInState.infoUser["role"]=="0")
                      _buildActionButton("Ver historia", Colors.blue, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HistorialScreen(
                              idCita: "1",
                              studentName: name,
                              studentCourse: course,
                              studentGrade: grade,
                              studentId: studenid,
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueAccent),
          const SizedBox(width: 8),
          Text(label, style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(width: 8),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget _buildStatusItem(String status) {
    Color statusColor;
    IconData statusIcon;

    switch (status) {
      case "Pendiente":
        statusColor = Colors.orange;
        statusIcon = Icons.hourglass_empty;
        break;
      case "Resuelta":
        statusColor = Colors.green;
        statusIcon = Icons.check_circle;
        break;
      case "Cancelada":
        statusColor = Colors.red;
        statusIcon = Icons.cancel;
        break;
      case "Activa":
        statusColor = Colors.blue;
        statusIcon = Icons.play_circle;
        break;
      default:
        statusColor = Colors.grey;
        statusIcon = Icons.help_outline;
    }

    return Row(
      children: [
        Icon(statusIcon, color: statusColor),
        const SizedBox(width: 8),
        Text(
          "Estado de la cita: $status",
          style: TextStyle(fontWeight: FontWeight.w600, color: statusColor),
        ),
      ],
    );
  }

  Widget _buildActionButton(String text, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
