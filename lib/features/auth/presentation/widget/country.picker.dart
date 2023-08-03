import 'package:drivn_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class CodePickerField extends StatelessWidget {
  const CodePickerField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        padding: EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          border: Border.all(color: white),
          borderRadius: BorderRadius.circular(10),
        ),
        child: InternationalPhoneNumberInput(
          onInputChanged: (PhoneNumber number) {
            print(number.phoneNumber);
          },
          onInputValidated: (bool value) {
            print(value);
          },
          selectorConfig: SelectorConfig(
            selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
          ),
          ignoreBlank: false,
          autoValidateMode: AutovalidateMode.onUserInteraction,
          selectorTextStyle: TextStyle(color: white),
          // initialValue: number,
          textFieldController: controller,
          formatInput: true,
          keyboardType: TextInputType.numberWithOptions(
            signed: true,
            decimal: true,
          ),
          inputBorder: InputBorder.none,
          textStyle: TextStyle(color: white),
          onSaved: (PhoneNumber number) {
            print('On Saved: $number');
          },
        ),
      ),
    );
  }
}
