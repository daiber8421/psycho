import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:phsycho/src/screens/mainscreens/other/historial/historial.dart';

import '../../../imports.dart';

class ManageScreen extends StatefulWidget {
  const ManageScreen({super.key});

  @override
  State<ManageScreen> createState() => _ManageScreenState();
}

class _ManageScreenState extends State<ManageScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  // Variables para almacenar los valores seleccionados en los filtros
  String _selectedGrade = 'Todos';
  String _selectedCourse = 'Todos';
  
  // Controladores de texto para los filtros
  final List<String> _grades = [ '7', '8', '9', '10', '11'];
  final List<String> _course = [ '1', '2', '3','4'];

  // Muestra un formulario para crear o actualizar un documento
  void _showForm({DocumentSnapshot? document}) {
    final bool exist = document != null; // Verifica si estamos editando un documento existente

    final TextEditingController nameController = TextEditingController(text: exist ? document['name'] : '');
    final TextEditingController idController = TextEditingController(text: exist ? document['id'] : '');
    final TextEditingController courseController = TextEditingController(text: exist ? document['course'] : '');
    final TextEditingController ageController = TextEditingController(text: exist ? document['age'] : '');
    final TextEditingController codigoInstitucionalController = TextEditingController(text: exist ? document['codigoInstitucional'] : '');
    final TextEditingController genderController = TextEditingController(text: exist ? document['gender'] : '');
    final TextEditingController gradeController = TextEditingController(text: exist ? document['grade'] : '');
    final TextEditingController passwordController = TextEditingController(text: exist ? document['password'] : '');
    final TextEditingController roleController = TextEditingController(text: exist ? document['role'] : '');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(exist ? 'Editar Documento' : 'Agregar Documento'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: idController,
                  decoration: const InputDecoration(labelText: 'ID'),
                ),
                TextField(
                  controller: courseController,
                  decoration: const InputDecoration(labelText: 'Course'),
                ),
                TextField(
                  controller: ageController,
                  decoration: const InputDecoration(labelText: 'Age'),
                ),
                TextField(
                  controller: codigoInstitucionalController,
                  decoration: const InputDecoration(labelText: 'Código Institucional'),
                ),
                TextField(
                  controller: genderController,
                  decoration: const InputDecoration(labelText: 'Gender'),
                ),
                TextField(
                  controller: gradeController,
                  decoration: const InputDecoration(labelText: 'Grade'),
                ),
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                TextField(
                  controller: roleController,
                  decoration: const InputDecoration(labelText: 'Role'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (nameController.text.isNotEmpty && idController.text.isNotEmpty && courseController.text.isNotEmpty) {
                  if (exist) {
                    _updateDocument(
                      document.id,
                      nameController.text,
                      idController.text,
                      courseController.text,
                      ageController.text,
                      codigoInstitucionalController.text,
                      genderController.text,
                      gradeController.text,
                      passwordController.text,
                      roleController.text,
                    );
                  } else {
                    _addDocument(
                      nameController.text,
                      idController.text,
                      courseController.text,
                      ageController.text,
                      codigoInstitucionalController.text,
                      genderController.text,
                      gradeController.text,
                      passwordController.text,
                      roleController.text,
                    );
                  }
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Porfavor llena todos los campos')),
                  );
                }
              },
              child: Text(exist ? 'Actualizar' : 'Agregar'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _addDocument(
    String name,
    String id,
    String course,
    String age,
    String codigoInstitucional,
    String gender,
    String grade,
    String password,
    String role,
  ) async {
    await _firestore.collection('Usuarios-E').add({
      'role': role,
      'password': password,
      'name': name,
      'id': id,
      'grade': grade,
      'gender': gender,
      'course': course,
      'codigoInstitucional': codigoInstitucional,
      'age': age,
    });
  }

  Future<void> _updateDocument(
    String docId,
    String name,
    String id,
    String course,
    String age,
    String codigoInstitucional,
    String gender,
    String grade,
    String password,
    String role,
  ) async {
    await _firestore.collection('Usuarios-E').doc(docId).update({
      'role': role,
      'password': password,
      'name': name,
      'id': id,
      'grade': grade,
      'gender': gender,
      'course': course,
      'codigoInstitucional': codigoInstitucional,
      'age': age,
    });
  }

  Future<void> _deleteDocument(String docId) async {
    await _firestore.collection('Usuarios-E').doc(docId).delete();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
        ),
        onPressed: () => _showForm(),
      ),
      body: Base(
        background: true,
        width: width,
        children: [
          // Filtros de grado y curso
          Padding(
            padding: const EdgeInsets.only( bottom: 15),
            child: Text(width > BreakPoint.laptop ? "Listado de estudiantes" : "Estudiantes", style: AddTextStyle.headContainerBase),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: 
                  CustomBuilderDropDownButton(
                    isExpanded: true,
                    text: "Grado",
                    hint: "Selecciona el grado",
                    selected: _selectedGrade,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedGrade = newValue!;
                      });
                    }, 
                    items: grades.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),                 
                  ),
                ),
                AddBoxStyle.normalBox,
                Expanded(
                  child: CustomBuilderDropDownButton(
                    isExpanded: true,
                    text: "Curso",
                    hint: "Selecciona el curso",
                    selected: _selectedCourse,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedCourse = newValue!;
                      });
                    }, 
                    items: course.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),                 
                  ),
                ),
              ],
            ),
          ),
          StreamBuilder(
            // Configura un StreamBuilder para escuchar los cambios en la colección 'Usuarios-E'
            stream: _firestore.collection('Usuarios-E')
              // Aplica filtros condicionales en función de los valores seleccionados para grado y curso
              .where(_selectedGrade != 'Todos' ? 'grade' : FieldPath.documentId, 
                    isEqualTo: _selectedGrade != 'Todos' ? _selectedGrade : null)
              .where(_selectedCourse != 'Todos' ? 'course' : FieldPath.documentId, 
                    isEqualTo: _selectedCourse != 'Todos' ? _selectedCourse : null)
              .snapshots(),
            builder: (context, snapshot) {
              // Muestra un indicador de carga mientras se espera que el stream proporcione datos
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              // Muestra un mensaje de error si ocurre un problema al obtener los datos
              else if (snapshot.hasError) {
                return Center(child: Text("${snapshot.error}"));
              }
              // Muestra un mensaje si no hay datos disponibles o si la consulta no devuelve documentos
              else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(child: Text('No se ha encontrado'));
              }else {
                return ListView(
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  reverse: false,
                  shrinkWrap: true,
                  children: snapshot.data!.docs.map((doc) {
                    final data = doc.data();
                    return StudentListtileBuilder(
                      infoU: data, 
                      buttons: [
                        IconButton(
                          icon: const Icon(
                            Icons.person_search,
                            
                          ),
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HistorialScreen(idCita: "1",studentName: data["name"], studentId: data["id"], studentCourse: data["course"], studentGrade: data["grade"], initial: "1",)),
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _showForm(document: doc),
                        ),
                        // Botón para eliminar el documento
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDiag(title: "Eliminar", function: () => _deleteDocument(doc.id),);
                              }
                            )
                          },
                        ),
                      ],
                    );
                  }).toList(),
                );
              }
            },
          ),
        ],
     ),
);
}
}
