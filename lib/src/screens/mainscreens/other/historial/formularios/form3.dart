import 'package:phsycho/src/screens/mainscreens/other/historial/widget/stepper.dart';
import "../../../../../imports.dart";
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "../widget/provaiderform.dart"; // Importa el provider
import 'form4.dart'; // Redirige a form4

class Form3 extends StatefulWidget {
  const Form3({super.key});

  @override
  _Form3State createState() => _Form3State();
}

class _Form3State extends State<Form3> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _estadocivilController = TextEditingController();
  final TextEditingController _nherController = TextEditingController();
  final TextEditingController _lugarocuController = TextEditingController();
  final TextEditingController _cuidadorController = TextEditingController();
  final TextEditingController _parentescoController = TextEditingController();
  final TextEditingController _fechainiController = TextEditingController();
  final TextEditingController _motivoController = TextEditingController();
  final TextEditingController _histoproController = TextEditingController();

  // Función de validación que recibe un texto para mostrar en el validator
  String? _validator(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingresa $fieldName.';
    }
    return null; // Si pasa la validación, retorna null
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
              TextFormField(
                controller: _estadocivilController,
                decoration: const InputDecoration(labelText: 'Estado civil de los Padres'),
                validator: (value) => _validator(value, 'el estado civil de los padres'),
                minLines: 1, 
               maxLines: null, 
               keyboardType: TextInputType.multiline, 
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _nherController,
                decoration: const InputDecoration(labelText: 'No. De Hermanos'),
                validator: (value) => _validator(value, 'el número de hermanos'),
                minLines: 1, 
               maxLines: null, 
               keyboardType: TextInputType.multiline, 
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _lugarocuController,
                decoration: const InputDecoration(labelText: 'Lugar que Ocupa'),
                validator: (value) => _validator(value, 'el lugar que ocupa'),
                minLines: 1, 
               maxLines: null, 
               keyboardType: TextInputType.multiline, 
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _cuidadorController,
                decoration: const InputDecoration(labelText: 'Cuidador'),
                validator: (value) => _validator(value, 'el cuidador'),
                minLines: 1, 
               maxLines: null, 
               keyboardType: TextInputType.multiline, 
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _parentescoController,
                decoration: const InputDecoration(labelText: 'Parentesco'),
                validator: (value) => _validator(value, 'el parentesco'),
                minLines: 1, 
               maxLines: null, 
               keyboardType: TextInputType.multiline, 
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _fechainiController,
                decoration: const InputDecoration(labelText: 'Fecha iniciación de la ficha de seguimiento'),
                validator: (value) => _validator(value, 'la fecha de iniciación'),
                minLines: 1, 
               maxLines: null, 
               keyboardType: TextInputType.multiline, 
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _motivoController,
                decoration: const InputDecoration(labelText: 'Motivo de Remisión'),
                validator: (value) => _validator(value, 'el motivo de remisión'),
                minLines: 1, 
               maxLines: null, 
               keyboardType: TextInputType.multiline, 
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _histoproController,
                decoration: const InputDecoration(labelText: 'Historia del Problema y/o Dificultad'),
                validator: (value) => _validator(value, 'la historia del problema'),
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
                        Provider.of<FormProvider>(context, listen: false).updateForm3(
                          _estadocivilController.text,
                          _nherController.text,
                          _lugarocuController.text,
                          _cuidadorController.text,
                          _parentescoController.text,
                          _fechainiController.text,
                          _motivoController.text,
                          _histoproController.text,
                        );
                        PageViewFormState.previousPage();
                      }
                    },
                    child: const Text('Atrás'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Provider.of<FormProvider>(context, listen: false).updateForm3(
                          _estadocivilController.text,
                          _nherController.text,
                          _lugarocuController.text,
                          _cuidadorController.text,
                          _parentescoController.text,
                          _fechainiController.text,
                          _motivoController.text,
                          _histoproController.text,
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
