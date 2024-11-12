import 'package:phsycho/src/screens/mainscreens/other/historial/widget/stepper.dart';
import "../../../../../imports.dart";
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "../widget/provaiderform.dart"; // Importa el provider


class Form11 extends StatefulWidget {
  const Form11({super.key});

  @override
  _Form11State createState() => _Form11State();
}

class _Form11State extends State<Form11> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _resulController = TextEditingController();
  final TextEditingController _interController = TextEditingController();
  final TextEditingController _recoController = TextEditingController();

  DateTime? _selectedDate;

  // Función reutilizable para validar campos
  String? validateField(String? value, String message) {
    if (value == null || value.isEmpty) {
      return message;
    }
    return null;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView( // Permite el desplazamiento vertical
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Alinea los widgets a la izquierda
              children: [
                TextFormField(
                  controller: _resulController,
                  decoration: const InputDecoration(
                    labelText: 'RESULTADOS DE LA EVALUCIÓN',
                  ),
                  validator: (value) => validateField(value, 'Este campo es obligatorio'),
                  minLines: 1,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                ),
                const SizedBox(height: 15),
                TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'FECHA REGISTRO',
                    hintText: _selectedDate == null
                        ? 'Selecciona una fecha'
                        : "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}",
                  ),
                  onTap: () => _selectDate(context),
                  validator: (value) => _selectedDate == null
                      ? 'La fecha es obligatoria'
                      : null,
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: _interController,
                  decoration: const InputDecoration(
                    labelText: 'INTERVENCION',
                  ),
                  validator: (value) => validateField(value, 'Este campo es obligatorio'),
                  minLines: 1,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: _recoController,
                  decoration: const InputDecoration(
                    labelText: 'SUGERENCIAS A DOCENTES, PADRES DE FAMILIA Y ESTUDIANTE.',
                  ),
                  validator: (value) => validateField(value, 'Este campo es obligatorio'),
                  minLines: 1,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      Provider.of<FormProvider>(context, listen: false).updateForm11(
                        _resulController.text,
                        _selectedDate?.toString() ?? '',
                        _interController.text,
                        _recoController.text,
                      );

                      try {
                        await Provider.of<FormProvider>(context, listen: false)
                            .submitFormData('studentId', 'studentName', 'studentCourse');
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Formulario enviado con éxito')),
                        );
                        Navigator.pop(context);
                      } catch (e) {
                        print(e);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Error al enviar los datos')),
                        );
                      }
                    }
                  },
                  child: const Text('Enviar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
