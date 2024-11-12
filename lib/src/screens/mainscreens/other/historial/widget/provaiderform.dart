import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import "../../../../../imports.dart";
import "../historial.dart";

class FormProvider with ChangeNotifier {
  String _studentId = '';
  //form1
  String _nombreController = '';
  String _lugarController = '';
  String _tdocController = '';
  String _docController = '';
  String _dirController = '';
  String _barController = '';
  String _telController = '';
  String _jorController = '';
  String _gradoController = '';
  String _sedeController = '';
  String _dirgrupoController = '';
  String _epsController = '';
  //form2
  String _nombrepadreController = '';
  String _edadpadreController = '';
  String _telpadreController = '';
  String _nescolarpadreController = '';
  String _profepadreController = '';
  String _hlaboralpadreController = '';
  String _nombremadreController = '';
  String _edadmadreController = '';
  String _telmadreController = '';
  String _nescolarmadreController = '';
  String _profemadreController = '';
  String _hlaboralmadreController = '';
  //form3
  String _estadoController = '';
  String _nherController = '';
  String _lugarocuController = '';
  String _cuidadorController = '';
  String _parentescoController = '';
  String _fechainiController = '';
  String _motivoController = '';
  String _histoproController = '';
  //form4
  String _numherController = '';
  String _vivepadres = '';
  String _padresobserController = '';
  String _nhomController = '';
  String _vivepadre = '';
  String _homobserController = '';
  String _nmujerController = '';
  String _vivemadre = '';
  String _mujerobserController = '';
  String _lugarentreController = '';
  String _vivetio = '';
  String _tioobserController = '';
  //form5
  String _nmienController = '';
  String _viveabuelo = '';
  String _abueloobserController = '';
  String _nfamController = '';
  String _vivefam = '';
  String _famobserController = '';
  String _nadulController = '';
  String _vivenofam = '';
  String _nofamobserController = '';
// form 6
  String _hert = '';
  String _herdescripController = '';
  String _padret = '';
  String _padescripController = '';
  String _madret = '';
  String _madescripController = '';
  String _cuidt = '';
  String _cuidescipController = '';
  String hisescolarController = '';
//form 7
  String _tiempoController = '';
  String  _deporController = '';
  String  _tipoamisController = '';
  String  _barrio = '';
  String  _colegio = '';
  String  _mayores = '';
  String  _menores = '';
  String  _misma = '';
  String  _rdemasController = '';
  String  _rcolController = '';
//form 8
  String observacion = '';
  
  String _observadorExcelenteController = '';
  String _observadorBuenasController = '';
  String _observadorBasicasController = '';
  String _observadorInsuficientesController = '';
//form 9
  String _fechController = '';
  String _enfermedadController = '';
  String _tratamientoController = '';
  String _examenesController = '';
  String _valoracionController = '';
  String _fechController2 = '';
  String _enfermedadController2 = '';
  String _tratamientoController2 = '';
  String _examenesController2 = '';
  String _valoracionController2 = '';
  String _fechController3 = '';
  String _enfermedadController3 = '';
  String _tratamientoController3 = '';
  String _examenesController3 = '';
  String _valoracionController3 = '';
//form 10_1
String _prom1leveController = '';
String _prom1moderadoController = '';
String _prom1severoController = '';
//form 10_2
String _prom2leveController = '';
String _prom2moderadoController = '';
String _prom2severoController = '';
//form 10_3
String _prom3leveController = '';
String _prom3moderadoController = '';
String _prom3severoController = '';
//form 10_4
String _prom4leveController = '';
String _prom4moderadoController = '';
String _prom4severoController = '';
//form 10_5
String _prom5leveController = '';
String _prom5moderadoController = '';
String _prom5severoController = '';
//form 10_6
String _prom6leveController = '';
String _prom6moderadoController = '';
String _prom6severoController = '';
//form 10_7
String _prom7leveController = '';
String _prom7moderadoController = '';
String _prom7severoController = '';
//form 10_8
String _prom8leveController = '';
String _prom8moderadoController = '';
String _prom8severoController = '';
//form 10_9
String _prom9leveController = '';
String _prom9moderadoController = '';
String _prom9severoController = '';
//form 11
 String _resulController= "";
 String _interController= "";
 String _recoController= "";
 String _selectedDate = "";

  // Método para actualizar el studentId
  void updateStudentId(String studentId) {
    _studentId = studentId;
    notifyListeners();
  }

