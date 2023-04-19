import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m_admin/api/rdv.dart';
import 'package:m_admin/models/categorieModel.dart';
import 'package:m_admin/partials/button.dart';
import 'package:m_admin/partials/input.dart';
import 'package:m_admin/screens/add_service.dart';

import '../partials/bottom_nav_bar.dart';

class Step2 extends StatefulWidget {
  final String sexe;
  const Step2({super.key, required this.sexe});

  @override
  State<Step2> createState() => _Step2State();
}

class _Step2State extends State<Step2> {
  late bool showProgess = false;
  TextEditingController _titreCategorie = TextEditingController();
  TextEditingController _descriptionCategorie = TextEditingController();
  TextEditingController _imgCategorie = TextEditingController();

  @override
  void initState() {
    super.initState();
    ApiRdv().getAllCategories();
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
                                    child: FutureBuilder(
                                        future: ApiRdv().getAllCategories(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot snapshot) {
                                          if (!snapshot.hasData) {
                                            return const Center(
                                                child:
                                                    CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 1,
                                            ));
                                          }
                                          List<CategorieModel> data =
                                              snapshot.data ?? [];
                                          return ListView.builder(
                                            physics:
                                                const BouncingScrollPhysics(),
                                            itemCount: data.length,
                                            itemBuilder: (context, index) {
                                              return Container(
                                                width: double.infinity,
                                                height: height * .1,
                                                color: const Color.fromARGB(
                                                    255, 22, 20, 20),
                                                margin: const EdgeInsets.only(
                                                    bottom: 20,
                                                    left: 10,
                                                    right: 10),
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    SizedBox(
                                                      width: width * .1,
                                                      height: height * .1,
                                                      child: CachedNetworkImage(
                                                          imageUrl: data[index]
                                                              .img_categorie
                                                              .toString()),
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          '${data[index].titre_categorie}',
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                        ),
                                                        Text(
                                                            '${data[index].sexe}',
                                                            style: GoogleFonts
                                                                .poppins(
                                                              color:
                                                                  Colors.white,
                                                            )),
                                                      ],
                                                    ),
                                                    CustomButton(
                                                      width: width * .1,
                                                      height: double.infinity,
                                                      backgroundColor:
                                                          Colors.white,
                                                      onPress: () {
                                                        /* showSnackBarText(
                                                            "L'option d'édition non disponible pour le moment"); */
                                                        Get.off(
                                                            () => AddService(
                                                                    data: {
                                                                      'sexe': widget
                                                                          .sexe
                                                                          .toString(),
                                                                      'titre_categorie':
                                                                          data[index].titre_categorie!.toString()
                                                                    }),
                                                            transition:
                                                                Transition
                                                                    .rightToLeft,
                                                            duration:
                                                                const Duration(
                                                                    seconds:
                                                                        1));
                                                      },
                                                      child: Center(
                                                        child: Icon(Icons.edit),
                                                      ),
                                                    ),
                                                    CustomButton(
                                                      width: width * .1,
                                                      height: double.infinity,
                                                      backgroundColor:
                                                          Colors.white,
                                                      onPress: () {
                                                        ApiRdv()
                                                            .deleteCategorieById(
                                                                data[index]
                                                                    .id_categorie);
                                                        Navigator.pop(context);

                                                        showSnackBarText(
                                                            'La suppression est effectuée avec succès');
                                                      },
                                                      child: Center(
                                                        child:
                                                            Icon(Icons.delete),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        }),
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
                  readOnly: false,
                  // height: height * .09,
                  backgroundColor: Color.fromARGB(255, 36, 34, 34),
                  hintText: 'Titre de la catégorie',
                  textEditingController: _titreCategorie,
                  contentPadding: EdgeInsets.all(20),
                ),
                SizedBox(
                  height: height * .03,
                ),
                CustomInput(
                  readOnly: false,
                  width: double.infinity,
                  // height: height * .09,
                  backgroundColor: Color.fromARGB(255, 36, 34, 34),
                  hintText: "URL de l'image",
                  textEditingController: _imgCategorie,
                  contentPadding: EdgeInsets.all(20),
                ),
                SizedBox(
                  height: height * .03,
                ),
                CustomInput(
                  readOnly: false,
                  width: double.infinity,
                  // height: height * .09,
                  backgroundColor: Color.fromARGB(255, 36, 34, 34),
                  hintText: "Description",
                  textEditingController: _descriptionCategorie,
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

                        if (_titreCategorie.text == '' ||
                            _imgCategorie.text == '' ||
                            _descriptionCategorie.text == '' ||
                            widget.sexe == '') {
                          showSnackBarText('Veuillez remplir tous les champs');
                          setState(() {
                            showProgess = false;
                          });
                        } else {
                          ApiRdv().insertCategorie(
                              _titreCategorie.text,
                              _imgCategorie.text,
                              _descriptionCategorie.text,
                              widget.sexe);
                          showSnackBarText(
                              'Catégorie ${_titreCategorie.text} ajouté avec succès');

                          Get.off(
                              () => AddService(data: {
                                    'sexe': widget.sexe.toString(),
                                    'titre_categorie': _titreCategorie.text
                                  }),
                              transition: Transition.rightToLeft,
                              duration: const Duration(seconds: 1));
                          /* setState(() {
                            _titreCategorie.text = "";
                            _imgCategorie.text = "";
                            _descriptionCategorie.text = "";
                            showProgess = false;
                          }); */
                        }
                      },
                      child: showProgess
                          ? const Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 1,
                                color: Colors.black,
                              ),
                            )
                          : const Icon(Icons.arrow_right_alt),
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

  void showSnackBarText(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
      text,
      style: GoogleFonts.poppins(color: Colors.white),
    )));
  }
}
