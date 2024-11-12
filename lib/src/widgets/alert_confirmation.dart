import '../imports.dart';

class AlertDiag extends StatelessWidget {
  final dynamic function; 
  final String title ;
  const AlertDiag({super.key, required this.function, required this.title});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text('¿Desea $title? '),
      actions: [
        TextButton(
          onPressed: () {
            function();
            Navigator.pop(context);
          },
          child: const Text('Aceptar'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancelar'),
        ),
      ],
    );
  }
}