import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "../widget/provaiderform.dart"; // Importa el provider
import "../widget/stepper.dart";

class Form10 extends StatefulWidget {
  const Form10({super.key});

  @override
  _Form10State createState() => _Form10State();
}

class _Form10State extends State<Form10> {
  String? _selectedTrastorno; // Almacena el trastorno seleccionado
  String? _selectedEstado; // Almacena el estado seleccionado

  // Controladores para manejar los estados de los problemas para cada trastorno
  final TextEditingController _prom1leveController = TextEditingController();
  final TextEditingController _prom1moderadoController =
      TextEditingController();
  final TextEditingController _prom1severoController = TextEditingController();

  final TextEditingController _prom2leveController = TextEditingController();
  final TextEditingController _prom2moderadoController =
      TextEditingController();
  final TextEditingController _prom2severoController = TextEditingController();

  final TextEditingController _prom3leveController = TextEditingController();
  final TextEditingController _prom3moderadoController =
      TextEditingController();
  final TextEditingController _prom3severoController = TextEditingController();

  final TextEditingController _prom4leveController = TextEditingController();
  final TextEditingController _prom4moderadoController =
      TextEditingController();
  final TextEditingController _prom4severoController = TextEditingController();

  final TextEditingController _prom5leveController = TextEditingController();
  final TextEditingController _prom5moderadoController =
      TextEditingController();
  final TextEditingController _prom5severoController = TextEditingController();

  final TextEditingController _prom6leveController = TextEditingController();
  final TextEditingController _prom6moderadoController =
      TextEditingController();
  final TextEditingController _prom6severoController = TextEditingController();

  final TextEditingController _prom7leveController = TextEditingController();
  final TextEditingController _prom7moderadoController =
      TextEditingController();
  final TextEditingController _prom7severoController = TextEditingController();

  final TextEditingController _prom8leveController = TextEditingController();
  final TextEditingController _prom8moderadoController =
      TextEditingController();
  final TextEditingController _prom8severoController = TextEditingController();

  final TextEditingController _prom9leveController = TextEditingController();
  final TextEditingController _prom9moderadoController =
      TextEditingController();
  final TextEditingController _prom9severoController = TextEditingController();

  // Lista de trastornos
  final List<String> trastornos = [
    'TRASTORNOS DEL ESPECTRO AUTISTA (TEA)',
    'INTELECTUAL',
    'PSICOSOCIAL',
    'SISTEMICA',
    'AUDITIVA',
    'VISUAL',
    'SORDOCEGUERRA',
    'FISICA',
    'TRASTORNOS PERMANENTES DE LA VOZ Y EL HABLA',
  ];

