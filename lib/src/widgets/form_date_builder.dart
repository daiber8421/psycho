import "../imports.dart";

class CustomFormBuilderDatePicker extends StatefulWidget {
  const CustomFormBuilderDatePicker({super.key, this.text, this.msgError, required this.name, this.controller, this.hint, this.label});
    final String? text;
    final String? msgError;
    final String name;
    final TextEditingController? controller;
    final String? hint;
    final String? label;

  @override
  State<CustomFormBuilderDatePicker> createState() => _CustomFormBuilderDatePickerState();
}

class _CustomFormBuilderDatePickerState extends State<CustomFormBuilderDatePicker> {
  String? msgErrorShow;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(widget.text != null)
          Text(widget.text!, style: AddTextStyle.labelForm),
        Container(
          decoration: AddContainerStyle.containerBase,
          child: FormBuilderDateTimePicker(
            name: widget.name,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2040),
            initialTime: const TimeOfDay(hour: 9, minute: 0),
            controller: widget.controller,
            decoration: AddInputStyle.inputForm.copyWith(
              hintText: widget.hint,
              labelText: widget.label,
            ),
            
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