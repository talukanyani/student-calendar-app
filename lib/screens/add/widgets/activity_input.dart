import 'package:flutter/material.dart';
import 'package:sc_app/screens/add/widgets/label_and_border.dart';

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
    return LabelAndBorderContainer(
      label: 'Activity',
      child: Autocomplete<String>(
        optionsBuilder: (TextEditingValue textEditingValue) {
          return _activityOptions.where((String option) {
            return option
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase());
          });
        },
        fieldViewBuilder:
            (context, textEditingController, focusNode, onFieldSubmitted) {
          return TextField(
            controller: textEditingController,
            focusNode: focusNode,
            keyboardType: TextInputType.text,
            autocorrect: true,
            maxLength: 20,
            textCapitalization: TextCapitalization.words,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Theme.of(context).textTheme.headline5?.color,
            ),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              isDense: true,
              contentPadding: const EdgeInsets.all(8),
              filled: true,
              fillColor: Theme.of(context).backgroundColor,
              counterText: '',
              hintText: 'Activity Name',
              hintStyle: const TextStyle(fontWeight: FontWeight.w400),
            ),
          );
        },
        optionsViewBuilder: (context, onSelected, options) {
          return Material(
            elevation: 2,
            borderRadius: BorderRadius.circular(8),
            child: ListView.separated(
              itemCount: options.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final option = options.elementAt(index);
                return ListTile(
                  title: Text(option),
                  onTap: () => onSelected(option),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
