import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:m_admin/api/rdv.dart';
import 'package:m_admin/api/service.dart';
import 'package:m_admin/models/categorieModel.dart';
import 'package:m_admin/partials/bottom_nav_bar.dart';
import 'package:m_admin/partials/button.dart';
import 'package:m_admin/partials/dropdown.dart';
import 'package:m_admin/partials/input.dart';

class AddService extends StatefulWidget {
  final Map<String, String>? data;
  const AddService({super.key, this.data});

  @override
  State<AddService> createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  late bool showItems = false;
  late String gender = "Masculin";
  late String heure_debut = "Heure début";
  late String heure_fin = "Heure fin";
  late bool showProgess = false;
  late bool showCategorie = false;
  late String titreCategorie = 'Choisir le titre de la catégorie';
  late TextEditingController _titleserviceController = TextEditingController();
  late TextEditingController _urlImageController = TextEditingController();
  late TextEditingController _descriptionController = TextEditingController();
  late TextEditingController _montantController = TextEditingController();
  // final String sexe = "";

  /*  onInit() {
    setState(() {
      sexe == widget.data?['sexe'];
    });
    print('_sexe_$sexe');
  } */

  @override
  void initState() {
    super.initState();
    // onInit();
  }

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
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.history,
                            color: Colors.white,
                          ))
                    ],
                  ),
                ),
                /* SizedBox(
                  height: height * .03,
                ), */
                CustomInput(
                  width: double.infinity,
                  // height: height * .09,
                  readOnly: false,
                  backgroundColor: Color.fromARGB(255, 36, 34, 34),
                  hintText: 'Titre du service',
                  textEditingController: _titleserviceController,
                  contentPadding: EdgeInsets.all(20),
                ),
                SizedBox(
                  height: height * .03,
                ),
                widget.data?['titre_categorie'] == null
                    ? TiDropdown(
                        firstItem: titreCategorie,
                        onPress: () {
                          setState(() {
                            showCategorie = !showCategorie;
                          });
                        },
                        width: double.infinity,
                        height: height * .08,
                        borderColor: Colors.transparent,
                        color: Color.fromARGB(255, 36, 34, 34))
                    : Text(
                        '${widget.data?['titre_categorie']}',
                        style: GoogleFonts.poppins(color: Colors.white),
                      ),
                showCategorie == true
                    ? Container(
                        width: double.infinity,
                        height: height * .1,
                        color: Color.fromARGB(255, 36, 34, 34),
                        child: FutureBuilder(
                          future: ApiRdv().getAllCategories(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 1,
                                ),
                              );
                            }

                            List<CategorieModel> data = snapshot.data ?? [];
                            return ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      titreCategorie =
                                          data[index].titre_categorie!;
                                      showCategorie = false;
                                    });
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: height * .06,
                                    color:
                                        const Color.fromARGB(255, 26, 22, 22),
                                    margin: const EdgeInsets.only(bottom: 5),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${data[index].titre_categorie}',
                                            style: GoogleFonts.poppins(
                                                color: Colors.white),
                                          ),
                                          const Icon(
                                            Icons.arrow_right,
                                            color: Colors.white,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      )
                    : SizedBox(),
                SizedBox(
                  height: height * .03,
                ),
                CustomInput(
                  width: double.infinity,
                  // height: height * .09,
                  readOnly: false,
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
                  readOnly: false,
                  backgroundColor: Color.fromARGB(255, 36, 34, 34),
                  hintText: "Description",
                  textEditingController: _descriptionController,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                ),
                SizedBox(
                  height: height * .03,
                ),
                CustomInput(
                  width: double.infinity,
                  readOnly: false,
                  // height: height * .09,
                  backgroundColor: Color.fromARGB(255, 36, 34, 34),
                  hintText: "Montant",
                  textEditingController: _montantController,
                  contentPadding: EdgeInsets.all(20),
                ),
                SizedBox(
                  height: height * .03,
                ),
                TiDropdown(
                  color: Color.fromARGB(255, 36, 34, 34),
                  borderColor: Colors.white,
                  firstItem: widget.data?['sexe'] == null
                      ? gender
                      : '${widget.data?['sexe'].toString()}',
                  height: height * .08,
                  width: double.infinity,
                  onPress: () {
                    // Vibration.vibrate(amplitude: 30, duration: 30);
                    widget.data?['sexe'] == null
                        ? setState(() {
                            showItems = !showItems;
                          })
                        : null;
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
                    setState(() {
                      showProgess = true;
                    });

                    if (_descriptionController.text == '' ||
                        _montantController.text == '' ||
                        _titleserviceController.text == '' ||
                        _urlImageController.text == '' ||
                        heure_debut == '' ||
                        heure_fin == '' ||
                        titreCategorie == '') {
                      showSnackBarText('Veuillez remplir tous les champs');
                    } else {
                      ApiRdv().insertService(
                          _titleserviceController.text,
                          heure_debut,
                          heure_fin,
                          gender,
                          _descriptionController.text,
                          _urlImageController.text,
                          titreCategorie,
                          _montantController.text);
                      showSnackBarText('Service ${_titleserviceController.text} ajouté avec succès');

                      Get.offAll(() => BottomNavBar(),
                          transition: Transition.leftToRight,
                          duration: Duration(seconds: 1));
                    }
                  },
                  child: showProgess
                      ? const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 1,
                            color: Colors.black,
                          ),
                        )
                      : Text(
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

  void showSnackBarText(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
      text,
      style: GoogleFonts.poppins(color: Colors.white),
    )));
  }
}
