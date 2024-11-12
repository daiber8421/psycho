import '../../../../imports.dart';

class NoticeBuilder extends StatelessWidget {
  final Map<String, dynamic> infoUser = SignInState.infoUser;

  NoticeBuilder({
    super.key,
    required this.title,
    required this.reason,
    required this.content,
    required this.formattedDate,
    required this.name,
    required this.idU,
    required this.idA,
    this.url,
  });

  final String content;
  final String formattedDate;
  final String name;
  final String reason;
  final String title;
  final String? url;
  final String idU;
  final String idA;

  void showImg(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: InteractiveViewer(
            child: Image.network(
              url!,
              fit: BoxFit.contain,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Detecta el tamaño de la pantalla
    final isMobile = MediaQuery.of(context).size.width < 600;
    
    return Container(
      margin: isMobile? EdgeInsets.only(top: 5): EdgeInsets.zero,
      child: Card(
        
        shape: RoundedRectangleBorder(
         
        ),
        margin: isMobile ? EdgeInsets.zero : const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colours.secondary,
                    child: Text(
                      name.isNotEmpty ? name[0] : 'U',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: AddTextStyle.titleMedium.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 2.0),
                        Text(
                          formattedDate,
                          style: AddTextStyle.contentMicro.copyWith(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                  if (infoUser['role'] == "0")
                    PopupMenuButton<String>(
                      itemBuilder: (BuildContext context) => [
                        PopupMenuItem<String>(
                          value: 'Eliminar',
                          onTap: () async {
                            await showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDiag(
                                  title: "Eliminar",
                                  function: () async {
                                    await deleteNotice(
                                      url ?? '',
                                      idA,
                                    );
                                  },
                                );
                              },
                            );
                          },
                          child: Row(
                            children: [
                              const Icon(Icons.delete, size: 18),
                              const SizedBox(width: 8),
                              Text(
                                "Eliminar",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: AddTextStyle.titleSmall.copyWith(fontWeight: FontWeight.bold, color: Colours.main),
              ),
              const SizedBox(height: 4),
              Text(
                reason,
                style: AddTextStyle.contentMedium.copyWith(fontStyle: FontStyle.italic, color: Colors.grey[700]),
              ),
              const SizedBox(height: 8),
              Text(
                content,
                style: AddTextStyle.contentSmall.copyWith(color: Colors.grey[800]),
              ),
              if (url != null && url!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: GestureDetector(
                    onTap: () => showImg(context),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          double maxHeight = isMobile ? 200 : 300;
                          return ConstrainedBox(
                            constraints: BoxConstraints(
                              maxHeight: maxHeight,
                              minHeight: 120,
                            ),
                            child: Image.network(
                              url!,
                              fit: BoxFit.contain,
                              width: double.infinity,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
