import 'package:my_amazon/constants/app_constants.dart';
import 'package:my_amazon/helpers/error_handler.dart';
import 'package:my_amazon/helpers/utils.dart';
import 'package:my_amazon/models/user.dart';
import 'package:http/http.dart' as http;

class AuthService {
  // signup user
  void signUp(
      {required context,
      required email,
      required name,
      required password}) async {
    try {
      User user = User(
          id: '',
          name: name,
          email: email,
          password: password,
          token: '',
          type: '');

      http.Response res = await http.post(
          Uri.parse(AppConstants.baseUrl + AppConstants.signUp),
          body: user.toJson(),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8"
          });

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(
                context, "Account created! Login with same credentials.");
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
