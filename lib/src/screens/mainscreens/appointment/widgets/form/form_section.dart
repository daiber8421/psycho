//Nomeclatura para nombre de clases:
//NombreModulo + Identificador + Grupo
//Grupo
//screen [5modulos principales o algun widget con scaffold]
//section [widgets que no llegan al nivel de un "screen" pero manejan muchos widgets hijos]
//builder [widgets constructores, generalmente los widgets que se van a reutilizar en muchas ocasiones(al cargar datos desde db)]
//en el form de psicologa asignar el valor segun la psicologa del estudiante
import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:video_player/video_player.dart';

import '../../../../../imports.dart';
import '../../service/appointment_service.dart';
import '../show/student_selector_screen.dart';

class AppointmentFormSection extends StatefulWidget {
  const AppointmentFormSection({super.key});

  @override
  State<AppointmentFormSection> createState() => _AppointmentFormSectionState();
}

class _AppointmentFormSectionState extends State<AppointmentFormSection> {
  final _form = GlobalKey<FormState>();
  final TextEditingController _reasonC = TextEditingController();
  final TextEditingController _descriptionC = TextEditingController();
  final TextEditingController _dateC = TextEditingController();

  final TextEditingController _student = TextEditingController();
  AppoinmentService service = AppoinmentService();
  late VideoPlayerController _videoController; // Controlador del video

  late String gradoImportancia;

