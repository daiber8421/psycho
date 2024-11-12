import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:phsycho/src/data/vars.dart';
import 'package:phsycho/src/screens/mainscreens/appointment/service/appointment_service.dart';
import '../../../../../imports.dart';

class RequestInfoScreen extends StatelessWidget {
  const RequestInfoScreen({
    super.key,
    required this.fech,
    required this.idDoc,
    required this.jornada,
    required this.psicologaid,
    required this.studenid,
    required this.name,
    required this.important,
    required this.motivo,
    required this.grade,
    required this.course,
    required this.description,
    required this.status,
    required this.id,
  });

  final String id;
  final String name;
  final String important;
  final String motivo;
  final String grade;
  final String course;
  final String description;
  final String status;
  final String fech;
  final String studenid;
  final String psicologaid;
  final String jornada;
  final String idDoc;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    AppoinmentService service = AppoinmentService();
    return Scaffold(
      appBar: AppBar(
        title: Text("Cita de $name"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: AddContainerStyle.appBarGradient,
        ),
      ),
      body: SingleChildScrollView( // Permitir el desplazamiento en dispositivos móviles
        child: Base(
          background: true,
          width: width,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Detalles de la cita",
                style: AddTextStyle.headContainerBase.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 4,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow(Icons.person, "Nombre", name, Colors.blue),
                  _buildInfoRow(Icons.star, "Importancia", important, Colors.orange),
                  _buildInfoRow(Icons.comment, "Motivo", motivo, Colors.green),
                  _buildInfoRow(Icons.school, "Grado", grade, Colors.purple),
                  _buildInfoRow(Icons.class_, "Curso", course, Colors.teal),
                  _buildInfoRow(Icons.description, "Descripción", description, Colors.indigo),
                  _buildInfoRow(Icons.date_range, "Fecha", formatDateTo12Hour(fech), Colors.red),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Center(
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  alignment: WrapAlignment.center,
                  children: [
                    _buildActionButton(
                      text: "Aceptar solicitud",
                      color: Colors.green,
                      onPressed: () {
                        service.acceptRequest(
                          idDoc,
                          studenid,
                          psicologaid,
                          jornada,
                          description,
                          name,
                          grade,
                          course,
                          motivo,
                          service.generateuuid(),
                          fech,
                          important,
                        );
                        Navigator.pop(context);
                      },
                    ),
                    _buildActionButton(
                      text: "Cancelar solicitud",
                      color: Colors.redAccent,
                      onPressed: () {
                        // Lógica para cancelar solicitud
                      },
                    ),
                    _buildActionButton(
                      text: "Asignar hora",
                      color: Colors.blueAccent,
                      onPressed: () {
                        // Lógica para asignar hora
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: color),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          Flexible( // Asegurar que el texto no desborde
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required String text,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );
  }
}
