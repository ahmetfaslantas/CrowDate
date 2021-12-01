import 'dart:core';

class EventModel {
  final String id;
  final String name;
  final String date;
  final String imageURL;
  final String genre;
  final String subGenre;
  final String currency;
  final double minPrice;
  final double maxPrice;
  final String address;

  EventModel(
      {required this.id,
      required this.name,
      required this.date,
      required this.imageURL,
      required this.genre,
      required this.subGenre,
      required this.currency,
      required this.minPrice,
      required this.maxPrice,
      required this.address});

  factory EventModel.fromJSON(Map<String, dynamic> json) {
    dynamic image = {
      "url":
          "https://s1.ticketm.net/dam/c/014/8d67fea3-d080-4e72-9094-ecf138a37014_105391_TABLET_LANDSCAPE_16_9.jpg"
    };
    for (var img in json["images"]) {
      if (!img["fallback"] && img["width"] > 640) {
        image = img;
      }
    }

    var venues = json["_embedded"]["venues"][0];

    String address = venues["country"]["name"] + venues["city"]["name"];

    return EventModel(
        id: json["id"],
        name: json["name"],
        date: json["dates"]["start"]["localDate"],
        imageURL: image["url"],
        genre: json["classifications"][0]["genre"]["name"],
        subGenre: json["classifications"][0]["subGenre"]["name"],
        currency: json["priceRanges"][0]["currency"],
        minPrice: json["priceRanges"][0]["min"],
        maxPrice: json["priceRanges"][0]["max"],
        address: address);
  }
}
