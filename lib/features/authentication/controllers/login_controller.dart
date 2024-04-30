import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:processed/features/authentication/views/login/screens/login.dart';
import 'package:processed/features/dashboard/views/home.dart';
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

  Future<void> getApiKey(String email) async {
    try {
      THttpHelper.setApiKeys(
          THttpHelper.administratorApiKey, THttpHelper.administratorApiSecret);
      final response = await THttpHelper.get(
          'api/resource/User?filters=[["name", "=" , "$email"]]&fields=["*"]');

      if (response.elementAt(0) == 200) {
        final api_key = response.elementAt(1)['data'][0]['api_key'];
        final api_secret = response.elementAt(1)['data'][0]['api_secret'];

        print('Api Key of logged in user is : $api_key ');
        print('Api Secret of logged in user is : $api_secret ');

        THttpHelper.setApiKeys(api_key, api_secret);
      }
    } catch (e) {
      print('Unable to fetch api key: $e');
    }
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
        print('Data posted successfully.');
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

  // void loginWithEmailAndPassword(String email, String password) async {
  //   //  post request to login user into erpnext portal

  //   await getApiKey(email);

  //   print(THttpHelper.apiKey);
  //   print(email);

  //   print(THttpHelper.apiSecret);
  //   print(password);

  //   try {
  //     Set response = await THttpHelper.post('api/method/prosessed.api.login', {
  //       'usr': email,
  //       'pwd': password,
  //     });

  //     if (response.elementAt(0) == 200) {
  //       print(response.elementAt(1));

  //       final String userName = response.elementAt(1)['full_name'];

  //       print(userName);
  //       print(email);

  //       final String storedUserName = GetStorage().read(
  //             'user_name',
  //           ) ??
  //           '';
  //       final String storedUserEmail = GetStorage().read('user_email') ?? '';

  //       if (storedUserEmail != email || storedUserName != userName) {
  //         // Update values if they differ
  //         GetStorage().write('user_name', userName);
  //         GetStorage().write('user_email', email);
  //         GetStorage().write('isLoggedIn', true);
  //       }

  //       THelperFunctions.showSnackBar(
  //         'Welcome ${GetStorage().read('user_name')}',
  //         Get.context!,
  //       );

  //       Get.to(
  //         () => const NavigationMenu(),
  //       );
  //     }
  //   } catch (e) {
  //     THelperFunctions.showSnackBar(
  //       'Invalid Credentials or User does not exist!',
  //       Get.context!,
  //     );
  //   }
  // }

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
