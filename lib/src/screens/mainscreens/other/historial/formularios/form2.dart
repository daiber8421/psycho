import 'package:phsycho/src/screens/mainscreens/other/historial/widget/stepper.dart';
import "../../../../../imports.dart";
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "../widget/provaiderform.dart"; // Importa el provider
import 'form3.dart'; // Redirige a form2

class Form2 extends StatefulWidget {
  const Form2({super.key});

  @override
  _Form2State createState() => _Form2State();
}

class _Form2State extends State<Form2> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nombrepadreController = TextEditingController();
  final TextEditingController _edadpadreController = TextEditingController();
  final TextEditingController _telpadreController = TextEditingController();
  final TextEditingController _nescolarpadreController = TextEditingController();
  final TextEditingController _profepadreController = TextEditingController();
  final TextEditingController _hlaboralpadreController = TextEditingController();
  final TextEditingController _nombremadreController = TextEditingController();
  final TextEditingController _edadmadreController = TextEditingController();
  final TextEditingController _telmadreController = TextEditingController();
  final TextEditingController _nescolarmadreController = TextEditingController();
  final TextEditingController _profemadreController = TextEditingController();
  final TextEditingController _hlaboralmadreController = TextEditingController();

  // Función reutilizable para validar campos
  String? validateField(String? value, String message) {
    if (value == null || value.isEmpty) {
      return message;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Permite ajustar la pantalla cuando aparece el teclado
      body: SingleChildScrollView(
        // Permite hacer scroll en el formulario
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Campos de texto con validación
              TextFormField(
                controller: _nombrepadreController,
                decoration: const InputDecoration(labelText: 'Nombre del Padre'),
                validator: (value) => validateField(value, 'El nombre del padre es obligatorio'),
                minLines: 1, 
               maxLines: null, 
               keyboardType: TextInputType.multiline, 
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _edadpadreController,
                decoration: const InputDecoration(labelText: 'Edad'),
                validator: (value) => validateField(value, 'La edad del padre es obligatoria'),
                minLines: 1, 
               maxLines: null, 
               keyboardType: TextInputType.multiline, 
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _telpadreController,
                decoration: const InputDecoration(labelText: 'Teléfono'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El teléfono es obligatorio';
                  }
                  if (value.length < 7) {
                    return 'El teléfono debe tener al menos 7 dígitos';
                  }
                  return null;
                },
                minLines: 1, 
               maxLines: null, 
               keyboardType: TextInputType.multiline, 
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _nescolarpadreController,
                decoration: const InputDecoration(labelText: 'Nivel escolaridad'),
                validator: (value) => validateField(value, 'El nivel de escolaridad del padre es obligatorio'),
                minLines: 1, 
               maxLines: null, 
               keyboardType: TextInputType.multiline, 
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _profepadreController,
                decoration: const InputDecoration(labelText: 'Profesión u Ocupación'),
                validator: (value) => validateField(value, 'La profesión del padre es obligatoria'),
                minLines: 1, 
               maxLines: null, 
               keyboardType: TextInputType.multiline, 
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _hlaboralpadreController,
                decoration: const InputDecoration(labelText: 'Horario Laboral'),
                validator: (value) => validateField(value, 'El horario laboral del padre es obligatorio'),
                minLines: 1, 
               maxLines: null, 
               keyboardType: TextInputType.multiline, 
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _nombremadreController,
                decoration: const InputDecoration(labelText: 'Nombre de la Madre'),
                validator: (value) => validateField(value, 'El nombre de la madre es obligatorio'),
                minLines: 1, 
               maxLines: null, 
               keyboardType: TextInputType.multiline, 
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _edadmadreController,
                decoration: const InputDecoration(labelText: 'Edad'),
                validator: (value) => validateField(value, 'La edad de la madre es obligatoria'),
                minLines: 1, 
               maxLines: null, 
               keyboardType: TextInputType.multiline, 
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _telmadreController,
                decoration: const InputDecoration(labelText: 'Teléfono'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El teléfono es obligatorio';
                  }
                  if (value.length < 7) {
                    return 'El teléfono debe tener al menos 7 dígitos';
                  }
                  return null;
                },
                minLines: 1, 
               maxLines: null, 
               keyboardType: TextInputType.multiline, 
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _nescolarmadreController,
                decoration: const InputDecoration(labelText: 'Nivel escolaridad'),
                validator: (value) => validateField(value, 'El nivel de escolaridad de la madre es obligatorio'),
                minLines: 1, 
               maxLines: null, 
               keyboardType: TextInputType.multiline, 
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _profemadreController,
                decoration: const InputDecoration(labelText: 'Profesión u Ocupación'),
                validator: (value) => validateField(value, 'La profesión de la madre es obligatoria'),
                minLines: 1, 
               maxLines: null, 
               keyboardType: TextInputType.multiline, 
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _hlaboralmadreController,
                decoration: const InputDecoration(labelText: 'Horario Laboral'),
                validator: (value) => validateField(value, 'El horario laboral de la madre es obligatorio'),
                minLines: 1, 
               maxLines: null, 
               keyboardType: TextInputType.multiline, 
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Botón para cancelar el registro
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Provider.of<FormProvider>(context, listen: false).updateForm2(
                          _nombrepadreController.text,
                          _edadpadreController.text,
                          _telpadreController.text,
                          _nescolarpadreController.text,
                          _profepadreController.text,
                          _hlaboralpadreController.text,
                          _nombremadreController.text,
                          _edadmadreController.text,
                          _telmadreController.text,
                          _nescolarmadreController.text,
                          _profemadreController.text,
                          _hlaboralmadreController.text,
                        );
                        PageViewFormState.previousPage();
                      }
                    },
                    child: const Text('Atrás'),
                  ),
                  const SizedBox(width: 20), // Espacio entre los botones
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Provider.of<FormProvider>(context, listen: false).updateForm2(
                          _nombrepadreController.text,
                          _edadpadreController.text,
                          _telpadreController.text,
                          _nescolarpadreController.text,
                          _profepadreController.text,
                          _hlaboralpadreController.text,
                          _nombremadreController.text,
                          _edadmadreController.text,
                          _telmadreController.text,
                          _nescolarmadreController.text,
                          _profemadreController.text,
                          _hlaboralmadreController.text,
                        );
                        PageViewFormState.nextPage();
                      }
                    },
                    child: const Text('Siguiente'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
