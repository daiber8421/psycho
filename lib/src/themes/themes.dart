import '../imports.dart';

//ThemeDatas
ThemeData globalStyle = ThemeData(
  colorScheme: lightScheme,
  useMaterial3: true,
  appBarTheme: AppBarTheme(
    backgroundColor: Colours.bluishGrey,
    titleTextStyle: AddTextStyle.appBartxt,
    foregroundColor: Colours.contrastW,
  ),
  dropdownMenuTheme: const DropdownMenuThemeData(
    
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: AddButtonStyle.button,
  ),
  /*inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none, // Sin borde exterior
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none, // Sin borde exterior
    ),
    filled: true,
    fillColor: const Color.fromARGB(255, 255, 255, 255),
    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
  ),*/
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colours.main,
    type: BottomNavigationBarType.shifting,
    unselectedItemColor: Colours.contrastW,
    selectedItemColor: Colours.main,
    selectedIconTheme: IconThemeData(
      color: Colours.main,
      size: 30,
    ),
    showUnselectedLabels: false,
  ),
  navigationRailTheme: const NavigationRailThemeData(
    backgroundColor: Colours.main,
    labelType: NavigationRailLabelType.selected,
    minExtendedWidth: 75, 
    groupAlignment: -1,
    indicatorShape: StadiumBorder(),
    selectedLabelTextStyle: TextStyle(color: Colors.white),
    selectedIconTheme: IconThemeData(
      color: Colours.main2,
    ),
    unselectedIconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
  /*textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: 96.0, fontWeight: FontWeight.bold,),
    displayMedium: TextStyle(fontSize: 60.0, fontWeight: FontWeight.bold,),
    displaySmall: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
    headlineLarge: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
    headlineMedium: TextStyle(fontSize: 34.0, fontWeight: FontWeight.w600,),
    headlineSmall: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w600,),
    titleLarge: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w500,),
    titleMedium: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500,),
    titleSmall: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500,),
    bodyLarge: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal,),
    bodyMedium: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal,),
    bodySmall: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal,),
    labelLarge: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500, color: Color.fromARGB(255, 54, 54, 54),),
    labelMedium: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500,),
    labelSmall: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500,),
  ),*/
);
ThemeData lightMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: lightScheme,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all<Color>(
        lightScheme.primary, // Slightly darker shade for the button
      ),
      foregroundColor:
          WidgetStateProperty.all<Color>(Colors.white), // text color
      elevation: WidgetStateProperty.all<double>(5.0), // shadow
      padding: WidgetStateProperty.all<EdgeInsets>(
          const EdgeInsets.symmetric(horizontal: 20, vertical: 18)),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // Adjust as needed
        ),
      ),
    ),
  ),
);
ThemeData darkMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: darkScheme,
);

//ColorSchemes
const lightScheme = ColorScheme(
  brightness: Brightness.light,
  //El color principal que aparece en elementos destacados como el AppBar, botones activos y otros componentes principales de la interfaz.
  primary: Colours.main2,
  //El color que debe aplicarse sobre el primary color, como el color del texto o íconos que se muestran encima de un fondo con el color primario.
  onPrimary: Colours.contrastW,
  //El color secundario que se utiliza para widgets de soporte, como el FloatingActionButton, los chips, los controles deslizantes y otros elementos que necesitan un color de énfasis secundario.
  secondary: Colours.contrastW,
  //El color que debe aplicarse sobre el secondary color. Similar a onPrimary, pero para elementos secundarios.
  onSecondary: Colours.contrastB,
  error: Colours.error,
  onError: Colours.contrastW,
  shadow: Colours.shadow,
  //Este color define la apariencia de las superficies como las tarjetas (Card), las listas y los diálogos. Normalmente se usa para los fondos de estos componentes.
  surface: Colours.surface,
  //El color que debe aplicarse sobre la surface. Por ejemplo, el color del texto en tarjetas o diálogos con un fondo de surface.
  onSurface: Colours.contrastB,
  //El color de fondo de la aplicación o de pantallas completas. Se utiliza en áreas grandes como el fondo de una pantalla o de un Scaffold.
  background: Colours.whiteSmoke,
  //El color que se aplica sobre el fondo (background). Por ejemplo, el color del texto principal en una pantalla con un fondo blanco o gris claro.
  onBackground: Colours.greyv,
);
const darkScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF416FDF),
  onPrimary: Color(0xFFFFFFFF),
  secondary: Color(0xFF6EAEE7),
  onSecondary: Color(0xFFFFFFFF),
  error: Color(0xFFBA1A1A),
  onError: Color(0xFFFFFFFF),
  shadow: Color(0xFF000000),
  outlineVariant: Color(0xFFC2C8BC),
  surface: Color(0xFFF9FAF3),
  onSurface: Color(0xFF1A1C18),
);





