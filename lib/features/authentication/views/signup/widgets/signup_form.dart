import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:processed/features/authentication/controllers/signup_controller.dart';
import 'package:processed/utils/constants/sizes.dart';
import 'package:processed/utils/constants/text_strings.dart';
import 'package:processed/utils/helpers/helper_functions.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return Form(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: SignUpController.instance.firstNameController,
                  expands: false,
                  decoration: InputDecoration(
                      labelText: TTexts.firstName,
                      labelStyle: TextStyle(fontSize: 12.sp),
                      prefixIcon: const Icon(Iconsax.user)),
                ),
              ),
              const SizedBox(width: TSizes.spaceBtwInputFields),
              Expanded(
                child: TextFormField(
                  controller: SignUpController.instance.lastNameController,
                  expands: false,
                  decoration: InputDecoration(
                      labelText: TTexts.lastName,
                      labelStyle: TextStyle(fontSize: 12.sp),
                      prefixIcon: const Icon(Iconsax.user)),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          TextFormField(
            controller: SignUpController.instance.designationController,
            decoration: InputDecoration(
                labelText: TTexts.designation,
                labelStyle: TextStyle(fontSize: 12.sp),
                prefixIcon: const Icon(Iconsax.user_edit)),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          TextFormField(
            controller: SignUpController.instance.genderController,
            decoration: InputDecoration(
              labelText: TTexts.gender,
              prefixIcon: const Icon(Iconsax.user_edit),
              labelStyle: TextStyle(fontSize: 12.sp),
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          TextFormField(
            validator: SignUpController.instance.validateEmail,
            controller: SignUpController.instance.emailController,
            decoration: InputDecoration(
                labelStyle: TextStyle(fontSize: 12.sp),
                labelText: TTexts.email,
                prefixIcon: const Icon(Iconsax.calendar)),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          TextFormField(
            keyboardType: TextInputType.phone,
            validator: SignUpController.instance.validatePhoneNumber,
            controller: SignUpController.instance.phoneController,
            decoration: InputDecoration(
                labelStyle: TextStyle(fontSize: 12.sp),
                labelText: TTexts.phoneNo,
                prefixIcon: const Icon(Iconsax.mobile)),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          TextFormField(
            controller: SignUpController.instance.companyController,
            decoration: InputDecoration(
                labelStyle: TextStyle(fontSize: 12.sp),
                labelText: TTexts.companyName,
                prefixIcon: const Icon(Iconsax.building)),
          ),
          const SizedBox(
            height: TSizes.spaceBtwSections,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  SignUpController.instance.signUp();
                },
                child: Text(
                  TTexts.submitDetails,
                  style: Theme.of(context).textTheme.headlineSmall,
                )),
          ),
        ],
      ),
    );
  }
}
