import 'package:crowdate/view/eventpreview.dart';
import 'package:crowdate/viewmodel/eventlist.dart';
import 'package:flutter/material.dart';

// TODO: Implement swipe to refresh.
// TODO: Add loading icon at the end of page when more events are loading.

class EventPreviewList extends StatelessWidget {
  final EventListViewModel eventsPreview;

  const EventPreviewList({Key? key, required this.eventsPreview})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return eventsPreview.eventsModel.isNotEmpty
        ? NotificationListener<ScrollEndNotification>(
          onNotification: (scrollInfo) {
            if (scrollInfo.metrics.maxScrollExtent == scrollInfo.metrics.pixels) {
              eventsPreview.fetchRecentEvents(refresh: false);
            }
            return true;
          },
          child: ListView.builder(
              itemCount: eventsPreview.eventsModel.length,
              itemBuilder: (BuildContext context, int index) {
                return EventPreview(model: eventsPreview.eventsModel[index]);
              },
            ),
        )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}
