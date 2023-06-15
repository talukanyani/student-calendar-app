import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/providers/data.dart';
import 'package:sc_app/utils/input_formatter.dart';

class ActivityTitleAutocompleteInput extends ConsumerWidget {
  const ActivityTitleAutocompleteInput({super.key, required this.onChanged});

  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<String> options = <String>[
      'Test',
      'Assignment',
      'Quiz',
      'Presentation',
      'Exam',
      ...ref.watch(allActivitiesProvider).map((activity) {
        return activity.title;
      }),
    ];

    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }

        return options.where((option) {
          return option.toLowerCase().contains(
                textEditingValue.text.toLowerCase(),
              );
        });
      },
      onSelected: (selection) => onChanged(selection),
      optionsViewBuilder: (context, onSelected, options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4,
            color: Theme.of(context).colorScheme.background,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
            child: Container(
              width: (MediaQuery.of(context).size.width - 64),
              constraints: const BoxConstraints(
                maxWidth: 320,
                maxHeight: 160,
              ),
              child: ListView.builder(
                padding: const EdgeInsets.all(0),
                shrinkWrap: true,
                primary: false,
                physics: const BouncingScrollPhysics(),
                itemExtent: 40,
                itemCount: options.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => onSelected(options.elementAt(index)),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        options.elementAt(index),
                        style: const TextStyle(letterSpacing: 1),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
      fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
        return TextField(
          controller: controller,
          focusNode: focusNode,
          onChanged: (value) => onChanged(value.trim()),
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.words,
          maxLength: 30,
          inputFormatters: [
            InputFormatter.noSpaceAtStart(),
            InputFormatter.noDoubleSpace(),
          ],
          style: const TextStyle(letterSpacing: 1),
          decoration: const InputDecoration(
            hintText: 'Activity Title',
            counterText: '',
          ),
        );
      },
    );
  }
}
