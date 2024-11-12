import 'package:phsycho/src/screens/mainscreens/other/historial/widget/stepper.dart';
import "../../../../../imports.dart";
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "../widget/provaiderform.dart"; // Importa el provider
import 'form10.dart'; // Redirige a form2

class Form9 extends StatefulWidget {
  const Form9({super.key});

  @override
  _Form9State createState() => _Form9State();
}

class _Form9State extends State<Form9> {
  final _formKey = GlobalKey<FormState>();

  // Controladores del primer formulario
  final TextEditingController _fechController = TextEditingController();
  final TextEditingController _enfermedadController = TextEditingController();
  final TextEditingController _tratamientoController = TextEditingController();
  final TextEditingController _examenesController = TextEditingController();
  final TextEditingController _valoracionController = TextEditingController();

  // Controladores del segundo formulario
  final TextEditingController _fechController2 = TextEditingController();
  final TextEditingController _enfermedadController2 = TextEditingController();
  final TextEditingController _tratamientoController2 = TextEditingController();
  final TextEditingController _examenesController2 = TextEditingController();
  final TextEditingController _valoracionController2 = TextEditingController();

  // Controladores del tercer formulario
  final TextEditingController _fechController3 = TextEditingController();
  final TextEditingController _enfermedadController3 = TextEditingController();
  final TextEditingController _tratamientoController3 = TextEditingController();
  final TextEditingController _examenesController3 = TextEditingController();
  final TextEditingController _valoracionController3 = TextEditingController();

  // Variable para seleccionar el número de formularios a mostrar
  String? _selectedFormCount = '1'; // Valor inicial: 1 formulario
  final List<String> formOptions = ['1', '2', '3']; // Opciones del dropdown

