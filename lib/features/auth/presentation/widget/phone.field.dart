import 'package:drivn/features/auth/presentation/providers/auth.shared.provider.dart';
import 'package:drivn/shared/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';

class PhoneFormField extends StatelessWidget {
  const PhoneFormField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        padding: const EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          border: Border.all(color: white),
          borderRadius: BorderRadius.circular(10),
        ),
        child: InternationalPhoneNumberInput(
          onInputChanged: (PhoneNumber number) {
            print(number.phoneNumber);
            context.read<AuthSharedProvider>().phoneNumber =
                number.phoneNumber.toString();
          },
          onInputValidated: (bool value) {
            print(value);
          },
          selectorConfig: const SelectorConfig(
            selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
          ),
          ignoreBlank: true,
          autoValidateMode: AutovalidateMode.onUserInteraction,
          selectorTextStyle: const TextStyle(color: white),
          // initialValue: number,
          textFieldController: controller,
          formatInput: true,
          keyboardType: const TextInputType.numberWithOptions(
            signed: true,
            decimal: true,
          ),
          inputBorder: InputBorder.none,
          textStyle: const TextStyle(color: white),
          onSaved: (PhoneNumber number) {
            print('On Saved: $number');
          },
          inputDecoration: const InputDecoration(
            hintStyle: TextStyle(color: white),
            hintText: 'Phone Number',
            border: OutlineInputBorder(borderSide: BorderSide.none),
          ),
          // validator: (p0) => p0 == null||p0.isEmpty ? 'Phone number is required' : null,
        ),
      ),
    );
  }
}
