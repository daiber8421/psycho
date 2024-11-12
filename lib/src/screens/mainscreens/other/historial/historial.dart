import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:phsycho/src/imports.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:phsycho/src/screens/mainscreens/other/historial/widget/stepper.dart';
import 'package:printing/printing.dart';
import '../historial/formularios/form1.dart';
import "../historial/widget/provaiderform.dart";
import 'package:provider/provider.dart';

class HistorialScreen extends StatefulWidget {
  final String studentName;
  final String studentId;
  final String studentCourse;
  final String studentGrade;
  final String? initial;
  final String idCita;
  
  HistorialScreen(
      {super.key,
   
      required this.studentName,
      required this.studentId,
      required this.studentCourse,
      required this.studentGrade,
      required this.idCita,
      this.initial = "0"});

  @override
  State<HistorialScreen> createState() => _HistorialScreenState();
}

class _HistorialScreenState extends State<HistorialScreen> {
  final TextEditingController _dateController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  PdfColor pdfColor = const PdfColor.fromInt(0xFF416FDF);
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(281),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  // Método para cargar el logo
  Future<Uint8List> _loadLogo() async {
    final ByteData bytes =
        await rootBundle.load('../../../../../../assets/images/logo.jpeg');
    return bytes.buffer.asUint8List();
  }

