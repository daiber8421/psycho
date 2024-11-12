import 'package:http/http.dart';

import '../imports.dart';

class CustomFormBuilderTextField extends StatefulWidget {
  const CustomFormBuilderTextField({super.key, this.controller, this.text, this.label, this.hint, this.obscureText, this.suffixIcon, this.onChanged, this.maxLines, this.prefixIcon, this.minLines,this.initValue, this.enabled, this.validator, required this.name, this.onSubmitted, this.msgError});
  final String name;
  final String? text;
  final String? hint;
  final String? label;
  final void Function(String?)? onSubmitted; 
  final void Function(String?)? onChanged;   
  final String? Function(String?)? validator;  
  final TextEditingController? controller;
  final bool? obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final int? maxLines;
  final int? minLines; 
  final String? msgError;
  final String? initValue;
  final bool? enabled;

  @override
  State<CustomFormBuilderTextField> createState() => _CustomFormBuilderTextFieldState();
}

class _CustomFormBuilderTextFieldState extends State<CustomFormBuilderTextField> {

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
          child: TextFormField(
            minLines: widget.minLines ?? 1,
            maxLines: widget.maxLines ?? 1,
            obscureText: widget.obscureText ?? false,
            initialValue: widget.initValue,
            controller: widget.controller,
            validator: widget.validator,
            enabled: widget.enabled ?? true,
            onChanged: widget.onChanged,
            decoration: AddInputStyle.inputForm.copyWith(
              hintText: widget.hint,
              labelText: widget.label,
              suffixIcon: widget.suffixIcon,  
              prefixIcon: widget.prefixIcon,
            ), 
          ),
        ),
      ],
    );
  }
}




