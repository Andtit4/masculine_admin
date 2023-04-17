import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:m_admin/partials/bottom_nav_bar.dart';
import 'package:m_admin/screens/home.dart';
import 'package:m_admin/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String? teluser = "";
  late bool isShow = true;

  onInit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString('tel_key');
    if (prefs.getString('tel_key') != null) {
      setState(() {
        teluser = prefs.getString('tel_key')!;
        isShow = prefs.getBool('show')!;
      });
      print("___STate: $teluser");
    }
  }

  @override
  void initState() {
    super.initState();
    onInit();
  }

  @override
  Widget build(BuildContext context) {
    print('teluser____$teluser');
    return isShow == true
        ? LoginScreen(cred: isShow)
        : BottomNavBar(
            telephoneuser: teluser,
          );
  }
}
