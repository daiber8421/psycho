import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:phsycho/main.dart';
import 'package:phsycho/src/api/firebase_api.dart';
import 'dart:html' as html;

import '../../imports.dart';
import '../../widgets/particles.dart';
import '../../widgets/particles_stela.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});
  static const String routename = "signin";

  @override
  State<SignIn> createState() => SignInState();
}

class SignInState extends State<SignIn> with SingleTickerProviderStateMixin {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  TextEditingController passwordController = TextEditingController();
  TextEditingController idController = TextEditingController();
  static Map<String, dynamic> infoUser = MainApp.infoUser ?? {};

  // ignore: unused_field
  bool _isLoading = false;
  bool _isObscure = true;

  late AnimationController _controller;
  late Animation<int> _characterCount;

  Future<bool> singIng() async {
    if (_formKey.currentState!.saveAndValidate()) {
      final formState = _formKey.currentState!;
      // Mostrar indicador de carga
      setState(() {
        _isLoading = true;
      });

      try {
        infoUser = await checkIfUserExists(
          idController.text,
          formState.value['institucion'],
          passwordController.text,
        );

        // Ocultar indicador de carga
        setState(() {
          _isLoading = false;
        });

        if (infoUser['exists']) {
          eliminarToken("Token");
          guardarToken("Token", infoUser);

          return true;
        } else {
          // Mostrar mensaje de error específico si existe
          showSnackBar(context, infoUser['error'] ?? 'Error desconocido');
          return false;
        }
      } catch (e) {
        // Ocultar indicador de carga
        setState(() {
          _isLoading = false;
        });
        showSnackBar(
            context, 'Error de conexión. Por favor, inténtalo de nuevo.');
        return false;
      }
    }
    return true;
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _characterCount = StepTween(
      begin: 0,
      end: title.length,
    ).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          ParticleStelaBackground(),
          SizedBox.expand(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [beforetxt(), animatedtxt(_characterCount, title)],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      constraints: const BoxConstraints(
                        maxHeight: 430,
                        maxWidth: 320,
                      ),
                      decoration: AddContainerStyle.containerBase.copyWith(),
                      padding: width > BreakPoint.mobileLarge
                          ? const EdgeInsets.all(20.0)
                          : const EdgeInsets.all(10.0),
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      child: FormBuilder(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomFormBuilderDropDown(
                              name: "institucion",
                              text: "Institución",
                              initial: "1",
                              items: registeredSchools.entries.map((entry) {
                                return DropdownMenuItem<String>(
                                  value: entry.key,
                                  child: Text(
                                    entry.value,
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colours.blackv,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            AddBoxStyle.normalBox,
                            CustomFormBuilderTextField(
                              //prefixIcon: const Icon(Icons.person),
                              name: "UserId",
                              text: "Usuario",
                              hint: "Ingrese el codigo de usuario",
                              controller: idController,
                              obscureText: false,
                              onSubmitted: (value) {
                                singIng();
                              },
                              msgError: "Por favor digita tu ID de Usuario ",
                            ),
                            AddBoxStyle.normalBox,
                            CustomFormBuilderTextField(
                              //prefixIcon: const Icon(Icons.password),
                              name: "password",
                              text: "Contraseña",
                              hint: "Ingrese la contraseña",
                              obscureText: _isObscure,
                              controller: passwordController,
                              onSubmitted: (value) {
                                singIng();
                              },
                              msgError: "Por favor digita tu contraseña",
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isObscure
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isObscure =
                                        !_isObscure; // Alterna el valor de _isObscure
                                  });
                                },
                              ),
                            ),
                            AddBoxStyle.bigBox,
                            SizedBox(
                              width: double.infinity,
                              child: Button(
                                onPressed: () async {
                                  eliminarToken("Token");

                                  if (kIsWeb) {
                                    if (html.window.navigator.onLine!) {
                                      if (await singIng()) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Await()),
                                        );
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "Por favor, conecta a internet.")),
                                      );
                                    }
                                  } else {
                                    var connectivityResult =
                                        await Connectivity()
                                            .checkConnectivity();

                                    if (connectivityResult ==
                                            ConnectivityResult.wifi ||
                                        connectivityResult ==
                                            ConnectivityResult.mobile) {
                                      if (await singIng()) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Await()),
                                        );
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "Por favor, conecta a internet.")),
                                      );
                                    }
                                  }
                                },
                                text: "Ingresar",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget beforetxt() {
  return Container(
    width: 14,
    height: 80,
    decoration: const BoxDecoration(
      color: Colours.main2,
      boxShadow: [
        BoxShadow(
          color: Colors.black,
          blurRadius: 1.5,
          offset: Offset(4, 8),
        ),
      ],
    ),
  );
}

Widget animatedtxt(characterCount, text) {
  return SizedBox(
    child: AnimatedBuilder(
      animation: characterCount,
      builder: (context, child) {
        String visibleText = text.substring(0, characterCount.value);
        return Text(visibleText, style: AddTextStyle.signInTile);
      },
    ),
  );
}
