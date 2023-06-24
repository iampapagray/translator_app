import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class NetworkHandler {
  var client = http.Client();
  var baseUrl = 'text-translator2.p.rapidapi.com';

  Future get(String endpoint) async {
    var url = Uri.https(baseUrl, endpoint);
    var response = await client.get(
      url,
      headers: {
        'X-RapidAPI-Key': '7164c53697mshfb67db9f044fa6bp1e4920jsn205969543cb3',
        'X-RapidAPI-Host': 'text-translator2.p.rapidapi.com'
      },
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      showSnack('Error', 'Error fetching languages');
      return 'Error';
    }
  }

  void showSnack(String msg, String title) {
    Get.snackbar(title, msg);
  }
}
