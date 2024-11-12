import "../imports.dart";

class CustomBuilderDropDownButton extends StatefulWidget {
  const CustomBuilderDropDownButton({super.key, this.text, required this.hint, required this.items, required this.onChanged, required this.selected, this.isExpanded ,});
  //final String name;
  final String? text;
  final String selected;
  final String hint;
  final bool? isExpanded;
  //final dynamic initial;
  final List<DropdownMenuItem<String>> items;
  final void Function(String?) onChanged;
  //final String? Function(dynamic)? validator;

  @override
  State<CustomBuilderDropDownButton> createState() => _CustomFormBuilderDropDownState();
}

class _CustomFormBuilderDropDownState extends State<CustomBuilderDropDownButton> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(widget.text != null)
          Text(widget.text!, style: AddTextStyle.labelForm),
        AddBoxStyle.microBox,
        Container(
          decoration: AddContainerStyle.containerBase,
          child: DropdownButton<String>(
            focusColor: Colors.transparent,
            isExpanded: widget.isExpanded ?? true,
            style: AddTextStyle.labelForm,
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 20),
            underline: const SizedBox(),
            hint: Text(widget.hint),
            value: widget.selected,
            onChanged: widget.onChanged,
            items: widget.items,
          ),
        ),
        //if(widget.selected == widget.initial)
          //const Text("Selecciona un grado de importancia"),    
      ],
    );
  }
}