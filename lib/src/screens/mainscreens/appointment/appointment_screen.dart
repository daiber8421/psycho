import "../../../imports.dart";
import "widgets/form/form_section.dart";
import "widgets/show/show_section.dart";
import "widgets/request/request_section.dart";

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});
  static String routename = "appointment";

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> with TickerProviderStateMixin {
  late TabController _tabController; // Controlador de TabBar
  late List<Tab> _tabs = [
    const Tab(icon: Icon(Icons.edit_calendar), text: "Agendar"),
    const Tab(icon: Icon(Icons.preview), text: "Ver citas"),
    const Tab(icon: Icon(Icons.perm_contact_cal), text: "Solicitudes"),
  ];

  final List<Widget> _wtabs = [
    const AppointmentFormSection(),
    const AppointmentShowSection(),
    const AppointmentRequestSection(),
  ];

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _initializeTabController();
  }

  void _initializeTabController() {
    if (SignInState.infoUser["role"] == "1") {
      _tabs = [
        const Tab(icon: Icon(Icons.edit_calendar), text: "Solicitar"),
        const Tab(icon: Icon(Icons.preview), text: "Ver citas"),
      ];
    } else if (SignInState.infoUser["role"] == "2") {
      _tabs = [
        const Tab(icon: Icon(Icons.edit_calendar), text: "Remitir"),
        const Tab(icon: Icon(Icons.preview), text: "Ver remisiones"),
      ];
    }

    _tabController = TabController(length: _tabs.length, vsync: this);
    // Escuchar cambios de índice de TabBar
    _tabController.addListener(() {
      setState(() {
        _currentIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose(); // Liberamos el controlador cuando no se usa
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:TabBar(
          controller: _tabController, // Asignamos el controlador al TabBar
          tabs: _tabs,
        ),
      
      body: TabBarView(
        controller: _tabController, // Asignamos el controlador al TabBarView
        children: _wtabs,
      ),
    );
  }
}
