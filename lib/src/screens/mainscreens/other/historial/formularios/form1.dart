import 'package:phsycho/src/screens/mainscreens/other/historial/widget/stepper.dart';
import "../../../../../imports.dart";
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "../widget/provaiderform.dart"; // Importa el provider
import 'form2.dart'; // Redirige a form2

class Form1 extends StatefulWidget {
  final String studentName;
  final String studentId;
  final String studentCourse;
  final String studentGrade;

  const Form1({
    super.key,
    required this.studentName,
    required this.studentId,
    required this.studentCourse,
    required this.studentGrade,
  });

  @override
  _Form1State createState() => _Form1State();
}

class _Form1State extends State<Form1> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _lugarController = TextEditingController();
  final TextEditingController _docController = TextEditingController();
  final TextEditingController _dirController = TextEditingController();
  final TextEditingController _barController = TextEditingController();
  final TextEditingController _telController = TextEditingController();
  final TextEditingController _jorController = TextEditingController();
  final TextEditingController _gradoController = TextEditingController();
  final TextEditingController _sedeController = TextEditingController();
  final TextEditingController _dirgrupoController = TextEditingController();
  final TextEditingController _epsController = TextEditingController();

  String? _selectedTdoc;

  final List<String> _tipoDocumentos = [
    'CC',
    'TI',
    'Pasaporte',
    'Cédula de extranjería'
  ];

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
      body: SingleChildScrollView( // Permite hacer scroll en el formulario
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Información del estudiante
              Text(
                'Nombre: ${widget.studentName}',
                style: const TextStyle(fontSize: 18),
              ),
              Text(
                'ID: ${widget.studentId}',
                style: const TextStyle(fontSize: 18),
              ),
              // Campos de texto con validadores
              TextFormField(
               controller: _nombreController,
               decoration: AddInputStyle.decorationFormField('Apellidos y Nombres del Alumno'),
               validator: (value) => validateField(value, 'El nombre es obligatorio'),
               minLines: 1, 
               maxLines: null,
               keyboardType: TextInputType.multiline, 
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _lugarController,
                decoration:  AddInputStyle.decorationFormField('Lugar y Fecha de Nacimiento'),
                validator: (value) => validateField(value, 'El lugar y la fecha de nacimiento son obligatorios'),
               minLines: 1, 
               maxLines: null,
               keyboardType: TextInputType.multiline, 
              ),
              const SizedBox(height: 20),
              
              // Dropdown para el tipo de documento con validador
              DropdownButtonFormField<String>(
                value: _selectedTdoc,
                items: _tipoDocumentos.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: AddInputStyle.decorationFormField( 'Tipo de documento'),
                onChanged: (newValue) {
                  setState(() {
                    _selectedTdoc = newValue;
                  });
                },
                validator: (value) => validateField(value, 'El tipo de documento es obligatorio'),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _docController,
                decoration: AddInputStyle.decorationFormField( 'N° de documento'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El número de documento es obligatorio';
                  }
                  if (value.length < 6) {
                    return 'El número de documento debe tener al menos 6 dígitos';
                  }
                  return null;
                },
                minLines: 1, 
               maxLines: null,
               keyboardType: TextInputType.multiline, 
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _dirController,
                decoration: AddInputStyle.decorationFormField( 'Dirección'),
                validator: (value) => validateField(value, 'La dirección es obligatoria'),
              minLines: 1, 
               maxLines: null,
               keyboardType: TextInputType.multiline, 
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _barController,
                decoration :AddInputStyle.decorationFormField( 'Barrio'),
                validator: (value) => validateField(value, 'El barrio es obligatorio'),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _telController,
                decoration:AddInputStyle.decorationFormField( 'Teléfono'),
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
                controller: _gradoController,
                decoration: AddInputStyle.decorationFormField( 'Grado'),
                validator: (value) => validateField(value, 'El grado es obligatorio'),
                 minLines: 1, 
               maxLines: null,
               keyboardType: TextInputType.multiline, 
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _jorController,
                decoration: AddInputStyle.decorationFormField('Jornada'),
                validator: (value) => validateField(value, 'La jornada es obligatoria'),
                 minLines: 1, 
               maxLines: null,
               keyboardType: TextInputType.multiline, 
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _sedeController,
                decoration:AddInputStyle.decorationFormField( 'Sede'),
                validator: (value) => validateField(value, 'La sede es obligatoria'),
                 minLines: 1, 
               maxLines: null,
               keyboardType: TextInputType.multiline, 
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _dirgrupoController,
                decoration: AddInputStyle.decorationFormField( 'Director de Grupo'),
                validator: (value) => validateField(value, 'El director de grupo es obligatorio'),
                 minLines: 1, 
               maxLines: null,
               keyboardType: TextInputType.multiline, 
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _epsController,
                decoration: AddInputStyle.decorationFormField('EPS'),
                validator: (value) => validateField(value, 'La EPS es obligatoria'),
                 minLines: 1, 
               maxLines: null,
               keyboardType: TextInputType.multiline, 
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Actualiza el provider con los datos del primer formulario
                        Provider.of<FormProvider>(context, listen: false)
                            .updateForm1(
                              widget.studentId,
                              _nombreController.text,
                              _lugarController.text,
                              _selectedTdoc ?? '',
                              _docController.text,
                              _dirController.text,
                              _barController.text,
                              _telController.text,
                              _jorController.text,
                              _gradoController.text,
                              _sedeController.text,
                              _dirgrupoController.text,
                              _epsController.text,
                        );
                      }
                    },
                    child: const Text('Cancelar Registro'),
                  ),
                  const SizedBox(width: 20), // Espacio entre los botones
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Provider.of<FormProvider>(context, listen: false)
                            .updateForm1(
                               widget.studentId,
                              _nombreController.text,
                              _lugarController.text,
                              _selectedTdoc ?? '',
                              _docController.text,
                              _dirController.text,
                              _barController.text,
                              _telController.text,
                              _jorController.text,
                              _gradoController.text,
                              _sedeController.text,
                              _dirgrupoController.text,
                              _epsController.text,
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
