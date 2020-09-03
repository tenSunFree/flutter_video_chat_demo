import 'package:flutter/material.dart';
import 'package:flutter_video_chat_demo/chat/chat_screen.dart';
import 'package:flutter_video_chat_demo/common/model/remote.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    double _statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
        body:Stack(children: <Widget>[
          Container(
              margin: EdgeInsets.only(top: _statusBarHeight),
              child: Image.asset('assets/images/icon_login.png', fit: BoxFit.fill)),
          Column(children: <Widget>[
            Expanded(flex: 48, child: SizedBox()),
            Expanded(
                flex: 14,
                child: GestureDetector(onTap: () {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) => LoginFireBaseDialog());
                })),
            Expanded(flex: 58, child: SizedBox())
          ])
        ])
    );
  }
}

class LoginFireBaseDialog extends AlertDialog {
  LoginFireBaseDialog();

  @override
  Widget get content => _LoginFireBaseWidget();
}

class _LoginFireBaseWidget extends StatefulWidget {
  _LoginFireBaseWidget();

  @override
  State<StatefulWidget> createState() => _LoginFireBaseWidgetState();
}

class _LoginFireBaseWidgetState extends State<_LoginFireBaseWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final Remote _auth = Remote();

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Wrap(children: <Widget>[
      Column(children: <Widget>[
        Text("FireBase Authentication",
            style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic)),
        SizedBox(height: 16),
        buildTextFormField('請輸入電子郵件', emailController),
        SizedBox(height: 8),
        buildTextFormField('請輸入密碼', passwordController),
        SizedBox(height: 16),
        RaisedButton(
            onPressed: () async {
              String email = emailController.text;
              String password = passwordController.text;
              dynamic result =
                  await _auth.signInWithEmailAndPassword(email, password);
              if (result != null) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    ChatScreen.id, (Route<dynamic> route) => false);
              }
            },
            textColor: Colors.white,
            padding: const EdgeInsets.all(0),
            child: buildLoginFireBaseButtonContainer())
      ])
    ]));
  }

  TextFormField buildTextFormField(
      String hintText, TextEditingController controller) {
    return TextFormField(
        decoration: new InputDecoration.collapsed(hintText: hintText),
        autofocus: true,
        controller: controller);
  }

  Container buildLoginFireBaseButtonContainer() {
    return Container(
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: <Color>[
              Color(0xFF4285F4),
              Color(0xFFEA4335),
              Color(0xFFFBBC05),
              Color(0xFF34A853)
            ])),
        child: const Text('使用FireBase登入',
            style: TextStyle(fontSize: 18, color: Colors.black)));
  }
}
