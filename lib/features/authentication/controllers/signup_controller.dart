import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:processed/common/widgets/thank_you.dart';
import 'package:processed/features/dashboard/views/home.dart';
import 'package:processed/navigation_menu.dart';
import 'package:processed/utils/helpers/helper_functions.dart';
import 'package:processed/utils/http/http_client.dart';
import 'package:processed/utils/validators/validators.dart';

class SignUpController extends GetxController {
  static RxString userApiKey = ''.obs;
  static RxString userApiSecret = ''.obs;
  RxBool isLoading = false.obs;

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

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void signUp() async {
    // isLoading.value = true;
    // check validations
    String email = emailController.text;
    String firstName = firstNameController.text;
    String lastName = lastNameController.text;
    String designation = designationController.text;
    String phone = phoneController.text;
    String company = companyController.text;
    String confirmedPassword = confirmPasswordController.text;

    try {
      // setting up contact information

      THttpHelper.setApiKeys(
          THttpHelper.administratorApiKey, THttpHelper.administratorApiSecret);

      await createContact(
          firstName, lastName, phone, email, designation, company);
      await createBusiness(company);
      await createUser(email, confirmedPassword, firstName);
      await generateKeys(email);
      await createUserPermissions(email, company);

      await getApiKey(email);

      // await setPassword(email, confirmedPassword);

      THttpHelper.setApiKeys(SignUpController.userApiKey.value,
          SignUpController.userApiSecret.value);

      // isLoading.value = false;

      await signInWithEmailPassword(email, confirmedPassword);

      // Get.to(NavigationMenu());

      // Get.to(const Home());

      print('Current ApiSecret: ${SignUpController.userApiSecret.value}');
      print('Current ApiKey: ${SignUpController.userApiKey.value}');
    } catch (e) {
      print('Total Error' + e.toString());
    }

    // clear all the fields
  }
}

Future<void> signInWithEmailPassword(String email, String password) async {
  try {
    print('Signing in with email $email');
    print(' with password $password');
    print('Api key using is - ${THttpHelper.apiKey}');
    print('Api secret using is - ${THttpHelper.apiSecret}');
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

      THelperFunctions.showSnackBar(
          'Welcome ${GetStorage().read('user_name')}', Get.context!, true);

      Get.to(
        () => const NavigationMenu(),
      );
    }
  } catch (e) {
    THelperFunctions.showSnackBar(
        'Invalid Credentials or User does not exist !', Get.context!, false);
  }
}

Future<void> setPassword(String email, String confirmedPassword) async {
  try {
    final response = await THttpHelper.put(
        'api/resource/User/$email', {"new_password": confirmedPassword});

    if (response.elementAt(0) == 200) {
      print(response.elementAt(1));

      print('Password Created Successfully !!');
    }
  } catch (e) {
    print('Error Creating password: $e');
  }
}

Future<void> createContact(String firstName, String lastName, String phone,
    String email, String designation, String company) async {
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
      'designation': designation,
      'company_name': company,
      'full_name': '$firstName $lastName',
    });

    if (response.elementAt(0) == 200) {
      print('Contact Created Successfully !!!');
      print(response.elementAt(1));
      print('\n\n\n');
    }
  } catch (e) {
    print('Error Creating Contact : $e');
  }
}

Future<void> createBusiness(String companyName) async {
  try {
    final response = await THttpHelper.post('api/resource/Business', {
      'business_name': companyName,
    });

    if (response.elementAt(0) == 200) {
      print('Business created successfully $response.elementAt(1)');
      print('\n\n\n');
    }
  } catch (e) {
    print('Error Creating Business: $e');
  }
}

Future<void> createUser(
    String email, String confirmedPassword, String firstName) async {
  try {
    final response = await THttpHelper.post('api/resource/User', {
      'email': email,
      'new_password': confirmedPassword,
      "first_name": firstName,
      "role_profile_name": "Quality Head",
      "new_password": confirmedPassword,
    });

    if (response.elementAt(0) == 200) {
      print('User created successfully $response.elementAt(1)');
      print('\n\n\n');
    }
  } catch (e) {
    print('Error Creating User: $e');
  }
}

Future<void> createUserPermissions(String email, String companyName) async {
  try {
    print(email);
    print(companyName);
    final response = await THttpHelper.post('api/resource/User Permission',
        {"user": "$email", "allow": "Business", "for_value": "$companyName"});

    if (response.elementAt(0) == 200) {
      print('User Permissions created successfully $response.elementAt(1)');
      print('\n\n\n');
    }
  } catch (e) {
    print('Error Creating User Permissions: $e');
  }
}

Future<void> generateKeys(String email) async {
  try {
    final response = await THttpHelper.post(
        'api/method/frappe.core.doctype.user.user.generate_keys',
        {"user": email.toString()});

    if (response.elementAt(0) == 200) {
      print('Keys generated successfully');
      print(response.elementAt(1)['message']['api_secret']);

      print('\n\n\n');

      SignUpController.userApiSecret.value =
          response.elementAt(1)['message']['api_secret'];
    }
  } catch (e) {
    print('Error Creating Keys: $e');
  }
}

Future<void> getApiKey(String email) async {
  try {
    final response = await THttpHelper.get(
        'api/resource/User?filters=[["name", "=" , "$email"]]&fields=["*"]');

    if (response.elementAt(0) == 200) {
      final key = response.elementAt(1)['data'][0]['api_key'];

      print(key);
      print('\n\n\n');

      SignUpController.userApiKey.value = key;
    }
  } catch (e) {
    print('Unable to fetch api key: $e');
  }
}
