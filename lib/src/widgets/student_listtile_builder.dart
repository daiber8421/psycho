import '../imports.dart';

class StudentListtileBuilder extends StatefulWidget {
  const StudentListtileBuilder({super.key, required this.infoU, this.onTap, required this.buttons, this.selectedTileColor,});

  final Map<String, dynamic> infoU;
  final void Function()? onTap;
  final List<Widget> buttons;
  final Color? selectedTileColor;

  @override
  State<StudentListtileBuilder> createState() => _StudentListtileBuilderState();
}

class _StudentListtileBuilderState extends State<StudentListtileBuilder> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.selectedTileColor,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colours.secondary,
          child: Text(
            widget.infoU['name'][0],
          ),
        ),
        title: Text(widget.infoU['name']),
        onTap: widget.onTap,
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Muestra el ID y el curso del documento
            Text("${widget.infoU['grade']} - ${widget.infoU['course']}"),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: widget.buttons,
        ),
      ),
    );
  }
}