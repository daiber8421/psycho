import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:phsycho/src/api/firebase_api.dart';
import '../../imports.dart';
import 'appointment/appointment_screen.dart';
import 'manage/manage.dart';
import 'notice/notice_screen.dart';
import 'chat/chat.dart';
import 'setting/settings.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});
  static const routename = "MainPage";

  @override
  State<Mainpage> createState() => MainpageScreenState();
}

class MainpageScreenState extends State<Mainpage>
    with TickerProviderStateMixin {
  @override
  void initState() {
    _initialize();
    super.initState();
    currentIndex = 0;
    // Inicializa en 0
  }

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final TabStyle _tabStyle = TabStyle.reactCircle;
  late List<Widget> screens;
  late List<String> screenTitles = [
    "",
    "",
    "",
    "",
    ""
  ];
  late List<IconData> screenIcons = [
    Icons.home,
    Icons.calendar_month,
    Icons.chat,
    Icons.person,
    Icons.settings
  ];
  late List<IconData> screenIconsAlt = [
    Icons.home_outlined,
    Icons.calendar_month_outlined,
    Icons.chat_outlined,
    Icons.person_outline,
    Icons.settings_outlined
  ];

  static int currentIndex = 0;
  int previousIndex = 0;
  Future<void> _initialize() async {
    await Firebase.initializeApp();
    await initializeNotifications();

    // Verifica si el id del usuario está presente
    if (SignInState.infoUser["id"] == null ||
        SignInState.infoUser["id"].isEmpty) {
      Navigator.pushReplacementNamed(
          context, SignIn.routename); // Redirige a SignIn
      return;
    }

    nservice.listenForMessages(SignInState.infoUser["id"]);
    await _updateUserInfo(SignInState.infoUser["id"]);
  }

  void setPageIndex(int index) {
    if (index < 0 || index >= screens.length) {
      return; // Evitar índice fuera de rango
    }
    setState(() {
      currentIndex = index;
    });
  }

  NotiferService nservice = NotiferService();

  @override
  void dispose() {
    nservice.cancelSubscriptions();
    super.dispose();
  }

  Future<void> _updateUserInfo(String userId) async {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('Usuarios-E')
        .doc(userId)
        .get();
    print(userId);

    if (userDoc.exists) {
      setState(() {
        String name;
        name = userDoc['name'];
        SignInState.infoUser["name"] = name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (SignInState.infoUser["role"] == "0") {
      screens = [
        const NoticeScreen(),
        const AppointmentScreen(),
        const ChatScreen(),
        const ManageScreen(),
        const SettingsScreen()
      ];
    } else if (SignInState.infoUser["role"] == "1" ||
        SignInState.infoUser["role"] == "2") {
      screens = [
        const NoticeScreen(),
        const AppointmentScreen(),
        const ChatScreen(),
        const SettingsScreen()
      ];
      
      screenIcons = [
        Icons.home,
        Icons.calendar_month,
        Icons.chat,
        Icons.settings
      ];
      screenIconsAlt = [
        Icons.home_outlined,
        Icons.calendar_month_outlined,
        Icons.chat_outlined,
        Icons.settings_outlined
      ];
    } else {
      screens = [const Text("Rol inválido")];
    }

    AppBar appBar = AppBar(
      toolbarHeight: 20,
      automaticallyImplyLeading: false,
      flexibleSpace: Container(
      margin: const EdgeInsets.all(0),
        decoration:
            AddContainerStyle.appBarGradient, // Degradado para el AppBar
      ),
    );

    Drawer sideAppBar = Drawer(
      
      width: 90.0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
        
      ),
      child: Container(
        margin: const EdgeInsets.all(0),
        padding: const EdgeInsets.all(12),//uno mas no aguanta
        decoration:
            AddContainerStyle.appBarGradient, // Degradado para el Sidebar
        child: Column(
          children: [

               const SizedBox(height: 20,),
            ...List.generate(screens.length - 1, (index) {
              return Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(0),
                    padding: const EdgeInsets.all(0),
               
                  
                    decoration: BoxDecoration(
                
                      color: currentIndex == index ?  const Color.fromARGB(255, 255, 255, 255): null,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: ListTile(
                      
                      
                      
                      leading: Icon(
               
                        screenIcons[index],
                        color: currentIndex == index
                            ? const Color.fromARGB(255, 0, 0, 0)
                            : const Color.fromARGB(255, 255, 255, 255),
                      ),
                      
                      onTap: () {
                        setPageIndex(index); // Cierra el Drawer
                      },
                    ),
                    
                  ),
                  const SizedBox(height: 10,)
                ],
              );
            }),
            const Spacer(),
            const Divider(),
            Container(
              decoration: BoxDecoration(
                color: currentIndex == screens.length - 1
                    ? Colours.whiteSmoke
                    : null,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: Icon(
                  screenIcons[screens.length - 1], // Ícono de Ajustes
                  color: currentIndex == screens.length - 1
                      ?  const Color.fromARGB(255, 0, 0, 0)
                      : Colours.greyv,
                ),
                
                onTap: () {
                  setPageIndex(screens.length - 1); // Cierra el Drawer
                },
              ),
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      
      backgroundColor:   Colors.white,
      key: scaffoldKey,
      appBar: appBar,
      body: width > BreakPoint.mobileTablet
          ? Row(
              children: [
                sideAppBar,
                const VerticalDivider(thickness: 1, width: 1),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      final offsetAnimation = Tween<Offset>(
                        begin: MediaQuery.of(context).size.width > 1300
                            ? (previousIndex < currentIndex
                                    ? const Offset(
                                        0, 1) // Down 
                                    : const Offset(
                                        0, -1) // Up i
                                )
                            : (previousIndex < currentIndex
                                ? const Offset(
                                    1, 0) // Right 
                                : const Offset(
                                    -1, 0) // Left 
                            ), 
                        end: Offset.zero,
                      ).animate(animation);

                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
                    child: screens[currentIndex],
                  ),
                ),
              ],
            )
          : AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (Widget child, Animation<double> animation) {
                final offsetAnimation = Tween<Offset>(
                  begin: MediaQuery.of(context).size.width > 1300
                            ? (previousIndex < currentIndex
                                    ? const Offset(
                                        0, 1) // Down 
                                    : const Offset(
                                        0, -1) // Up i
                                )
                            : (previousIndex < currentIndex
                                ? const Offset(
                                    1, 0) // Right 
                                : const Offset(
                                    -1, 0) // Left 
                            ),  // Sube si el índice disminuye
                  end: Offset.zero,
                ).animate(animation);

                return SlideTransition(
                  position: offsetAnimation,
                  child: child,
                );
              },
              child: screens[currentIndex],
            ),
      bottomNavigationBar: width > BreakPoint.mobileTablet
          ? null
          : ConvexAppBar(
              backgroundColor:
                  Colours.main2,
              activeColor: Theme.of(context)
                  .bottomNavigationBarTheme
                  .unselectedItemColor,
              color: Theme.of(context)
                  .bottomNavigationBarTheme
                  .unselectedItemColor,
              style: _tabStyle,
              initialActiveIndex: currentIndex,
              onTap: setPageIndex,
              items: List.generate(screens.length, (index) {
                return TabItem(
                  icon: Icon(
                    screenIcons[index],
                    color: Theme.of(context)
                        .bottomNavigationBarTheme
                        .unselectedItemColor,
                  ),
                  activeIcon: Icon(
                    screenIconsAlt[index],
                    size: 28,
                    color: Theme.of(context)
                        .bottomNavigationBarTheme
                        .selectedItemColor,
                  ),
                  title: screenTitles[index],
                );
              }),
            ),
    );
  }
}
