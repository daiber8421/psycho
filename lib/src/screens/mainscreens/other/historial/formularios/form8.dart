import 'package:phsycho/src/screens/mainscreens/other/historial/widget/stepper.dart';
import "../../../../../imports.dart";
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "../widget/provaiderform.dart"; // Importa el provider
import 'form9.dart'; // Redirige a form9

class Form8 extends StatefulWidget {
  const Form8({super.key});

  @override
  _Form8State createState() => _Form8State();
}

class _Form8State extends State<Form8> {
  final _formKey = GlobalKey<FormState>();

  // Controladores de los TextFormField
  final TextEditingController _observadorExcelenteController = TextEditingController();
  final TextEditingController _observadorBuenasController = TextEditingController();
  final TextEditingController _observadorBasicasController = TextEditingController();
  final TextEditingController _observadorInsuficientesController = TextEditingController();

  String? _selectedCondition = 'Excelente'; // Valor inicial de la condición
  String observacion = ''; // Variable para guardar el valor de la observación

  // Lista de opciones del dropdown
  final List<String> conditions = ['Excelente', 'Buenas', 'Básicas', 'Insuficientes'];

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
              // DropdownButton para seleccionar la condición
              DropdownButton<String>(
                value: _selectedCondition,
                isExpanded: true,
                hint: const Text('Selecciona una condición'),
                items: conditions.map((String condition) {
                  return DropdownMenuItem<String>(
                    value: condition,
                    child: Text(condition),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedCondition = newValue;
                    observacion = newValue ?? ''; // Actualiza la observación con la selección
                  });
                },
              ),
              const SizedBox(height: 20),

              // Campos para los observadores según la opción seleccionada
              if (_selectedCondition == 'Excelente')
                _buildDynamicTextField(
                  controller: _observadorExcelenteController,
                  label: 'Observador Excelente',
                  hint: 'Ingrese el observador para Excelente',
                ),
              if (_selectedCondition == 'Buenas')
                _buildDynamicTextField(
                  controller: _observadorBuenasController,
                  label: 'Observador Buenas',
                  hint: 'Ingrese el observador para Buenas',
                ),
              if (_selectedCondition == 'Básicas')
                _buildDynamicTextField(
                  controller: _observadorBasicasController,
                  label: 'Observador Básicas',
                  hint: 'Ingrese el observador para Básicas',
                ),
              if (_selectedCondition == 'Insuficientes')
                _buildDynamicTextField(
                  controller: _observadorInsuficientesController,
                  label: 'Observador Insuficientes',
                  hint: 'Ingrese el observador para Insuficientes',
                ),
              const SizedBox(height: 20),

              // Botones para continuar o cancelar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Botón para cancelar el registro
                  ElevatedButton(
                    onPressed: () {
                      Provider.of<FormProvider>(context, listen: false).updateForm8(
                        observacion,
                        _observadorExcelenteController.text,
                        _observadorBuenasController.text,
                        _observadorBasicasController.text,
                        _observadorInsuficientesController.text,
                      );
                      // Redirige a la segunda pantalla
                      PageViewFormState.previousPage();
                    },
                    child: const Text('Atrás'),
                  ),
                  const SizedBox(width: 20),

                  // Botón para ir al siguiente formulario (Form9)
                  ElevatedButton(
                    onPressed: () {
                      Provider.of<FormProvider>(context, listen: false).updateForm8(
                        observacion,
                        _observadorExcelenteController.text,
                        _observadorBuenasController.text,
                        _observadorBasicasController.text,
                        _observadorInsuficientesController.text,
                      );
                      // Redirige a la siguiente pantalla
                      PageViewFormState.nextPage();
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

  // Widget para crear TextFormField con tamaño dinámico
  Widget _buildDynamicTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
      ),
      maxLines: null, // Permite líneas ilimitadas
      minLines: 1,    // Mínimo 1 línea
      keyboardType: TextInputType.multiline, // Tipo multilinea
      onChanged: (text) {
        setState(() {
          // Aquí podrías hacer algún ajuste visual si es necesario
        });
      },
    );
  }
}
