import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:the_national_dawn/Screens/BookMarkDetailScreen.dart';
import 'package:the_national_dawn/Screens/BookMarkScreen.dart';
import 'package:the_national_dawn/Screens/BusinessCardScreen.dart';
import 'package:the_national_dawn/Screens/CalendarDetailScreen.dart';
import 'package:the_national_dawn/Screens/CalenderScreen.dart';
import 'package:the_national_dawn/Screens/CategoryScreen.dart';
import 'package:the_national_dawn/Screens/DailyNewScreen.dart';
import 'package:the_national_dawn/Screens/DirectoryScreen.dart';
import 'package:the_national_dawn/Screens/HomeCalendarScreen.dart';
import 'package:the_national_dawn/Screens/HomeCategoryScreen.dart';
import 'package:the_national_dawn/Screens/HomeNetworkScreen.dart';
import 'package:the_national_dawn/Screens/HomePage.dart';
import 'package:the_national_dawn/Screens/HomeScreen.dart';
import 'package:the_national_dawn/Screens/HomeStoriesScreen.dart';
import 'package:the_national_dawn/Screens/LoginScreen.dart';
import 'package:the_national_dawn/Screens/NetworkScreen.dart';
import 'package:the_national_dawn/Screens/OfferDetailScreen.dart';
import 'package:the_national_dawn/Screens/OfferScreen.dart';
import 'package:the_national_dawn/Screens/OneTwoOneScreen.dart';
import 'package:the_national_dawn/Screens/PopularNewsScreen.dart';
import 'package:the_national_dawn/Screens/ProfileScreen.dart';
import 'package:the_national_dawn/Screens/RegisterScreen.dart';
import 'package:the_national_dawn/Screens/SplashScreen.dart';
import 'package:the_national_dawn/Screens/StoriesScreen.dart';
import 'package:the_national_dawn/Screens/UpdateProfileScreen.dart';
import 'package:the_national_dawn/Screens/ViewDetailScreen.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TND',
      initialRoute: '/',
      routes: {
        //'/': (context) => AddressScreen(),
        '/': (context) => SplashScreen(),
        '/LoginScreen': (context) => LoginScreen(),
        '/RegisterScreen': (context) => RegisterScreen(),
        '/HomePage': (context) => HomePage(),
        '/HomeScreen': (context) => HomeScreen(),
        '/CalenderScreen': (context) => CalenderScreen(),
        '/CategoryScreen': (context) => CategoryScreen(),
        '/StoriesScreen': (context) => StoriesScreen(),
        '/OneTwoOneScreen': (context) => OneTwoOneScreen(),
        '/DirectoryScreen': (context) => DirectoryScreen(),
        '/NetworkScreen': (context) => NetworkScreen(),
        '/DailyNewScreen': (context) => DailyNewScreen(),
        '/PopularNewsScreen': (context) => PopularNewsScreen(),
        '/ViewDetailScreen': (context) => ViewDetailScreen(),
        '/BookMarkScreen': (context) => BookMarkScreen(),
        '/OfferScreen': (context) => OfferScreen(),
        '/OfferDetailScreen': (context) => OfferDetailScreen(),
        '/ProfileScreen': (context) => ProfileScreen(),
        '/BusinessCardScreen': (context) => BusinessCardScreen(),
        '/HomeCategoryScreen': (context) => HomeCategoryScreen(),
        '/HomeCalendarScreen': (context) => HomeCalendarScreen(),
        '/HomeStoriesScreen': (context) => HomeStoriesScreen(),
        '/HomeNetworkScreen': (context) => HomeNetworkScreen(),
        '/BookMarkDetailScreen': (context) => BookMarkDetailScreen(),
        '/UpdateProfileScreen': (context) => UpdateProfileScreen(),
        '/CalendarDetailScreen': (context) => CalendarDetailScreen(),
      },
      theme: ThemeData(
          //fontFamily: 'RobotoSlab',
          // primarySwatch: cnst.appPrimaryMaterialColor,
//        accentColor: Colors.black,
//        buttonColor: Colors.deepPurple,
          ),
    );
  }
}
