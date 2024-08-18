import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project/data/clean_data.dart';
import 'package:project/pages/home_page.dart';
import 'package:project/widget_tree.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

//import 'widget_tree.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  await Hive.openBox("mybox2");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CleanData(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: WidgetTree(),
      ),
    );
  }
}
