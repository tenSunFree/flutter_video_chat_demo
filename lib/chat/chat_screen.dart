import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_video_chat_demo/chat/chat_screen_message_widget.dart';
import 'package:flutter_video_chat_demo/common/model/user_bean.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ChatScreen extends StatefulWidget {
  static const String id = "ChatScreen";
  UserBean user;

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final Firestore _firestore = Firestore.instance;
  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    double _statusBarHeight = MediaQuery.of(context).padding.top;
    widget.user = Provider.of<UserBean>(context);
    return Scaffold(
        body: Container(
            margin: EdgeInsets.only(top: _statusBarHeight),
            child:
                Column(children: <Widget>[buildExpanded(), buildContainer()])));
  }

  Expanded buildExpanded() {
    return Expanded(
        child: StreamBuilder<QuerySnapshot>(
            stream: _firestore
                .collection('flutter_video_chat_demo')
                .document('01')
                .collection("message")
                .orderBy('date')
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              List<DocumentSnapshot> docs = snapshot.data.documents;
              List<Widget> messages = docs.map((doc) {
                return MessageWidget(
                    date: doc.data['date'],
                    name: doc.data['name'] != null ? doc.data['name'] : "null",
                    message: doc.data['message'],
                    imageUrl: doc.data['image_url'],
                    isMe: widget.user.email == doc.data['email']);
              }).toList();
              return ListView(
                  controller: scrollController,
                  children: messages.reversed.toList(),
                  reverse: true);
            }));
  }

  Container buildContainer() {
    return Container(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
        child: Container(
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(),
                boxShadow: [BoxShadow(blurRadius: 1.0)]),
            child: Row(children: <Widget>[
              Flexible(
                  child: TextField(
                      controller: messageController,
                      onSubmitted: (value) => addFirestoreDocument(),
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: '傳送簡訊'))),
              SizedBox(
                  width: 50,
                  child: FlatButton(
                      color: Color(0xFFE5E6E9),
                      onPressed: addFirestoreDocument,
                      child: Icon(Icons.send, color: Colors.white),
                      clipBehavior: Clip.none)),
              SizedBox(width: 10)
            ])));
  }

  Future<void> addFirestoreDocument() async {
    String message = messageController.text;
    String imageUrl =
        'https://www.avenueofstars.com.hk/wp-content/uploads/feature-photo/097_%E5%BC%B5%E5%AD%B8%E5%8F%8B-coverf.jpg';
    if (message.length > 0) {
      await _firestore
          .collection('flutter_video_chat_demo')
          .document('01')
          .collection("message")
          .add({
        'date': DateTime.now().toIso8601String().toString(),
        'name': '張學友',
        'message': message,
        'email': widget.user.email,
        'image_url': imageUrl
      });
      messageController.clear();
      scrollController.animateTo(scrollController.position.minScrollExtent,
          curve: Curves.easeOut, duration: const Duration(milliseconds: 300));
    }
  }
}
