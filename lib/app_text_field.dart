import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextCapitalization? textCapitalization;
  final TextInputAction? textInputAction;
  final bool? obscureText;
  final String? hintText;
  final String? labelText;
  final bool? obscuringCharacter;
  final Function(String)? onChanged;
  final String Function(String?)? validator;

  const AppTextField({
    Key? key,
    this.controller,
    this.keyboardType,
    this.textCapitalization,
    this.textInputAction,
    this.obscureText,
    this.hintText,
    this.onChanged,
    this.validator,
    this.labelText,
    this.obscuringCharacter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(
        color: Color(0xA1000000),
        fontFamily: 'Abel',
      ),
      validator: validator,
      onChanged: onChanged,
      obscureText: obscureText ?? false,
      obscuringCharacter: '*',
      textInputAction: textInputAction ?? TextInputAction.next,
      keyboardType: keyboardType ?? TextInputType.emailAddress,
      textCapitalization: textCapitalization ?? TextCapitalization.words,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          borderSide: BorderSide(
            color: Color(0x37474F45),
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          borderSide: BorderSide(
            color: Color(0x37474F45),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          borderSide: BorderSide(
            color: Color(0x37474F45),
          ),
        ),
        labelText: labelText ?? "",
        labelStyle: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w500,
        ),
        hintText: hintText ?? '',
        hintStyle: const TextStyle(
          color: Color(0x37474F45),
        ),
      ),
    );
  }
}

class AppTextFieldNumber extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextCapitalization? textCapitalization;
  final TextInputAction? textInputAction;
  final bool? obscureText;
  final String? hintText;
  final String? labelText;
  final bool? obscuringCharacter;
  final Function(String)? onChanged;
  final String Function(String?)? validator;
  const AppTextFieldNumber({
    Key? key,
    this.controller,
    this.keyboardType,
    this.textCapitalization,
    this.textInputAction,
    this.obscureText,
    this.hintText,
    this.labelText,
    this.obscuringCharacter,
    this.onChanged,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(
        color: Color(0xA1000000),
        fontFamily: 'Abel',
      ),
      validator: validator,
      onChanged: onChanged,
      obscureText: obscureText ?? false,
      obscuringCharacter: '*',
      textInputAction: textInputAction ?? TextInputAction.next,
      keyboardType: keyboardType ?? TextInputType.emailAddress,
      textCapitalization: textCapitalization ?? TextCapitalization.words,
      decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            borderSide: BorderSide(
              color: Color(0x37474F45),
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0x37474F45),
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0x37474F45),
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          labelText: labelText ?? "",
          labelStyle: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w500,
          ),
          hintText: hintText ?? '',
          hintStyle: const TextStyle(
            color: Color(0x37474F45),
          ),
          isDense: false,
          contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 12),
          prefix: Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Container(
              width: 62,
              height: 28,
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(
                    'assets/image/flage.png',
                    height: 28,
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  const Text(
                    '+1',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const VerticalDivider(
                    color: Color(0x29000000),
                    indent: 2,
                    endIndent: 2,
                    thickness: 1,
                  )
                ],
              ),
            ),
          )),
    );
  }
}
