import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/data/clean_data.dart';
import 'package:project/tools/design_settings.dart';
import 'package:provider/provider.dart';
import '../tools/auth.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  static const _title = Text('Hi, ');
  String _getUserName(String emailAddress) {
    return emailAddress.substring(0, emailAddress.indexOf("@"));
  }

  Text _getTitle() {
    return Text(
      'Hi, ${_getUserName(_userName())}',
      style: headerStyle,
    );
  }

  Text _userUid() {
    return Text(user?.email ?? 'User email');
  }

  String _userName() {
    return user?.email ?? 'User email';
  }

  ElevatedButton _signOutButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        backgroundColor: docBlack,
      ),
      onPressed: signOut,
      child: const Text('Sign Out', style: docStyleWhite,),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CleanData>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: warmBeige,
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          color: Color.fromARGB(255, 249, 231, 217),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _getTitle(),
              SizedBox(
                height: 20,
              ),
              _signOutButton(),
            ],
          ),
        ),
      ),
    );
  }
}
