import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m_admin/partials/card.dart';
import 'package:m_admin/screens/add_categorie.dart';

import '../partials/bottom_nav_bar.dart';

class Step1 extends StatefulWidget {
  const Step1({super.key});

  @override
  State<Step1> createState() => _Step1State();
}

class _Step1State extends State<Step1> {
  @override
  Widget build(BuildContext context) {
    late double width = MediaQuery.of(context).size.width;
    late double heigth = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Get.offAll(() => Step2(sexe: 'Masculin'),
                  transition: Transition.rightToLeft,
                  duration: Duration(seconds: 1));
            },
            child: Container(
              width: double.infinity,
              height: heigth * .08,
              color: const Color.fromARGB(255, 14, 13, 13),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.offAll(() => BottomNavBar(),
                          transition: Transition.leftToRight,
                          duration: Duration(seconds: 1));
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Choisir le sexe',
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  SizedBox()
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.offAll(() => Step2(sexe: 'Féminin'),
                  transition: Transition.rightToLeft,
                  duration: Duration(seconds: 1));
            },
            child: Container(
              width: double.infinity,
              height: heigth * .2,
              color: Color.fromARGB(255, 20, 20, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Masculin',
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_right,
                        color: Colors.white,
                      ))
                ],
              ),
            ),
          ),
          SizedBox(
            height: heigth * .08,
          ),
          Container(
            width: double.infinity,
            height: heigth * .2,
            color: Color.fromARGB(255, 20, 20, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Féminin',
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_right,
                      color: Colors.white,
                    ))
              ],
            ),
          ),
          SizedBox(
            height: heigth * .08,
          ),
          Container(
            width: width * .2,
            height: 2,
            color: Colors.white,
          )
        ],
      )),
    );
  }
}
