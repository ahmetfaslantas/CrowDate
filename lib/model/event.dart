import 'dart:core';

class EventModel {
  final String id;
  final String name;
  final String date;
  final String imageURL;
  final String genre;
  final String subGenre;
  final String currency;
  final int minPrice;
  final int maxPrice;
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
    var image;
    for (var img in json["images"]) {
      if (!img["fallback"] && img["width"] > 640) {
        image = img;
      }
    }

    var venues = json["_embedded"]["venues"][0];

    String address = venues["country"] + venues["city"];

    return EventModel(
        id: json["id"],
        name: json["name"],
        date: json["dates"]["start"]["localDate"],
        imageURL: image["url"],
        genre: json["classifications"]["genre"],
        subGenre: json["classifications"]["subgenre"],
        currency: json["priceRanges"]["currency"],
        minPrice: json["priceRanges"]["min"],
        maxPrice: json["priceRanges"]["max"],
        address: address);
  }
}