  // Métodos para actualizar los datos del formulario
  void updateForm1(
      String studentId, 
      String nombre,
      String lugar,
      String tdoc,
      String doc,
      String dir,
      String bar,
      String tel,
      String jor,
      String grado,
      String sede,
      String dirgrupo,
      String eps) {
        _studentId = studentId;
    _nombreController = nombre;
    _lugarController = lugar;
    _tdocController = tdoc;
    _docController = doc;
    _dirController = dir;
    _barController = bar;
    _telController = tel;
    _jorController = jor;
    _gradoController = grado;
    _sedeController = sede;
    _dirgrupoController = dirgrupo;
    _epsController = eps;

    notifyListeners();
  }

  void updateForm2(
      String nombrepadre,
      String edadpadre,
      String telpadre,
      String nivelescpadre,
      String profepadre,
      String hlaboralpadre,
      String nombremadre,
      String edadmadre,
      String telmadre,
      String nivelescmadre,
      String profemadre,
      String hlaboralmadre) {
    _nombrepadreController = nombrepadre;
    _edadpadreController = edadpadre;
    _telpadreController = telpadre;
    _nescolarpadreController = nivelescpadre;
    _profepadreController = profepadre;
    _hlaboralpadreController = hlaboralpadre;
    _nombremadreController = nombremadre;
    _edadmadreController = edadmadre;
    _telmadreController = telmadre;
    _nescolarmadreController = nivelescmadre;
    _profemadreController = profemadre;
    _hlaboralmadreController = hlaboralmadre;
    notifyListeners();
  }

  void updateForm3(
      String estado,
      String nhermanos,
      String lugarocu,
      String cuidador,
      String paren,
      String fechaini,
      String motiv,
      String historialpro) {
    _estadoController = estado;
    _nherController = nhermanos;
    _lugarocuController = lugarocu;
    _cuidadorController = cuidador;
    _parentescoController = paren;
    _fechainiController = fechaini;
    _motivoController = motiv;
    _histoproController = historialpro;
    notifyListeners();
  }

  void updateForm4(
      String nher,
      String vivepadres,
      String padreobs,
      String nhom,
      String vivepadre,
      String homobser,
      String nmuj,
      String vivemadre,
      String mujobser,
      String lugarentre,
      String vivetio,
      String tioobser) {
    _numherController = nher;
    _vivepadres = vivepadres;
    _padresobserController = padreobs;
    _nhomController = nhom;
    _vivepadre = vivepadre;
    _homobserController = homobser;
    _nmujerController = nmuj;
    _vivemadre = vivemadre;
    _mujerobserController = mujobser;
    _lugarentreController = lugarentre;
    _vivetio = vivetio;
    _tioobserController = tioobser;
    notifyListeners();
  }

  void updateForm5(
      String nmienbros,
      String viveabuelo,
      String abueloobser,
      String nfam,
      String vivefam,
      String famobser,
      String nadul,
      String vivenofam,
      String nofamonbser) {
    _nmienController = nmienbros;
    _viveabuelo = viveabuelo;
    _abueloobserController = abueloobser;
    _nfamController = nfam;
    _vivefam = vivefam;
    _famobserController = famobser;
    _nadulController = nadul;
    _vivenofam = vivenofam;
    _nofamobserController = nofamonbser;
    notifyListeners();
  }

  void updateForm6(String hertrato, String herdescrip,String padretrato, String padredescrip,String madretrato, String madredescrip,String cuidtrato, String cuiddescrip, String hiescolar ) {
    _hert = hertrato;
    _herdescripController = herdescrip;
    _padret = padretrato;
    _padescripController = padredescrip;
    _madret = madretrato;
    _madescripController = madredescrip;
    _cuidt = cuidtrato;
    _cuidescipController = cuiddescrip;
    hisescolarController = hiescolar;
    notifyListeners();
  }

  void updateForm7(String tiempo, String deporte, String tipoamis, String barrio, String colegio, String mayores, String menores, String misma, String relaciond, String relacionc) {
   _tiempoController = tiempo ;
    _deporController = deporte;
    _tipoamisController = tipoamis;
    _barrio = barrio;
    _colegio = colegio;
    _mayores = mayores;
    _menores = menores;
    _misma = misma;
    _rdemasController =relaciond ;
    _rcolController = relacionc;
    notifyListeners();
  }

  void updateForm8(String estado, String observadorExcelente, String observadorBuenas, String observadorBasicas, String observadorInsuficientes) {
    observacion = estado;
    _observadorExcelenteController = observadorExcelente;
    _observadorBuenasController = observadorBuenas;
    _observadorBasicasController = observadorBasicas;
    _observadorInsuficientesController = observadorInsuficientes;
    notifyListeners(); 
  }

