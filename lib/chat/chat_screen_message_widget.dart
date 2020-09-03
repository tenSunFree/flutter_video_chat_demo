import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MessageWidget extends StatelessWidget {
  final String name;
  final String message;
  final String imageUrl;
  final String date;
  bool isMe;

  MessageWidget({this.name, this.message, this.imageUrl, this.date, this.isMe});

  @override
  Widget build(BuildContext context) {
    Container messageContainer = buildMessageContainer(context);
    if (isMe) {
      return buildMePadding(messageContainer);
    }
    return buildNotMePadding(messageContainer);
  }

  Container buildMessageContainer(BuildContext context) {
    final Container messageContainer = Container(
        margin: isMe
            ? EdgeInsets.only(top: 8.0, bottom: 8.0, left: 80.0)
            : EdgeInsets.only(top: 8.0, bottom: 8.0),
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        width: MediaQuery.of(context).size.width * 0.60,
        decoration: BoxDecoration(
          color: isMe ? Color(0xFF00c300) : Color(0xFFE5E6E9),
          borderRadius: isMe
              ? BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                  bottomLeft: Radius.circular(15.0))
              : BorderRadius.only(
                  topRight: Radius.circular(15.0),
                  topLeft: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0)),
        ),
        child: buildMessageColumn());
    return messageContainer;
  }

  Column buildMessageColumn() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(name,
              style: TextStyle(
                  color: isMe ? Colors.white : Colors.black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400)),
          SizedBox(height: 8.0),
          Text(message,
              style: TextStyle(
                  color: isMe ? Colors.white : Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400))
        ]);
  }

  Padding buildMePadding(Container messageContainer) {
    return Padding(
        padding: const EdgeInsets.all(3.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                  padding: EdgeInsets.all(2.0),
                  child: Row(children: <Widget>[messageContainer])),
              Container(
                  padding: EdgeInsets.all(2.0),
                  child: Row(children: <Widget>[
                    CircleAvatar(
                        backgroundColor: Colors.green[200],
                        backgroundImage:
                            imageUrl != null && NetworkImage(imageUrl) != null
                                ? NetworkImage(imageUrl)
                                : null)
                  ]))
            ]));
  }

  Padding buildNotMePadding(Container messageContainer) {
    return Padding(
        padding: const EdgeInsets.all(3.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                  padding: EdgeInsets.all(2.0),
                  child: Row(children: <Widget>[
                    CircleAvatar(
                        backgroundColor: Colors.blue,
                        backgroundImage:
                            imageUrl != null ? NetworkImage(imageUrl) : null)
                  ])),
              Container(
                  padding: EdgeInsets.all(2.0),
                  child: Row(children: <Widget>[messageContainer]))
            ]));
  }
}
