


import 'package:phsycho/src/imports.dart';

class AddInputStyle {
  AddInputStyle._();
  static InputDecoration decorationFormField(String labelText) {
  return InputDecoration(
    labelText: labelText,
    labelStyle: TextStyle(
      fontSize: 16,
      color: Color(0xFF0D47A1), // Color del texto del label
    ),
    hintText: 'Ingresa $labelText',
    hintStyle: TextStyle(
      color: Colours.whiteSmoke, // Color del hint
    ),
    filled: true,
    fillColor: const Color.fromARGB(255, 255, 255, 255), // Fondo claro para todos los campos
    contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: Color(0xFF0D47A1).withOpacity(0.4), // Borde cuando no está enfocado
        width: 1.5,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: Color(0xFF0D47A1), // Borde cuando está enfocado
        width: 2.0,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: Colors.redAccent, // Borde en caso de error
        width: 1.5,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: Colors.redAccent, // Borde cuando hay error y está enfocado
        width: 2.0,
      ),
    ),
  );
}



  static InputDecoration get inputForm => InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none, // Sin borde exterior
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none, // Sin borde exterior
      ),
      filled: true,
      hintStyle: TextStyle(
        color: Colours.blackv,
        fontWeight: FontWeight.normal, // Color del hint
      ),
      fillColor: Colours.contrastW,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
    );
}

class AddTextStyle{
  AddTextStyle._();

  static TextStyle get headContainerBase => AddTextStyle.titleBig.copyWith(
    color: Colours.blackv,
    fontSize: 30,
    
  );

  static TextStyle get signInTile => const TextStyle(
    shadows: <Shadow>[
      Shadow(
        offset: Offset(2, 6),
        blurRadius: 2,
        color: Color.fromARGB(77, 134, 134, 134),
      ),
      Shadow(
        color: Color.fromARGB(37, 131, 130, 130),
        offset: Offset(2, 12),
        blurRadius: 8,
      ),
    ],
    color: Colors.black,
    fontSize: 50,
    letterSpacing: -2.2,
    height: 1.2,
    decoration: TextDecoration.none,
    fontWeight: FontWeight.w700,
  );

  static TextStyle get labelForm => const TextStyle(
    //color: Color.fromARGB(255, 54, 54, 54),
    color: Colours.main,
    fontSize: 17,
    fontWeight: FontWeight.w500,
  );

  static TextStyle get appBartxt => const TextStyle(
    color: Colours.contrastW,
    fontSize: 21.0,
    fontWeight: FontWeight.w600, 
  );

  static TextStyle get titleBig => const TextStyle(
    fontSize: 26.0, // Tamaño grande para títulos
    fontWeight: FontWeight.w600,
    color: Colors.black, // Puedes cambiar el color
  );

  static TextStyle get titleMedium => const TextStyle(
    fontSize: 20.0, // Tamaño mediano para títulos
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  static TextStyle get titleSmall => const TextStyle(
    fontSize: 18.0, // Tamaño pequeño para títulos
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  static TextStyle get contentBig => const TextStyle(
    fontSize: 17.0, // Tamaño grande para contenido
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );

  static TextStyle get contentMedium => const TextStyle(
    fontSize: 15.0, // Tamaño mediano para contenido
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );

  static TextStyle get contentSmall => const TextStyle(
    fontSize: 13.0, // Tamaño pequeño para contenido
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );

  static TextStyle get contentMicro => const TextStyle(
    fontSize: 11.0, // Tamaño pequeño para contenido
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );

  static TextStyle get contentBold => const TextStyle(
    fontSize: 15.0, // Tamaño mediano pero en negrita para contenido
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );

  static TextStyle get statusPending => const TextStyle(
    color: Colors.yellow,
  );
  static TextStyle get statusDone => const TextStyle(
    color: Colours.main,
  );
  static TextStyle get statusCanceled => TextStyle(
    color: Colors.red.shade300,
  );
  static TextStyle get statusActive => const TextStyle(
    color: Colors.green,
  );
}

class AddBoxStyle{
  AddBoxStyle._();

  static SizedBox get microBox => const SizedBox(height: 5);

  static SizedBox get smallBox => const SizedBox(height: 15);

  static SizedBox get normalBox => const SizedBox(height: 25);

  static SizedBox get bigBox => const SizedBox(height: 40);
}

class AddContainerStyle{
  AddContainerStyle._();

  static BoxDecoration get appBarGradient => const BoxDecoration(
    
    gradient: LinearGradient(
      colors: [
        Color.fromARGB(255, 0, 38, 255), // Azul oscuro base
               Color.fromARGB(255, 0, 38, 255),  // Azul más claro
        Color.fromARGB(255, 0, 38, 255),  // Azul aún más claro
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  );

  static BoxDecoration get containerBase => BoxDecoration(
    color: Colours.contrastW,
    borderRadius: BorderRadius.circular(12.0), // Bordes redondeados
    border: Border.all(
      color: Colors.grey[400]!, // Borde delgado y suave
      width: 1.0, // Grosor del borde
    ),
    boxShadow: [
      BoxShadow(
        offset: Offset(1, 2),
        blurRadius: 2,
        color: Color.fromARGB(255, 117, 117, 117),
      ),
    ],
  );
  static BoxDecoration get containerInput => BoxDecoration(
    borderRadius: BorderRadius.circular(12.0), // Bordes redondeados
    border: Border.all(
      color: Colors.grey[300]!, // Borde delgado y suave
      width: 1.0, // Grosor del borde
    ),
    boxShadow: [
      BoxShadow(
        offset: Offset(1, 2),
        blurRadius: 2,
        color: Color.fromARGB(255, 117, 117, 117),
      ),
    ],
  );
}

class AddButtonStyle{
  AddButtonStyle._();

  static ButtonStyle get button => ElevatedButton.styleFrom(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    backgroundColor: Colours.secondary,
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    )
  ); 
}
