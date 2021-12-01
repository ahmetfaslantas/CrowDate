import 'package:crowdate/util/webutil.dart';
import 'package:crowdate/viewmodel/event.dart';
import 'package:flutter/foundation.dart';

class EventListViewModel extends ChangeNotifier {
  List<EventViewModel> eventsModel = [];
  // TODO: Reset this page variable when another screen is opened.
  int page = 1;

  Future<void> fetchRecentEvents({bool refresh = true}) async {
    if (refresh) {
      eventsModel = [];
      notifyListeners();
    }

    final results = await WebUtil.fetchRecentEvents(page: page);

    if (refresh) {
      eventsModel = results.map((item) => EventViewModel(model: item)).toList();
    } else {
      eventsModel.addAll(results.map((item) => EventViewModel(model: item)).toList());
      page++;
    }

    notifyListeners();
  }
}
