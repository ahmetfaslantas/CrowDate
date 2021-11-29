import 'package:crowdate/util/webutil.dart';
import 'package:crowdate/viewmodel/event.dart';
import 'package:flutter/foundation.dart';

class EventListViewModel extends ChangeNotifier {
  List<EventViewModel> eventsModel = [];

  Future<void> fetchRecentEvents() async {
    eventsModel = [];
    notifyListeners();

    final results = await WebUtil.fetchRecentEvents();

    eventsModel = results.map((item) => EventViewModel(model: item)).toList();

    notifyListeners();
  }
}
