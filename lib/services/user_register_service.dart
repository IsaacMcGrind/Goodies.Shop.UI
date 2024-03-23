import 'package:http/http.dart' as http;
import 'package:unamed_yet/models/user_account.dart';

const String baseUri = "https://localhost:7048";
String? api = "", username = "";

class UserRemoteService {
  var client = http.Client();
  UserAccount userAccountResponse = UserAccount();


  Future<dynamic> userRegister(dynamic object) async {
    var headers = {'Content-Type': 'application/json'};
    var api = "/api/Employee";
    var url = Uri.parse(baseUri + api);

    var payload = userAccountToJson(object);

    var response = await http.post(url, headers: headers, body: payload);

    if (response.statusCode == 201) {
      return userAccountFromJson(response.body);
    } else {
      throw Exception('Failed to register: ${response.statusCode}');
    }
  }

  Future<dynamic> userList() async {
    var headers = {'Content-Type': 'application/json'};
    var api = "/api/Employee";
    var url = Uri.parse(baseUri + api);

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      return userAccountListFromJson(response.body);
    } else {
      throw Exception('Failed to register: ${response.statusCode}');
    }
  }
}