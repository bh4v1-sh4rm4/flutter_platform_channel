import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EventChannelScreen extends StatefulWidget {
  const EventChannelScreen({super.key});

  @override
  State<EventChannelScreen> createState() => _EventChannelScreenState();
}

class _EventChannelScreenState extends State<EventChannelScreen> {
  String result = 'No Result';
  final String eventChannelName = 'com.bajaj.com/event_channel';
  late EventChannel _eventChannel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _eventChannel = EventChannel(eventChannelName);
  }

  Stream getEventFromNative() async* {
    await for (var event in _eventChannel.receiveBroadcastStream()) {
      yield event;
    }
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Event Channel Screen'),
        ),
        body: StreamBuilder(
          stream: getEventFromNative(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              return Center(
                child: Text(snapshot.data.toString()),
              );
            } else {
              return Center(
                child: Text('Failed to get data'),
              );
            }
          },
        ));
  }
}
