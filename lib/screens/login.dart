import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m_admin/api/user.dart';
import 'package:m_admin/partials/bottom_nav_bar.dart';
import 'package:m_admin/widget/input.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  late bool? cred;
  LoginScreen({super.key, required this.cred});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late double width = MediaQuery.of(context).size.width;
  late double height = MediaQuery.of(context).size.height;
  late bool showProgress = false;

  TextEditingController _telController = TextEditingController();
  var response = [];

  authenticate(tel) async {
    var res = await ApiUser().getAdmin(tel);
    if (res[0]['telephoneuser'] == tel) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('tel_key', tel);
      prefs.setBool('show', false);
      // widget.cred = prefs.setBool('show', false) as bool?;
      setState(() {});
      print('__SHOWING_INSTANCE__CHANGED___${widget.cred}');
      Get.to(() => BottomNavBar(telephoneuser: prefs.getString('tel_key')));
    } else {
      showSnackBarText('Numéro de téléphone incorrect');
    }

    // print(res[0]['telephoneuser']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(15.0),
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * .03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(),
               
                  SizedBox(),
                  Container(
                      width: width * .2,
                      height: height * .07,
                      decoration: BoxDecoration(
                          /* border: Border.all(width: 1, color: Colors.white) */),
                      child: Center(child: Image.asset("assets/logo1.png")))
                ],
              ),
              SizedBox(
                height: height * .03,
              ),
              Text(
                'Entrez votre\nnuméro de télephone',
                style: GoogleFonts.poppins(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: height * .02,
              ),
              Text(
                "Veuillez entrer le code de vérification",
                style: GoogleFonts.poppins(color: Colors.white),
              ),
              Container(
                width: width * .9,
                height: height * .24,
                margin: EdgeInsets.only(top: height * .02),
                color: Color.fromARGB(94, 46, 46, 46),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          /*  Text(
                              '+225',
                              style: GoogleFonts.poppins(),
                            ), */

                          Row(
                            children: [
                              SizedBox(
                                width: 46,
                                height: 36,
                                child: Image.network(
                                  'https://d1z1c2g2uiorau.cloudfront.net/685-large_default/drapeau-mali-5075-cm.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(
                                width: width * .03,
                              ),
                              Text(
                                "Mali",
                                style: GoogleFonts.poppins(color: Colors.white),
                              ),
                            ],
                          ),
                          SizedBox(),
                          Icon(
                            Icons.arrow_downward,
                            color: Colors.white,
                          )
                        ],
                      ),
                      TiInput(
                          color: Color.fromARGB(94, 46, 46, 46),
                          hintText: '',
                          height: height * .08,
                          icon: '',
                          border: Border.all(width: .1, color: Colors.white),
                          inputController: _telController,
                          keyboardType: TextInputType.phone,
                          readonly: false,
                          width: width * .9)
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height * .02,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    showProgress = true;
                  });

                  authenticate(_telController.text);
                  // verifyOtp();
                },
                child: Container(
                  width: width * .9,
                  height: height * .08,
                  color: Color.fromARGB(94, 46, 46, 46),
                  child: Center(
                    child: showProgress == true
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 1,
                            ),
                          )
                        : Text(
                            'Connexion',
                            style: GoogleFonts.poppins(color: Colors.white),
                          ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void showSnackBarText(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
      text,
      style: GoogleFonts.poppins(color: Colors.white),
    )));
  }
}
