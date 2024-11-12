import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:phsycho/src/imports.dart';
import 'package:phsycho/src/screens/mainscreens/appointment/service/appointment_service.dart';
import 'package:phsycho/src/screens/mainscreens/other/historial/formularios/form1.dart';
import 'package:phsycho/src/screens/mainscreens/other/historial/formularios/form2.dart';
import 'package:phsycho/src/screens/mainscreens/other/historial/formularios/form3.dart';
import 'package:phsycho/src/screens/mainscreens/other/historial/formularios/form4.dart';
import 'package:phsycho/src/screens/mainscreens/other/historial/formularios/form5.dart';
import 'package:phsycho/src/screens/mainscreens/other/historial/formularios/form6.dart';
import 'package:phsycho/src/screens/mainscreens/other/historial/formularios/form7.dart';
import 'package:phsycho/src/screens/mainscreens/other/historial/formularios/form8.dart';
import 'package:phsycho/src/screens/mainscreens/other/historial/formularios/form9.dart';
import 'package:phsycho/src/screens/mainscreens/other/historial/formularios/form10.dart';
import 'package:phsycho/src/screens/mainscreens/other/historial/formularios/form11.dart';

class PageViewForm extends StatefulWidget {
  PageViewForm(
      {super.key,
      required this.studentCourse,
      required this.studentGrade,
      required this.studentId,
      required this.studentName,
      required this.psicologaid,
      required this.idCita});

  final String studentId;
  final String studentName;
  final String studentGrade;
  final String studentCourse;
  final String idCita;
  final String psicologaid;

  @override
  PageViewFormState createState() => PageViewFormState();
}

class PageViewFormState extends State<PageViewForm> {
  static final PageController pageController = PageController();
  static int currentPage = 0;
  bool historial = false;
  static Map<String, dynamic> exists = {};

  @override
  void initState() {
    super.initState();
    _checkHistorial();
  }

  Future<void> _checkHistorial() async {
    exists = await exitshistorial(widget.studentId);
    setState(() {
      historial = exists["bool"];
    });
  }

  static void nextPage() {
    if (currentPage < 11) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  bool isLoading = false;

  static void previousPage() {
    if (currentPage > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<Map<String, dynamic>> exitshistorial(String id) async {
    try {
      QuerySnapshot historial = await FirebaseFirestore.instance
          .collection("historiales-clinicos")
          .doc(id)
          .collection("historial")
          .limit(1)
          .get();

      // Verifica si hay documentos y extrae el id del primer documento
      if (historial.docs.isNotEmpty) {
        return {
          "id": historial
              .docs[0].id, // Cambia 'id' si necesitas un campo específico
          "bool": true,
        };
      } else {
        return {
          "id": null, // o algún valor por defecto
          "bool": false,
        };
      }
    } catch (e) {
      // Manejo de errores: devolver un mapa indicando que hubo un error
      return {
        "id": null,
        "bool": false,
        "error": e.toString(),
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: pageController,
              onPageChanged: (int page) {
                setState(() {
                  currentPage = page;
                });
              },
              children: _buildFormPages(),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildFormPages() {
    if (historial) {
      // Si historial es true, retorna el formulario de seguimiento
      return [
        FollowUpForm(
          studentId: widget.studentId,
          idCita: widget.idCita,
        ),
      ];
    }
    if (!historial) {
      // Si historial es false, retorna los formularios
      return [
        _buildFormPage(Form1(
          studentCourse: widget.studentCourse,
          studentGrade: widget.studentGrade,
          studentId: widget.studentId,
          studentName: widget.studentName,
        )),
        _buildFormPage(Form2()),
        _buildFormPage(Form3()),
        _buildFormPage(Form4()),
        _buildFormPage(Form5()),
        _buildFormPage(Form6()),
        _buildFormPage(Form7()),
        _buildFormPage(Form8()),
        _buildFormPage(Form9()),
        _buildFormPage(Form10()),
        _buildFormPage(Form11()),
      ];
    } else {
      return [];
    }
  }

  // Página con un cuadro blanco y sombra
  Widget _buildFormPage(Widget form) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width > 800 ? 500 : 0,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              spreadRadius: 2,
              offset: Offset(0, 2), // Sombra hacia abajo
            ),
          ],
        ),
        padding: const EdgeInsets.all(16.0),
        child: form,
      ),
    );
  }
// Formulario de seguimiento mejorado
}

