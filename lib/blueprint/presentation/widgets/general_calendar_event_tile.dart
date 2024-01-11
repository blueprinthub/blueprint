import 'package:blueprint_repository/blueprint_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GeneralCalendarEventTile extends StatelessWidget {
  const GeneralCalendarEventTile({
    required this.appointment,
    required this.isSmallVersion,
    super.key,
    this.showDeleteButton = true,
    this.color,
  });
  final GeneralCalendarEvent appointment;

  final bool showDeleteButton;
  final bool isSmallVersion;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    final backgroundColor = color ?? Theme.of(context).colorScheme.secondary;
    final foregroundColor =
        backgroundColor.computeLuminance() > 0.5 ? Colors.black : Colors.white;

    if (isSmallVersion) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(4)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Flexible(
                child: Text(
                  appointment.subject,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: foregroundColor,
                      ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Flexible(
                child: Text(
                  '${DateFormat('hh:mm a').format(appointment.startTime)} - '
                  '${DateFormat('hh:mm a').format(appointment.endTime)}',
                  textAlign: TextAlign.left,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: foregroundColor,
                      ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(4)),
      ),
      child: ListTile(
        isThreeLine: true,
        leading: CircleAvatar(
          backgroundColor:
              Theme.of(context).colorScheme.onSecondary.withOpacity(0.3),
          child: Icon(
            switch (appointment
                .event.conferenceData?.entryPoints.first.entryPointType) {
              'video' => Icons.video_call,
              'phone' => Icons.phone,
              'sip' => Icons.phone,
              null || _ => Icons.event,
            },
          ),
        ),
        title: Text(
          appointment.subject,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: foregroundColor,
              ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showDeleteButton)
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.delete,
                  color: foregroundColor,
                ),
              ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${DateFormat('hh:mm a').format(appointment.startTime)} - '
              '${DateFormat('hh:mm a').format(appointment.endTime)}',
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: foregroundColor,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
