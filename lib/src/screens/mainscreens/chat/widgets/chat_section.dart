import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:phsycho/src/imports.dart';
import '../../other/historial/historial.dart';
import '../services/chat_service.dart';
import 'message_builder.dart';

class ChatPage extends StatefulWidget {
  final String receilverid;
  final String name;
  final String course;
  final String grade;
  final Map<String, dynamic> userData;

  const ChatPage(
      {super.key,
      required this.receilverid,
      required this.name,
      required this.course,
      required this.grade,
      required this.userData});

  @override
  State<ChatPage> createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  final TextEditingController _messagecontroller = TextEditingController();
  final ChatService _chatService = ChatService();
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

  static List<Map<String, dynamic>> localMessages =
      []; // Lista local para mensajes

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollDown();
    });

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        Future.delayed(const Duration(milliseconds: 300), () => scrollDown());
      }
    });
  }

  void scrollDown() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.fastEaseInToSlowEaseOut,
      );
    }
  }

  void sendMessage() async {
    if (_messagecontroller.text.isNotEmpty) {
      String mensajeLocal = _messagecontroller.text;
      _messagecontroller.clear();
      await _chatService.sendMessage(
          mensajeLocal, widget.receilverid, SignInState.infoUser["name"]);
      scrollDown();
    }
  }

 @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: PreferredSize(
      preferredSize: const Size.fromHeight(56),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.transparent,
          border: Border(
            bottom: BorderSide(
              color: Color.fromARGB(255, 235, 235, 235),
              width: 1,
            ),
          ),
        ),
        child: AppBar(
          foregroundColor: Colors.black,
          forceMaterialTransparency: true,
          elevation: 0,
          titleTextStyle: const TextStyle(color: Colors.black),
          title: Row(
            children: [
              
              Container(
         
                
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                         color: Colours.main2,
                  shape: BoxShape.circle
                ),
                child: Icon(Icons.person, color: Colors.white,)),
                SizedBox(width: 5,),
              Text(
                widget.name,
                
              ),
            ],
          ),
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          actions: [
            PopupMenuButton<String>(
              iconColor: Colors.black,
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'Ver historial clínico',
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => HistorialScreen(
                        idCita: "1",
                        studentName: widget.name,
                        studentId: widget.receilverid,
                        studentCourse: widget.course,
                        studentGrade: widget.grade,
                      ),
                    ));
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.preview,
                        size: 18,
                        color: Colours.contrastB,
                      ),
                      SizedBox(width: 8),
                      Text("Ver historial clínico"),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'Vaciar chat',
                  onTap: () {
                    // Lógica para vaciar el chat
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.person_remove,
                        size: 18,
                        color: Colours.contrastB,
                      ),
                      SizedBox(width: 8),
                      Text("Vaciar chat"),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'Ver perfil',
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ProfileScreen(info: widget.userData),
                    ));
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.person_search,
                        size: 18,
                        color: Colours.contrastB,
                      ),
                      SizedBox(width: 8),
                      Text("Ver perfil"),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
    body: Stack(
      children: [
        Container(
           color: Colours.whiteSmoke,
        ),
        // Imagen de fondo
        
        Center(
          child: Container(
            width: 250,
         
            decoration: const BoxDecoration(
             
              image: DecorationImage(
                
                image: AssetImage('/images/fondo_chat.webp'), // Cambia esta ruta por la de tu imagen
                fit: BoxFit.contain,
                
              ),
            ),
          ),
        ),
        // Contenido encima de la imagen de fondo
        Column(
          children: [
            Expanded(
              child: _buildMessageList(),
            ),
            _buildUserInput(),
          ],
        ),
      ],
    ),
  );
}


  Widget _buildMessageList() {
    String senderId = SignInState.infoUser["id"];
    return StreamBuilder(
      stream: _chatService.getMessages(senderId, widget.receilverid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Error al cargar los mensajes");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Cargando...");
        }

        // Actualizar la lista local de mensajes
        localMessages = snapshot.data!.docs.map((doc) {
          return doc.data() as Map<String, dynamic>;
        }).toList();

        WidgetsBinding.instance.addPostFrameCallback((_) {
          scrollDown();
        });

        // Usar la lista local para mostrar los mensajes
        return ListView.builder(
          controller: _scrollController,
          itemCount: localMessages.length,
          itemBuilder: (context, index) {
            return _buildMessageItemFromLocal(index);
          },
        );
      },
    );
  }

  // Nuevo método para construir un mensaje desde la lista local
  Widget _buildMessageItemFromLocal(int index) {
    String senderId = SignInState.infoUser["id"];
    Map<String, dynamic> data = localMessages[index];

    bool isCurrentUser = data["senderID"] == senderId;
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;
    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment:
            isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          ChatBurble(
            id: data["messageID"],
            message: data["messageText"],
            isCurrentUser: isCurrentUser,
            startTime: data["timestamp"].toDate(),
            messageID: "local_$index", // Identificador temporal local
            isRead: data["isRead"],
            receiverId: data["receilverid"],
            senderId: data["senderID"],
          ),
        ],
      ),
    );
  }

  Widget _buildUserInput() {
    return Container(
    
      
      decoration: BoxDecoration(
          color: Colors.white,
        border: Border(
          top: BorderSide( color: const Color.fromARGB(255, 221, 221, 221)
                        .withOpacity(0.4),
                    width: 1,)
        )
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 0.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                focusNode: _focusNode,
                controller: _messagecontroller,
                onSubmitted: (value) {
                  if (value.trim().isNotEmpty) {
                    sendMessage();
                    _messagecontroller
                        .clear(); // Limpia el campo después de enviar
                    _focusNode.requestFocus(); // Mantiene el teclado abierto
                  }
                },
                decoration: InputDecoration(
                  
                  hintText: 'Digita un mensaje...',
                  filled: true,
                  fillColor: Colors.white,
                  // Cambia a fondo blanco
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                    borderSide: BorderSide.none
                     
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 12.0), // Mejora el padding
                  hintStyle: const TextStyle(color: Colors.grey), // Color del hint
                ),
                style: const TextStyle(color: Colors.black), // Color del texto
              ),
            ),
            const SizedBox(width: 8.0),
             // Espacio entre el TextField y el botón
            Container(
              
              decoration:  BoxDecoration(
                
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                
                color: Colours.whiteSmoke,
                onPressed: () {
                  if (_messagecontroller.text.trim().isNotEmpty) {
                    sendMessage();
                    _messagecontroller
                        .clear(); // Limpia el campo después de enviar
                    _focusNode.requestFocus(); // Mantiene el teclado abierto
                  }
                },
                icon: const Icon(Icons.send_rounded,  color: Colors.black,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
