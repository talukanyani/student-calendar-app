import 'package:flutter/material.dart';
import 'package:sc_app/widgets/activities_list.dart';

class ActivitiesListBox extends StatelessWidget {
  const ActivitiesListBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      height: 200,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withOpacity(0.8),
        border: Border.all(color: Theme.of(context).dividerColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(
              top: 8,
              left: 8,
              bottom: 4,
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 12,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor.withOpacity(0.4),
              border: Border.all(color: Theme.of(context).dividerColor),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Today',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          const Expanded(child: ActivitiesList()),
        ],
      ),
    );
  }
}
