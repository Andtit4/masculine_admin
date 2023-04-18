import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:m_admin/partials/bottom_nav_bar.dart';
import 'package:m_admin/partials/button.dart';
import 'package:m_admin/partials/dropdown.dart';
import 'package:m_admin/partials/input.dart';

class AddService extends StatefulWidget {
  const AddService({super.key});

  @override
  State<AddService> createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  late bool showItems = false;
  late String gender = "Masculin";
  late String heure_debut = "Heure début";
  late String heure_fin = "Heure fin";

  @override
  Widget build(BuildContext context) {
    late double width = MediaQuery.of(context).size.width;
    late double height = MediaQuery.of(context).size.height;
    late TextEditingController _titleserviceController =
        TextEditingController();
    late TextEditingController _urlImageController = TextEditingController();
    late TextEditingController _descriptionController = TextEditingController();
    //late TextEditingController _sexeController = TextEditingController();

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
                        'Ajouter un service',
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      SizedBox()
                    ],
                  ),
                ),
                /* SizedBox(
                  height: height * .03,
                ), */
                CustomInput(
                  width: double.infinity,
                  // height: height * .09,
                  backgroundColor: Color.fromARGB(255, 36, 34, 34),
                  hintText: 'Titre du service',
                  textEditingController: _titleserviceController,
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
                  textEditingController: _urlImageController,
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
                  textEditingController: _descriptionController,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                ),
                SizedBox(
                  height: height * .03,
                ),
                TiDropdown(
                  color: Color.fromARGB(255, 36, 34, 34),
                  borderColor: Colors.white,
                  firstItem: gender,
                  height: height * .08,
                  width: double.infinity,
                  onPress: () {
                    // Vibration.vibrate(amplitude: 30, duration: 30);
                    setState(() {
                      showItems = !showItems;
                    });
                  },
                ),
                SizedBox(
                  height: height * .03,
                ),
                showItems
                    ? Center(
                        child: Container(
                          width: double.infinity,
                          height: height * .12,
                          color: Color.fromARGB(255, 36, 34, 34),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    gender = "Masculin";
                                    showItems = !showItems;
                                  });
                                  print(gender);
                                },
                                child: Container(
                                  height: height * .04,
                                  margin: EdgeInsets.only(top: 20),
                                  child: Text(
                                    'Masculin',
                                    style: GoogleFonts.poppins(
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    gender = "Féminin";
                                    showItems = !showItems;
                                  });
                                  print(gender);
                                },
                                child: Text(
                                  'Féminin',
                                  style:
                                      GoogleFonts.poppins(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : SizedBox(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'De',
                        style: GoogleFonts.poppins(color: Colors.white),
                      ),
                      GestureDetector(
                        onTap: () {
                          DatePicker.showTimePicker(context,
                              theme: DatePickerTheme(
                                  backgroundColor: Colors.black,
                                  itemStyle:
                                      GoogleFonts.poppins(color: Colors.white)),
                              onConfirm: (DateTime time) {
                            setState(() {
                              var time_convert =
                                  "${DateTime.tryParse(time.hour.toString())} : ${DateTime.tryParse(time.minute.toString())} : ${DateTime.tryParse(time.second.toString())}";
                              heure_debut = DateFormat('HH:mm:ss').format(time);
                            });
                            print(heure_debut);
                          });
                        },
                        child: Container(
                          width: width * .25,
                          height: height * .05,
                          color: Color.fromARGB(255, 34, 32, 32),
                          child: Center(
                            child: Text('$heure_debut',
                                style:
                                    GoogleFonts.poppins(color: Colors.white)),
                          ),
                        ),
                      ),
                      Text(
                        'A',
                        style: GoogleFonts.poppins(color: Colors.white),
                      ),
                      GestureDetector(
                        onTap: () {
                          DatePicker.showTimePicker(context,
                              theme: DatePickerTheme(
                                  backgroundColor: Colors.black,
                                  itemStyle:
                                      GoogleFonts.poppins(color: Colors.white)),
                              onConfirm: (DateTime time) {
                            setState(() {
                              var time_convert =
                                  "${DateTime.tryParse(time.hour.toString())} : ${DateTime.tryParse(time.minute.toString())} : ${DateTime.tryParse(time.second.toString())}";
                              heure_fin = DateFormat('HH:mm:ss').format(time);
                            });
                            print(heure_fin);
                          });
                        },
                        child: Container(
                          width: width * .25,
                          height: height * .05,
                          color: Color.fromARGB(255, 34, 32, 32),
                          child: Center(
                            child: Text('$heure_fin',
                                style:
                                    GoogleFonts.poppins(color: Colors.white)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * .03,
                ),
                CustomButton(
                  width: double.infinity,
                  height: height * .08,
                  backgroundColor: Colors.white,
                  onPress: () {
                    print('pressed');
                  },
                  child: Text(
                    'Enregister',
                    style: GoogleFonts.poppins(),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
