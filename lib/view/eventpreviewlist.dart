import 'package:crowdate/view/eventpreview.dart';
import 'package:crowdate/viewmodel/event.dart';
import 'package:crowdate/viewmodel/eventlist.dart';
import 'package:flutter/material.dart';

class EventPreviewList extends StatelessWidget {
  final EventListViewModel eventsPreview;

  const EventPreviewList({Key? key, required this.eventsPreview})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return eventsPreview.eventsModel.isNotEmpty
        ? NotificationListener<ScrollEndNotification>(
            onNotification: (scrollInfo) {
              if (scrollInfo.metrics.maxScrollExtent ==
                  scrollInfo.metrics.pixels) {
                eventsPreview.fetchRecentEvents(refresh: false);
              }
              return true;
            },
            child: RefreshIndicator(
              onRefresh: () {
                return eventsPreview.fetchRecentEvents(primary: false);
              },
              child: ListView(
                children: [
                  for (EventViewModel item in eventsPreview.eventsModel)
                    EventPreview(model: item),
                  Column(
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      )
                    ],
                  )
                ],
              ),
            ))
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}
