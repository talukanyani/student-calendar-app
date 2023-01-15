import 'package:flutter/material.dart';

class ActivityInput extends StatelessWidget {
  const ActivityInput({super.key});

  static const List<String> _activityOptions = <String>[
    'Test',
    'Assignment',
    'Quiz',
    'Presantation',
  ];

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        return _activityOptions.where((String option) {
          return option
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        });
      },
      optionsViewBuilder: (context, onSelected, options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4,
            color: Theme.of(context).backgroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width - 64,
              constraints: const BoxConstraints(
                maxWidth: 240,
                maxHeight: 120,
              ),
              child: ListView.builder(
                padding: const EdgeInsets.all(0),
                shrinkWrap: true,
                primary: false,
                physics: const BouncingScrollPhysics(),
                itemExtent: 40,
                itemCount: options.length,
                itemBuilder: (context, index) {
                  final option = options.elementAt(index);
                  return InkWell(
                    onTap: () => onSelected(option),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        option,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
      fieldViewBuilder:
          (context, textEditingController, focusNode, onFieldSubmitted) {
        return TextField(
          controller: textEditingController,
          focusNode: focusNode,
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.words,
          maxLength: 30,
          style: const TextStyle(fontSize: 20),
          decoration: const InputDecoration(
            hintText: 'Activity Name',
            counterText: '',
          ),
        );
      },
    );
  }
}
