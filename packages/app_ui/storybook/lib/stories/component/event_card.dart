import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:storybook/src/component.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class EventCardComponent extends StatelessWidget {
  const EventCardComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Component(
      title: 'Event Card',
      child: EventCard(
          title: EventListTile.videoConference(
            title: context.knobs.text(label: 'Title', initial: 'Event Title'),
            subtitle: context.knobs.text(
              label: 'Subtitle',
              initial: 'Event Subtitle',
            ),
          ),
          labels: [
            Label(
              text: context.knobs.text(
                label: 'Label',
                initial: 'Label',
              ),
              avatar: Image.network(
                context.knobs.text(
                  label: 'Avatar url',
                  initial:
                      'https://cdn-icons-png.flaticon.com/512/25/25231.png',
                ),
              ),
            ),
            Label(
              text: context.knobs.text(label: 'Label', initial: 'Label'),
            ),
          ],
          dateAndTime: context.knobs.text(
            label: 'Date and Time',
            initial: 'Date and Time',
          )),
    );
  }
}
