import 'package:http/http.dart';

import '../model/model.dart';

class RemoteService {
  RemoteService();

  Future fetchRestaurantData() async {
    var uri = Uri.parse('https://www.mocky.io/v2/5dfccffc310000efc8d2c1ad');

    final response = await get(uri);

    if (response.statusCode == 200) {
      var json = response.body;

      return modelFromJson(json);
    } else {
      throw Exception('Failed to load');
    }
  }
}
