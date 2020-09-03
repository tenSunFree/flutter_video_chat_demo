import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_video_chat_demo/common/model/user_bean.dart';
import 'file:///C:/FlutterVideoChatDemo/flutter_video_chat_demo/lib/common/util/toast_util.dart';

class Remote {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserBean userFromFirebaseUser(FirebaseUser user) =>
      user != null ? UserBean(email: user.email) : null;

  Stream<UserBean> get getUserBean =>
      _auth.onAuthStateChanged.map(userFromFirebaseUser);

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return userFromFirebaseUser(user);
    } catch (e) {
      toast(e.toString());
      return null;
    }
  }
}
