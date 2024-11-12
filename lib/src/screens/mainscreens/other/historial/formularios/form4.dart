import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phsycho/src/screens/mainscreens/other/historial/widget/provaiderform.dart';
import 'package:phsycho/src/screens/mainscreens/other/historial/widget/stepper.dart';
import 'package:provider/provider.dart';
import 'form5.dart';

class Form4 extends StatefulWidget {
  const Form4({super.key});

  @override
  _Form4State createState() => _Form4State();
}

class _Form4State extends State<Form4> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _numherController = TextEditingController();
  bool _vivepadres = false;
  final TextEditingController _padresobserController = TextEditingController();
  final TextEditingController _nhomController = TextEditingController();
  bool _vivepadre = false;
  final TextEditingController _homobserController = TextEditingController();
  final TextEditingController _nmujerController = TextEditingController();
  bool _vivemadre = false;
  final TextEditingController _mujerobserController = TextEditingController();
  final TextEditingController _lugarentreController = TextEditingController();
  bool _vivetio = false;
  final TextEditingController _tioobserController = TextEditingController();

  String? _validateObservations(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese observaciones';
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
              DropdownButtonFormField<int>(
                decoration: const InputDecoration(labelText: 'Número de hermanos'),
                value: int.tryParse(_numherController.text),
                onChanged: (int? newValue) {
                  setState(() {
                    _numherController.text = newValue.toString();
                  });
                },
                items: List.generate(11, (index) => index).map((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
                validator: (value) {
                  if (value == null) {
                    return 'Por favor, seleccione un número de hermanos';
                  }
                  return null;
                },
                
              ),
              const SizedBox(height: 15),
              SwitchListTile(
                title: const Text('Vive con ambos padres'),
                value: _vivepadres,
                onChanged: (value) {
                  setState(() {
                    _vivepadres = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _padresobserController,
                decoration: const InputDecoration(labelText: 'Observaciones sobre los padres'),
                validator: _validateObservations,
                minLines: 1, 
               maxLines: null, 
               keyboardType: TextInputType.multiline, 
              ),
              const SizedBox(height: 15),
              DropdownButtonFormField<int>(
                decoration: const InputDecoration(labelText: 'Número de hombres'),
                value: int.tryParse(_nhomController.text),
                onChanged: (int? newValue) {
                  setState(() {
                    _nhomController.text = newValue.toString();
                  });
                },
                items: List.generate(11, (index) => index).map((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
                validator: (value) {
                  if (value == null) {
                    return 'Por favor, seleccione un número de hombres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              SwitchListTile(
                title: const Text('Vive con el padre'),
                value: _vivepadre,
                onChanged: (value) {
                  setState(() {
                    _vivepadre = value;
                  });
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _homobserController,
                decoration: const InputDecoration(labelText: 'Observaciones sobre el padre'),
                validator: _validateObservations,
                minLines: 1, 
               maxLines: null, 
               keyboardType: TextInputType.multiline, 
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<int>(
                decoration: const InputDecoration(labelText: 'Número de mujeres'),
                value: int.tryParse(_nmujerController.text),
                onChanged: (int? newValue) {
                  setState(() {
                    _nmujerController.text = newValue.toString();
                  });
                },
                items: List.generate(11, (index) => index).map((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
                validator: (value) {
                  if (value == null) {
                    return 'Por favor, seleccione un número de mujeres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              SwitchListTile(
                title: const Text('Vive con la madre'),
                value: _vivemadre,
                onChanged: (value) {
                  setState(() {
                    _vivemadre = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _mujerobserController,
                decoration: const InputDecoration(labelText: 'Observaciones sobre la madre'),
                validator: _validateObservations,
                minLines: 1, 
               maxLines: null, 
               keyboardType: TextInputType.multiline, 
              ),
              const SizedBox(height: 15),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Lugar que ocupa entre ellos'),
                value: _lugarentreController.text.isEmpty ? null : _lugarentreController.text,
                onChanged: (String? newValue) {
                  setState(() {
                    _lugarentreController.text = newValue!;
                  });
                },
                items: ['Primero', 'Segundo', 'Tercero', 'Otro'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                validator: (value) {
                  if (value == null) {
                    return 'Por favor, seleccione una opción';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              SwitchListTile(
                title: const Text('Vive con tíos'),
                value: _vivetio,
                onChanged: (value) {
                  setState(() {
                    _vivetio = value;
                  });
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _tioobserController,
                decoration: const InputDecoration(labelText: 'Observaciones sobre los tíos'),
                validator: _validateObservations,
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
                        Provider.of<FormProvider>(context, listen: false).updateForm4(
                          _numherController.text,
                          _vivepadres ? 'Sí' : 'No',
                          _padresobserController.text,
                          _nhomController.text,
                          _vivepadre ? 'Sí' : 'No',
                          _homobserController.text,
                          _nmujerController.text,
                          _vivemadre ? 'Sí' : 'No',
                          _mujerobserController.text,
                          _lugarentreController.text,
                          _vivetio ? 'Sí' : 'No',
                          _tioobserController.text,
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
                        Provider.of<FormProvider>(context, listen: false).updateForm4(
                          _numherController.text,
                          _vivepadres ? 'Sí' : 'No',
                          _padresobserController.text,
                          _nhomController.text,
                          _vivepadre ? 'Sí' : 'No',
                          _homobserController.text,
                          _nmujerController.text,
                          _vivemadre ? 'Sí' : 'No',
                          _mujerobserController.text,
                          _lugarentreController.text,
                          _vivetio ? 'Sí' : 'No',
                          _tioobserController.text,
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
