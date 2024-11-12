import '../../imports.dart';

class Await extends StatefulWidget {
  static const String routename = "await";

  const Await({super.key}); 

  @override
  AwaitState createState() => AwaitState();
}

class AwaitState extends State<Await> {
  Random random = Random();
  String gifAsset = '';

  @override
  void initState() {
    super.initState();

    // Elige un GIF aleatorio al inicio
    _chooseRandomGif();

    // Llama a la función para cargar la siguiente pantalla en segundo plano
    _loadNextScreen();
  }

  void _chooseRandomGif() {
    // Genera un número aleatorio entre 0 y 1
    int randomNumber = random.nextInt(2);

    // Elige el GIF basado en el número aleatorio
    setState(() {
      gifAsset = randomNumber == 0 ? '/images/await1.gif' : '/images/await2.gif'; 
    });
  }

  Future<void> _loadNextScreen() async {
    await Future.delayed(const Duration(seconds: 4)); // Espera 4 segundos

    // Verifica si el widget aún está montado antes de navegar
    if (mounted) {

      MainpageScreenState.currentIndex = 0;
      Navigator.pushReplacementNamed(
        context,
        Mainpage.routename, // Usa el routeName para la siguiente pantalla
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, 
      body: Center(
        child: SizedBox(
          width: 150,
          height: 150,
          child: gifAsset.isNotEmpty
              ? Image.asset(gifAsset) // Muestra el GIF elegido si existe
              : const SizedBox.shrink(), // Muestra un SizedBox vacío mientras se carga el GIF
        ),
      ),
    );
  }
}
