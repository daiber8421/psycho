import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:phsycho/main.dart';
import 'package:phsycho/src/data/vars.dart';
import 'package:phsycho/src/imports.dart';
import 'package:phsycho/src/screens/mainscreens/chat/services/chat_service.dart';
import 'package:phsycho/src/screens/mainscreens/chat/widgets/usertitle_builder.dart';
import 'package:phsycho/src/screens/signin/signin.dart';
import 'package:phsycho/src/widgets/dropdown_button_builder.dart';

import 'widgets/chat_section.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatService _chatService = ChatService();
  final userData = SignInState.infoUser;
  String? selectedCurso;
  String? selectedGrado;
  Map<String, dynamic>? selectedUser;
  final ValueNotifier<Map<String, dynamic>?> _selectedUserNotifier =
      ValueNotifier(null);

  bool? state = true;

  @override
  void initState() {
    super.initState();

    
    // Llama al método para verificar el estado de la cita
  }



  Widget build(BuildContext context) {
    // Usar FutureBuilder para esperar el resultado de la verificación del estado
    return FutureBuilder(
        future:
            getState(userData), // Llama al método que verifica el estado
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Mientras espera, muestra un indicador de carga
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Manejo de errores
            return const Center(
                child: Text("Error al cargar el estado de la cita."));
          } else {
            // Una vez que el estado está definido, muestra el contenido
            return LayoutBuilder(
              builder: (context, constraints) {
                if (MediaQuery.of(context).size.width > 1300) {
                  return Row(
                    children: [
                      if (SignInState.infoUser["role"] == "1")
                        if (!state!)
                          Expanded(
                            child: Container(
                              alignment: Alignment.bottomRight,
                              color: const Color.fromARGB(255, 255, 255, 255),
                              child: Container(
                                margin: const EdgeInsets.all(20),
                                color: Colors.transparent,
                                width: 500,
                                height: 500,
                                alignment: Alignment.bottomRight,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    padding: WidgetStateProperty.all(
                                      const EdgeInsets.all(30),
                                    ),
                                    shape: WidgetStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      mainPageKey.currentState?.setPageIndex(1);
                                    });
                                  },
                                  child: const Icon(
                                    Icons.chat,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    size: 36,
                                  ),
                                ),
                              ),
                            ),
                          )
                        else
                          Expanded(
                            flex: 2,
                            child: Scaffold(
                              backgroundColor: Colors.white,
                              appBar: AppBar(
                                  automaticallyImplyLeading: false,
                                  title: const Text(
                                    "Chats",
                                    style: TextStyle(color: Colours.blackv),
                                  ),
                                  backgroundColor:
                                      const Color.fromARGB(255, 255, 255, 255)),
                              body: Container(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Expanded(child: _buildUserList()),
                                  ],
                                ),
                              ),
                            ),
                          ),
                      if (SignInState.infoUser["role"] == "0")
                        Expanded(
                          flex: 2,
                          child: Scaffold(
                            backgroundColor: Colors.white,
                            appBar: PreferredSize(
                                preferredSize: const Size.fromHeight(56),
                                child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      border: Border(
                                        right: BorderSide(
                                          color: Color.fromARGB(
                                              255, 235, 235, 235),
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                    child: AppBar(
                                        automaticallyImplyLeading: false,
                                        title: const Text(
                                          "Chats    ",
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 63, 62, 62)),
                                        ),
                                        backgroundColor: const Color.fromARGB(
                                            255, 255, 255, 255)))),
                            body: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: const BoxDecoration(
                                  border: Border(
                                right: BorderSide(
                                  color: Color.fromARGB(255, 235, 235, 235),
                                  width: 1,
                                ),
                              )),
                              child: Column(
                                children: [
                                  _filtro(),
                                  Expanded(child: _buildUserList()),
                                ],
                              ),
                            ),
                          ),
                        ),
                      if (state! || SignInState.infoUser["role"] == "0")
                        Expanded(
                          flex: 6,
                          child: ValueListenableBuilder<Map<String, dynamic>?>(
                            valueListenable: _selectedUserNotifier,
                            builder: (context, selectedUser, _) {
                              return selectedUser != null
                                  ? ChatPage(
                                      receilverid: selectedUser["id"],
                                      name: selectedUser["name"],
                                      course: selectedUser["course"],
                                      grade: selectedUser["grade"],
                                      userData:
                                          selectedUser, // Parámetro añadido
                                    )
                                  : const Center(
                                      child: Text(
                                          "Selecciona un usuario para chatear"));
                            },
                          ),
                        ),
                    ],
                  );
                } else {
                  return SignInState.infoUser["role"] == "0"
                      ? Scaffold(
                          backgroundColor: Colors.white,
                          appBar: AppBar(
                            backgroundColor: Colors.white,
                            title: const Text("Chats Celular"),
                            titleTextStyle:
                                const TextStyle(color: Colors.black),
                          ),
                          body: Column(
                            children: [
                              const Divider(),
                              _filtro(),
                              Expanded(child: _buildUserList()),
                            ],
                          ),
                        )
                      : !state!
                          ? Scaffold(
                              body: Container(
                                alignment: Alignment.bottomRight,
                                color: const Color.fromARGB(255, 255, 255, 255),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    padding: WidgetStateProperty.all(
                                      const EdgeInsets.all(30),
                                    ),
                                    shape: WidgetStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      state = true;
                                    });
                                  },
                                  child: const Icon(
                                    Icons.chat,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    size: 36,
                                  ),
                                ),
                              ),
                            )
                          : Scaffold(
                              appBar: AppBar(
                                automaticallyImplyLeading: true,
                                title: const Text("Chats"),
                                backgroundColor:
                                    const Color.fromARGB(255, 255, 255, 255),
                              ),
                              body: Column(
                                children: [
                                  const Divider(
                                      color: Colors.grey, thickness: 1),
                                  Expanded(
                                    child: _buildUserList(),
                                  ),
                                ],
                              ),
                            );
                }
              },
            );
          }
        });
  }

  // Filtros
  Widget _filtro() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(right: 6.0),
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.grey.shade300, width: 1.2),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 255, 255, 255)
                        .withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: selectedGrado,
                  hint: Text(
                    "Grado",
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                  ),
                  icon:
                      Icon(Icons.arrow_drop_down, color: Colors.grey.shade500),
                  onChanged: (value) {
                    setState(() {
                      selectedGrado = value;
                    });
                  },
                  items: List.generate(6, (index) => (index + 6).toString())
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 6.0),
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.grey.shade300, width: 1.2),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 252, 252, 252)
                        .withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: selectedCurso,
                  hint: Text(
                    "Curso",
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                  ),
                  icon:
                      Icon(Icons.arrow_drop_down, color: Colors.grey.shade500),
                  onChanged: (value) {
                    setState(() {
                      selectedCurso = value;
                    });
                  },
                  items: List.generate(8, (index) => (index + 1).toString())
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Lista de usuarios filtrada
  Widget _buildUserList() {
    if (SignInState.infoUser["role"] == "0") {
      return StreamBuilder<List<Map<String, dynamic>>>(
        stream: _chatService.getUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Error al cargar los usuarios.");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Filtro
          var filteredUsers = snapshot.data!.where((user) {
            final matchesCurso =
                selectedCurso == null || user['course'] == selectedCurso;
            final matchesGrado =
                selectedGrado == null || user['grade'] == selectedGrado;
            final isNotCurrentUser = user['id'] != _chatService.getDate("id");
            return matchesCurso && matchesGrado && isNotCurrentUser;
          }).toList();

          return ListView(
            children: filteredUsers
                .map<Widget>((userData) => _buildUserListItem(userData))
                .toList(),
          );
        },
      );
    } else {
      Stream<List<Map<String, dynamic>>> fil =
          _chatService.obtenerpsicologa(SignInState.infoUser["jornada"]);

      return StreamBuilder<List<Map<String, dynamic>>>(
        stream: fil, // Pasamos el Stream al StreamBuilder
        builder: (context, snapshot) {
          // Mientras el Stream está esperando datos, mostramos un indicador de carga
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // Si ocurre un error, mostramos un mensaje de error
          else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          // Si no hay datos o está vacío, mostramos un mensaje de que no hay datos
          else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay datos disponibles'));
          }
          // Si los datos están disponibles, construimos el ListView
          else {
            List<Map<String, dynamic>> fill = snapshot.data!;

            return ListView(
              children: fill
                  .map<Widget>((entry) => _buildUserListItem(entry))
                  .toList(),
            );
          }
        },
      );

      // Definimos el Future
    }
  }

  // Ítem por usuario
  Widget _buildUserListItem(Map<String, dynamic> userData) {
    // Define un ValueNotifier para controlar el color de fondo de cada elemento
    ValueNotifier<Color> backgroundColorNotifier =
        ValueNotifier<Color>(Colors.white);

    return ValueListenableBuilder<Map<String, dynamic>?>(
      valueListenable: _selectedUserNotifier,
      builder: (context, selectedUser, _) {
        // Determina si este elemento es el seleccionado
        bool isSelected = selectedUser?['id'] == userData['id'];

        // Actualiza el color de fondo según si el elemento es el seleccionado
        backgroundColorNotifier.value = isSelected
            ? const Color.fromRGBO(129, 131, 133, .5).withOpacity(0.2)
            : Colors.white;

        return MouseRegion(
          onEnter: (_) {
            // Cambia el color cuando el mouse entra en el área, si no está seleccionado
            if (!isSelected) {
              backgroundColorNotifier.value =
                  const Color.fromARGB(255, 202, 202, 202).withOpacity(0.1);
            }
          },
          onExit: (_) {
            // Restaura el color cuando el mouse sale del área
            backgroundColorNotifier.value = isSelected
                ? const Color.fromRGBO(129, 131, 133, .5).withOpacity(0.2)
                : Colors.white;
          },
          child: ValueListenableBuilder<Color>(
            valueListenable: backgroundColorNotifier,
            builder: (context, bgColor, _) {
              return Column(
                children: [
                  const SizedBox(height: 5),
                  UsertileBuilder(
                    selectedTileColor: bgColor,
                    infoU: userData,
                    onTap: () {
                      // Al hacer clic, cambia el usuario seleccionado y actualiza todos los colores
                      if (MediaQuery.of(context).size.width > 1300) {
                        _selectedUserNotifier.value = userData;
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatPage(
                              receilverid: userData["id"],
                              name: userData["name"],
                              course: userData["course"],
                              grade: userData["grade"],
                              userData: userData,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}

Future<bool> getState(var userData) async {
  var querySnapshotC = await FirebaseFirestore.instance
      .collection("Appointments")
      .doc("sede principal")
      .collection("Appoinments-Jornada ${userData["jornada"]}")
      .doc("Psicologa ${userData["jornada"] == "matinal" ? "3" : "2"}")
      .collection("Appointments")
      .where("studentid", isEqualTo: userData["id"])
      .limit(1)
      .get();
  var querySnapshotS = await FirebaseFirestore.instance
      .collection("Solicitudes")
      .doc("sede principal")
      .collection("Appoinments-Jornada ${userData["jornada"]}")
      .doc("Psicologa ${userData["jornada"] == "matinal" ? "3" : "2"}")
      .collection("Appointments")
      .where("studentid", isEqualTo: userData["id"])
      .limit(1)
      .get();

  // Verifica si hay documentos en el QuerySnapshot
  if (querySnapshotC.docs.isNotEmpty || querySnapshotS.docs.isNotEmpty) {
    // Si se encontró un documento, puedes acceder a sus datos

    // Aquí puedes agregar lógica adicional si es necesario
    return true; // Hay una cita
  } else {
    print("nodata");
    return false; // No hay citas para este estudiante
  }
}
