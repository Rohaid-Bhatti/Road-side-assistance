import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:home_hub/controllers/auth_controller.dart';
import 'package:home_hub/screens/dashboard_screen.dart';
import 'package:home_hub/screens/sign_up_screen.dart';
import 'package:home_hub/utils/constant.dart';
import 'package:home_hub/utils/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../custom_widget/space.dart';
import '../main.dart';
import '../utils/colors.dart';
import '../utils/images.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _loginFormKey = GlobalKey<FormState>();
  double screenHeight = 0.0;
  double screenWidth = 0.0;

  //my code
  var controller = Get.put(AuthController());
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  bool _securePassword = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /*bool checkPhoneNumber(String phoneNumber) {
    String regexPattern = r'^(?:[+0][1-9])?[0-9]{10,12}$';
    var regExp = RegExp(regexPattern);

    if (phoneNumber.isEmpty) {
      return false;
    } else if (regExp.hasMatch(phoneNumber)) {
      return true;
    }
    return false;
  }*/

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
          statusBarIconBrightness:
              appData.isDark ? Brightness.light : Brightness.dark),
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Space(60),
                  Text("Welcome back!",
                      style: TextStyle(
                          fontSize: mainTitleTextSize,
                          fontWeight: FontWeight.bold)),
                  Space(8),
                  Text("Please Login to your account",
                      style: TextStyle(fontSize: 14, color: subTitle)),
                  Space(16),
                  Image.asset(splash_logo,
                      width: 100, height: 100, fit: BoxFit.cover),
                ],
              ),
              Space(70),
              /*Form(
                key: _loginFormKey,
                child: TextFormField(
                  keyboardType: TextInputType.phone,
                  style: TextStyle(fontSize: 16),
                  inputFormatters: [LengthLimitingTextInputFormatter(10)],
                  decoration: commonInputDecoration(
                    hintText: "Enter mobile number",
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(16),
                      child: GestureDetector(
                        onTap: () => _showCountryPicker(),
                        child: Text(
                          _selectedCountry == null ? "+92" : _selectedCountry!.callingCode,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ),
              ),*/

              //my code

              Form(
                key: _loginFormKey,
                child: Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        enableSuggestions: true,
                        autocorrect: true,

                        //my code
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

                        decoration: commonInputDecoration(
                          hintText: "Email",
                          prefixIcon: Icon(
                            Icons.person_outline,
                            size: 18,
                          ),
                        ),
                        style: TextStyle(fontSize: 20),
                      ),
                      Space(16),
                      TextFormField(
                        controller: passwordController,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: _securePassword,

                        //my code
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
                          prefixIcon: Icon(Icons.lock_outline, size: 18),
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
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: controller.isLoading.value
                            ? CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(Colors.blue),
                              )
                            : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.all(16),
                                  textStyle: TextStyle(fontSize: 16),
                                  shape: StadiumBorder(),
                                  backgroundColor: appData.isDark
                                      ? Colors.grey.withOpacity(0.2)
                                      : Colors.black,
                                ),
                                onPressed: () async {
                                  if (_loginFormKey.currentState!.validate()) {
                                    controller.isLoading(true);
                                    await controller
                                        .loginMethod(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    )
                                        .then((value) async {
                                      if (value != null) {
                                        Fluttertoast.showToast(
                                          msg: "Logged in successfully",
                                          toastLength: Toast.LENGTH_SHORT,
                                          backgroundColor: Colors.black,
                                          textColor: Colors.white,
                                          fontSize: 14,
                                        );
                                        Get.offAll(DashBoardScreen());
                                        //checking
                                        controller.isLoading(false);
                                      } else {
                                        controller.isLoading(false);
                                      }
                                      /*if (value != null) {
                                        // Check if the user's email is verified
                                        if (value.user != null &&
                                            value.user!.emailVerified) {
                                          Fluttertoast.showToast(
                                            msg: "Logged in successfully",
                                            // ... Toast properties ...
                                          );
                                          Get.offAll(DashBoardScreen());
                                        } else {
                                          // If email is not verified, show a message and sign out
                                          Fluttertoast.showToast(
                                            msg:
                                            "Please verify your email before logging in from sign in screen.",
                                            // ... Toast properties ...
                                          );
                                          await controller.signoutMethod();
                                        }
                                      } else {
                                        // Handle unsuccessful login
                                        // ...
                                      }
                                      controller.isLoading(false);*/
                                    });
                                  }
                                  // if (_loginFormKey.currentState!.validate()) {
                                  /* Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => OTPVerificationScreen()),
                        );*/
                                  //  }
                                },
                                child: Text("Log In",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.white)),
                              ),
                      ),
                      Space(32),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: [
                            Expanded(
                                child: Divider(
                                    thickness: 1.2,
                                    color: Colors.grey.withOpacity(0.2))),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 10),
                              child: Text("Or Login With",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                            ),
                            Expanded(
                                child: Divider(
                                    thickness: 1.2,
                                    color: Colors.grey.withOpacity(0.2))),
                          ],
                        ),
                      ),
                      Space(32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(icGoogle,
                              scale: 24,
                              color: appData.isDark ? blackColor : blackColor),
                          Space(40),
                          Image.asset(icInstagram,
                              scale: 24,
                              color: appData.isDark ? blackColor : blackColor),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Space(32),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have account?", style: TextStyle(fontSize: 16)),
                    Space(4),
                    Text('Sign Up',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
