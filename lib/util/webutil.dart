import 'dart:convert';

import 'package:crowdate/model/event.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class WebUtil {
  static final String apiKey = dotenv.get("APIKEY");
  static const String _baseUrl = "app.ticketmaster.com";

  static Future<List<EventModel>> fetchEvents(
      {int page = 1,
      String keyword = "",
      String locale = "",
      String sort = "date,asc"}) async {
    DateTime now = DateTime.now();

    String convertedDateTime =
        "${now.year.toString()}-${now.month.toString().padLeft(2, '0')}-${(now.day + 2).toString().padLeft(2, '0')}T00:00:00Z";

    final queryParams = {
      "apikey": apiKey,
      "page": page.toString(),
      "keyword": keyword,
      "locale": locale,
      "sort": sort,
      "startDateTime": convertedDateTime
    };

    queryParams.removeWhere((key, value) => value == "");

    final uri = Uri.https(_baseUrl, "/discovery/v2/events.json", queryParams);

    final response = await http.get(uri);

    final List<dynamic> json = jsonDecode(response.body)["_embedded"]["events"];

    return json.map((e) => EventModel.fromJSON(e)).toList();
  }
}
