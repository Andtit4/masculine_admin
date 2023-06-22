import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m_admin/api/rdv.dart';
import 'package:m_admin/partials/button.dart';
import 'package:m_admin/partials/card.dart';
import 'package:m_admin/partials/dropdown.dart';
import 'package:m_admin/screens/add_categorie.dart';
import 'package:m_admin/widget/input.dart';

import '../partials/bottom_nav_bar.dart';

class Step1 extends StatefulWidget {
  const Step1({super.key});

  @override
  State<Step1> createState() => _Step1State();
}

class _Step1State extends State<Step1> {
  late bool showItem = false;
  late String firstItem = 'Masculin';
  late TextEditingController titreCategorieController = TextEditingController();
  late TextEditingController imgCategorieController = TextEditingController();
  late TextEditingController posteController = TextEditingController();

  final String titreCategorie = '';
  late String imgCategorie = '';
  late String sexe = '';
  bool isMaleChecked = false;
  bool isFemaleChecked = false;
  late String m = 'Masculin';
  late String f = 'Féminin';

  late String poste = '';

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
          Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Get.offAll(() => BottomNavBar());
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        )),
                    Text(
                      'Ajouter une catégorie',
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: heigth * .08,
                ),
                TiInput(
                    color: const Color.fromARGB(255, 34, 34, 34),
                    hintText: 'Titre catégorie',
                    inputController: titreCategorieController,
                    inputValue: titreCategorie,
                    hintColor: Colors.white,
                    icon: '',
                    keyboardType: TextInputType.name,
                    readonly: false,
                    width: width),
                TiInput(
                    color: const Color.fromARGB(255, 34, 34, 34),
                    hintText: 'img url catégorie',
                    inputController: imgCategorieController,
                    inputValue: imgCategorie,
                    hintColor: Colors.white,
                    icon: '',
                    keyboardType: TextInputType.name,
                    readonly: false,
                    width: width),
                Row(
                  children: [
                    Checkbox(
                      value: isMaleChecked,
                      onChanged: (value) {
                        setState(() {
                          isMaleChecked = value!;
                          if (isMaleChecked) {
                            isFemaleChecked = false;
                            setState(() {
                              firstItem == 'Masculin';
                            });
                          }
                        });
                      },
                    ),
                    Text(
                      'Lui',
                      style: GoogleFonts.poppins(color: Colors.white),
                    ),
                    SizedBox(width: 20), // Espace entre les cases à cocher
                    Checkbox(
                      value: isFemaleChecked,
                      onChanged: (value) {
                        setState(() {
                          isFemaleChecked = value!;
                          if (isFemaleChecked) {
                            isMaleChecked = false;
                            setState(() {
                              firstItem == 'Féminin';
                            });
                          }
                        });
                      },
                    ),
                    Text('Elle',
                        style: GoogleFonts.poppins(color: Colors.white)),
                  ],
                ),
                /* TiDropdown(
                    firstItem: firstItem,
                    onPress: () {
                      setState(() {
                        showItem = !showItem;
                      });
                      // print('Value of showitem == $showItem');
                    },
                    width: width,
                    height: heigth * .08,
                    borderColor: Colors.white,
                    color: Colors.black),
                showItem == true
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            firstItem = 'Féminin';
                            showItem = false;
                          });
                          // print('Value of first item == $firstItem');
                        },
                        child: Container(
                          width: width,
                          height: heigth * .08,
                          color: Colors.white,
                          child: Center(
                            child: Text(
                              'Féminin',
                              style: GoogleFonts.poppins(color: Colors.black),
                            ),
                          ),
                        ),
                      )
                    : SizedBox(), */
                TiInput(
                    color: const Color.fromARGB(255, 34, 34, 34),
                    hintText: 'Postes',
                    hintColor: Colors.white,
                    icon: '',
                    inputValue: poste,
                    keyboardType: TextInputType.number,
                    readonly: false,
                    width: width),
                SizedBox(
                  height: heigth * .04,
                ),
                CustomButton(
                  backgroundColor: const Color.fromARGB(255, 34, 34, 34),
                  width: width,
                  height: heigth * .08,
                  onPress: () {
                    ApiRdv().insertCategorie(titreCategorieController.text,
                        imgCategorieController.text, '', firstItem);
                    showSnackBarText(
                        'Catégorie ${titreCategorieController.text} ajouté');
                  },
                  child: Center(
                    child: Text(
                      'Enregistrer',
                      style: GoogleFonts.poppins(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      )),
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