  String? validateYear(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese el año.';
    }
    if (!RegExp(r'^\d{4}$').hasMatch(value)) {
      return 'El año debe ser un número de 4 dígitos.';
    }
    return null;
  }

  String? validateNotEmpty(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese $fieldName.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Dropdown para seleccionar el número de formularios
              DropdownButton<String>(
                value: _selectedFormCount,
                isExpanded: true,
                hint: const Text('Selecciona el número de formularios'),
                items: formOptions.map((String option) {
                  return DropdownMenuItem<String>(
                    value: option,
                    child: Text(option),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedFormCount = newValue;
                  });
                },
              ),
              const SizedBox(height: 20),

              // Mostrar el primer formulario siempre
              const Text('Formulario 1'),
              TextFormField(
                controller: _fechController,
                decoration: const InputDecoration(labelText: 'AÑO'),
               minLines: 1, 
               maxLines: null, 
               keyboardType: TextInputType.multiline, 
                validator: validateYear,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _enfermedadController,
                decoration: const InputDecoration(labelText: 'ENFERMEDADES Y/O TRASTORNOS'),
                validator: (value) => validateNotEmpty(value, 'enfermedades y/o trastornos'),
                 minLines: 1, 
               maxLines: null, 
               keyboardType: TextInputType.multiline, 
              ),
               TextFormField(
                controller: _tratamientoController,
                decoration: const InputDecoration(labelText: 'TRATAMIENTOS'),
                validator: (value) => validateNotEmpty(value, 'tratamientos'), // Validación para este campo
                 minLines: 1, 
               maxLines: null, 
               keyboardType: TextInputType.multiline, 
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _examenesController,
                decoration: const InputDecoration(labelText: 'EXAMENES y/o PRUEBAS '),
                validator: (value) => validateNotEmpty(value, 'exámenes y/o pruebas'), // Validación para este campo
                 minLines: 1, 
               maxLines: null, 
               keyboardType: TextInputType.multiline, 
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _valoracionController,
                decoration: const InputDecoration(labelText: 'VALORACIONES POR ESPECIALISTAS'),
                validator: (value) => validateNotEmpty(value, 'valoraciones por especialistas'), // Validación para este campo
                 minLines: 1, 
               maxLines: null, 
               keyboardType: TextInputType.multiline, 
              ),
              const SizedBox(height: 20),

              // Mostrar el segundo formulario si selecciona "2" o "3"
              if (_selectedFormCount == '2' || _selectedFormCount == '3') ...[
                const Text('Formulario 2'),
                TextFormField(
                  controller: _fechController2,
                  decoration: const InputDecoration(labelText: 'AÑO (Form 2)'),
                   minLines: 1, 
               maxLines: null, 
               keyboardType: TextInputType.multiline, 
                  validator: validateYear,
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: _enfermedadController2,
                  decoration: const InputDecoration(labelText: 'ENFERMEDADES Y/O TRASTORNOS (Form 2)'),
                  validator: (value) => validateNotEmpty(value, 'enfermedades y/o trastornos'),
                   minLines: 1, 
               maxLines: null, 
               keyboardType: TextInputType.multiline, 
                ),
                 TextFormField(
                controller: _tratamientoController2,
                decoration: const InputDecoration(labelText: 'TRATAMIENTOS'),
                validator: (value) => validateNotEmpty(value, 'tratamientos'), // Validación para este campo
                 minLines: 1, 
               maxLines: null, 
               keyboardType: TextInputType.multiline, 
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _examenesController2,
                decoration: const InputDecoration(labelText: 'EXAMENES y/o PRUEBAS '),
                validator: (value) => validateNotEmpty(value, 'exámenes y/o pruebas'), // Validación para este campo
                 minLines: 1, 
               maxLines: null, 
               keyboardType: TextInputType.multiline, 
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _valoracionController2,
                decoration: const InputDecoration(labelText: 'VALORACIONES POR ESPECIALISTAS'),
                validator: (value) => validateNotEmpty(value, 'valoraciones por especialistas'), // Validación para este campo
                 minLines: 1, 
               maxLines: null, 
               keyboardType: TextInputType.multiline, 
              ),
                const SizedBox(height: 20),
              ],

              // Mostrar el tercer formulario si selecciona "3"
              if (_selectedFormCount == '3') ...[
                const Text('Formulario 3'),
                TextFormField(
                  controller: _fechController3,
                  decoration: const InputDecoration(labelText: 'AÑO (Form 3)'),
                  validator: validateYear,
                   minLines: 1, 
               maxLines: null, 
               keyboardType: TextInputType.multiline, 
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: _enfermedadController3,
                  decoration: const InputDecoration(labelText: 'ENFERMEDADES Y/O TRASTORNOS (Form 3)'),
                  validator: (value) => validateNotEmpty(value, 'enfermedades y/o trastornos'),
                   minLines: 1, 
               maxLines: null, 
               keyboardType: TextInputType.multiline, 
                ),
                 TextFormField(
                controller: _tratamientoController3,
                decoration: const InputDecoration(labelText: 'TRATAMIENTOS'),
                validator: (value) => validateNotEmpty(value, 'tratamientos'), // Validación para este campo
                 minLines: 1, 
               maxLines: null, 
               keyboardType: TextInputType.multiline, 
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _examenesController3,
                decoration: const InputDecoration(labelText: 'EXAMENES y/o PRUEBAS '),
                validator: (value) => validateNotEmpty(value, 'exámenes y/o pruebas'), // Validación para este campo
                 minLines: 1, 
               maxLines: null, 
               keyboardType: TextInputType.multiline, 
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _valoracionController3,
                decoration: const InputDecoration(labelText: 'VALORACIONES POR ESPECIALISTAS'),
                validator: (value) => validateNotEmpty(value, 'valoraciones por especialistas'), // Validación para este campo
                 minLines: 1,
               maxLines: null, 
               keyboardType: TextInputType.multiline, 
              ),
                const SizedBox(height: 20),
              ],

              // Botones de acción
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Provider.of<FormProvider>(context, listen: false).updateForm9(
                          _fechController.text,
                          _enfermedadController.text,
                          _tratamientoController.text,
                          _examenesController.text,
                          _valoracionController.text,
                          _fechController2.text,
                          _enfermedadController2.text,
                          _tratamientoController2.text,
                          _examenesController2.text,
                          _valoracionController2.text,
                          _fechController3.text,
                          _enfermedadController3.text,
                          _tratamientoController3.text,
                          _examenesController3.text,
                          _valoracionController3.text,
                        );
                        PageViewFormState.previousPage();
                      }
                    },
                    child: const Text('Atrás'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Provider.of<FormProvider>(context, listen: false).updateForm9(
                          _fechController.text,
                          _enfermedadController.text,
                          _tratamientoController.text,
                          _examenesController.text,
                          _valoracionController.text,
                          _fechController2.text,
                          _enfermedadController2.text,
                          _tratamientoController2.text,
                          _examenesController2.text,
                          _valoracionController2.text,
                          _fechController3.text,
                          _enfermedadController3.text,
                          _tratamientoController3.text,
                          _examenesController3.text,
                          _valoracionController3.text,
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
