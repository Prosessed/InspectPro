import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
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
    //  post request to login user into erpnext portal

    await getApiKey(email);

    print(THttpHelper.apiKey);
    print(email);

    print(THttpHelper.apiSecret);
    print(password);

    if (email.isEmpty || password.isEmpty) {
      THelperFunctions.showSnackBar(
          'Email or Password cannot be empty', '', Colors.red);
      return;
    }

    try {
      Set response = await THttpHelper.post('api/method/login', {
        'usr': email,
        'pwd': password,
      });

      if (response.elementAt(0) == 200) {
        print(response.elementAt(1));

        final String userName = response.elementAt(1)['full_name'];

        print(userName);
        print(email);

        final String storedUserName = GetStorage().read(
              'user_name',
            ) ??
            '';
        final String storedUserEmail = GetStorage().read('user_email') ?? '';

        if (storedUserEmail != email || storedUserName != userName) {
          // Update values if they differ
          GetStorage().write('user_name', userName);
          GetStorage().write('user_email', email);
          GetStorage().write('isLoggedIn', true);
        }

        THelperFunctions.showSnackBar('Successfully Logged In ',
            'Welcome ${GetStorage().read('user_name')}', Colors.green);

        Get.to(
          () => const NavigationMenu(),
        );
      }
    } catch (e) {
      THelperFunctions.showSnackBar(
          'Invalid Credentials or User does not exist !', '', Colors.red);
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

        THelperFunctions.showSnackBar('Successfully Logged Out ',
            'You have been logged out successfully', Colors.green);

        emailController.clear();
        passwordController.clear();

        GetStorage().write('isLoggedIn', false);

        Get.off(() => const LoginScreen());

        update();
      }
    } catch (e) {
      //  show error message

      THelperFunctions.showSnackBar('Error', 'An error occured', Colors.red);
    }
  }
}
