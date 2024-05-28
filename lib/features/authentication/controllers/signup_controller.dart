import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:processed/features/authentication/views/login/screens/login.dart';
import 'package:processed/utils/helpers/helper_functions.dart';
import 'package:processed/utils/http/http_client.dart';
import 'package:http/http.dart' as http;

class SignUpController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isPasswordVisible = false.obs;
  RxBool isConfirmPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  @override
  void onClose() {
    // clear all controllers
    emailController.clear();
    firstNameController.clear();
    lastNameController.clear();
    designationController.clear();
    phoneController.clear();
    companyController.clear();

    super.onClose();
  }

  // create an instance using get.find
  static SignUpController get instance => Get.find();

  final emailController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final designationController = TextEditingController();
  final phoneController = TextEditingController();
  final companyController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void signUp() async {
    isLoading.value = true;
    String email = emailController.text;
    String firstName = firstNameController.text;
    String lastName = lastNameController.text;
    String designation = designationController.text;
    String phone = phoneController.text;
    String company = companyController.text;
    String confirmedPassword = confirmPasswordController.text;

    try {
      if (passwordController.text != confirmPasswordController.text) {
        THelperFunctions.showSnackBar(
            'Passwords don\'t match!', Get.context!, false);
        return;
      }

      await createUser(email, confirmedPassword, firstName);

      await createContact(
          firstName, lastName, phone, email, designation, company);
      await createBusiness(company);
      await createUserPermissions(email, company);

      emailController.clear();
      firstNameController.clear();
      lastNameController.clear();
      designationController.clear();
      phoneController.clear();
      companyController.clear();
      passwordController.clear();
      confirmPasswordController.clear();

      isLoading.value = false;

      Get.to(() => const LoginScreen());

      THelperFunctions.showSnackBar(
          'Account created successfully!', Get.context!, true);
    } catch (e) {
      print('Total Error$e');
    }
  }
}

Future<void> createContact(String firstName, String lastName, String phone,
    String email, String designation, String company) async {
  try {
    // Define the URL for the POST request
    Uri url = Uri.parse('https://app.prosessed.com/api/resource/Contact');

    // Prepare the data to be sent in the POST request
    Map<String, dynamic> postData = {
      'first_name': firstName,
      'last_name': lastName,
      'phone_nos': [
        {
          'phone': phone,
        }
      ],
      'email_ids': [
        {
          'email_id': email,
        }
      ],
      'designation': designation,
      'company_name': company,
      'full_name': '$firstName $lastName',
    };

    // Convert the data to JSON format
    String jsonData = jsonEncode(postData);

    // Make the POST request
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':
            'token ${THttpHelper.administratorApiKey}:${THttpHelper.administratorApiSecret}'
      },
      body: jsonData,
    );

    // Check the status code of the response
    if (response.statusCode == 200) {
      // Successful response
      print('Contact Created successfully.');
      print('Response body: ${response.body}');
    } else {
      // Handle other status codes (e.g., 404, 500)
      print('Error Creating Contact. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  } catch (e) {
    // Handle any exceptions that may occur during the request
    print('Error making POST request: $e');
  }
}

Future<void> createBusiness(String companyName) async {
  try {
    // Define the URL for the POST request
    Uri url = Uri.parse('https://app.prosessed.com/api/resource/Business');

    // Prepare the data to be sent in the POST request
    Map<String, dynamic> postData = {
      'business_name': companyName,
    };

    // Convert the data to JSON format
    String jsonData = jsonEncode(postData);

    // Make the POST request
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':
            'token ${THttpHelper.administratorApiKey}:${THttpHelper.administratorApiSecret}'
      },
      body: jsonData,
    );

    // Check the status code of the response
    if (response.statusCode == 200) {
      // Successful response
      print('Business Created successfully.');
      print('Response body: ${response.body}');
    } else {
      // Handle other status codes (e.g., 404, 500)
      print('Error Creating Business. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  } catch (e) {
    // Handle any exceptions that may occur during the request
    print('Error making POST request: $e');
  }
}

Future<void> createUser(
  String email,
  String confirmedPassword,
  String firstName,
) async {
  try {
    // Define the URL for the POST request
    Uri url =
        Uri.parse('https://app.prosessed.com/api/method/prosessed.api.signup');

    // Prepare the data to be sent in the POST request
    Map<String, dynamic> postData = {
      "email": email,
      "password": confirmedPassword,
      "first_name": firstName,
      // "role_profile_name": "Quality Head",
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
      print('User Created successfully.');
      print('Response body: ${response.body}');
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

Future<void> createUserPermissions(
  String email,
  String companyName,
) async {
  try {
    // Define the URL for the POST request
    Uri url =
        Uri.parse('https://app.prosessed.com/api/resource/User Permission');

    // Prepare the data to be sent in the POST request
    Map<String, dynamic> postData = {
      "user": email,
      "allow": "Business",
      "for_value": companyName
    };

    // Convert the data to JSON format
    String jsonData = jsonEncode(postData);

    // Make the POST request
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':
            'token ${THttpHelper.administratorApiKey}:${THttpHelper.administratorApiSecret}'
      },
      body: jsonData,
    );

    // Check the status code of the response
    if (response.statusCode == 200) {
      // Successful response
      print('User Permission Created successfully.');
      print('Response body: ${response.body}');

      Get.to(
        () => const LoginScreen(),
      );
    } else {
      // Handle other status codes (e.g., 404, 500)
      print(
          'Error Creating User Permission data. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  } catch (e) {
    // Handle any exceptions that may occur during the request
    print('Error making POST request: $e');
  }
}
