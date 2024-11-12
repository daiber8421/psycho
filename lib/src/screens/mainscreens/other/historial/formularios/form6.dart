import 'package:phsycho/src/screens/mainscreens/other/historial/widget/stepper.dart';
import "../../../../../imports.dart";
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "../widget/provaiderform.dart"; // Importa el provider
import 'form7.dart'; // Redirige a form2

class Form6 extends StatefulWidget {
  const Form6({super.key});

  @override
  _Form6State createState() => _Form6State();
}

class _Form6State extends State<Form6> {
  final _formKey = GlobalKey<FormState>();

  // Boolean values for relationships (whether conflictiva or not)
  bool _hert = false;
  bool _padret = false;
  bool _madret = false;
  bool _cuidt = false;

  // TextEditingControllers for description fields
  final TextEditingController _herdescripController = TextEditingController();
  final TextEditingController _padescripController = TextEditingController();
  final TextEditingController _madescripController = TextEditingController();
  final TextEditingController _cuidescipController = TextEditingController();
  final TextEditingController _hisescolarController = TextEditingController();

  // Sample options for dropdown
  List<String> relationshipOptions = ['Buena', 'Regular', 'Mala'];

  // Function for validation
  String? _validator(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingresa $fieldName.';
    }
    return null; // If validation passes, return null
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Adjust screen when keyboard is visible
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Header Text
              const Text("Si es conflictiva, presione el switch"),

              // Switch for "Hermanos" relationship
              SwitchListTile(
                title: const Text('Hermanos'),
                value: _hert,
                onChanged: (value) {
                  setState(() {
                    _hert = value;
                  });
                },
              ),
              TextFormField(
                controller: _herdescripController,
                decoration: const InputDecoration(
                  labelText: 'Descripción de la relación con los hermanos',
                ),
                validator: (value) => _validator(value, 'la descripción de la relación con los hermanos'),
              ),
              const SizedBox(height: 15),

              // Switch for "Padre" relationship
              SwitchListTile(
                title: const Text('Padre'),
                value: _padret,
                onChanged: (value) {
                  setState(() {
                    _padret = value;
                  });
                },
              ),
              TextFormField(
                controller: _padescripController,
                decoration: const InputDecoration(
                  labelText: 'Descripción de la relación con el padre',
                ),
                validator: (value) => _validator(value, 'la descripción de la relación con el padre'),
                minLines: 1, 
               maxLines: null, 
               keyboardType: TextInputType.multiline, 
              ),
              const SizedBox(height: 15),

              // Switch for "Madre" relationship
              SwitchListTile(
                title: const Text('Madre'),
                value: _madret,
                onChanged: (value) {
                  setState(() {
                    _madret = value;
                  });
                },
              ),
              TextFormField(
                controller: _madescripController,
                decoration: const InputDecoration(
                  labelText: 'Descripción de la relación con la madre',
                ),
                validator: (value) => _validator(value, 'la descripción de la relación con la madre'),
                minLines: 1, 
               maxLines: null, 
               keyboardType: TextInputType.multiline, 
              ),
              const SizedBox(height: 15),

              // Switch for "Cuidador" relationship
              SwitchListTile(
                title: const Text('Cuidador'),
                value: _cuidt,
                onChanged: (value) {
                  setState(() {
                    _cuidt = value;
                  });
                },
              ),
              TextFormField(
                controller: _cuidescipController,
                decoration: const InputDecoration(
                  labelText: 'Descripción de la relación con el cuidador',
                ),
                validator: (value) => _validator(value, 'la descripción de la relación con el cuidador'),
                minLines: 1, 
               maxLines: null, 
               keyboardType: TextInputType.multiline, 
              ),
              const SizedBox(height: 20),

              // School and Coexistence History
              const Text('Historia Escolar y Convivencial'),
              TextFormField(
                controller: _hisescolarController,
                decoration: const InputDecoration(
                  labelText: 'Historia Escolar y Convivencial',
                ),
                validator: (value) => _validator(value, 'la historia escolar y convivencial'),
                minLines: 1, 
               maxLines: null, 
               keyboardType: TextInputType.multiline, 
              ),
              const SizedBox(height: 20),


              // Navigation Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Update the provider with the form data
                        Provider.of<FormProvider>(context, listen: false)
                            .updateForm6(
                          _hert ? 'C' : 'N',
                          _herdescripController.text,
                          _padret ? 'C' : 'N',
                          _padescripController.text,
                          _madret ? 'C' : 'N',
                          _madescripController.text,
                          _cuidt ? 'C' : 'N',
                          _cuidescipController.text,
                          _hisescolarController.text,
                        );
                        PageViewFormState.previousPage(); // Navigate to previous form
                      }
                    },
                    child: const Text('Atrás'),
                  ),
                  const SizedBox(width: 20),

                  // Button to navigate to the next form (Form7)
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Update the provider with the form data
                        Provider.of<FormProvider>(context, listen: false)
                            .updateForm6(
                          _hert ? 'C' : 'N',
                          _herdescripController.text,
                          _padret ? 'C' : 'N',
                          _padescripController.text,
                          _madret ? 'C' : 'N',
                          _madescripController.text,
                          _cuidt ? 'C' : 'N',
                          _cuidescipController.text,
                          _hisescolarController.text,
                        );
                        PageViewFormState.nextPage(); // Navigate to the next form
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
