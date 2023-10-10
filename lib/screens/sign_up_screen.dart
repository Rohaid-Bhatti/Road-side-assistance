import 'package:country_calling_code_picker/country.dart';
import 'package:country_calling_code_picker/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:home_hub/const/firebase_const.dart';
import 'package:home_hub/controllers/auth_controller.dart';
import 'package:home_hub/main.dart';
import 'package:home_hub/screens/dashboard_screen.dart';
import 'package:home_hub/screens/sign_in_screen.dart';
import 'package:home_hub/utils/constant.dart';
import 'package:home_hub/utils/widgets.dart';

import '../custom_widget/space.dart';
import '../utils/colors.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _signUpFormKey = GlobalKey<FormState>();

  //my code
  var controller = Get.put(AuthController());

  //text controller
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmpassController = TextEditingController();

  bool agreeWithTeams = false;
  bool _securePassword = true;
  bool _secureConfirmPassword = true;

  double screenHeight = 0.0;
  double screenWidth = 0.0;

  bool? checkBoxValue = false;

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _showAlertDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: SingleChildScrollView(
            child: ListBody(
                children: [Text('Please agree the terms and conditions')]),
          ),
          actions: [
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  /*//my code
  Country? _selectedCountry;

  void _showCountryPicker() async {
    final country = await showCountryPickerSheet(context);
    if (country != null) {
      setState(() {
        _selectedCountry = country;
      });
    }
  }*/

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Space(42),
              Center(
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                      fontSize: mainTitleTextSize, fontWeight: FontWeight.bold),
                ),
              ),
              Space(60),
              Form(
                key: _signUpFormKey,
                child: Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //user name
                      TextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          RegExp regex = new RegExp(r'^.{3,}$');
                          if (value!.isEmpty) {
                            return ("Name cannot be Empty");
                          }
                          if (!regex.hasMatch(value)) {
                            return ("Enter Valid name(Min. 3 Character)");
                          }
                          return null;
                        },
                        onSaved: (value) {
                          nameController.text = value!;
                        },
                        style: TextStyle(fontSize: 16),
                        decoration: commonInputDecoration(hintText: "Username"),
                      ),
                      Space(16),
                      //email
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        enableSuggestions: true,
                        autocorrect: true,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Please Enter Your Email");
                          }
                          // reg expression for email validation
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                              .hasMatch(value)) {
                            return ("Please Enter a valid email");
                          }
                          return null;
                        },
                        onSaved: (value) {
                          emailController.text = value!;
                        },
                        style: TextStyle(fontSize: 20),
                        decoration: commonInputDecoration(hintText: "Email"),
                      ),
                      Space(16),
                      //my code
                      //phone number
                      TextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        style: TextStyle(fontSize: 16),
                        validator: (value) {
                          RegExp regex =
                              new RegExp(r'^(?:[+0]9)?[0-9]{11}$');
                          if (value!.length == 0) {
                            return ("Please enter mobile number");
                          }
                          if (!regex.hasMatch(value)) {
                            return ("Please enter valid mobile number");
                          }
                          return null;
                        },
                        onSaved: (value) {
                          phoneController.text = value!;
                        },
                        inputFormatters: [LengthLimitingTextInputFormatter(11)],
                        decoration: commonInputDecoration(
                          hintText: "Enter mobile number",
                          /*prefixIcon: Padding(
                            padding: EdgeInsets.all(16),
                            child: GestureDetector(
                              onTap: () => _showCountryPicker(),
                              child: Text(
                                _selectedCountry == null
                                    ? "+92"
                                    : _selectedCountry!.callingCode,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                          ),*/
                        ),
                      ),
                      Space(16),
                      //password
                      TextFormField(
                        controller: passwordController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: _securePassword,
                        validator: (value) {
                          RegExp regex = new RegExp(r'^.{6,}$');
                          if (value!.isEmpty) {
                            return ("Password is required for login");
                          }
                          if (!regex.hasMatch(value)) {
                            return ("Enter Valid Password(Min. 6 Character)");
                          }
                        },
                        onSaved: (value) {
                          passwordController.text = value!;
                        },
                        style: TextStyle(fontSize: 20),
                        decoration: commonInputDecoration(
                          hintText: "Password",
                          suffixIcon: Padding(
                            padding: EdgeInsets.only(right: 5.0),
                            child: IconButton(
                              icon: Icon(
                                  _securePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  size: 18),
                              onPressed: () {
                                _securePassword = !_securePassword;
                                setState(() {});
                              },
                            ),
                          ),
                        ),
                      ),
                      Space(16),
                      //confirm password
                      TextFormField(
                        controller: confirmpassController,
                        textInputAction: TextInputAction.done,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.emailAddress,
                        obscureText: _secureConfirmPassword,
                        validator: (value) {
                          if (confirmpassController.text !=
                              passwordController.text) {
                            return "Password don't match";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          confirmpassController.text = value!;
                        },
                        style: TextStyle(fontSize: 20),
                        decoration: commonInputDecoration(
                          hintText: "Re-enter Password",
                          suffixIcon: Padding(
                            padding: EdgeInsets.only(right: 5.0),
                            child: IconButton(
                              icon: Icon(
                                  _secureConfirmPassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  size: 18),
                              onPressed: () {
                                _secureConfirmPassword =
                                    !_secureConfirmPassword;
                                setState(() {});
                              },
                            ),
                          ),
                        ),
                      ),
                      Space(16),
                      Theme(
                        data: ThemeData(
                            unselectedWidgetColor:
                                appData.isDark ? Colors.white : blackColor),
                        child: CheckboxListTile(
                          contentPadding: EdgeInsets.all(0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          activeColor: Colors.black,
                          title: Text("I agree to the Terms and Conditions",
                              style: TextStyle(fontWeight: FontWeight.normal)),
                          value: checkBoxValue,
                          dense: true,
                          onChanged: (newValue) {
                            setState(() {
                              checkBoxValue = newValue;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ),
                      Space(16),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: controller.isLoading.value
                            ? CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(Colors.blue),
                              )
                            : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.all(16),
                                  textStyle: TextStyle(fontSize: 25),
                                  shape: StadiumBorder(),
                                  backgroundColor: appData.isDark
                                      ? Colors.grey.withOpacity(0.2)
                                      : Colors.black,
                                ),
                                onPressed: () async {
                                  if (_signUpFormKey.currentState!.validate()) {
                                    if (checkBoxValue != false) {
                                      controller.isLoading(true);
                                      try {
                                        await controller
                                            .signupMethod(
                                                email: emailController.text,
                                                password:
                                                    passwordController.text)
                                            .then((value) {
                                          return controller.storeUserData(
                                            name: nameController.text,
                                            email: emailController.text,
                                            password: passwordController.text,
                                            phoneNumber: phoneController.text,
                                          );
                                        }).then((value) {
                                          Fluttertoast.showToast(
                                            msg: "Account created successfully",
                                            toastLength: Toast.LENGTH_SHORT,
                                            backgroundColor: Colors.black,
                                            textColor: Colors.white,
                                            fontSize: 14,
                                          );
                                          Get.offAll(DashBoardScreen());
                                          controller.isLoading(false);
                                        });

                                        /*final userCredential = await controller
                                            .signupMethod(
                                            email: emailController.text,
                                            password: passwordController.text);

                                        if (userCredential != null) {
                                          Fluttertoast.showToast(
                                            msg:
                                            "Account created successfully. Verification email sent.",
                                            // ... Toast properties ...
                                          );

                                          // Store user data in Firestore
                                          await controller.storeUserData(
                                            name: nameController.text,
                                            email: emailController.text,
                                            password: passwordController.text,
                                            phoneNumber: phoneController.text,
                                          );

                                          // Redirect to LoginScreen
                                          Get.offAll(SignInScreen());
                                          // Get.offAll(DashBoardScreen());
                                        } else {
                                          // Handle unsuccessful sign-up
                                          // ...
                                          Fluttertoast.showToast(
                                            msg:
                                            "Account not created",
                                            // ... Toast properties ...
                                          );
                                        }*/
                                      } catch (e) {
                                        auth.signOut();
                                        Fluttertoast.showToast(
                                          msg: e.toString(),
                                          toastLength: Toast.LENGTH_SHORT,
                                          backgroundColor: Colors.black,
                                          textColor: Colors.white,
                                          fontSize: 14,
                                        );
                                        controller.isLoading(false);
                                      }
                                    } else {
                                      _showAlertDialog();
                                    }
                                  }
                                  /*if (_signUpFormKey.currentState!.validate()) {
                              if (agreeWithTeams == true) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => OTPVerificationScreen()),
                                );
                              } else {
                                _showAlertDialog();
                              }
                            }*/
                                },
                                child: Text("Sign Up",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.white)),
                              ),
                      ),
                      Space(20),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignInScreen()));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Have an account?",
                                style: TextStyle(fontSize: 16)),
                            Space(4),
                            Text('Sign In',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
