import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:processed/features/authentication/controllers/signup_controller.dart';
import 'package:processed/features/authentication/views/signup/screens/crate_new_password.dart';
import 'package:processed/utils/constants/sizes.dart';
import 'package:processed/utils/constants/text_strings.dart';
import 'package:processed/utils/helpers/helper_functions.dart';
import 'package:processed/utils/validators/validators.dart';

class SignUpForm extends StatelessWidget {
  SignUpForm({
    super.key,
  });

  SignUpController signUpController = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Form(
      key: formKey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  controller: SignUpController.instance.firstNameController,
                  labelText: TTexts.firstName,
                  prefixIcon: Iconsax.user,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter a valid first name';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: TSizes.spaceBtwInputFields),
              Expanded(
                child: CustomTextField(
                  controller: SignUpController.instance.lastNameController,
                  labelText: TTexts.lastName,
                  prefixIcon: Iconsax.user,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter a valid last name';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          CustomTextField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your designation';
              }
              return null;
            },
            controller: SignUpController.instance.designationController,
            labelText: TTexts.designation,
            prefixIcon: Iconsax.user_edit,
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          CustomTextField(
            controller: SignUpController.instance.emailController,
            labelText: TTexts.email,
            prefixIcon: Iconsax.calendar,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your email';
              }
              if (!AppValidations.isValidEmail(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          CustomTextField(
            controller: SignUpController.instance.phoneController,
            labelText: TTexts.phoneNo,
            prefixIcon: Iconsax.mobile,
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your phone number';
              }
              if (!AppValidations.isValidPhoneNumber(value)) {
                return 'Please enter a valid phone number';
              }
              return null;
            },
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          CustomTextField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your company name';
              }
              return null;
            },
            controller: SignUpController.instance.companyController,
            labelText: TTexts.companyName,
            prefixIcon: Iconsax.building,
          ),
          const SizedBox(height: TSizes.spaceBtwSections),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  Get.to(() => CreateNewPassword());
                } else {
                  THelperFunctions.showSnackBar(
                      'Please fill all valid details', context, false);
                }
              },
              child: Text(
                TTexts.next,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData prefixIcon;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.prefixIcon,
    this.keyboardType,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: keyboardType,
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        // focusedErrorBorder: InputBorder.none,
        // errorBorder: InputBorder.none,
        errorStyle: TextStyle(
          fontSize: 10.sp,
        ),
        errorMaxLines: 1,
        labelStyle: TextStyle(fontSize: 12.sp),
        prefixIcon: Icon(prefixIcon),
      ),
    );
  }
}
