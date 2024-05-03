import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:processed/features/authentication/views/login/screens/login.dart';
import 'package:processed/utils/helpers/helper_functions.dart';
import 'package:processed/utils/http/http_client.dart';
import 'package:http/http.dart' as http;

class ResetPasswordController extends GetxController {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    resetPasswordEmail.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
  }

  RxString newPassword = ''.obs;
  RxString confirmPassword = ''.obs;
  RxBool isPasswordVisible = true.obs;
  RxBool isConfirmPasswordVisible = true.obs;

  TextEditingController resetPasswordEmail = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  Future<void> resetPassword() async {
    try {
      final response = await http.get(Uri.parse(
          'https://app.prosessed.com/api/method/frappe.core.doctype.user.user.reset_password?user=${resetPasswordEmail.text}'));

      if (response.statusCode == 200) {
        print(response.body);

        print('Instructions Sent Successfully !!');
      }
    } catch (e) {
      print('Error Creating password: $e');
    }
  }
}