  void updateForm9(String fecha, String enfermedad, String tratamiento, String examnes, String valoracion,String fecha2, String enfermedad2, String tratamiento2, String examnes2, String valoracion2, String fecha3, String enfermedad3, String tratamiento3, String examnes3, String valoracion3) {
   _fechController = fecha;
   _enfermedadController = enfermedad;
   _tratamientoController = tratamiento;
   _examenesController = examnes;
   _valoracionController = valoracion;
   _fechController2 = fecha2;
   _enfermedadController2 = enfermedad2;
   _tratamientoController2 = tratamiento2;
   _examenesController2 = examnes2;
   _valoracionController2 = valoracion2;
   _fechController3 = fecha3;
   _enfermedadController3 = enfermedad3;
   _tratamientoController3 = tratamiento3;
   _examenesController3 = examnes3;
   _valoracionController3 = valoracion3;
    notifyListeners();
  }

  void updateForm10_1(String leve1, String mode1, String severo1) {
  _prom1leveController = leve1;
  _prom1moderadoController = mode1;
  _prom1severoController = severo1;

    notifyListeners(); // Notifica a los oyentes que ha habido un cambio
  }

  void updateForm10_2(String leve2, String mode2, String severo2) {
  _prom2leveController = leve2;
  _prom2moderadoController = mode2;
  _prom2severoController = severo2;
    notifyListeners(); // Notifica a los oyentes que ha habido un cambio
  }

  void updateForm10_3(String leve3, String mode3, String severo3) {
  _prom3leveController = leve3;
  _prom3moderadoController = mode3;
  _prom3severoController = severo3;
    notifyListeners(); // Notifica a los oyentes que ha habido un cambio
  }

  void updateForm10_4(String leve4, String mode4, String severo4) {
  _prom4leveController = leve4;
  _prom4moderadoController = mode4;
  _prom4severoController = severo4;
    notifyListeners(); // Notifica a los oyentes que ha habido un cambio
  }

  void updateForm10_5(String leve5, String mode5, String severo5) {
  _prom5leveController = leve5;
  _prom5moderadoController = mode5;
  _prom5severoController = severo5;
    notifyListeners(); // Notifica a los oyentes que ha habido un cambio
  }

  void updateForm10_6(String leve6, String mode6, String severo6) {
  _prom6leveController = leve6;
  _prom6moderadoController = mode6;
  _prom6severoController = severo6;
    notifyListeners(); // Notifica a los oyentes que ha habido un cambio
  }

  void updateForm10_7(String leve7, String mode7, String severo7) {
  _prom7leveController = leve7;
  _prom7moderadoController = mode7;
  _prom7severoController = severo7;
    notifyListeners(); // Notifica a los oyentes que ha habido un cambio
  }

  void updateForm10_8(String leve8, String mode8, String severo8) {
  _prom8leveController = leve8;
  _prom8moderadoController = mode8;
  _prom8severoController = severo8;
    notifyListeners(); // Notifica a los oyentes que ha habido un cambio
  }

  void updateForm10_9(String leve9, String mode9, String severo9) {
  _prom9leveController = leve9;
  _prom9moderadoController = mode9;
  _prom9severoController = severo9;
    notifyListeners(); // Notifica a los oyentes que ha habido un cambio
  }

  void updateForm11(String res, String fregis, String inter, String sug) {
 _interController= inter;
 _recoController= sug;
 _resulController= res;
 _selectedDate = fregis;
    notifyListeners();
  }


   String generateUuid() {
    Uuid uuid = const Uuid();
    return uuid.v4();
  }

