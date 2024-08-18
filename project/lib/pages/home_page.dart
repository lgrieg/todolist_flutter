

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/data/clean_data.dart';
import 'package:project/pages/chores_page.dart';
import 'package:project/pages/profile_page.dart';
import 'package:project/tools/design_settings.dart';
import 'package:provider/provider.dart';
import '../tools/auth.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  String userNameString() {
    return user?.email ?? 'User email';
  }

  Text _title() {
    return Text('Your profile: ${userNameString()}');
  }

  @override
  void initState() {
    super.initState();
    Provider.of<CleanData>(context, listen: false).initChoreList();
  }

  final roomNameController = TextEditingController();
  void createRoom() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add Room", style: headerStyle,),
        content: TextField(controller: roomNameController),
        actions: [
          MaterialButton(
            onPressed: save,
            child: const Text('save'),
          ),
          MaterialButton(
            onPressed: cancel,
            child: const Text('cancel'),
          ),
        ],
      ),
    );
  }

  void save() {
    String newRoomName = roomNameController.text;
    Provider.of<CleanData>(context, listen: false).addRoom(newRoomName);
    Navigator.pop(context);
  }

  void cancel() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CleanData>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: Text("Your To-do...", style: headerStyle,),
          leading: Padding(
            padding: EdgeInsets.all(2),
            child: IconButton(
              onPressed: () => goToProfilePage(),
              icon: const Icon(Icons.home),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createRoom,
          child: const Icon(Icons.add),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView.separated(
            padding: EdgeInsets.all(20),
            itemCount: value.getRooms().length,
            itemBuilder: (context, index) => Material(
              child: ListTile(
                leading: Icon(Icons.star),
                tileColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                title: Text(value.getRooms()[index].name),
                contentPadding: EdgeInsets.all(8),
                minVerticalPadding: 8.0,
                onTap: () => goToChoresPage(value.getRooms()[index].name),
                trailing: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    value.removeRoom(index);
                    setState(() {});
                  },
                ),
              ),
            ),
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(
              height: 10,
            ),
          ),
        ),
      ),
    );
  }

  void goToChoresPage(String roomName) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ChorePage(name: roomName)));
  }

  void goToProfilePage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ProfilePage()));
  }
}
