import 'package:crowdate/util/webutil.dart';
import 'package:crowdate/viewmodel/event.dart';
import 'package:flutter/foundation.dart';

class EventListViewModel extends ChangeNotifier {
  List<EventViewModel> eventsModel = [];
  int page = 1;

  Future<void> fetchEvents(
      {bool refresh = true,
      bool primary = true,
      String keyword = "",
      String locale = "",
      String sort = "date,asc",
      List<String> genreList = const []}) async {
    if (refresh) {
      eventsModel = [];
      page = 1;
      if (primary) notifyListeners();
    }

    final results = await WebUtil.fetchEvents(
        page: page, keyword: keyword, locale: locale, sort: sort, genreList: genreList);

    if (refresh) {
      eventsModel = results.map((item) => EventViewModel(model: item)).toList();
    } else {
      eventsModel
          .addAll(results.map((item) => EventViewModel(model: item)).toList());
      page++;
    }

    notifyListeners();
  }

  void clear() {
    eventsModel = [];
    page = 1;
    notifyListeners();
  }
}
