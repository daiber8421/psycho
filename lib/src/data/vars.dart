import '../imports.dart';



String title = "HealthMind";

final List<String> grades = ['Todos', '7', '8', '9', '10', '11'];
final List<String> course = ['Todos', '1', '2', '3', '4', '5', '6', '7', '8'];
final List<String> status = ["Todos",'Pendiente', 'Resuelta', 'Cancelada', 'Activa'];
final List<String> gradeIlistF = [
  /*"Selecciona el grado de importancia",*/"Todos", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"
];
final List<String> gradeIlistf = [
  /*"Selecciona el grado de importancia",*/ "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"
];

class BreakPoint {
  static const double full = 2560;
  static const double laptopLarge = 1440;
  static const double laptop = 1025;
  static const double tabletLaptop = 900;
  //Separacion de tamaños
  static const double tablet = 769;
    static const double mobileTablet = 651;
  static const double mobileLarge = 426;
  static const double mobileMedium = 376;
  static const double mobileSmall = 321;
}

class Colours{
    Colours._();

    static const Color main = Color(0xFF0D47A1);
      static const Color main2 = Color.fromARGB(255, 0, 38, 255);
    //static const Color onMain = Colors.white;
    static const Color secondary = Color(0xFF1976D2);
    static const Color tertary = Color(0xFF42A5F5);

    //static const Color onSecondary = Colors.white;
    static const Color surface = Colors.white;
    static const Color shadow = Colors.black;
    static const Color error = Color(0xFFBA1A1A);
    
    static const Color contrastW = Colors.white;
    static const Color contrastB = Colors.black;

    static const Color whiteSmoke = Color.fromARGB(255, 245, 245, 245);
    
    static const Color blackv = Color(0xff626262);
    static const Color bluishGrey = Color(0xffdddee9);
    static const Color navyBlue = Color(0xff6471e9);
    static const Color lightNavyBlue = Color(0xffb3b9ed);
    static const Color redv = Color(0xfff96c6c);
    static const Color greyv = Color(0xffe0e0e0);
    //static const Color onColor = Colors.white;
}

Map<String, String> registeredSchools = {
  "1" : "Dolores María Ucros",
  "2" : "Itida",
  "3" : "Cosmopolitano",
};


