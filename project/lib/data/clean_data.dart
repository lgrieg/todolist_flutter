import 'package:flutter/material.dart';
import 'package:project/data/hive_database.dart';
import 'package:project/models/chore.dart';

import '../models/room.dart';

class CleanData extends ChangeNotifier {
  final db = Database();

  List<Room> choreList = [
    Room(
      name: 'Bathroom',
      chores: [
        Chore(name: "ugly name")
      ],
    ),
  ];

  List<Room> getRooms() {
    return choreList;
  }

  List<Chore> getChores(String roomName) {
    Room currentRoom = findRoom(roomName);
    List<Chore> chores = currentRoom.chores;
    return chores;
  }

  Room findRoom(String name) {
    return choreList.firstWhere((room) => room.name == name);
  }

  Chore findChore(String roomName, String choreName) {
    List<Chore> chores = getChores(roomName);
    Chore currentChore = chores.firstWhere((chore) => chore.name == choreName);
    return currentChore;
  }

  void addRoom(String name) {
    choreList.add(Room(name: name, chores: []));
    notifyListeners();
    db.saveToDatabase(choreList);
  }

  void removeRoom(int index) {
    choreList.removeAt(index);
    db.saveToDatabase(choreList);
  }

  void addChores(String roomName, String choreName) {
    Room currentRoom = findRoom(roomName);
    currentRoom.chores.add(Chore(name: choreName));
    notifyListeners();
    db.saveToDatabase(choreList);
  }

  void completeChore(String roomName, String choreName) {
    findChore(roomName, choreName).isCompleted = !findChore(roomName, choreName).isCompleted;
    notifyListeners();
    db.saveToDatabase(choreList);
  }

  void initChoreList() {
    if (db.dataExists()) {
      choreList = db.readFromDatabase();
      db.printCurrentRoomsAndChores();
    } else {
      db.saveToDatabase(choreList);
    }
  }
}
