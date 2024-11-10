import 'package:flutter/material.dart';
import 'package:platform_channel_trial/event_channel_screen.dart';
import 'package:platform_channel_trial/method_channel_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Platfrom Channel'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => EventChannelScreen()));
                },
                child: Text('Event channel')),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => MethodChannelScreen()));
                },
                child: Text('Method channel')),
          ],
        ),
      ),
    );
  }
}
