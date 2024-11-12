import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:phsycho/src/imports.dart';

import 'package:phsycho/src/screens/mainscreens/appointment/widgets/request/request_info_screen.dart';

class AppointmentRequestBuilder extends StatelessWidget {
  final String name;
  final String important;
  final String motivo;
  final String grado;
  final String course;
  final String description;
  final String status;
  final String id;
  final String fech;
  final String studentid;
  final String jornada;
  final String psicologaid;
  final String type;
  final String idDoc;

  const AppointmentRequestBuilder({
    super.key,
    required this.type,
    required this.idDoc,
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

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 6,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: OpenContainer(
        transitionDuration: const Duration(milliseconds: 500),
        closedElevation: 0,
        closedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        closedBuilder: (ctx, action) => Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  radius: 22,
                  child: Text(
                    name[0].toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                title: Text(
                  name,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                subtitle: Text(
                  "$course - $grado",
                  style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                ),
                trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey[600], size: 28),
              ),
              const SizedBox(height: 8),
              _buildDetailRow(
                icon: Icons.warning_amber_rounded,
                label: "Importancia",
                value: important,
                color: Colors.amber[800],
              ),
              _buildDetailRow(
                icon: Icons.info_outline,
                label: "Motivo",
                value: motivo,
                color: Colors.blue[700],
              ),
              _buildDetailRow(
                icon: Icons.date_range,
                label: "Fecha",
                value: formatDateTo12Hour(fech),
                color: Colors.green[700],
              ),
             
            ],
          ),
        ),
        openBuilder: (ctx, action) => RequestInfoScreen(
          idDoc: idDoc,
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
          fech: fech,
          status: status,
        ),
      ),
    );
  }

  Widget _buildDetailRow({required IconData icon, required String label, required String value, Color? color}) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 6),
          Text(
            "$label: ",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12, color: Colors.black87),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: color ?? Colors.black54, fontSize: 12),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }


}
