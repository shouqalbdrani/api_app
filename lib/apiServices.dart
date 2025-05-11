import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<List<String>> fetchCities(String country) async {
    const url = 'https://countriesnow.space/api/v0.1/countries/cities';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"country": country}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['error'] == false) {
          return List<String>.from(data['data']);
        } else {
          throw Exception("API error: ${data['msg']}");
        }
      } else {
        throw Exception("Failed to load cities (Status: ${response.statusCode})");
      }
    } catch (e) {
      throw Exception("Error fetching cities: $e");
    }
  }
}
