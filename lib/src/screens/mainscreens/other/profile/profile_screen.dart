import '../../../../imports.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.info});

  final Map<String, dynamic> info;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: Center(
        child: Text('Perfil de ${widget.info["name"]}'),
      ),
    );
  }
}