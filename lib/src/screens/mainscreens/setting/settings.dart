import 'package:phsycho/main.dart';
import 'package:phsycho/src/api/firebase_api.dart';
import 'package:provider/provider.dart';

import '../../../imports.dart';
import 'settings_card.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsScreen> {
  final Map<String, dynamic> infoUser = SignInState.infoUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            const CircleAvatar(
              radius: 40,
              backgroundColor: Colors.blue,
            ),
            const SizedBox(height: 20),
            const InfoCard(title: 'Nombre'),
            const SizedBox(height: 10),
            const InfoCard(title: 'Info'),
            const SizedBox(height: 10),
            const InfoCard(title: 'ID de Institución'),
            const SizedBox(height: 10),
            const InfoCard(title: 'Contraseña'),
            const SizedBox(height: 10),
            Button(
              onPressed: () async {
                // Limpiar el estado del usuario y navegar al SignIn sin afectar el estado del widget actual
 // Limpia los datos del usuario
                await eliminarToken(
                    "Token"); // Asegura que el token esté eliminado

                // Navega a la pantalla de SignIn
               Navigator.of(context).pushAndRemoveUntil(
  MaterialPageRoute(builder: (context) => const SignIn()),
  (route) => false,
);
              },
              text: 'Cerrar sesión',
            ),
          ],
        ),
      ),
    );
  }
}
