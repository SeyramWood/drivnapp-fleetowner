// ignore: must_be_immutable
import 'package:drivn/shared/utils/constants/colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FormWithOption extends StatefulWidget {
  FormWithOption({
    super.key,
    required this.controller,
    required this.labelText,
    required this.onSelected,
    required this.customOptionsBuilder,
  });
  TextEditingController controller;
  String labelText;
  void Function(String) onSelected;
  final CustomOptionsBuilder<String> customOptionsBuilder;

  @override
  State<FormWithOption> createState() => _FormWithOptionState();
}

typedef CustomOptionsBuilder<T> = Future<List<T>> Function(
    String textEditingValue);

class _FormWithOptionState extends State<FormWithOption> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.labelText),
        Autocomplete<String>(
          onSelected: (selectedOption) {
            widget.onSelected(selectedOption);
          },
          optionsBuilder: (textEditingValue) {
            if (textEditingValue.text.isEmpty) {
              return const Iterable.empty();
            }
            return widget.customOptionsBuilder(textEditingValue.text);
          },
          fieldViewBuilder:
              (context, textEditingController, focusNode, onFieldSubmitted) {
            return TextFormField(
              textCapitalization: TextCapitalization.sentences,
              controller: widget.controller = textEditingController,
              focusNode: focusNode,
              onEditingComplete: onFieldSubmitted,
              onTapOutside: (event) {
                const PointerDownEvent(obscured: true);
              },
              onFieldSubmitted: (value) {
                // widget.controller.clear();
              },
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: yellow),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: yellow),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: yellow),
                ),
                // hintText: "Search Something",
              ),
              onChanged: (value) {
                // widget.controller.text = value;
              },
              onSaved: (newValue) {
                // textEditingController.clear();
              },
            );
          },
        ),
      ],
    );
  }
}
