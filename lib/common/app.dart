import 'package:flutter/material.dart';
import 'package:flutter_video_chat_demo/chat/chat_screen.dart';
import 'package:flutter_video_chat_demo/common/model/remote.dart';
import 'package:flutter_video_chat_demo/common/model/user_bean.dart';
import 'package:flutter_video_chat_demo/login/login_screen.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) => StreamProvider<UserBean>.value(
      value: Remote().getUserBean,
      child: MaterialApp(
          title: 'FlutterVideoChatDemo',
          home: LoginScreen(),
          routes: {ChatScreen.id: (context) => ChatScreen()},
          debugShowCheckedModeBanner: false));
}
