import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class FormInput extends StatefulWidget {
  final String inputName;
  final String placeHolder;
  final String? inputType;
  final TextEditingController inputController;
  final bool obscureText;
  final bool? autofocus;

  const FormInput({
    super.key,
    required this.inputName,
    required this.placeHolder,
    required this.inputController,
    this.inputType = "text",
    this.obscureText = false,
    this.autofocus = true,
  });

  @override
  State<FormInput> createState() => _FormInputState();
}

class _FormInputState extends State<FormInput> {
  late bool _isObscured;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText; // Initialize with the passed value
  }

  String? _validateInput(String value) {
    // Email validation with regex
    if (widget.inputType == 'email') {
      final emailRegex =
          RegExp(r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
      if (!emailRegex.hasMatch(value)) {
        return 'Please enter a valid email';
      }
    }

    // Password validation (at least 6 characters for simplicity)
    if (widget.inputType == 'password') {
      if (value.isEmpty) {
        return 'Password cannot be empty';
      } else if (value.length < 6) {
        return 'Password must be at least 6 characters long';
      }
    }

    // General validation
    if (value.isEmpty) {
      return 'This field cannot be empty';
    }

    return null; // No errors
  }

  @override
  Widget build(BuildContext context) {
    // Determine keyboard type based on inputType
    TextInputType getKeyboardType(String inputType) {
      switch (inputType.toLowerCase()) {
        case 'email':
          return TextInputType.emailAddress;
        case 'number':
          return TextInputType.number;
        case 'phone':
          return TextInputType.phone;
        default:
          return TextInputType.text;
      }
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            obscureText: _isObscured, // Use the current state for obscureText
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: getKeyboardType(widget.inputType!),
            controller: widget.inputController,
            autofocus: widget.autofocus!,
            style: Theme.of(context).textTheme.bodySmall,
            decoration: InputDecoration(
              suffixIcon: widget.inputType == "password"
                  ? IconButton(
                      icon: Icon(
                        _isObscured ? Iconsax.eye : Iconsax.eye_slash,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscured =
                              !_isObscured; // Toggle the obscureText value
                        });
                      },
                    )
                  : null,
              labelText: widget.inputName,
              hintText: widget.placeHolder,
              hintStyle: Theme.of(context).textTheme.bodySmall,
              labelStyle: Theme.of(context).textTheme.bodySmall,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                ),
                borderRadius:
                    BorderRadius.circular(8), // Keep consistent radius
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 2.0, // Custom width for error border
                ),
                borderRadius:
                    BorderRadius.circular(8), // Keep consistent radius
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 2.0, // Custom width for focused error border
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              errorText: _errorText, // Set the error text
            ),

            onChanged: (value) => {
              setState(() {
                _errorText = _validateInput(value);
              })
            },
          ),
        ],
      ),
    );
  }
}
