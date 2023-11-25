import 'package:http/http.dart' as http;
import 'dart:convert';

const kWeatherAPIKey = '47ad1c13b90d32287f11fede62c59870';


class NetworkHelper {
  NetworkHelper(this.url);

  final String url;

  Future getData() async {
    // print('Getting data in NetworkHelper');
    Uri urlFromString = Uri.parse(url);
    http.Response response = await http.get(urlFromString);

    if(response.statusCode == 200) {
      // print('All OK to proceed. Response: ${response.body}');

      String jsonSource = response.body;

      return jsonDecode(jsonSource);
    }
    else {
      print('Error condition from get data ${response.statusCode} ${response.reasonPhrase}');
      return null;
    }
  }
}