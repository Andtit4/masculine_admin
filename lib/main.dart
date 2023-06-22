import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
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
      title: 'Masculine Admin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.poppinsTextTheme(),
        unselectedWidgetColor: Colors.white,
      ),
      home: const MyHomePage(title: 'Masculine admin'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
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
