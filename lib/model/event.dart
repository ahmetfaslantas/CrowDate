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
  final String info;

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
      required this.address,
      required this.info});

  // TODO: Find a better solution than this.
  factory EventModel.fromJSON(Map<String, dynamic> json) {
    dynamic image = {
      "url":
          "https://s1.ticketm.net/dam/c/014/8d67fea3-d080-4e72-9094-ecf138a37014_105391_TABLET_LANDSCAPE_16_9.jpg"
    };
    for (Map<String, dynamic> img in json["images"]) {
      if (!img["fallback"] && img["width"] > 640) {
        image = img;
      }
    }

    String address = json.containsKey("place")
        ? json["place"]["country"]["name"] + " " + json["place"]["city"]["name"]
        : "No address provided.";

    return EventModel(
        id: json["id"],
        name: json["name"],
        date: json["dates"]["start"]["localDate"],
        imageURL: image["url"],
        genre: json.containsKey("classifications") &&
                json["classifications"][0]["genre"] != null
            ? json["classifications"][0]["genre"]["name"]
            : "Other",
        subGenre: json.containsKey("classifications") &&
                json["classifications"][0]["subGenre"] != null
            ? json["classifications"][0]["subGenre"]["name"]
            : "Other",
        currency: json.containsKey("priceRanges")
            ? json["priceRanges"][0]["currency"]
            : "USD",
        minPrice:
            json.containsKey("priceRanges") ? json["priceRanges"][0]["min"] : 5,
        maxPrice:
            json.containsKey("priceRanges") ? json["priceRanges"][0]["max"] : 5,
        address: address,
        info: json.containsKey("description")
            ? json["description"]
            : "No description provided.");
  }
}
