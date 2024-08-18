import 'package:flutter/material.dart';
import 'package:project/data/clean_data.dart';
import 'package:project/tools/design_settings.dart';
import 'package:provider/provider.dart';

class ChorePage extends StatefulWidget {
  final String name;
  const ChorePage({super.key, required this.name});

  @override
  State<StatefulWidget> createState() => ChorePageState();
}

class ChorePageState extends State<ChorePage> {
  void checkboxChanged(String roomName, String choreName) {
    Provider.of<CleanData>(context, listen: false)
        .completeChore(roomName, choreName);
  }

  final choreNameController = TextEditingController();

  void createChore() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add Chore", style: headerStyle,),
        content: TextField(controller: choreNameController),
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
    String choreName = choreNameController.text;
    Provider.of<CleanData>(context, listen: false).addChores(widget.name, choreName);
    Navigator.pop(context);
  }

  void cancel() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CleanData>(
      builder: (BuildContext context, CleanData value, Widget? child) =>
          Scaffold(
        appBar: AppBar(
          title: Text(widget.name, style: headerStyle,),
          backgroundColor: Colors.deepPurple[50],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createChore,
          child: const Icon(Icons.add),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/chore_background3.jpeg"),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView.builder(
            padding: EdgeInsets.all(20),
            itemCount: value.getChores(widget.name).length,
            itemBuilder: (context, index) => Material(
              child: ListTile(
                tileColor: Colors.deepPurple[50],
                title: Text(value.getChores(widget.name)[index].name),
                trailing: Checkbox(
                  activeColor: docBlack,
                  onChanged: (val) => checkboxChanged(
                      widget.name, value.getChores(widget.name)[index].name),
                  value: value.getChores(widget.name)[index].isCompleted,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
