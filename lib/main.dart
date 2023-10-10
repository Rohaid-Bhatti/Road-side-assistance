import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';
import 'package:home_hub/components/my_scroll_behaviour.dart';
import 'package:home_hub/providers/booking_provider.dart';
import 'package:home_hub/providers/category_provider.dart';
import 'package:home_hub/providers/services_provider.dart';
import 'package:home_hub/providers/user_provider.dart';
import 'package:home_hub/screens/splash_screen.dart';
import 'package:home_hub/utils/colors.dart';
import 'package:home_hub/utils/constant.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'store/appData.dart';

AppData appData = AppData();

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(MyApp());
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message)async {
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider<CategoryProvider>(
          create: (context) => CategoryProvider(),
        ),
        ChangeNotifierProvider<ServicesProvider>(
          create: (context) => ServicesProvider(),
        ),
        ChangeNotifierProvider<BookingProvider>(
          create: (context) => BookingProvider(),
        ),
      ],
      child: Observer(
        builder: (context) {
          return GetMaterialApp(
            scrollBehavior: MyScrollBehavior(),
            debugShowCheckedModeBanner: false,
            title: appName,
            theme: ThemeData.light().copyWith(
              colorScheme: ColorScheme(
                brightness: Brightness.light,
                primary: primaryColor,
                onPrimary: whiteColor,
                secondary: secondaryColor,
                onSecondary: secondaryColor,
                error: redColor,
                onError: redColor,
                background: whiteColor,
                onBackground: whiteColor,
                surface: whiteColor,
                onSurface: blackColor,
              ),
              primaryColor: primaryColor,
              secondaryHeaderColor: whiteColor,
              iconTheme: IconThemeData(color: primaryColor),
              tabBarTheme: TabBarTheme(labelColor: Colors.black),
              listTileTheme: ListTileThemeData(iconColor: blackColor),
              brightness: Brightness.light,
              dividerColor: transparent,
              appBarTheme: AppBarTheme(
                iconTheme: IconThemeData(color: primaryColor),
                titleTextStyle: TextStyle(color: primaryColor),
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarIconBrightness: Brightness.dark),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: whiteColor,
                selectedItemColor: bottomSelectedColor,
                unselectedItemColor: bottomUnselectedColor,
              ),
            ),
            darkTheme: ThemeData.dark().copyWith(
              colorScheme: ColorScheme(
                brightness: Brightness.light,
                primary: Colors.black,
                onPrimary: Colors.white,
                secondary: secondaryColor,
                onSecondary: secondaryColor,
                error: redColor,
                onError: redColor,
                background: whiteColor,
                onBackground: whiteColor,
                surface: greyColor,
                onSurface: blackColor,
              ),
              primaryColor: whiteColor,
              secondaryHeaderColor: primaryColor,
              iconTheme: IconThemeData(color: whiteColor),
              brightness: Brightness.dark,
              tabBarTheme: TabBarTheme(labelColor: Colors.white),
              listTileTheme: ListTileThemeData(iconColor: whiteColor),
              dividerColor: transparent,
              dialogTheme: DialogTheme(
                backgroundColor: Colors.grey,
                titleTextStyle: TextStyle(
                  color: blackColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
                contentTextStyle: TextStyle(color: Colors.black),
              ),
              expansionTileTheme: ExpansionTileThemeData(
                  iconColor: whiteColor, textColor: whiteColor),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: Colors.black,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.grey.shade500,
              ),
              appBarTheme: AppBarTheme(
                iconTheme: IconThemeData(color: whiteColor),
                titleTextStyle: TextStyle(color: whiteColor),
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarIconBrightness: Brightness.light),
              ),
            ),
            themeMode: appData.mode,
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}
