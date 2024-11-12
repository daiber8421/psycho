import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:phsycho/src/screens/mainscreens/appointment/widgets/request/request_card.dart';
import 'package:phsycho/src/screens/mainscreens/appointment/widgets/show/show_card.dart';
import '../../../../../imports.dart';
import '../../service/appointment_service.dart';
import 'request_filter_screen.dart';

class AppointmentRequestSection extends StatefulWidget {
  const AppointmentRequestSection({super.key});

  @override
  State<AppointmentRequestSection> createState() => _AppoinmentRequestState();
}

class _AppoinmentRequestState extends State<AppointmentRequestSection> {
   final String? userRole = SignInState.infoUser["role"];
  final String? userId = SignInState.infoUser["id"];
  final String? psicologaid = SignInState.infoUser["role"] == "0"
      ? SignInState.infoUser["psicologaid"]
      : SignInState.infoUser["jornada"] == "matinal"
          ? "3"
          : "2";
  AppoinmentService service = AppoinmentService();

  String selectedGrade = "Todos";
  String selectedCourse = "Todos";
  String selectedStatus = "Todos";
  String selectedImportanci = "Todos";
  String selectedDate = "Todos";

  Future<void> _showFilterScreen() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RequestFilterScreen(
          selectedGrade: selectedGrade,
          selectedCourse: selectedCourse,
          selectedStatus: selectedStatus,
          selectedImportanci: selectedImportanci,
          selectedDate: selectedDate,
        ),
      ),
    );

    if (result != null) {
      setState(() {
        selectedGrade = result['selectedGrade'] ?? selectedGrade;
        selectedCourse = result['selectedCourse'] ?? selectedCourse;
        selectedStatus = result['selectedStatus'] ?? selectedStatus;
        selectedImportanci = result['selectedImportanci'] ?? selectedImportanci;
        selectedDate = result['selectedDate'] ?? selectedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Base(
      background: true,
      width: width,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
       
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Text(
            "Solicitudes de citas",
            style: AddTextStyle.headContainerBase,
          ),
        ),
        if (SignInState.infoUser["role"] == "0")
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                   if (SignInState.infoUser["role"] == "0")
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colours.main2,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: _showFilterScreen,
              icon: const Icon(Icons.filter_list, size: 18),
              label: const Text(""),
            ),
          ),
                  _buildChip("Grado", selectedGrade),
                  _buildChip("Curso", selectedCourse),
                  _buildChip("Estado", selectedStatus),
                  _buildChip("Importancia", selectedImportanci),
                  _buildChip("Fecha", selectedDate),
                ],
              ),
            ),
          ),
        StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Solicitudes')
              .doc('sede principal')
              .collection("Appoinments-Jornada ${SignInState.infoUser["jornada"]}")
              .doc("Psicologa $psicologaid")
              .collection("Appointments")
              .where('grado', isEqualTo: selectedGrade == "Todos" ? null : selectedGrade)
              .where('course', isEqualTo: selectedCourse == "Todos" ? null : selectedCourse)
              .where('important', isEqualTo: SignInState.infoUser["role"] == "0" ? selectedImportanci == "Todos" ? null : selectedImportanci : null)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Text("No hay citas disponibles.");
            }

            final filteredAppointments = snapshot.data!.docs.where((doc) {
              final appointment = doc.data() as Map<String, dynamic>;
              final appointmentDateStr = appointment['fech'] ?? "";
              final appointmentDate = appointmentDateStr.split(" ")[0];

              if (selectedDate == "Todos") return true;
              return appointmentDate == selectedDate;
            }).toList();

            return ListView(
              scrollDirection: Axis.vertical,
              reverse: false,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: filteredAppointments.map((doc) {
                final appointment = doc.data() as Map<String, dynamic>;

                return AppointmentRequestBuilder(
                  idDoc: doc.id,
                  type: appointment["type"],
                  jornada: appointment["jornada"] ?? "",
                  psicologaid: appointment["psicologaid"] ?? "",
                  studentid: appointment["studentid"],
                  name: appointment['name'],
                  course: appointment['course'],
                  grado: appointment['grado'],
                  description: appointment['description'],
                  important: appointment['important'],
                  motivo: appointment['motivo'],
                  id: appointment["id"],
                  status: appointment['status'] ?? "",
                  fech: appointment['fech'] ?? "",
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }

  Widget _buildChip(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Chip(
        avatar: Icon(
          Icons.filter_alt,
          color: Colors.white70,
          size: 20,
        ),
        label: Text(
          "$label: $value",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueGrey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
  
}
