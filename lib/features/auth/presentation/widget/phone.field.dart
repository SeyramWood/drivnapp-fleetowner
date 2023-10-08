import 'package:drivn/features/auth/presentation/providers/auth.shared.provider.dart';
import 'package:drivn/shared/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';

class PhoneFormField extends StatefulWidget {
  const PhoneFormField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  State<PhoneFormField> createState() => _PhoneFormFieldState();
}

class _PhoneFormFieldState extends State<PhoneFormField> {
  PhoneNumber number = PhoneNumber(isoCode: 'GH');
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Telephone', style: TextStyle(color: yellow)),
          Container(
            padding: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              border: Border.all(color: white),
              borderRadius: BorderRadius.circular(10),
            ),
            child: InternationalPhoneNumberInput(
              onInputChanged: (PhoneNumber number) {
                context.read<AuthSharedProvider>().phoneNumber =
                    number.phoneNumber.toString();
              },
              spaceBetweenSelectorAndTextField: 5,
              onInputValidated: (bool value) {},
              selectorConfig: const SelectorConfig(
                setSelectorButtonAsPrefixIcon: true,
                trailingSpace: false,
                selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
              ),
              cursorColor: white,
              ignoreBlank: true,
              initialValue: number,
              autoValidateMode: AutovalidateMode.disabled,
              selectorTextStyle: const TextStyle(
                color: white,
                fontSize: 17,
                fontWeight: FontWeight.w400,
              ),
              textFieldController: widget.controller,
              formatInput: true,
              keyboardAction: TextInputAction.next,
              keyboardType: const TextInputType.numberWithOptions(
                signed: true,
                decimal: false,
              ),
              inputDecoration: const InputDecoration(
                  border: UnderlineInputBorder(borderSide: BorderSide.none),
                  focusedErrorBorder:
                      UnderlineInputBorder(borderSide: BorderSide.none),
                  errorBorder:
                      UnderlineInputBorder(borderSide: BorderSide.none)),
              textStyle: const TextStyle(
                  color: white, fontSize: 17, fontWeight: FontWeight.w500),
              onSaved: (PhoneNumber number) {},
              validator: (p0) =>
                  p0 == null || p0.isEmpty ? 'Phone number is required' : null,
            ),
          ),
        ],
      ),
    );
  }
}
