import "../imports.dart";

class CustomFormBuilderDropDown extends StatefulWidget {
  const CustomFormBuilderDropDown({super.key, required this.name, this.text, this.label, this.hint, required this.initial, required this.items, this.onChanged, this.msgError,});
  final String name;
  final String? text;
  final String? label;
  final String? hint;
  final dynamic initial;
  final List<DropdownMenuItem> items;
  final void Function(dynamic)? onChanged;
  //final String? Function(dynamic)? validator;
  final String? msgError;

  @override
  State<CustomFormBuilderDropDown> createState() => _CustomFormBuilderDropDownState();
}

class _CustomFormBuilderDropDownState extends State<CustomFormBuilderDropDown> {
  String? msgErrorShow;

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
          child: FormBuilderDropdown(
            validator: (value){
              if (value == widget.initial) {
                setState(() {
                    msgErrorShow = widget.msgError;
                });
                return;
              } else {
              setState(() {
                  msgErrorShow = null;
                });
              }
              return null;
            },
            name: widget.name,
            decoration: AddInputStyle.inputForm.copyWith(
              hintText: widget.hint,
              labelText: widget.label,
            ),
            onChanged: widget.onChanged,
            initialValue: widget.initial,
            items: widget.items,
          ),
        ),
        if (msgErrorShow != null)
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text(
              msgErrorShow!,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }
}