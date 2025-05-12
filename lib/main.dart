import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'theme.dart';

void main() {
  runApp(RestaurantDeliveryApp());
}

class RestaurantDeliveryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Foodie',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: SplashScreen(),
    );
  }
}
