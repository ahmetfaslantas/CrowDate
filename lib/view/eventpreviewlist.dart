import 'package:crowdate/view/eventpreview.dart';
import 'package:crowdate/viewmodel/event.dart';
import 'package:crowdate/viewmodel/eventlist.dart';
import 'package:flutter/material.dart';

class EventPreviewList extends StatelessWidget {
  final EventListViewModel eventsPreview;
  final bool expandable;

  const EventPreviewList({Key? key, required this.eventsPreview, required this.expandable})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return eventsPreview.eventsModel.isNotEmpty ||
            !eventsPreview.resultsAvailable
        ? NotificationListener<ScrollEndNotification>(
            onNotification: (scrollInfo) {
              if (scrollInfo.metrics.maxScrollExtent ==
                  scrollInfo.metrics.pixels && expandable) {
                eventsPreview.fetchEvents(refresh: false);
              }
              return true;
            },
            child: RefreshIndicator(
              onRefresh: () {
                return eventsPreview.fetchEvents(primary: false);
              },
              child: eventsPreview.resultsAvailable
                  ? ListView(
                      children: [
                        for (EventViewModel item in eventsPreview.eventsModel)
                          EventPreview(model: item),
                        expandable ? Column(
                          children: const [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(),
                            )
                          ],
                        ) : Container()
                      ],
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.event_busy_rounded,
                            size: 100,
                            color: Colors.black54,
                          ),
                          Text(
                            "No Events Found!",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                                fontSize: 30),
                          )
                        ],
                      ),
                    ),
            ))
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}
