//@dart=2.9
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/login_model.dart';

class APIService {
  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
    final url = "https://javestore.000webhostapp.com/jave/queryDB.php";
    final response = await http.post(Uri.parse(url), body: {
      "query":
          "select id as token from Cuenta c where c.email='${requestModel.email}' and c.password='${requestModel.password}';"
    });
    LoginResponseModel rt = LoginResponseModelFromJson(response.body)[0];
    print(rt.token);
    return rt;
  }
}
