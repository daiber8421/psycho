import '../../../imports.dart';
import 'package:intl/intl.dart';
import 'widgets/form_screen.dart';
import 'widgets/card.dart';
import 'widgets/loader.dart';

//Pantalla principal de los anuncios
class NoticeScreen extends StatefulWidget {
  const NoticeScreen({super.key});

  @override
  State<NoticeScreen> createState() => _NoticeScreenState();
}

class _NoticeScreenState extends State<NoticeScreen> {

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Base(
        background: false,
        width: width,
        children: [
          if(SignInState.infoUser["role"] == "0")
            FractionallySizedBox(
              widthFactor: 0.85,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10, 
                ),
                child: OpenContainer(
                  transitionDuration: const Duration(milliseconds: 500),
                  closedBuilder: (ctx, action) => ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colours.secondary,
                      child: Text(
                        SignInState.infoUser["name"].isNotEmpty ?  SignInState.infoUser["name"][0] : 'U',
                      ),
                    ),
                    subtitle: Text("¡Publícalo!", style: AddTextStyle.contentMedium),
                    title: Text('¿Tienes algo en mente?', style: AddTextStyle.contentBig.copyWith(
                      fontWeight: FontWeight.w600,
                    ),),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                  ),
                  openBuilder: (ctx, action) => const NoticeAddScreen(),
                ),
              ),
            ),
          AddBoxStyle.smallBox,
          Column(
            children: [
              AddBoxStyle.smallBox,
              NoticeLoaderBuilder(),
            ],
          ),   
        ],
      ),
    );
  }
}