class FollowUpForm extends StatefulWidget {
  final String studentId;
  final String idCita;

  const FollowUpForm({
    Key? key,
    required this.studentId,
    required this.idCita,
  }) : super(key: key);

  @override
  _FollowUpFormState createState() => _FollowUpFormState();
}

class _FollowUpFormState extends State<FollowUpForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _recommendationsController =
      TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  String? _emotionalState;
  bool isLoading = false;

  Future<void> handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
    });

    try {
      await FirebaseFirestore.instance
          .collection("historiales-clinicos")
          .doc(widget.studentId)
          .collection("historial")
          .doc(widget.idCita)
          .collection("seguimientos")
          .add({
        "Notas": _notesController.text,
        "estado": _emotionalState,
        "recomendaciones": _recommendationsController.text,
        "fecha de creacion": DateTime.now(),
      });
      AppoinmentService().actualizarestado(
          "Resuelta",
          SignInState.infoUser["psicologaid"],
          SignInState.infoUser["jornada"],
          widget.idCita,
          "1");
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al enviar el formulario: $error")),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width > 800 ? 500 : 0,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 12,
              spreadRadius: 2,
              offset: Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.psychology, color: Colors.blueAccent, size: 28),
                  const SizedBox(width: 8),
                  AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'Seguimiento de Cita de Psicología',
                        textStyle:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueAccent,
                                ),
                        speed: const Duration(milliseconds: 100),
                      ),
                    ],
                    isRepeatingAnimation: false,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: widget.studentId,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'ID del Estudiante',
                  labelStyle: TextStyle(color: Colors.blueAccent),
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person, color: Colors.blueAccent),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: widget.idCita,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'ID de la cita',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _recommendationsController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Recomendaciones',
                  hintText: 'Escribe tus recomendaciones aquí...',
                  labelStyle: TextStyle(color: Colors.blueAccent),
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.note, color: Colors.blueAccent),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa recomendaciones.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Text(
                'Estado emocional del estudiante:',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _emotionalState,
                items: [
                  DropdownMenuItem(value: 'Feliz', child: Text('😊 Feliz')),
                  DropdownMenuItem(value: 'Triste', child: Text('😢 Triste')),
                  DropdownMenuItem(value: 'Ansioso', child: Text('😟 Ansioso')),
                  DropdownMenuItem(
                      value: 'Estresado', child: Text('😖 Estresado')),
                  DropdownMenuItem(value: 'Neutral', child: Text('😐 Neutral')),
                ],
                onChanged: (value) {
                  setState(() {
                    _emotionalState = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Selecciona el estado emocional',
                  labelStyle: TextStyle(color: Colors.blueAccent),
                  border: OutlineInputBorder(),
                  prefixIcon:
                      Icon(Icons.sentiment_satisfied, color: Colors.blueAccent),
                ),
                validator: (value) {
                  if (value == null) {
                    return 'Por favor selecciona un estado emocional.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _notesController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Notas adicionales',
                  hintText: 'Escribe notas adicionales aquí...',
                  labelStyle: TextStyle(color: Colors.blueAccent),
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.comment, color: Colors.blueAccent),
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton.icon(
                  onPressed: !isLoading ? handleSubmit : null,
                  icon: !isLoading
                      ? Icon(Icons.send)
                      : CircularProgressIndicator(
                          color: Colors.white, strokeWidth: 2),
                  label: Text(
                    !isLoading ? 'Enviar' : "Cargando...",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 20),
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
