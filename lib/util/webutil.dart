import 'dart:convert';

import 'package:crowdate/model/event.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class WebUtil {
  static final String apiKey = dotenv.get("APIKEY");
  static const String _baseUrl = "app.ticketmaster.com";

  static Future<List<EventModel>> fetchRecentEvents({int page = 1}) async {
    final queryParams = {
      "apikey": apiKey,
      "page": page.toString()
    };

    final uri = Uri.https(_baseUrl, "/discovery/v2/events.json", queryParams);

    final response = await http.get(uri);

    final List<dynamic> json = jsonDecode(response.body)["_embedded"]["events"];

    return json.map((e) => EventModel.fromJSON(e)).toList();
  }
}