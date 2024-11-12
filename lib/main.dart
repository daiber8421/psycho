import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:intl/intl.dart'; // Para formatear fechas
import 'package:intl/date_symbol_data_local.dart'; // Para inicializar locales
import 'package:provider/provider.dart';
import 'src/imports.dart';
import 'src/screens/mainscreens/appointment/appointment_screen.dart';
import 'src/screens/mainscreens/other/historial/widget/provaiderform.dart'; // Importa el FormProvider

final navigatorKey = GlobalKey<NavigatorState>();
GlobalKey<MainpageScreenState> mainPageKey = GlobalKey<MainpageScreenState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await initializeDateFormatting('es_ES', null);

  await MainApp.cargarToken(); // Carga el token antes de ejecutar la aplicación

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(
            create: (context) => FormProvider()), // Proveedor del formulario
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  static Map<String, dynamic>? infoUser; // Variable estática

  static Future<void> cargarToken() async {
    infoUser = await obtenerToken("Token"); // Carga el token
  }

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: globalStyle,
      title: title,
      scrollBehavior: const ScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.trackpad,
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
        },
      ),
      initialRoute:
          userProvider.isUserLoggedIn ? Mainpage.routename : SignIn.routename,
      routes: {
        SignIn.routename: (context) => const SignIn(),
        Mainpage.routename: (context) => Mainpage(key: mainPageKey),
        AppointmentScreen.routename: (context) => const AppointmentScreen(),
      },
    );
  }
}

class UserProvider with ChangeNotifier {
  bool _isUserLoggedIn = false;

  bool get isUserLoggedIn => _isUserLoggedIn;

  Future<void> loadUser() async {
    MainApp.infoUser = await obtenerToken("Token");
    _isUserLoggedIn = MainApp.infoUser != null && MainApp.infoUser!.isNotEmpty;
    notifyListeners();
  }

  void clearData() {
    MainApp.infoUser = null;
    _isUserLoggedIn = false;
    eliminarToken("Token");
    SignInState.infoUser = {};
    notifyListeners();
  }
}
