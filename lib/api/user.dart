import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:m_admin/models/user.dart';

class ApiUser {
  List<UserModel> users = [];

  initializeEndPoint(middlware, endpoint) async {
    // final url = "https://masuline-grkb.onrender.com/$middlware/$endpoint";
    final url =
        "https://drab-puce-peacock-gear.cyclic.app/$middlware/$endpoint";
    // final url = "http://192.168.100.40:3000/$middlware/$endpoint";
    return url;
  }

  getAdmin(telephoneuser) async {
    print('___FROM_API___GET__ADMIN__$telephoneuser');
    const middleware = "api/user";
    var endpoint = "admin?telephoneuser=${telephoneuser.toString()}";
    String apiUrl = await initializeEndPoint(middleware, endpoint);

    var response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      print('___RESPONSE___${jsonData}');
      return jsonData;
    } else {
      print('[-]___ERROR___${response.statusCode}');
    }
  }

  getAll() async {
    print('___FROM_API___GET__ADMIN__');
    const middleware = "api/user";
    var endpoint = "all";
    String apiUrl = await initializeEndPoint(middleware, endpoint);

    var response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      print('___RESPONSE___${jsonData}');
      users = (jsonData as List<dynamic>)
          .map((json) => UserModel.fromJson(json))
          .toList();
      return users;
    } else {
      print('[-]___ERROR___${response.statusCode}');
    }
  }
}
