import '../imports.dart';

class Button extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const Button({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton( 
      
      onPressed: onPressed,
      child: Text(
        text, style: const TextStyle(fontSize: 17),
      ), 
    );
  }
}

