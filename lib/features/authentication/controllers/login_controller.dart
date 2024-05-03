import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:processed/features/authentication/views/login/screens/login.dart';
import 'package:processed/navigation_menu.dart';
import 'package:processed/utils/helpers/helper_functions.dart';
import 'package:processed/utils/http/http_client.dart';

class AuthController extends GetxController {
  //  instance of AuthController

  RxBool isPasswordVisible = true.obs;
  static AuthController get instance => Get.find();

  // email controller

  final emailController = TextEditingController();

  // password controller

  final passwordController = TextEditingController();

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void loginWithEmailAndPassword(String email, String password) async {
    try {
      // Define the URL for the POST request
      Uri url =
          Uri.parse('https://app.prosessed.com/api/method/prosessed.api.login');

      // Prepare the data to be sent in the POST request
      Map<String, dynamic> postData = {
        'usr': email,
        'pwd': password,
      };

      // Convert the data to JSON format
      String jsonData = jsonEncode(postData);

      // Make the POST request
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonData,
      );

      // Check the status code of the response
      if (response.statusCode == 200) {
        // Successful response
        print('Login  successfully.');
        print('Response body: ${response.body}');

        Map<String, dynamic> responseData = jsonDecode(response.body);

        String apiKey = responseData['message']['api_key'];
        String apiSecret = responseData['message']['api_secret'];
        String username = responseData['message']['username'];
        String email = responseData['message']['email'];

        print('API Key: $apiKey');
        print('API Secret: $apiSecret');
        print('Username: $username');
        print('Email: $email');

        GetStorage().write('apikey', apiKey);
        GetStorage().write('apisecret', apiSecret);
        GetStorage().write('full_name', username);
        GetStorage().write('user_email', email);
        GetStorage().write('isLoggedIn', true);

        THttpHelper.setApiKeys(apiKey, apiSecret);

        THelperFunctions.showSnackBar(
            'Welcome ${GetStorage().read('full_name')}', Get.context!, true);

        Get.to(
          () => const NavigationMenu(),
        );
      } else {
        // Handle other status codes (e.g., 404, 500)
        print('Error posting data. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      // Handle any exceptions that may occur during the request
      print('Error making POST request: $e');
    }
  }

  void logout() async {
    //  post request to logout user from erpnext portal

    try {
      Set response = await THttpHelper.post('api/method/logout', {
        'usr': emailController.text,
        'pwd': passwordController.text,
      });

      if (response.elementAt(1).length == 0) {
        print(response.elementAt(1));

        THelperFunctions.showSnackBar(
            'You have been logged out successfully', Get.context!, true);

        emailController.clear();
        passwordController.clear();

        GetStorage().write('isLoggedIn', false);

        Get.off(() => const LoginScreen());

        update();
      }
    } catch (e) {
      //  show error message
    }
  }
}
