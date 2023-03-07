import 'dart:convert';
import 'package:http/http.dart' as http;

class GroceryAPI {
  static Future<String> fetchPrice(http.Client client, String itemID) async {
    var url = Uri.parse(
      'https://api.bls.gov/publicAPI/v1/timeseries/data/APU0000${itemID}',
    );
    final response = await client.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      return jsonData['Results']['series'][0]['data'][1]['value'];
    } else {
      throw Exception('Failed to load current price');
    }
  }
}
