import "../../../../imports.dart";
import 'package:intl/intl.dart';
import 'card.dart';

//Pantalla para la creación de un anuncio
class NoticeAddScreen extends StatefulWidget {
  const NoticeAddScreen({super.key});

  @override
  State<NoticeAddScreen> createState() => _NoticeAddScreenState();
}

class _NoticeAddScreenState extends State<NoticeAddScreen> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final List<NoticeBuilder> _settingCards = [];
  File? _imagenToUpload; // Para móviles
  PlatformFile? _webFile; // Para web
  String? _imageURL; // URL de la imagen subida
  late Map<String, dynamic> _upload;
  bool _isEnabled = true;

  final TextEditingController _titleC = TextEditingController(); 
  final TextEditingController _reasonC = TextEditingController();
  final TextEditingController _contentC = TextEditingController(); 
  
  String? title;
  String? reason;
  String? content;

  void _setEnabled(String field, String? value) {
  setState(() {
    switch (field) {
      case 'title':
        title = value;
        break;
      case 'reason':
        reason = value;
        break;
      case 'content':
        content = value;
        break;
    }

    // Actualizar el estado de habilitación del botón
    _isEnabled = title == null ||
        title!.isEmpty ||
        reason == null ||
        reason!.isEmpty ||
        content == null ||
        content!.isEmpty;
  });
}

  void _submitFormNotice() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      String title = _titleC.text;
      String reason = _reasonC.text;
      String content = _contentC.text;

      String appointmentId = generarnumeroramdon(10);

      if (_imagenToUpload != null) {
        _upload = await uploadImage(_imagenToUpload!,  SignInState.infoUser["documentID"] ?? 'ID por defecto');
        _imageURL = _upload['url'] ?? '';
      } else if (_webFile != null) {
        _imageURL = await uploadWebFile(_webFile!,  SignInState.infoUser["documentID"] ?? 'ID por defecto') ?? '';
      } else {
        _imageURL = '';
      }
      Navigator.pop(context);
      DateTime now = DateTime.now();
      await addNot(reason, content, title, now,  SignInState.infoUser["name"] ?? 'Nombre por defecto', _imageURL!, appointmentId);
      setState(() {
        _settingCards.add(NoticeBuilder(
          title: title,
          reason: reason,
          content: content,
          url: _imageURL!,
          formattedDate: DateFormat('hh:mm a').format(now),
          name:  SignInState.infoUser["name"] ?? 'Nombre por defecto',
          idU:  SignInState.infoUser["documentID"] ?? 'ID por defecto',
          idA: appointmentId,
        ));
      });

      _formKey.currentState?.reset();
      setState(() {
        _imagenToUpload = null;
        _webFile = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Anuncio publicado con éxito')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Inválido")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar( 
        title: const Text("Nuevo anuncio"),
        flexibleSpace: Container(
          decoration: AddContainerStyle.appBarGradient,
        ),
      ),
      body: Base(
        background: true, 
        width: width, 
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Text(width > BreakPoint.laptop ? "Redacción de nuevo anuncio" : "Nuevo anuncio", style: AddTextStyle.headContainerBase),
          ),
          FormBuilder(
            key: _formKey,
            child: Column(
              children: [
                CustomFormBuilderTextField(
                  name: "title",
                  controller: _titleC,
                  text: "Titulo", 
                  hint: "Ingrese el titulo del anuncio", 
                  onChanged: (value) => _setEnabled('title', value),   
                ),
                AddBoxStyle.normalBox,
                CustomFormBuilderTextField(
                  name: "reason",
                  controller: _reasonC,
                  text: "Razón", 
                  hint: "Digite la razón del anuncio", 
                  onChanged: (value) => _setEnabled('reason', value),   
                ),
                AddBoxStyle.normalBox,
                CustomFormBuilderTextField(
                  name: "content",
                  controller: _contentC,
                  text: "Contenido", 
                  hint: "Digite el contenido del anuncio", 
                  onChanged: (value) => _setEnabled('content', value),   
                ),
                AddBoxStyle.smallBox,
                GestureDetector(
                  child: const Icon(Icons.upload_file, size: 25,),
                  onTap: () async {
                    if (kIsWeb) {
                      final result = await FilePicker.platform.pickFiles();
                      if (result != null) {
                        setState(() {
                          _webFile = result.files.first;
                        });
                      }
                    } else {
                      final picker = ImagePicker();
                      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
                      if (pickedFile != null) {
                        setState(() {
                          _imagenToUpload = File(pickedFile.path);
                        });
                      }
                    }
                  },
                ),
                if (_imagenToUpload != null || _webFile != null)
                  Text(
                    "Imagen seleccionada",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                Container(
                  width: double.infinity,
                  height: 300, // Especifica una altura fija para el contenedor de la imagen
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: kIsWeb && _webFile != null
                          ? MemoryImage(_webFile!.bytes!) as ImageProvider // Mostrar imagen seleccionada en web
                          : _imagenToUpload != null
                              ? FileImage(_imagenToUpload!) // Mostrar imagen seleccionada en móvil
                              : const AssetImage("") as ImageProvider, // Imagen por defecto si no hay ninguna seleccionada
                      fit: BoxFit.cover,
                    ),               
                  ),
                ),
                const SizedBox(height: 15),
                Button(
                  onPressed: _isEnabled ? null : _submitFormNotice,
                  text: 'Publicar anuncio',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
