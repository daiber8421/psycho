import 'package:phsycho/src/screens/mainscreens/chat/services/chat_service.dart';
import 'package:phsycho/src/screens/mainscreens/chat/widgets/chat_section.dart';
import 'package:phsycho/src/screens/mainscreens/chat/widgets/message_builder.dart';
import 'package:phsycho/src/themes/themes.dart';
import '../../../../imports.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:intl/intl.dart'; // For formatting timestamp

class UsertileBuilder extends StatefulWidget {
  final void Function()? onTap;
  final Color? selectedTileColor;
  final Map<String, dynamic> infoU;

  const UsertileBuilder({
    super.key, 
    required this.onTap, 
    this.selectedTileColor, 
    required this.infoU,
  });

  @override
  State<UsertileBuilder> createState() => _UsertileState();
}

class _UsertileState extends State<UsertileBuilder> {
  
  final ChatService _chatService = ChatService();
  String _lastMessage = ''; // Local variable to store the last message
  String _lastMessageTime = ''; // Local variable for message time
  bool _isMyMessage = false;
   bool _isread = false; // Track if the message is from the current user

  @override
  void initState() {
    super.initState();
    // Fetch the last message from the stream and store it in the local variables
    _chatService.streamLastMessage(widget.infoU["id"]).listen((messageData) {
      if (messageData != null && messageData['messageText'] != null ) {
        setState(() {
          _lastMessage = messageData['messageText']; // Update message text
          _isMyMessage = messageData['senderID'] == SignInState.infoUser['id']; // Check if message is from the user
          _lastMessageTime = formatearTimestamp(messageData['timestamp']);
          _isread = messageData["isRead"]; // Format and store the timestamp
         
          
          
        });
      }
    });
  }

 String formatearTimestamp(Timestamp timestamp) {
  final DateTime now = DateTime.now();
  final DateTime messageDate = timestamp.toDate();

  final Duration difference = now.difference(messageDate);

  if (difference.inDays == 0) {
   
    return DateFormat('hh:mm a').format(messageDate);
  } else if (difference.inDays == 1) {
    return 'Ayer';
  } else if (difference.inDays == 2) {

    return 'Hace dos dias';
  } else if (difference.inDays > 2 && difference.inDays < 7) {
    return DateFormat('EEEE').format(messageDate);
  } else {

    return DateFormat('MMM dd, yyyy').format(messageDate);
  }
}


  @override
  @override
Widget build(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: widget.selectedTileColor,
    ),
    child: ListTile(
      leading: const CircleAvatar(
        backgroundColor: Colours.greyv,
        child: Icon(Icons.person),
      ),
      title: Text(
        widget.infoU['name'],
        overflow: TextOverflow.ellipsis, 
        maxLines: 1, 
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              if (_lastMessage != "")
                Expanded(
                  child: Row(
                    children: [
                      if (_isMyMessage)
                        Icon(
                          Icons.done_all,
                          color: _isread ? Colors.blue : const Color.fromARGB(255, 8, 8, 8),
                          size: 14,
                        ),
                      const SizedBox(width: 4),
                      Expanded( 
                        child: Text(
                          _lastMessage,
                          overflow: TextOverflow.ellipsis, 
                          maxLines: 1, 
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),

          Align(
            alignment: Alignment.topRight, 
            child: Text(
              _lastMessageTime,
              overflow: TextOverflow.ellipsis, 
              maxLines: 1, 
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
      onTap: widget.onTap,
    ),
  );
}
}