  // Lista de estados
  final List<String> estados = ['LEVE', 'MODERADO', 'SEVERO'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Dropdown para seleccionar el trastorno
            DropdownButton<String>(
              value: _selectedTrastorno,
              isExpanded: true,
              hint: const Text('Selecciona un trastorno'),
              items: trastornos.map((String trastorno) {
                return DropdownMenuItem<String>(
                  value: trastorno,
                  child: Text(trastorno),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedTrastorno = newValue;
                  _selectedEstado =
                      null; // Reiniciar estado al seleccionar un nuevo trastorno
                  _resetControllers(); // Reiniciar controladores
                });
              },
            ),
            const SizedBox(height: 20),

            // Mostrar opciones de estado si hay un trastorno seleccionado
            if (_selectedTrastorno != null) ...[
              Text('Estado del problema para: $_selectedTrastorno'),
              for (var estado in estados)
                RadioListTile<String>(
                  title: Text(estado),
                  value: estado,
                  groupValue: _selectedEstado,
                  onChanged: (value) {
                    setState(() {
                      _selectedEstado = value; // Guardar el estado seleccionado
                      _resetControllers(); // Limpiar el controlador correspondiente
                      switch (_selectedTrastorno) {
                        case 'TRASTORNOS DEL ESPECTRO AUTISTA (TEA)':
                          switch (_selectedEstado) {
                            case 'LEVE':
                              _prom1leveController.text = 'X';
                              break;
                            case 'MODERADO':
                              _prom1moderadoController.text = 'X';
                              break;
                            case 'SEVERO':
                              _prom1severoController.text = 'X';
                              break;
                          }
                          Provider.of<FormProvider>(context, listen: false)
                              .updateForm10_1(
                            _prom1leveController.text,
                            _prom1moderadoController.text,
                            _prom1severoController.text,
                          );
                          break;
                        case 'INTELECTUAL':
                          switch (_selectedEstado) {
                            case 'LEVE':
                              _prom2leveController.text = 'X';
                              break;
                            case 'MODERADO':
                              _prom2moderadoController.text = 'X';
                              break;
                            case 'SEVERO':
                              _prom2severoController.text = 'X';
                              break;
                          }
                          Provider.of<FormProvider>(context, listen: false)
                              .updateForm10_2(
                            _prom2leveController.text,
                            _prom2moderadoController.text,
                            _prom2severoController.text,
                          );
                          break;
                        case 'PSICOSOCIAL':
                          switch (_selectedEstado) {
                            case 'LEVE':
                              _prom3leveController.text = 'X';
                              break;
                            case 'MODERADO':
                              _prom3moderadoController.text = 'X';
                              break;
                            case 'SEVERO':
                              _prom3severoController.text = 'X';
                              break;
                          }
                          Provider.of<FormProvider>(context, listen: false)
                              .updateForm10_3(
                            _prom3leveController.text,
                            _prom3moderadoController.text,
                            _prom3severoController.text,
                          );
                          break;
                        case 'SISTEMICA':
                          switch (_selectedEstado) {
                            case 'LEVE':
                              _prom4leveController.text = 'X';
                              break;
                            case 'MODERADO':
                              _prom4moderadoController.text = 'X';
                              break;
                            case 'SEVERO':
                              _prom4severoController.text = 'X';
                              break;
                          }
                          Provider.of<FormProvider>(context, listen: false)
                              .updateForm10_4(
                            _prom4leveController.text,
                            _prom4moderadoController.text,
                            _prom4severoController.text,
                          );
                          break;
                        case 'AUDITIVA':
                          switch (_selectedEstado) {
                            case 'LEVE':
                              _prom5leveController.text = 'X';
                              break;
                            case 'MODERADO':
                              _prom5moderadoController.text = 'X';
                              break;
                            case 'SEVERO':
                              _prom5severoController.text = 'X';
                              break;
                          }
                          Provider.of<FormProvider>(context, listen: false)
                              .updateForm10_5(
                            _prom5leveController.text,
                            _prom5moderadoController.text,
                            _prom5severoController.text,
                          );
                          break;
                        case 'VISUAL':
                          switch (_selectedEstado) {
                            case 'LEVE':
                              _prom6leveController.text = 'X';
                              break;
                            case 'MODERADO':
                              _prom6moderadoController.text = 'X';
                              break;
                            case 'SEVERO':
                              _prom6severoController.text = 'X';
                              break;
                          }
                          Provider.of<FormProvider>(context, listen: false)
                              .updateForm10_6(
                            _prom6leveController.text,
                            _prom6moderadoController.text,
                            _prom6severoController.text,
                          );
                          break;
                        case 'SORDOCEGUERRA':
                          switch (_selectedEstado) {
                            case 'LEVE':
                              _prom7leveController.text = 'X';
                              break;
                            case 'MODERADO':
                              _prom7moderadoController.text = 'X';
                              break;
                            case 'SEVERO':
                              _prom7severoController.text = 'X';
                              break;
                          }
                          Provider.of<FormProvider>(context, listen: false)
                              .updateForm10_7(
                            _prom7leveController.text,
                            _prom7moderadoController.text,
                            _prom7severoController.text,
                          );
                          break;
                        case 'FISICA':
                          switch (_selectedEstado) {
                            case 'LEVE':
                              _prom8leveController.text = 'X';
                              break;
                            case 'MODERADO':
                              _prom8moderadoController.text = 'X';
                              break;
                            case 'SEVERO':
                              _prom8severoController.text = 'X';
                              break;
                          }
                          Provider.of<FormProvider>(context, listen: false)
                              .updateForm10_8(
                            _prom8leveController.text,
                            _prom8moderadoController.text,
                            _prom8severoController.text,
                          );
                          break;
                        case 'TRASTORNOS PERMANENTES DE LA VOZ Y EL HABLA':
                          switch (_selectedEstado) {
                            case 'LEVE':
                              _prom9leveController.text = 'X';
                              break;
                            case 'MODERADO':
                              _prom9moderadoController.text = 'X';
                              break;
                            case 'SEVERO':
                              _prom9severoController.text = 'X';
                              break;
                          }
                          Provider.of<FormProvider>(context, listen: false)
                              .updateForm10_9(
                            _prom9leveController.text,
                            _prom9moderadoController.text,
                            _prom9severoController.text,
                          );
                          break;
                      }
                    });
                  },
                ),
              const SizedBox(height: 20),
            ],

            // Botones para navegar entre páginas
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    PageViewFormState.previousPage();
                  },
                  child: const Text('Atrás'),
                ),
                ElevatedButton(
                  onPressed: () {
                    PageViewFormState.nextPage();
                  },
                  child: const Text('Siguiente'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Función para limpiar los controladores al cambiar el trastorno
  void _resetControllers() {
    _prom1leveController.clear();
    _prom1moderadoController.clear();
    _prom1severoController.clear();

    _prom2leveController.clear();
    _prom2moderadoController.clear();
    _prom2severoController.clear();

    _prom3leveController.clear();
    _prom3moderadoController.clear();
    _prom3severoController.clear();

    _prom4leveController.clear();
    _prom4moderadoController.clear();
    _prom4severoController.clear();

    _prom5leveController.clear();
    _prom5moderadoController.clear();
    _prom5severoController.clear();

    _prom6leveController.clear();
    _prom6moderadoController.clear();
    _prom6severoController.clear();

    _prom7leveController.clear();
    _prom7moderadoController.clear();
    _prom7severoController.clear();

    _prom8leveController.clear();
    _prom8moderadoController.clear();
    _prom8severoController.clear();

    _prom9leveController.clear();
    _prom9moderadoController.clear();
    _prom9severoController.clear();
  }

  @override
  void dispose() {
    // Limpia los controladores al destruir el widget
    _prom1leveController.dispose();
    _prom1moderadoController.dispose();
    _prom1severoController.dispose();

    _prom2leveController.dispose();
    _prom2moderadoController.dispose();
    _prom2severoController.dispose();

    _prom3leveController.dispose();
    _prom3moderadoController.dispose();
    _prom3severoController.dispose();

    _prom4leveController.dispose();
    _prom4moderadoController.dispose();
    _prom4severoController.dispose();

    _prom5leveController.dispose();
    _prom5moderadoController.dispose();
    _prom5severoController.dispose();

    _prom6leveController.dispose();
    _prom6moderadoController.dispose();
    _prom6severoController.dispose();

    _prom7leveController.dispose();
    _prom7moderadoController.dispose();
    _prom7severoController.dispose();

    _prom8leveController.dispose();
    _prom8moderadoController.dispose();
    _prom8severoController.dispose();

    _prom9leveController.dispose();
    _prom9moderadoController.dispose();
    _prom9severoController.dispose();

    super.dispose();
  }
}