  // Método para enviar los datos a Firebase
  Future<void> submitFormData(
      String studentName, String studentCourse, String studentGrade) async {
    Map<String, dynamic> data = {
      "id": generateUuid(),
      "date": DateTime.now(),
      "idUser": _studentId, // Usar el studentId guardado en el provider
      "name": _nombreController,
      "lugaryfechadenacimiento" : _lugarController,
      "tipo de documento": _tdocController,
      "N°": _docController,
      "direccion" : _dirController,
      "barrio" : _barController,
      "telefono" : _telController,
      "jornada" : _jorController,
      "grado" : _gradoController,
      "sede" : _sedeController,
      "directoradegruoo" : _dirgrupoController,
      "eps" :_epsController,
      "nombrepadre": _nombrepadreController,
      "edadpadre" : _edadpadreController,
      "telefonopadre": _telpadreController,
      "nivelescolarpadre" : _nescolarpadreController,
      "profesionuocupacionpadre" : _profepadreController,
      "horariolaboralpadre" :_hlaboralpadreController,
      "nombremadre": _nombremadreController,
      "edadmadre" : _edadmadreController,
      "telefonomadre": _telmadreController,
      "nivelescolarmadre" : _nescolarmadreController,
      "profesionuocupacionmadre" : _profemadreController,
      "horariolaboralmadre" :_hlaboralmadreController,
      "esadocivil": _estadoController,
      "numerodehermanos" : _nherController,
      "lugarqueocupa": _lugarocuController,
      "cuidador": _cuidadorController,
      "parentesco": _parentescoController,
      "Fechainiciacióndelafichadeseguimiento" : _fechainiController,
      "motivo de remision": _motivoController,
      "historiadelproblemay/odificultad" :_histoproController,
      "NodeHermanos" : _numherController,
      "¿viveconambospadres?": _vivepadres,
      "observacionpadres":_padresobserController,
      "Nhombres":_nhomController,
      "¿viveconelpadres?": _vivepadre,
      "observacionpadre": _homobserController,
      "Nmujeres": _nmujerController,
      "¿viveconlamadre?": _vivemadre,
      "madreobservacion": _mujerobserController,
      "lugarqueocupaa": _lugarentreController,
      "¿vivecontios?": _vivetio,
      "tiosobervador": _tioobserController,
      "Nmiebrosdelafamilia": _nmienController,
      "¿viveconabuelos?": _viveabuelo,
      "abueloobservador": _abueloobserController,
      "¿cuantasfamilia?": _nfamController,
      "¿viveconotrosfamilaires?": _vivefam ,
      "familiaresobervadores": _famobserController,
      "¿cuantosadultosviven?": _nadulController,
      "¿nofamilia?": _vivenofam,
      "familiaobervador": _nofamobserController,
      "relacionhermano": _hert,
      "descripcionher": _herdescripController,
      "relacionpadre": _padret,
      "descripcionpadre": _padescripController,
      "relacionmadre": _madret,
      "descripcionmadre": _madescripController ,
      "relacioncuidador": _cuidt,
      "descripcionrelacion":_cuidescipController,
      "historialescolaryconvivencial" : hisescolarController,
      "tiempolibre" :_tiempoController,
      "practicadeportes":_deporController,
      "tipodeamistades":_tipoamisController,
      "bar":_barrio,
      "colegio":_colegio,
      "mayores" : _mayores,
      "menores" : _menores,
      "mismaedad":_misma,
      "relacionconlosdemas": _rdemasController,
      "relacionenelcolegio":_rcolController,
      "estadoeconomico": _estadoController,
      "observadorExcelente" :_observadorExcelenteController,
      "observadorBuenas" : _observadorBuenasController,
      "observadorBasicas" :_observadorBasicasController, 
      "observadorInsuficientes" : _observadorInsuficientesController,
      "fechasalud" : _fechController,
      "enfermedadesy/otrastorno": _enfermedadController,
      "tratamientos": _tratamientoController,
      "exmanesy/opruebas": _examenesController,
      "valoracion": _valoracionController,
      "fechasalud2" : _fechController2,
      "enfermedadesy/otrastorno2": _enfermedadController2,
      "tratamientos2": _tratamientoController2,
      "exmanesy/opruebas2": _examenesController2,
      "valoracion2": _valoracionController2,
      "fechasalud3" : _fechController3,
      "enfermedadesy/otrastorno3": _enfermedadController3,
      "tratamientos3": _tratamientoController3,
      "exmanesy/opruebas3": _examenesController3,
      "valoracion3": _valoracionController3,
      "leve1": _prom1leveController,
      "mode1": _prom1moderadoController,
      "severo1" : _prom1severoController,
      "leve2": _prom2leveController,
      "mode2": _prom2moderadoController,
      "severo2" : _prom2severoController,
      "leve3": _prom3leveController,
      "mode3": _prom3moderadoController,
      "severo3" : _prom3severoController,
      "leve4": _prom4leveController,
      "mode4": _prom4moderadoController,
      "severo4" : _prom4severoController,
      "leve5": _prom5leveController,
      "mode5": _prom5moderadoController,
      "severo5" : _prom5severoController,
      "leve6": _prom6leveController,
      "mode6": _prom6moderadoController,
      "severo6" : _prom6severoController,
      "leve7": _prom7leveController,
      "mode7": _prom7moderadoController,
      "severo7" : _prom7severoController,
      "leve8": _prom8leveController,
      "mode8": _prom8moderadoController,
      "severo8" : _prom8severoController,
      "leve9": _prom9leveController,
      "mode9": _prom9moderadoController,
      "severo9" : _prom9severoController,
      "resultados": _resulController,
      "fregis" : _recoController,
      "interven" : _interController,
      "suge" : _selectedDate,

    };

    try {
      await FirebaseFirestore.instance
          .collection('historiales-clinicos')
          .doc(_studentId)
          .collection("historial")
          .add(data);
    } catch (e) {
      throw Exception("Error al enviar los datos: $e");
    }
  }
}