  // Generación del PDF con header en cada página
  Future<void> _generatePdf(Map<String, dynamic> historial) async {
    final pdf = pw.Document();

    // Cargar la imagen del logo
    final Uint8List logo = await _loadLogo();

    pdf.addPage(
      pw.MultiPage(
        margin: const pw.EdgeInsets.all(60),
        header: (pw.Context context) {
          return pw.Container(
            padding: const pw.EdgeInsets.all(8),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Image(pw.MemoryImage(logo), width: 50, height: 50),
                pw.Header(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'INSTITUCIÓN EDUCATIVA DOLORES MARÍA UCRÓS',
                        style: pw.TextStyle(
                            fontSize: 14, fontWeight: pw.FontWeight.bold),
                      ),
                      pw.Text(
                        'FICHA DE SEGUIMIENTO ORIENTACION',
                        style: const pw.TextStyle(fontSize: 10),
                      ),
                      pw.Text(
                        'Código: FO-DHP-24     Versión: 01     Fecha: 12/12/2012',
                        style: const pw.TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
        build: (pw.Context context) {
          return <pw.Widget>[
            pw.SizedBox(height: 8),
            pw.Text('I. IDENTIFICACIÓN',
                style: const pw.TextStyle(fontSize: 12)),
            pw.SizedBox(height: 8),
            pw.Text(
              'Apellidos y Nombres del Alumno: ${historial["name"]} '
              'Lugar y Fecha de Nacimiento: ${historial["lugaryfechadenacimiento"] ?? "___________________________________"} '
              'Tipo de documento: ${historial["tipo de documento"]} '
              'N°: ${historial["N°"] ?? "_______________________"} '
              'Dirección: ${historial["direccion"] ?? "__________________________________________"} '
              'Barrio: ${historial["barrio"] ?? "______________"} '
              'Teléfono: ${historial["telefono"] ?? "__________________"} '
              'Grado: ${historial["grado"]} '
              'Jornada: ${historial["jornada"] ?? "______"} '
              'Sede: ${historial["sede"] ?? "_____"} '
              'Director de grupo: ${historial["directoradegruoo"] ?? "______________"}',
              style: const pw.TextStyle(fontSize: 10),
            ),
            pw.SizedBox(height: 8),
            pw.Text('II. COMPOSICIÓN FAMILIAR',
                style: const pw.TextStyle(fontSize: 12)),
            pw.SizedBox(height: 8),
            pw.Text(
              'Nombre del Padre: ${historial["nombrepadre"] ?? "_________"} '
              'Edad: ${historial["edadpadre"] ?? "_________"} '
              'Teléfono: ${historial["telefonopadre"] ?? "________________"} '
              'Nivel escolaridad: ${historial["nivelescolarpadre"] ?? "__________"} '
              'Profesión u Ocupación: ${historial["profesionuocupacionpadre"] ?? "_________"} '
              'Horario Laboral: ${historial["horariolaboralpadre"] ?? "________"} '
              'Nombre de la Madre: ${historial["nombremadre"] ?? "_________"} '
              'Edad: ${historial["edadmadre"] ?? "_________"} '
              'Teléfono: ${historial["telefonomadre"] ?? "________________"} '
              'Nivel escolaridad: ${historial["nivelescolarmadre"] ?? "__________"} '
              'Profesión u Ocupación: ${historial["profesionuocupacionmadre"] ?? "_________"} '
              'Horario Laboral: ${historial["horariolaboralmadre"] ?? "________"} '
              'Estado civil de los Padres: ${historial["esadocivil"] ?? "________"} '
              'No. de Hermanos: ${historial["numerodehermanos"] ?? "________"} '
              'Lugar que Ocupa: ${historial["lugarqueocupa"] ?? "________"} '
              'Cuidador: ${historial["cuidador"] ?? "________"} '
              'Parentesco: ${historial["parentesco"] ?? "________"} '
              'Fecha iniciación de la ficha de seguimiento: ${historial["Fechainiciacióndelafichadeseguimiento"] ?? "________"}',
              style: const pw.TextStyle(fontSize: 10),
            ),

            pw.SizedBox(height: 8),
            pw.Text('Motivo de remision',
                style: const pw.TextStyle(fontSize: 12)),
            pw.SizedBox(height: 8),

            pw.Paragraph(
                text: ' ${historial["motivo de remision"] ?? "________"}',
                style: const pw.TextStyle(fontSize: 10)),

            pw.SizedBox(height: 8),
            pw.Text('Historial de problema y/o dificultad',
                style: const pw.TextStyle(fontSize: 12)),
            pw.SizedBox(height: 8),

            pw.Paragraph(
                text:
                    '${historial["historiadelproblemay/odificultad"] ?? "________"}',
                style: const pw.TextStyle(fontSize: 10)),

            pw.SizedBox(height: 8),
            pw.Text('Historial familiar',
                style: const pw.TextStyle(fontSize: 12)),
            pw.SizedBox(height: 8),

            pw.Table(
              border: pw.TableBorder.all(width: 0.5),
              columnWidths: {
                0: const pw.FixedColumnWidth(
                    80), // Definir un tamaño fijo de 100px
                1: const pw.FlexColumnWidth(
                    0.2), // Esta columna tendrá el ancho proporcional al resto
                2: const pw.FlexColumnWidth(1.2),
                3: const pw.FlexColumnWidth(0.2),
                4: const pw.FlexColumnWidth(0.2),
                5: const pw.FlexColumnWidth(2.5),
              },
              children: [
                pw.TableRow(
                  children: [
                    pw.Text(' Personas con las que vives',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text(' N°', style: const pw.TextStyle(fontSize: 10)),
                    pw.Text(''),
                    pw.Text(' si ', style: const pw.TextStyle(fontSize: 10)),
                    pw.Text(' no ', style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('                             Observaciones',
                        style: const pw.TextStyle(fontSize: 10)),
                  ],
                ),
                pw.TableRow(
                  children: [
                    pw.Text(' No de Hermanos',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('${historial["numerodehermanos"] ?? "________"}',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text(' ¿vive con ambos padres?',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text(
                        historial["¿viveconambospadres?"] == "Sí" ? "X" : "",
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text(
                        historial["¿viveconambospadres?"] == "No" ? "X" : "",
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('${historial["observacionpadres"] ?? ""}',
                        style: const pw.TextStyle(fontSize: 10)),
                  ],
                ),
                pw.TableRow(
                  children: [
                    pw.Text(' Hombres',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('${historial["Nhombres"]}',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text(' ¿vive con el padre?',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text(historial["¿viveconelpadres?"] == "Sí" ? "X" : "",
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text(historial["¿viveconelpadres?"] == "No" ? "X" : "",
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('${historial["observacionpadre"] ?? ""}',
                        style: const pw.TextStyle(fontSize: 10)),
                  ],
                ),
                pw.TableRow(
                  children: [
                    pw.Text(' Mujeres',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('${historial["Nmujeres"]}',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text(' ¿vive con la madre?',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text(historial["¿viveconlamadre?"] == "Sí" ? "X" : "",
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text(historial["¿viveconlamadre?"] == "No" ? "X" : "",
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('${historial["madreobservacion"] ?? ""}',
                        style: const pw.TextStyle(fontSize: 10)),
                  ],
                ),
                pw.TableRow(
                  children: [
                    pw.Text(' Lugares que  ocupa entre sus hermanos ',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('${historial["lugarqueocupaa"] ?? ""}',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text(' ¿vive con tíos?',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text(historial["¿vivecontios?"] == "Sí" ? "X" : "",
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text(historial["¿vivecontios?"] == "No" ? "X" : "",
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('${historial["tiosobervador"] ?? ""}',
                        style: const pw.TextStyle(fontSize: 10)),
                  ],
                ),
                pw.TableRow(
                  children: [
                    pw.Text(' ¿cuántos  son los miembros de la  familia?',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('${historial["Nmiebrosdelafamilia"]}',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text(' ¿vive con abuelos?',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text(historial["¿viveconabuelos?"] == "Sí" ? "X" : "",
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text(historial["¿viveconabuelos?"] == "No" ? "X" : "",
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('${historial["abueloobservador"] ?? ""}',
                        style: const pw.TextStyle(fontSize: 10)),
                  ],
                ),
                pw.TableRow(
                  children: [
                    pw.Text(' ¿cuántas  familias viven en  la casa?',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('${historial["¿cuantasfamilia?"]}',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text(' ¿vive con otros  familiares?',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text(
                        historial["¿viveconotrosfamilaires?"] == "Si"
                            ? "X"
                            : "",
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text(
                        historial["¿viveconotrosfamilaires?"] == "No"
                            ? "X"
                            : "",
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('${historial["familiaresobervadores"] ?? ""}',
                        style: const pw.TextStyle(fontSize: 10)),
                  ],
                ),
                pw.TableRow(
                  children: [
                    pw.Text(' ¿cuántos adultos  viven en la casa?',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('${historial["¿cuantosadultosviven?"]}',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text(' ¿vive con personas que  no sean familiares?',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text(historial["¿nofamilia?"] == "Si" ? "X" : "",
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text(historial["¿nofamilia?"] == "No" ? "X" : "",
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('${historial["familiaobervador"] ?? ""}',
                        style: const pw.TextStyle(fontSize: 10)),
                  ],
                ),
              ],
            ),

            pw.SizedBox(height: 8),
            pw.Text(
                'Relaciones familiares (Escriba con N, cuando sea Normal, o con una C, cuando sea conflictiva)',
                style: const pw.TextStyle(fontSize: 10)),
            pw.SizedBox(height: 8),

            pw.Table(
              border: pw.TableBorder.all(width: 0.5),
              columnWidths: {
                0: const pw.FixedColumnWidth(
                    110), // Definir un tamaño fijo de 100px
                1: const pw.FlexColumnWidth(
                    0.3), // Esta columna tendrá el ancho proporcional al resto
                2: const pw.FlexColumnWidth(3),
              },
              children: [
                pw.TableRow(
                  children: [
                    pw.Text(' ', style: const pw.TextStyle(fontSize: 12)),
                    pw.Text('Tipo', style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('                      Descripcion'),
                  ],
                ),
                pw.TableRow(
                  children: [
                    pw.Text(' Hermanos',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('${historial["relacionhermano"] ?? ""}',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('${historial["descripcionher"] ?? ""}',
                        style: const pw.TextStyle(fontSize: 10)),
                  ],
                ),
                pw.TableRow(
                  children: [
                    pw.Text('padre', style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('${historial["relacionpadre"] ?? ""}',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('${historial["descripcionpadre"] ?? ""}',
                        style: const pw.TextStyle(fontSize: 10)),
                  ],
                ),
                pw.TableRow(
                  children: [
                    pw.Text(' Madre', style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('${historial["relacionmadre"] ?? ""}',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text(' ${historial["descripcionmadre"] ?? ""}',
                        style: const pw.TextStyle(fontSize: 10)),
                  ],
                ),
                pw.TableRow(
                  children: [
                    pw.Text(' cuidador',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('${historial["relacioncuidador"] ?? ""}',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text(' ${historial["descripcionrelacion"] ?? ""}',
                        style: const pw.TextStyle(fontSize: 10)),
                  ],
                ),
              ],
            ),

            pw.SizedBox(height: 8),
            pw.Text('Historial escolar y convivencial',
                style: const pw.TextStyle(fontSize: 12)),
            pw.SizedBox(height: 8),

            pw.Paragraph(
                text:
                    '${historial["historialescolaryconvivencial"] ?? "________"}',
                style: const pw.TextStyle(fontSize: 10)),

            pw.Text('Historial social',
                style: const pw.TextStyle(fontSize: 12)),

//primera parte

            pw.Table(
              border: pw.TableBorder.all(width: 0.5),
              columnWidths: {
                0: const pw.FixedColumnWidth(
                    220), // Definir un tamaño fijo de 100px
                1: const pw.FlexColumnWidth(
                    1), // Esta columna tendrá el ancho proporcional al resto
              },
              children: [
                pw.TableRow(
                  children: [
                    pw.Text(
                        ' USO DEL TIEMPO LIBRE: ${historial["tiempolibre"] ?? ""} ',
                        style: const pw.TextStyle(fontSize: 12)),
                    pw.Text(
                        ' PRACTICA DEPORTES: ${historial["practicadeportes"] ?? ""} ',
                        style: const pw.TextStyle(fontSize: 10)),
                  ],
                ),
                pw.TableRow(
                  children: [
                    pw.Text(
                        ' TIPO DE AMISTADES:${historial["tipodeamistades"] ?? ""} ',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('', style: const pw.TextStyle(fontSize: 10)),
                  ],
                ),
              ],
            ),

            pw.Table(
              border: pw.TableBorder.all(width: 0.5),
              columnWidths: {
                0: const pw.FixedColumnWidth(
                    50), // Definir un tamaño fijo de 100px
                1: const pw.FlexColumnWidth(0.6),
                2: const pw.FlexColumnWidth(1),
                3: const pw.FlexColumnWidth(1),
                4: const pw.FlexColumnWidth(0.6),
                5: const pw.FlexColumnWidth(1.6),
                6: const pw.FlexColumnWidth(
                    3), // Esta columna tendrá el ancho proporcional al resto
              },
              children: [
                // Primera  // Segunda  parte
                pw.TableRow(
                  children: [
                    pw.Text('BARRIO', style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('${historial["bar"] ?? ""}',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text(' COLEGIO',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('${historial["colegio"] ?? ""}',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('${historial["mismaedad"] ?? ""}',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('¿Cómo son sus relaciones con las demás personas?',
                        style: const pw.TextStyle(fontSize: 6)),
                    pw.Text('${historial["relacionconlosdemas"] ?? ""}',
                        style: const pw.TextStyle(fontSize: 10)),
                  ],
                ),

                pw.TableRow(
                  children: [
                    pw.Text(' MAYORES', style: const pw.TextStyle(fontSize: 9)),
                    pw.Text('${historial["mayores"] ?? ""}',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text(' MENORES',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('MISMA EDAD',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('${historial["menores"] ?? ""}',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text(
                        '¿Cómo son sus relaciones con sus compañeros y profesores?',
                        style: const pw.TextStyle(fontSize: 6)),
                    pw.Text('${historial["relacionenelcolegio"] ?? ""}',
                        style: const pw.TextStyle(fontSize: 10)),
                  ],
                ),
              ],
            ),

            pw.Text('CONDICIONES ECONOMICAS (Marque con una X)',
                style: const pw.TextStyle(fontSize: 12)),

            pw.Table(
              border: pw.TableBorder.all(width: 0.5),
              columnWidths: {
                0: const pw.FixedColumnWidth(
                    140), // Definir un tamaño fijo de 100px
                1: const pw.FlexColumnWidth(
                    0.5), // Esta columna tendrá el ancho proporcional al resto
              },
              children: [
                pw.TableRow(
                  children: [
                    pw.Text(' CUALIFICADOR',
                        style: const pw.TextStyle(fontSize: 12)),
                    pw.Text(' DESCRIPCION ',
                        style: const pw.TextStyle(fontSize: 10)),
                  ],
                ),
                pw.TableRow(
                  children: [
                    pw.Text(
                        'EXCELENTES ${historial["estadoeconomico"] == "Excelente" ? "X" : ""}',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('${historial["observadorExcelente"] ?? ""}',
                        style: const pw.TextStyle(fontSize: 10)),
                  ],
                ),
                pw.TableRow(
                  children: [
                    pw.Text(
                        'BUENAS ${historial["estadoeconomico"] == "Buenas" ? "X" : ""}',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('${historial["observadorBuenas"] ?? ""}',
                        style: const pw.TextStyle(fontSize: 10)),
                  ],
                ),
                pw.TableRow(
                  children: [
                    pw.Text(
                        'BASICAS ${historial["estadoeconomico"] == "Básicas" ? "X" : ""} ',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('${historial["observadorBasicas"] ?? ""}',
                        style: const pw.TextStyle(fontSize: 10)),
                  ],
                ),
                pw.TableRow(
                  children: [
                    pw.Text(
                        ' INSUFICIENTES ${historial["estadoeconomico"] == "Insuficientes" ? "X" : ""} ',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('${historial["observadorInsuficientes"] ?? ""}',
                        style: const pw.TextStyle(fontSize: 10)),
                  ],
                ),
              ],
            ),

            pw.Text('Condicion de salud',
                style: const pw.TextStyle(fontSize: 12)),

            pw.Table(
              border: pw.TableBorder.all(width: 0.5),
              columnWidths: {
                0: const pw.FixedColumnWidth(
                    40), // Definir un tamaño fijo de 100px
                1: const pw.FlexColumnWidth(
                    4), // Esta columna tendrá el ancho proporcional al resto
                2: const pw.FlexColumnWidth(4),
                3: const pw.FlexColumnWidth(3.5),
                4: const pw.FlexColumnWidth(4),
              },
              children: [
                pw.TableRow(
                  children: [
                    pw.Text(' AÑO', style: const pw.TextStyle(fontSize: 12)),
                    pw.Text(' ENFERMEDADES Y/O TRASTORNOS',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text(' TRATAMIENTOS'),
                    pw.Text(' EXAMENES y/o PRUEBAS ',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text(' VALORACIONES POR ESPECIALISTAS',
                        style: const pw.TextStyle(fontSize: 10)),
                  ],
                ),
                pw.TableRow(
                  children: [
                    pw.Text('${historial["fechasalud"] ?? ""} ',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('${historial["enfermedadesy/otrastorno"] ?? ""} ',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('${historial["tratamientos"] ?? ""} ',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('${historial["exmanesy/opruebas"] ?? ""} ',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('${historial["valoracion"] ?? ""} ',
                        style: const pw.TextStyle(fontSize: 10)),
                  ],
                ),
                pw.TableRow(
                  children: [
                    pw.Text('${historial["fechasalud2"] ?? ""} ',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('${historial["enfermedadesy/otrastorno2"] ?? ""} ',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('${historial["tratamientos2"] ?? ""} ',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('${historial["exmanesy/opruebas2"] ?? ""} ',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('${historial["valoracion2"] ?? ""} ',
                        style: const pw.TextStyle(fontSize: 10)),
                  ],
                ),
                pw.TableRow(
                  children: [
                    pw.Text('${historial["fechasalud3"] ?? ""} ',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('${historial["enfermedadesy/otrastorno3"] ?? ""} ',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('${historial["tratamientos3"] ?? ""} ',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('${historial["exmanesy/opruebas3"] ?? ""} ',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('${historial["valoracion3"] ?? ""} ',
                        style: const pw.TextStyle(fontSize: 10)),
                  ],
                ),
              ],
            ),

            pw.Text('Presenta discapacidad si no',
                style: const pw.TextStyle(fontSize: 12)),

            pw.Table(
              border: pw.TableBorder.all(width: 0.5),
              columnWidths: {
                0: const pw.FixedColumnWidth(
                    100), // Definir un tamaño fijo de 100px
                1: const pw.FlexColumnWidth(
                    1), // Esta columna tendrá el ancho proporcional al resto
                2: const pw.FlexColumnWidth(1),
                3: const pw.FlexColumnWidth(1),
              },
              children: [
                pw.TableRow(
                  children: [
                    pw.Text(' CUALIFICADOR',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('LEVE', style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('MODERADO'),
                    pw.Text(' SEVERO', style: const pw.TextStyle(fontSize: 10)),
                  ],
                ),
                pw.TableRow(
                  children: [
                    pw.Text(' TRASTORNOS DEL ESPECTRO AUTISTA (TEA)',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('${historial["leve1"] ?? ""}',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('${historial["mode1"] ?? ""}',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('${historial["severo1"] ?? ""}',
                        style: const pw.TextStyle(fontSize: 10)),
                  ],
                ),
                pw.TableRow(
                  children: [
                    pw.Text('INTELECTUAL',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('${historial["leve2"] ?? ""}',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('${historial["mode2"] ?? ""}',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('${historial["severo2"] ?? ""}',
                        style: const pw.TextStyle(fontSize: 10)),
                  ],
                ),
                pw.TableRow(
                  children: [
                    pw.Text(' PSICOSOCIAL',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('${historial["leve3"] ?? ""}',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('${historial["mode3"] ?? ""}',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('${historial["severo3"] ?? ""}',
                        style: const pw.TextStyle(fontSize: 10)),
                  ],
                ),
                pw.TableRow(
                  children: [
                    pw.Text(' SISTEMICA',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('${historial["leve4"] ?? ""}',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('${historial["mode4"] ?? ""}',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('${historial["severo4"] ?? ""}',
                        style: const pw.TextStyle(fontSize: 10)),
                  ],
                ),
                pw.TableRow(
                  children: [
                    pw.Text(' AUDITIVA',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('${historial["leve5"] ?? ""}',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('${historial["mode5"] ?? ""}',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('${historial["severo5"] ?? ""}',
                        style: const pw.TextStyle(fontSize: 10)),
                  ],
                ),
                pw.TableRow(
                  children: [
                    pw.Text(' VISUAL', style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('${historial["leve6"] ?? ""}',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('${historial["mode6"] ?? ""}',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('${historial["severo6"] ?? ""}',
                        style: const pw.TextStyle(fontSize: 10)),
                  ],
                ),
                pw.TableRow(
                  children: [
                    pw.Text(' SORDOCEGUERRA',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('${historial["leve7"] ?? ""}',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('${historial["mode7"] ?? ""}',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('${historial["severo7"] ?? ""}',
                        style: const pw.TextStyle(fontSize: 10)),
                  ],
                ),
                pw.TableRow(
                  children: [
                    pw.Text(' FISICA', style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('${historial["leve8"] ?? ""}',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('${historial["mode8"] ?? ""}',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('${historial["severo8"] ?? ""}',
                        style: const pw.TextStyle(fontSize: 10)),
                  ],
                ),
                pw.TableRow(
                  children: [
                    pw.Text(' TRASTORNOS PERMANETES DE LA VOZ Y EL HABLA ',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('${historial["leve9"] ?? ""}',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('${historial["mode9"] ?? ""}',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('${historial["severo9"] ?? ""}',
                        style: const pw.TextStyle(fontSize: 10)),
                  ],
                ),
              ],
            ),

            pw.SizedBox(height: 8),
            pw.Text('resultado de la evaluacion',
                style: const pw.TextStyle(fontSize: 12)),
            pw.SizedBox(height: 8),

            pw.Paragraph(
                text:
                    '${historial["historialescolaryconvivencial"] ?? "________"}',
                style: const pw.TextStyle(fontSize: 10)),

            pw.SizedBox(height: 8),
            pw.Text('registro de atencion',
                style: const pw.TextStyle(fontSize: 12)),
            pw.SizedBox(height: 8),

            pw.Table(
              border: pw.TableBorder.all(width: 0.5),
              columnWidths: {
                0: const pw.FixedColumnWidth(
                    70), // Definir un tamaño fijo de 100px
                1: const pw.FlexColumnWidth(
                    4), // Esta columna tendrá el ancho proporcional al resto
                2: const pw.FlexColumnWidth(4),
              },
              children: [
                pw.TableRow(
                  children: [
                    pw.Text(' fecha de registro',
                        style: const pw.TextStyle(fontSize: 8)),
                    pw.Text('INTERVENCION ',
                        style: const pw.TextStyle(fontSize: 8)),
                    pw.Text(
                        '  SUGERENCIAS A DOCENTES, PADRES DE FAMILIA Y ESTUDIANTE.',
                        style: const pw.TextStyle(fontSize: 8)),
                  ],
                ),
                pw.TableRow(
                  children: [
                    pw.Text('${historial["fregis"] ?? ""}',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('${historial["intervenl"] ?? ""}',
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text('${historial["suge"] ?? ""} ',
                        style: const pw.TextStyle(fontSize: 10)),
                  ],
                ),
              ],
            ),

            pw.SizedBox(height: 8),
            pw.Text('___________________',
                style: const pw.TextStyle(fontSize: 12)),
            pw.Text('Docente orientador',
                style: const pw.TextStyle(fontSize: 12)),
            pw.Text('sede ', style: const pw.TextStyle(fontSize: 12)),
            pw.Text('jornada', style: const pw.TextStyle(fontSize: 12)),
          ];
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.idCita != "1" ? 2 : 1,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colours.main2,
          title: Text("Historial de ${widget.studentName}"),
          bottom: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black,
            tabs: [
              if (widget.idCita != "1") Tab(text: "Crear"),
              Tab(text: "Imprimir"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            if (widget.idCita != "1")
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Nombre: ${widget.studentName}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "ID: ${widget.studentId}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Aquí es donde implementas el PageView

                    Expanded(
                      child: PageViewForm(
                        psicologaid: SignInState.infoUser["psicologaid"],
                        idCita: widget.idCita,
                        studentName: widget.studentName,
                        studentId: widget.studentId,
                        studentCourse: widget.studentCourse,
                        studentGrade: widget.studentGrade,
                      ),
                    ),
                  ],
                ),
              ),
            Container(
              margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width > 1300 ? 500 : 0,
                  right: MediaQuery.of(context).size.width > 1300 ? 500 : 0,
                  top: MediaQuery.of(context).size.width > 1300 ? 100 : 0,
                  bottom: MediaQuery.of(context).size.width > 1300 ? 50 : 0),
              decoration: AddContainerStyle.containerBase,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('historiales-clinicos')
                    .doc(widget.studentId)
                    .collection("historial")
                    .where('idUser', isEqualTo: widget.studentId)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                        child: Text('No hay historial disponible.'));
                  }

                  final List<DocumentSnapshot> historialDocs =
                      snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: historialDocs.length,
                    itemBuilder: (context, index) {
                      final historial =
                          historialDocs[index].data() as Map<String, dynamic>;
                      return Card(
                        margin: const EdgeInsets.all(8),
                        child: ListTile(
                          title: Text(
                            'Fecha: ${DateFormat('yyyy-MM-dd').format((historial['date'] as Timestamp).toDate())}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colours
                                  .main, // Color más oscuro para mayor contraste
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 5),
                              Text(
                                'Cliente: ${historial['name']}',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey[700]),
                              ),
                              Text(
                                'Datos personales: ${historial['telefono']}-${historial['direccion']}-${historial["N°"]}',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey[700]),
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.picture_as_pdf,
                              color: Colors.redAccent,
                              size: 28,
                            ),
                            onPressed: () => _generatePdf(historial),
                            tooltip: 'Generar PDF',
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          tileColor: Colors.white,
                          leading: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colours.main2.withOpacity(0.1),
                            ),
                            padding: const EdgeInsets.all(6),
                            child: Image.asset("/images/historial.png"),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