  @override
  void initState() {
    super.initState();
    gradoImportancia = "1";
    _videoController = VideoPlayerController.asset(
      'assets/videos/macota.mp4', // Reemplaza con la ruta de tu video local
    )..initialize().then((_) {
        setState(() {}); // Actualiza el estado cuando el video esté listo
      });
    _videoController.play();
    _videoController.setLooping(true);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (MediaQuery.of(context).size.width > 1300)
          Expanded(
            flex: 2,
            child: Container(),
          ),
        Expanded(
          flex: 8,
          child: Base(
            background: true,
            width: width,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Text(
                  "Agendar citas",
                  style: AddTextStyle.headContainerBase,
                ),
              ),
              // Formulario para agregar evento
              FormBuilder(
                key: _form,
                child: SignInState.infoUser["role"] == "0"
                    ? formPsycho()
                    : SignInState.infoUser["role"] == "1"
                        ? formStudent()
                        : SignInState.infoUser["role"] == "3"
                            ? formTeacher()
                            : const Text("Rol Inválido"),
              ),
            ],
          ),
        ),
        if (MediaQuery.of(context).size.width > 1300)
          Expanded(
            flex: 2,
            child: Container(),
          ),
        // Verificamos si el ancho es mayor a 1300
      ],
    );
  }

  Widget formPsycho() {
    return Column(
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: CustomFormBuilderTextField(
                  name: "selectStudent",
                  text: "Selección de estudiante",
                  controller: _student,
                  msgError: "Seleccione un estudiante",
                  hint: "Seleccione el estudiante a citar",
                  enabled: false,
                ),
              ),
              buttonchooser()
            ],
          ),
          AddBoxStyle.smallBox,
          CustomFormBuilderTextField(
            name: "reason",
            controller: _reasonC,
            hint: "Ingresa el motivo de la cita",
            text: "Motivo",
            msgError: "Ingrese un motivo",
          ),
          AddBoxStyle.smallBox,
          CustomFormBuilderTextField(
            name: "description",
            controller: _descriptionC,
            text: "Descripción",
            hint: "Ingresa la descripción de la cita",
            minLines: 1,
            maxLines: 10,
            msgError: "Ingrese una descripción",
          ),
          AddBoxStyle.smallBox,
          CustomBuilderDropDownButton(
              isExpanded: true,
              //initial: "Selecciona el grado de importancia",
              text: "Grado de importancia",
              hint: "Selecciona un grado de impor",
              selected: gradoImportancia,
              items: gradeIlistf.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  gradoImportancia = newValue!;
                });
              }),
          AddBoxStyle.smallBox,

          // ignore: prefer_const_constructors
          //Asignar variable de psicologa
          const CustomFormBuilderTextField(
            name: "Psicologa",
            initValue: "Lorena Acosta",
            text: "Psicologa",
            enabled: false,
          ),
        ]),
        AddBoxStyle.smallBox,
        ElevatedButton(
          onPressed: () async {
            selectedDateTime = await selectDateTime(context);
            setState(
                () {}); // Actualiza la interfaz para mostrar la fecha y hora seleccionada
          },
          child: Text("Seleccionar Fecha y Hora"),
        ),
        AddBoxStyle.smallBox,
        // Mostrar la fecha y hora seleccionada
        if (selectedDateTime != null)
          Text(
            "Fecha y Hora: ${selectedDateTime!.toLocal()}",
            style: TextStyle(fontSize: 16),
          ),
        AddBoxStyle.normalBox,
        Button(
          text: _isLoading == true ? "Cargando..." : "Agregar cita",
          onPressed: _isLoading ==
                  true // Deshabilitar el botón si está en carga
              ? null
              : () async {
                  // Validar que los campos no estén vacíos
                  if (_reasonC.text.isEmpty ||
                      _descriptionC.text.isEmpty ||
                      gradoImportancia.isEmpty ||
                      selectedDateTime == null) {
                    // Mostrar un mensaje de error o una notificación al usuario
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text("Todos los campos son obligatorios")),
                    );
                    return; // No continuar si hay campos vacíos
                  }
                  setState(() {
                    _isLoading = true;
                  });
                  _formSubmit("psicologo");
                },
        ),
      ],
    );
  }

  DateTime? selectedDateTime;

  Future<DateTime?> selectDateTime(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: Colors.blue,
              colorScheme: ColorScheme.light(primary: Colors.blue),
              buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
              dialogBackgroundColor: Colors.white,
            ),
            child: child!,
          );
        });

    if (selectedDate == null) return null;

    // Obtén las horas bloqueadas para la fecha seleccionada desde Firestore
    List<String> blockedHours = await service.getBlockedHoursForDate(
      selectedDate,
      SignInState.infoUser["jornada"],
      SignInState.infoUser["jornada"] == "matinal" ? "3" : "2",
    );

    String? selectedTime = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text("Selecciona una hora"),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
            side: BorderSide(
              color: Colors.blueAccent,
              width: 2,
              style: BorderStyle.solid, // Para obtener un borde punteado
              strokeAlign: BorderSide.strokeAlignInside,
            ),
          ),
          content: SizedBox(
            width: 800,
            child: SingleChildScrollView(
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _buildTimeBlocks(context, blockedHours),
              ),
            ),
          ),
        );
      },
    );

    if (selectedTime == null) return null;

    int hour = int.parse(selectedTime.split(':')[0]);
    int minute = int.parse(selectedTime.split(':')[1].split(' ')[0]);
    if (selectedTime.contains("PM") && hour != 12) hour += 12;
    if (selectedTime.contains("AM") && hour == 12) hour = 0;

    return DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      hour,
      minute,
    );
  }

  List<Widget> _buildTimeBlocks(
      BuildContext context, List<String> blockedHours) {
    List<String> availableHours = [];

    if (SignInState.infoUser["jornada"] == "matinal") {
      availableHours = [
        '8:00 AM',
        '8:30 AM',
        '9:00 AM',
        '9:30 AM',
        '10:00 AM',
        '10:30 AM',
        '11:00 AM',
        '11:30 AM',
      ];
    } else {
      availableHours = [
        '1:00 PM',
        '1:30 PM',
        '2:00 PM',
        '2:30 PM',
        '3:00 PM',
        '3:30 PM',
        '4:00 PM',
        '4:30 PM',
        '5:00 PM',
        '5:30 PM'
      ];
    }

    print("Blocked Hours: ${blockedHours.map((h) => "'$h'").toList()}");
    print("Available Hours: ${availableHours.map((h) => "'$h'").toList()}");

    availableHours.removeWhere((element) {
      String trimmedElement = element.trim().replaceAll(RegExp(r'\s+'), ' ');
      return blockedHours.any((blocked) {
        String trimmedBlocked = blocked.trim().replaceAll(RegExp(r'\s+'), ' ');
        return trimmedBlocked == trimmedElement;
      });
    });

    if (availableHours.isEmpty) {
      return [
        Container(
          width: double.infinity,
          height: 50,
          alignment: Alignment.center,
          child: Text(
            "No hay disponibilidad para este día",
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
        ),
      ];
    }

    return availableHours.map((time) {
      return Container(
        width: 150,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.zero,
        ),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context, time);
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            elevation: 0,
          ),
          child: Text(time),
        ),
      );
    }).toList();
  }

  static bool _isLoading = false;
  Widget formStudent() {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomFormBuilderTextField(
              name: "reason",
              controller: _reasonC,
              hint: "Ingresa el motivo de la cita",
              text: "Motivo",
              msgError: "Ingrese un motivo",
            ),
            AddBoxStyle.smallBox,
            CustomFormBuilderTextField(
              name: "description",
              controller: _descriptionC,
              text: "Descripción",
              hint: "Ingresa la descripción de la cita",
              minLines: 1,
              maxLines: 10,
              msgError: "Ingrese una descripción",
            ),
            AddBoxStyle.smallBox,
            CustomBuilderDropDownButton(
              text: "Grado de importancia",
              hint: "Selecciona un grado de importancia",
              selected: gradoImportancia,
              items: gradeIlistf.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  gradoImportancia = newValue!;
                });
              },
            ),
            AddBoxStyle.smallBox,
            const CustomFormBuilderTextField(
              name: "Psicologa",
              initValue: "Lorena Acosta",
              text: "Psicologa",
              enabled: false,
            ),
            AddBoxStyle.smallBox,
            ElevatedButton(
              onPressed: () async {
                selectedDateTime = await selectDateTime(context);
                setState(() {});
              },
              child: Text("Seleccionar Fecha y Hora"),
            ),
            AddBoxStyle.smallBox,
            if (selectedDateTime != null)
              Text(
                "Fecha y Hora: ${selectedDateTime!.toLocal()}",
                style: TextStyle(fontSize: 16),
              ),
          ],
        ),
        AddBoxStyle.smallBox,
        Button(
          text: _isLoading == true ? "Cargando..." : "Agregar cita",
          onPressed: _isLoading == true
              ? null
              : () async {
                  if (_reasonC.text.isEmpty ||
                      _descriptionC.text.isEmpty ||
                      gradoImportancia.isEmpty ||
                      selectedDateTime == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text("Todos los campos son obligatorios")),
                    );
                    return;
                  }
                  _formSubmit("estudiante");
                },
        ),
      ],
    );
  }

 void _formSubmit(String type) async {
  setState(() {
    _isLoading = true; // Establecer el estado de carga al iniciar el envío
  });

  try {
    // Consulta a la base de datos para ver si hay citas pendientes
    QuerySnapshot docss = await db
        .collection("Solicitudes")
        .doc("sede principal")
        .collection("Appoinments-Jornada ${SignInState.infoUser["jornada"]}")
        .doc(
            "Psicologa ${SignInState.infoUser["jornada"] == "matinal" ? "3" : "2"}")
        .collection("Appointments")
        .where("status", isEqualTo: "Pendiente")
        .get();
 QuerySnapshot docs = await db
        .collection("Appointments")
        .doc("sede principal")
        .collection("Appoinments-Jornada ${SignInState.infoUser["jornada"]}")
        .doc(
            "Psicologa ${SignInState.infoUser["jornada"] == "matinal" ? "3" : "2"}")
        .collection("Appointments")
        .where("status", isEqualTo: "Pendiente")
        .get();

    // Verificar si hay citas pendientes
    if (docs.docs.isNotEmpty || docss.docs.isNotEmpty) {
      _clearForm();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Ya cuentas con una cita o solicitud pendiente. Por favor, espera su validación.")),
      );
      return;
    }

    // Agregar cita dependiendo del tipo
    if (type == "estudiante") {
      await service.addAppointment(
        SignInState.infoUser["name"],
        gradoImportancia,
        _reasonC.text,
        SignInState.infoUser["grade"],
        SignInState.infoUser["course"],
        _descriptionC.text,
        "SE",
        SignInState.infoUser["jornada"] == "matinal" ? "3" : "2",
        SignInState.infoUser["jornada"],
        service.generateuuid(),
        "Pendiente",
        SignInState.infoUser["id"],
        selectedDateTime.toString(),
      );
    } else if (type == "psicologo") {
      await service.addAppointment(
        StudentSelectorScreenState.datap["name"],
        gradoImportancia,
        _reasonC.text,
        StudentSelectorScreenState.datap["grade"],
        StudentSelectorScreenState.datap["course"],
        _descriptionC.text,
        "SP",
        SignInState.infoUser["psicologaid"],
        SignInState.infoUser["jornada"],
        service.generateuuid(),
        "Pendiente",
        StudentSelectorScreenState.datap["id"],
        selectedDateTime.toString(),
      );
    }

    // Limpiar los campos después de un envío exitoso
    _clearForm();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Cita solicitada exitosamente.")),
    );

  } catch (e) {
    // Manejar errores durante el envío
    print("Error al solicitar la cita: $e"); // Imprimir el error en la consola
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error al solicitar la cita.")),
    );
  } finally {
    setState(() {
      _isLoading = false; // Restablecer el estado de carga, sin importar si hubo un error o no
    });
  }
}

