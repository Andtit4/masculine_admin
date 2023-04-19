import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m_admin/partials/button.dart';
import 'package:m_admin/partials/input.dart';

import '../partials/bottom_nav_bar.dart';

class Step2 extends StatefulWidget {
  final String sexe;
  const Step2({super.key, required this.sexe});

  @override
  State<Step2> createState() => _Step2State();
}

class _Step2State extends State<Step2> {
  late bool showProgess = false;

  @override
  Widget build(BuildContext context) {
    late double width = MediaQuery.of(context).size.width;
    late double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: height * .08,
                  color: Color.fromARGB(255, 22, 22, 22),
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
                        'Ajouter une catégorie',
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (context) {
                                  return Container(
                                    width: width,
                                    height: height * 04,
                                    color: Colors.black,
                                    margin: EdgeInsets.only(
                                        left: width * .1, right: width * .1),
                                        
                                  );
                                });
                          },
                          icon: Icon(
                            Icons.history,
                            color: Colors.white,
                          ))
                    ],
                  ),
                ),
                SizedBox(
                  height: height * .03,
                ),
                CustomInput(
                  width: double.infinity,
                  // height: height * .09,
                  backgroundColor: Color.fromARGB(255, 36, 34, 34),
                  hintText: 'Titre de la catégorie',
                  // textEditingController: _titleserviceController,
                  contentPadding: EdgeInsets.all(20),
                ),
                SizedBox(
                  height: height * .03,
                ),
                CustomInput(
                  width: double.infinity,
                  // height: height * .09,
                  backgroundColor: Color.fromARGB(255, 36, 34, 34),
                  hintText: "URL de l'image",
                  // textEditingController: _urlImageController,
                  contentPadding: EdgeInsets.all(20),
                ),
                SizedBox(
                  height: height * .03,
                ),
                CustomInput(
                  width: double.infinity,
                  // height: height * .09,
                  backgroundColor: Color.fromARGB(255, 36, 34, 34),
                  hintText: "Description",
                  // textEditingController: _descriptionController,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                ),
                SizedBox(
                  height: height * .03,
                ),
                SizedBox(
                  height: height * .03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    /* CustomButton(
                      width: width * .2,
                      height: height * .08,
                      backgroundColor: Colors.white,
                      onPress: () {
                        print('pressed');
                        setState(() {
                          showProgess = true;
                        });
                        print(showProgess);
                      },
                      child: showProgess
                          ? const Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 1,
                                color: Colors.black,
                              ),
                            )
                          : Icon(Icons.arrow_back_sharp),
                    ), */
                    CustomButton(
                      width: width * .2,
                      height: height * .08,
                      backgroundColor: Colors.white,
                      onPress: () {
                        print('pressed');
                        setState(() {
                          showProgess = true;
                        });
                        print(showProgess);
                      },
                      child: showProgess
                          ? const Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 1,
                                color: Colors.black,
                              ),
                            )
                          : Icon(Icons.arrow_right_alt),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
