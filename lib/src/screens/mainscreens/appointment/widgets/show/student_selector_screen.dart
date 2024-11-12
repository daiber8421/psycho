import "package:cloud_firestore/cloud_firestore.dart";

import "../../../../../imports.dart";

class StudentSelectorScreen extends StatefulWidget {
  const StudentSelectorScreen({super.key, required this.controller});

  final TextEditingController controller;

  @override
  State<StudentSelectorScreen> createState() => StudentSelectorScreenState();
}

class StudentSelectorScreenState extends State<StudentSelectorScreen> {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String selectedGrade = 'Todos';
  String selectedCourse = 'Todos';
  static  late Map<String,dynamic> datap;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Seleccionar estudiante"),
        flexibleSpace: Container(
          decoration: AddContainerStyle.appBarGradient,
        ),
      ),
      body: Base(
        background: true,
        width: width,
        children: [
          Padding(
            padding: const EdgeInsets.only( bottom: 15),
            child: Text(width > BreakPoint.laptop ? "Selección de estudiante" : "Estudiante", style: AddTextStyle.headContainerBase),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: CustomBuilderDropDownButton(
                    isExpanded: true,
                    text: "Grado",
                    hint: "Selecciona el grado",
                    selected: selectedGrade,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedGrade = newValue!;
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
                    selected: selectedCourse,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCourse = newValue!;
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
              .where(selectedGrade != 'Todos' ? 'grade' : FieldPath.documentId, 
                    isEqualTo: selectedGrade != 'Todos' ? selectedGrade : null)
              .where(selectedCourse != 'Todos' ? 'course' : FieldPath.documentId, 
                    isEqualTo: selectedCourse != 'Todos' ? selectedCourse : null)
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
                return Center(child: Text('No se han encontrado datos', style: AddTextStyle.contentBold,));
              }
              // Muestra los datos obtenidos en una lista con divisores entre los elementos
              else {
                return ListView(
                  scrollDirection: Axis.vertical,
                  reverse: false,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: snapshot.data!.docs.map((doc) {
                    // Convierte cada documento en un mapa de datos
                    final data = doc.data();
                    return StudentListtileBuilder(
                      onTap: (){
                        widget.controller.text = data['name']; // Actualiza el TextField
                        datap = data;
                        Navigator.of(context).pop();
                      },
                      infoU: data, 
                      buttons: [
                        IconButton(
                          icon: const Icon(
                            Icons.person_search,
                          ),
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ProfileScreen(info: data)),
                            );
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