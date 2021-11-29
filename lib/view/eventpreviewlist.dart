import 'package:crowdate/view/eventpreview.dart';
import 'package:crowdate/viewmodel/eventlist.dart';
import 'package:flutter/material.dart';

// TODO: Implement swipe to refresh.
// TODO: Implement loading more events when end of the list is reached.

class EventPreviewList extends StatelessWidget {
  final EventListViewModel eventsPreview;

  const EventPreviewList({Key? key, required this.eventsPreview})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return eventsPreview.eventsModel.isNotEmpty
        ? ListView.builder(
            itemCount: eventsPreview.eventsModel.length,
            itemBuilder: (BuildContext context, int index) {
              return EventPreview(model: eventsPreview.eventsModel[index]);
            },
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}
