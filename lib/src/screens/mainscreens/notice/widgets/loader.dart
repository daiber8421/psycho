import 'package:cloud_firestore/cloud_firestore.dart';

import "../../../../imports.dart";
import 'package:intl/intl.dart';
import 'form_screen.dart';
import 'card.dart';

//Carga de los anuncios en la db por medio de un <StreamBuilder>
class NoticeLoaderBuilder extends StatelessWidget {
  final Map<String, dynamic> infoUser = SignInState.infoUser; 
  NoticeLoaderBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Notice')
          .orderBy('time', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text(
              'No hay Anuncios disponibles',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          );
        }
        return ListView(
          scrollDirection: Axis.vertical,
          reverse: false,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: snapshot.data!.docs.map((doc) {
            var data = doc.data();
            Timestamp timestamp = data['time'] as Timestamp? ?? Timestamp.now();
            DateTime dateTime = timestamp.toDate();
            String formattedDate = DateFormat('dd-MM-yy hh:mm a').format(dateTime);
            return NoticeBuilder(
              title: data['title'] ?? 'Sin título',
              reason: data['reason'] ?? 'Sin motivo',
              content: data['content'] ?? 'Sin contenido',
              formattedDate: formattedDate,
              name: data['name'] ?? 'No registra',
              url: data['url'] ?? '',
              idU: infoUser["documentID"] ?? 'ID por defecto',
              idA: data['id'] ?? 'ID no disponible',
            );
          }).toList(),
        );
      },
    );
  }
}
