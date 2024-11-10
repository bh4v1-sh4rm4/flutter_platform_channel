import 'package:flutter/material.dart';
import 'package:platform_channel_trial/home_screen.dart';

void main() {
  runApp(PlatformChannel());
}

class PlatformChannel extends MaterialApp {
  PlatformChannel({super.key}) : super(home: HomeScreen());
}
