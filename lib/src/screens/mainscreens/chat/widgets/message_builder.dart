import 'package:intl/intl.dart';
import 'package:phsycho/src/imports.dart';
import 'package:phsycho/src/screens/mainscreens/chat/services/chat_service.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ChatBurble extends StatefulWidget {
  final String message;
  final bool isCurrentUser;
  final DateTime startTime;
  final String messageID;
  final bool isRead;
  final String receiverId;
  final String senderId;
  final String id;

  const ChatBurble({
    super.key,
    required this.id,
    required this.message,
    required this.isCurrentUser,
    required this.startTime,
    required this.isRead,
    required this.messageID,
    required this.receiverId,
    required this.senderId,
  });

  @override
  ChatBurbleState createState() => ChatBurbleState();
}

class ChatBurbleState extends State<ChatBurble> {
  ChatService chatService = ChatService();
  bool hasUpdatedReadStatus = false; // Para evitar actualizaciones redundantes
  late bool isRead; // Estado interno para el estado de "leído"

  @override
  void initState() {
    super.initState();
    isRead = widget.isRead; // Inicializar el estado interno con el valor inicial
  }

  @override
  void didUpdateWidget(covariant ChatBurble oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Actualiza el estado interno si cambian las propiedades del widget
    if (widget.isRead != oldWidget.isRead) {
      setState(() {
        isRead = widget.isRead;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedTime12h = DateFormat('h:mm a').format(widget.startTime);

    return VisibilityDetector(
      key: Key(widget.messageID),
      onVisibilityChanged: (visibilityInfo) async {
        if (!widget.isCurrentUser &&
            visibilityInfo.visibleFraction > 0.4 &&
            !isRead &&
            !hasUpdatedReadStatus) {
          hasUpdatedReadStatus = true; // Evitar múltiples llamadas

          bool updateSuccessful = await chatService.actualizarestado(
            widget.id,
            widget.receiverId,
            widget.senderId,
          );

          if (updateSuccessful && mounted) {
            setState(() {
              isRead = true;
            });
          }
        }
      },
      child: Container(
          margin:MediaQuery.of(context).size.width>1300 ? widget.isCurrentUser? const EdgeInsets.only(right: 200) : const EdgeInsets.only(left: 200):  widget.isCurrentUser? const EdgeInsets.only(right: 20) : const EdgeInsets.only(left: 20),
        child: Column(
          crossAxisAlignment:
              widget.isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
            
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
               
                minHeight: 40,
                maxHeight: 250,
              ),
              decoration: BoxDecoration(
                color: widget.isCurrentUser ? Colours.tertary : Colors.white,
                borderRadius: widget.isCurrentUser
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                        topRight: Radius.circular(30),
                      )
                    : const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 1),
                    blurRadius: 3,
                  ),
                ],
              ),
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 15, top: 10, bottom: 5, right: 5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: widget.isCurrentUser
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text(widget.message),
                    ),
                    if (widget.isCurrentUser)
                      Icon(
                        Icons.done_all,
                        color: isRead ? Colors.blue : Colors.black,
                        size: 14,
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              formattedTime12h,
              style: TextStyle(
                fontSize: 12,
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
