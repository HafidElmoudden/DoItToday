import 'dart:convert';

import 'package:do_it_today/models/quote.dart';
import 'package:http/http.dart' as http;

Future<Quote> getRandomQuote() async {
  var response = await http.get(Uri.parse('https://api.quotable.io/random'));
  if(response.statusCode == 200) {
    return Quote.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Error: couldn't fetch a random quote!");
  }
}