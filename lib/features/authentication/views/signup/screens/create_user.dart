import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:processed/features/authentication/controllers/signup_controller.dart';
import 'package:processed/features/authentication/views/signup/widgets/signup_form.dart';
import 'package:processed/utils/constants/colors.dart';
import 'package:processed/utils/constants/sizes.dart';
import 'package:processed/utils/constants/text_strings.dart';
import 'package:processed/utils/helpers/helper_functions.dart';

class CreateUser extends StatelessWidget {
  const CreateUser({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            width: 48.w,
            height: 48.h,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: TColors.grey)),
            child: Center(
              child: Icon(Iconsax.arrow_left,
                  color: isDark ? TColors.white : TColors.primary),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: TSizes.defaultSpace),
          child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  TTexts.createUserTitle,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        controller:
                            SignUpController.instance.designationController,
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
                        validator:
                            SignUpController.instance.validatePhoneNumber,
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
                              // SignUpController.instance.signUp();
                              Get.to(() => const CreateUser());
                            },
                            child: Text(
                              TTexts.createAccount,
                              style: Theme.of(context).textTheme.headlineSmall,
                            )),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}