// Método auxiliar para limpiar los campos del formulario
void _clearForm() {
  _reasonC.clear();
  _descriptionC.clear();
  gradoImportancia = "1"; // Restablecer el grado de importancia
  selectedDateTime = null; // Limpiar la fecha y hora seleccionada
}


  Widget buttonchooser() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StudentSelectorScreen(controller: _student),
            ),
          );
        },
        child: const Icon(
          Icons.person_search,
        ),
      ),
    );
  }

  Widget formTeacher() {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OpenContainer(
              closedColor: Colors.white,
              closedBuilder: (ctx, action) => CustomFormBuilderTextField(
                name: "selectStudent",
                text: "Selección de estudiante",
                controller: _student,
                msgError: "Seleccione un estudiante",
                hint: "Seleccione el estudiante a citar",
                enabled: false,
              ),
              openBuilder: (ctx, action) => StudentSelectorScreen(
                controller: _student,
              ),
            ),
            AddBoxStyle.smallBox,
            CustomFormBuilderTextField(
              name: "reason",
              controller: _reasonC,
              hint: "Ingresa el motivo de la cita",
              text: "Motivo",
              msgError: "Ingrese un motivo",
            ),
            AddBoxStyle.smallBox,
            CustomFormBuilderTextField(
              name: "description",
              controller: _descriptionC,
              text: "Descripción",
              hint: "Ingresa la descripción de la cita",
              minLines: 1,
              maxLines: 10,
              msgError: "Ingrese una descripción",
            ),
            AddBoxStyle.smallBox,
            CustomBuilderDropDownButton(
                //initial: "Selecciona el grado de importancia",
                text: "Grado de importancia",
                hint: "Selecciona un grado de impor",
                selected: gradoImportancia,
                items:
                    gradeIlistf.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    gradoImportancia = newValue!;
                  });
                }),
            AddBoxStyle.smallBox,
            const CustomFormBuilderTextField(
              name: "Psicologa",
              initValue: "Lorena Acosta",
              text: "Psicologa",
              enabled: false,
            ),
          ],
        ),
        AddBoxStyle.smallBox,
        const Button(
          text: "Agregar cita",
        ),
      ],
    );
  }
}
