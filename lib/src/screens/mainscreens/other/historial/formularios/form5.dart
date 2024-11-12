import 'package:phsycho/src/screens/mainscreens/other/historial/widget/stepper.dart';

import "../../../../../imports.dart";
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "../widget/provaiderform.dart"; // Importa el provider
import 'form6.dart'; // Redirige a form2
import 'package:flutter/services.dart'; // Import for input formatters

class Form5 extends StatefulWidget {
  const Form5({super.key});

  @override
  _Form5State createState() => _Form5State();
}

class _Form5State extends State<Form5> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nmienController = TextEditingController();
  bool _viveabuelo = false;
  final TextEditingController _abueloobserController = TextEditingController();
  final TextEditingController _nfamController = TextEditingController();
  bool _vivefam = false;
  final TextEditingController _famobserController = TextEditingController();
  final TextEditingController _nadulController = TextEditingController();
  bool _vivenofam = false;
  final TextEditingController _nofamobserController = TextEditingController();

  // Validator function for positive numbers
  String? _validatePositiveNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese un número';
    }
    final numValue = int.tryParse(value);
    if (numValue == null) {
      return 'Ingrese un número válido';
    }
    if (numValue < 0) {
      return 'El número no puede ser negativo';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Permite ajustar la pantalla cuando aparece el teclado
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nmienController,
                decoration: const InputDecoration(labelText: '¿Cuánto son los miembros de la familia?'),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly], // Only allows digits
                validator: _validatePositiveNumber, // Apply validator
              ),
              const SizedBox(height: 15),
              SwitchListTile(
                title: const Text('Vive con abuelos'),
                value: _viveabuelo,
                onChanged: (value) {
                  setState(() {
                    _viveabuelo = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _abueloobserController,
                decoration: const InputDecoration(labelText: 'observaciones'),
                minLines: 1, 
               maxLines: null, 
               keyboardType: TextInputType.multiline, 
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _nfamController,
                decoration: const InputDecoration(labelText: '¿Cuántas familias viven en la casa?'),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly], // Only allows digits
                validator: _validatePositiveNumber, // Apply validator
              ),
              const SizedBox(height: 20),
              SwitchListTile(
                title: const Text('¿Vive con otros familiares?'),
                value: _vivefam,
                onChanged: (value) {
                  setState(() {
                    _vivefam = value;
                  });
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _famobserController,
                decoration: const InputDecoration(labelText: 'observaciones'),
                minLines: 1, 
               maxLines: null, 
               keyboardType: TextInputType.multiline, 
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nadulController,
                decoration: const InputDecoration(labelText: '¿Cuántos adultos viven en casa?'),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly], // Only allows digits
                validator: _validatePositiveNumber, // Apply validator
                
              ),
              const SizedBox(height: 15),
              SwitchListTile(
                title: const Text('¿Vive con otras personas que no son familia?'),
                value: _vivenofam,
                onChanged: (value) {
                  setState(() {
                    _vivenofam = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nofamobserController,
                decoration: const InputDecoration(labelText: 'observaciones'),
                minLines: 1, 
               maxLines: null, 
               keyboardType: TextInputType.multiline, 
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Provider.of<FormProvider>(context, listen: false).updateForm5(
                          _nmienController.text,
                          _viveabuelo ? 'Sí' : 'No',
                          _abueloobserController.text,
                          _nfamController.text,
                          _vivefam ? 'Si' : 'NO',
                          _famobserController.text,
                          _nadulController.text,
                          _vivenofam ? 'Si' : 'No',
                          _nofamobserController.text,
                        );
                        PageViewFormState.previousPage();
                      }
                    },
                    child: const Text('Atras'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Provider.of<FormProvider>(context, listen: false).updateForm5(
                          _nmienController.text,
                          _viveabuelo ? 'Sí' : 'No',
                          _abueloobserController.text,
                          _nfamController.text,
                          _vivefam ? 'Si' : 'NO',
                          _famobserController.text,
                          _nadulController.text,
                          _vivenofam ? 'Si' : 'No',
                          _nofamobserController.text,
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
