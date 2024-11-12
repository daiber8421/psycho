import 'package:phsycho/src/screens/mainscreens/other/historial/widget/stepper.dart';
import "../../../../../imports.dart";
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "../widget/provaiderform.dart"; // Importa el provider
import 'form8.dart'; // Redirige a form2

class Form7 extends StatefulWidget {
  const Form7({super.key});

  @override
  _Form7State createState() => _Form7State();
}

class _Form7State extends State<Form7> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _tiempoController = TextEditingController();
  final TextEditingController _deporController = TextEditingController();
  final TextEditingController _tipoamisController = TextEditingController();
  
  bool _barrio = false;
  bool _colegio = false;
  bool _mayores = false;
  bool _menores = false;
  bool _misma = false;
  
  final TextEditingController _rdemasController = TextEditingController();
  final TextEditingController _rcolController = TextEditingController();

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
              // Campos de texto (Observación y Diagnóstico)
              TextFormField(
                controller: _tiempoController,
                decoration: const InputDecoration(labelText: 'USO DEL TIEMPO LIBRE:'),
                minLines: 1, 
               maxLines: null, 
               keyboardType: TextInputType.multiline, 
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _deporController,
                decoration: const InputDecoration(labelText: 'PRACTICA DEPORTES:'),
                minLines: 1, 
               maxLines: null, 
               keyboardType: TextInputType.multiline, 
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _tipoamisController,
                decoration: const InputDecoration(labelText: 'TIPO DE AMISTADES:'),
                minLines: 1, 
               maxLines: null, 
               keyboardType: TextInputType.multiline, 
              ),
              const SizedBox(height: 15),
              SwitchListTile(
                title: const Text('BARRIO'),
                value: _barrio,
                onChanged: (value) {
                  setState(() {
                    _barrio = value;
                  });
                },
              ),
              SwitchListTile(
                title: const Text('COLEGIO'),
                value: _colegio,
                onChanged: (value) {
                  setState(() {
                    _colegio = value;
                  });
                },
              ),
              SwitchListTile(
                title: const Text('MAYORES'),
                value: _mayores,
                onChanged: (value) {
                  setState(() {
                    _mayores = value;
                  });
                },
              ),
              SwitchListTile(
                title: const Text('MENORES'),
                value: _menores,
                onChanged: (value) {
                  setState(() {
                    _menores = value;
                  });
                },
              ),
              SwitchListTile(
                title: const Text('MISMA EDAD'),
                value: _misma,
                onChanged: (value) {
                  setState(() {
                    _misma = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _rdemasController,
                decoration: const InputDecoration(labelText: '¿Cómo son sus relaciones con las demás personas?'),
                minLines: 1, 
               maxLines: null, 
               keyboardType: TextInputType.multiline, 
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _rcolController,
                decoration: const InputDecoration(labelText: '¿Cómo son sus relaciones con sus compañeros y profesores?'),
                minLines: 1, 
               maxLines: null, 
               keyboardType: TextInputType.multiline, 
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Botón para cancelar el registro
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Actualiza el provider con los datos del primer formulario
                        Provider.of<FormProvider>(context, listen: false).updateForm7(
                          _tiempoController.text,
                          _deporController.text,
                          _tipoamisController.text,
                          _barrio ? 'X' : '',
                          _colegio ? 'X' : '',
                          _mayores ? 'X' : '',
                          _menores ? 'X' : '',
                          _misma ? 'X' : '',
                          _rdemasController.text,
                          _rcolController.text,
                        );
                        // Redirige a la pantalla anterior
                        PageViewFormState.previousPage();
                      }
                    },
                    child: const Text('Atrás'),
                  ),
                  const SizedBox(width: 20), // Espacio entre los botones
                  // Botón para ir al siguiente formulario (Form2)
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Actualiza el provider con los datos del primer formulario
                        Provider.of<FormProvider>(context, listen: false).updateForm7(
                          _tiempoController.text,
                          _deporController.text,
                          _tipoamisController.text,
                          _barrio ? 'X' : '',
                          _colegio ? 'X' : '',
                          _mayores ? 'X' : '',
                          _menores ? 'X' : '',
                          _misma ? 'X' : '',
                          _rdemasController.text,
                          _rcolController.text,
                        );
                        // Redirige a la siguiente pantalla
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
