import 'package:hive/hive.dart';
import 'package:project/models/chore.dart';
import 'package:project/models/room.dart';
import 'package:project/tools/datetime.dart';

class Database {
  final _myBox = Hive.box("mybox2");

  bool dataExists() {
    if (_myBox.isEmpty) {
      print("data doesn`t exist");
      _myBox.put("StartDate", todayDateYYYYMMDD());
      return false;
    } else {
      print("data exists");
      return true;
    }
  }

  String getStartDate() {
    return _myBox.get("StartDate");
  }

  void printCurrentRoomsAndChores() {
    List<String> roomNames = _myBox.get("Rooms");
    print(roomNames);
    final chores = _myBox.get("Chores");
    print(chores);
  }

  void saveToDatabase(List<Room> rooms) {
    /*
    List<String> roomNames1 = _myBox.get("Rooms");
    print(roomNames1);
    final chores1 = _myBox.get("Chores");
    print(chores1);*/
    final roomList = convertRooms(rooms);
    List<List<List<String>>> choreList = [];
    for (int i = 0; i < rooms.length; ++i) {
      final chores = convertChores(rooms[i]);
      choreList.add(chores);
    }
    _myBox.put("Rooms", roomList);
    _myBox.put("Chores", choreList);
    print(choreList.length);
    print(choreList);
    List<String> roomNames = _myBox.get("Rooms");
    print(roomNames);
    final chores = _myBox.get("Chores");
    print(chores);
  }

  List<Room> readFromDatabase() {
    List<Room> savedRooms = [];
    List<String> roomNames = _myBox.get("Rooms");
    final chores = _myBox.get("Chores");

    for (int i = 0; i < roomNames.length; ++i) {
      List<Chore> choresInRoom = [];
      for (int j = 0; j < chores[i].length; ++j) {
        choresInRoom.add(
          Chore(
            //i - room j - chore id - 3id is for chores properties
            name: chores[i][j][0],
            isCompleted: chores[i][j][1].toString() == 'true' ? true : false,
          ),
        );
      }
      savedRooms.add(Room(name: roomNames[i], chores: choresInRoom));
    }
    return savedRooms;
  }

  
  List<String> convertRooms(List<Room> rooms) {
    List<String> res = [];
    for (int i = 0; i < rooms.length; ++i) {
      res.add(rooms[i].name);
    }
    return res;
  }

  List<List<String>> convertChores(Room room) {
    List<List<String>> res = [];
    for (int i = 0; i < room.chores.length; ++i) {
      final name = room.chores[i].name;
      final isComplete = room.chores[i].isCompleted ? "true" : "false";
      res.add([name, isComplete]);
    }
    return res;
  }
}
