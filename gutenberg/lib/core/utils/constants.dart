import 'package:flutter/widgets.dart';

class AppConstants {
  AppConstants._();

  static const String baseUrl = 'http://skunkworks.ignitesol.com:8000';
}

bool isWideScreen(BuildContext context) {
  final size = MediaQuery.of(context).size;
  return size.shortestSide >= 600;
}
