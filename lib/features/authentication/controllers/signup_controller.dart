import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:processed/common/widgets/thank_you.dart';
import 'package:processed/utils/helpers/helper_functions.dart';
import 'package:processed/utils/http/http_client.dart';

class SignUpController extends GetxController {
  @override
  void onClose() {
    // clear all controllers
    emailController.clear();
    firstNameController.clear();
    lastNameController.clear();
    designationController.clear();
    phoneController.clear();
    companyController.clear();
    genderController.clear();

    // TODO: implement onClose
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
  final genderController = TextEditingController();

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required.';
    }

    // Regular expression for email validation
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value)) {
      return 'Invalid email address.';
    }

    return null;
  }

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required.';
    }

    // Regular expression for phone number validation
    final phoneRegExp =
        RegExp(r'^[0-9]{10}$'); // Assuming 10-digit phone number

    if (!phoneRegExp.hasMatch(value)) {
      return 'Invalid phone number.';
    }

    return null;
  }

  void signUp() async {
    // check validations
    String email = emailController.text;
    String firstName = firstNameController.text;
    String lastName = lastNameController.text;
    String designation = designationController.text;
    String phone = phoneController.text;
    String company = companyController.text;
    String gender = genderController.text;

    if (email.isEmpty ||
        firstName.isEmpty ||
        lastName.isEmpty ||
        designation.isEmpty ||
        phone.isEmpty ||
        company.isEmpty) {
      THelperFunctions.showSnackBar(
          'Please fill all the details !', '', Colors.red);
      return;
    }

    try {
      final response = await THttpHelper.post('api/resource/Contact', {
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
        'gender': gender,
        'designation': designation,
        'company_name': company,
        'full_name': '$firstName $lastName',
      });

      print(response.elementAt(0));
      print(response.elementAt(1));

      if (response.elementAt(0) == 200) {
        print(response.elementAt(1));

        Get.to(() => const ThankyouScreen(
              title: 'Thank you for submitting your details',
              message:
                  'Your Details has been submitted successfully \n Our team will get back to you shortly ! ',
            ));
        // reset values
        emailController.clear();
        firstNameController.clear();
        lastNameController.clear();
        designationController.clear();
        phoneController.clear();
        companyController.clear();
      } else {
        // print()
        THelperFunctions.showSnackBar(
            'Oops!', 'There is something wrong !', Colors.red);
      }
    } catch (e) {
      // send to login screen again if mail is sent successfully
      THelperFunctions.showSnackBar(
          'Oops!', 'There is something wrong ! ${e.toString()}', Colors.green);
      // Get.offAll(const LoginScreen());
    }

    // clear all the fields
  }
}



// final Email sendEmail = Email(
//       body: '''

// Hi Team Processed,

// I hope this email finds you well. I am reaching out to express my interest in setting up an account with Processed. Our company, ${companyController.text}, is keen on utilizing your services to streamline our operations.

// Below are the details required for the account setup:

// First Name: ${firstNameController.text}
// Last Name: ${lastNameController.text}
// Email: ${emailController.text}
// Company Name: ${companyController.text}
// Phone: ${phoneController.text}

// We believe that Processed's solutions align perfectly with our needs, and we are eager to begin leveraging your platform. Please let us know the next steps to proceed with the account setup process.
// Looking forward to your prompt response and beginning this partnership.

// Thank you for your attention to this matter.

// Best regards,
// ${firstNameController.text} ${lastNameController.text}


//   ''',
//       subject: 'Account Setup Process with Prosessed.com',
//       recipients: ['care@prosessed.com'],
//       // cc: ['cc@example.com'],
//       // attachmentPaths: ['/path/to/attachment.zip'],
//       isHTML: false,
//     );

//     await FlutterEmailSender.send(sendEmail);

//     // send to login screen again if mail is sent successfully
//     THelperFunctions.showSnackBar(
//         'Success', 'Mail Sent Successfully', Colors.green);
//     Get.offAll(const LoginScreen());