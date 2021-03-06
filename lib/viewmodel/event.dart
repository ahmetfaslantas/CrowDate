import 'package:crowdate/model/event.dart';

class EventViewModel {
  final EventModel model;

  EventViewModel({required this.model});

  String get id {
    return model.id;
  }

  String get name {
    return model.name;
  }

  String get date {
    return model.date;
  }

  String get imageURL {
    return model.imageURL;
  }

  String get genre {
    return model.genre;
  }

  String get subGenre {
    return model.subGenre;
  }

  String get currency {
    return model.currency;
  }

  double get minPrice {
    return model.minPrice;
  }

  double get maxPrice {
    return model.maxPrice;
  }

  String get address {
    return model.address;
  }

  String get info {
    return model.info;
  }

  int get daysUntil {
    return DateTime.parse(date).difference(DateTime.now()).inDays;
  }
}
