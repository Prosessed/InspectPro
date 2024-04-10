import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:processed/utils/http/http_client.dart';

class ResetPasswordController extends GetxController {
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
      final response = await THttpHelper.put(
          'api/resource/User/${resetPasswordEmail.text}',
          {"new_password": confirmPasswordController.text});

      if (response.elementAt(0) == 200) {
        print(response.elementAt(1));

        print('Password Reset Successfully !!');
      }
    } catch (e) {
      print('Error Creating password: $e');
    }
  }
}
