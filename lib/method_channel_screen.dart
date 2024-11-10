import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MethodChannelScreen extends StatefulWidget {
  const MethodChannelScreen({super.key});

  @override
  State<MethodChannelScreen> createState() => _MethodChannelScreenState();
}

class _MethodChannelScreenState extends State<MethodChannelScreen> {
  String result = 'No Result';
  final String methodChannelName = 'com.bajaj.com/method_channel';
  final String getResultMethodName = 'getResult';
  late MethodChannel _methodChannel;
  final String showDialogMethodName = 'showDialog';

  final TextEditingController dialogTextController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _methodChannel = MethodChannel(methodChannelName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Method Channel Screen'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(result),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: () async {
                result = await _methodChannel.invokeMethod(getResultMethodName);
                setState(() {});
              },
              child: Text('Get Result')),
          SizedBox(
            height: 30,
          ),
          TextField(
            controller: dialogTextController,
          ),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: () async {
                result = await _methodChannel.invokeMethod(
                    showDialogMethodName, dialogTextController.text);
                setState(() {});
              },
              child: Text('Show Dialog')),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: () async {
                log('result ::::: $result');
                _methodChannel.setMethodCallHandler((handler) {
                  if (handler.method == 'iOSToFlutter') {
                    result = handler.arguments.toString();
                    log('result ::::: $result');
                    setState(() {});
                  }
                  return Future.value();
                });
                setState(() {});
              },
              child: Text('From iOS')),
        ],
      )),
    );
  }
}
