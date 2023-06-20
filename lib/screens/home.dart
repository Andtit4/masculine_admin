import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m_admin/api/rdv.dart';
import 'package:m_admin/models/rdv.dart';
import 'package:m_admin/screens/chat.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class HomeScreen extends StatefulWidget {
  final String? telephoneuser;
  const HomeScreen({super.key, this.telephoneuser});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late double width = MediaQuery.of(context).size.width;
  late double height = MediaQuery.of(context).size.height;
  late bool enabled_1 = true;
  late bool enabled_2 = false;

  late int nb = 0;
  late int nb_recu = 0;

  getNbAttente() async {
    nb = await ApiRdv().getNbAttente();
    setState(() {});
    return nb;
  }

  getNbRecu() async {
    nb_recu = await ApiRdv().getNbRecu();
    setState(() {});
    return nb_recu;
  }

  @override
  void initState() {
    super.initState();
    getNbAttente();
    getNbRecu();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height * .04,
            ),
            Row(
              children: [
                Text(
                  'Liste',
                  style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Container(
                  width: width * .2,
                  height: 1,
                  color: Colors.white,
                )
              ],
            ),
            Text(
              'de rendez-vous',
              style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(
              height: height * .02,
            ),
            Container(
              width: width * .9,
              height: height * .18,
              padding: EdgeInsets.all(10),
              // color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        enabled_1 = true;
                        enabled_2 = false;
                      });
                    },
                    child: Container(
                      width: width * .4,
                      height: height * .16,
                      decoration: BoxDecoration(
                        color: enabled_1 == true
                            ? Colors.white
                            : Color.fromARGB(255, 20, 20, 20),
                        /* border: Border.all(
                              width: .5,
                              color: Color.fromARGB(255, 177, 174, 174)) */
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Text(
                              'En attente',
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: enabled_1 == true
                                      ? Colors.black
                                      : Colors.white),
                            ),
                          ),
                          Text(
                            nb.toString(),
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: enabled_1 == true
                                    ? Colors.black
                                    : Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        enabled_1 = false;
                        enabled_2 = true;
                      });
                    },
                    child: Container(
                      width: width * .4,
                      height: height * .16,
                      decoration: BoxDecoration(
                          color: enabled_2 == true
                              ? Colors.white
                              : Color.fromARGB(255, 20, 20, 20),
                          border: Border.all(
                            width: 1,
                            /*  color: enabled_2 == true
                                  ? Colors.black
                                  : Color.fromARGB(255, 177, 174, 174) */
                          )),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Text(
                              'Reçu',
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: enabled_2 == true
                                      ? Colors.black
                                      : Colors.white),
                            ),
                          ),
                          Text(
                            nb_recu.toString(),
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: enabled_2 == true
                                    ? Colors.black
                                    : Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: width * .9,
              height: height * .5,
              child: FutureBuilder(
                  future: enabled_1 == true
                      ? ApiRdv().getAttente()
                      : ApiRdv().getRecu(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      const CircularProgressIndicator(
                        strokeWidth: 1,
                        color: Colors.white,
                      );
                    }

                    List<RdvModel> data = snapshot.data ?? [];

                    print('__ITEM_NB__${data.length}');
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return Center(
                          child: Text(
                            "Une erreur s'est produite",
                            style: GoogleFonts.poppins(color: Colors.white),
                          ),
                        );
                      case ConnectionState.waiting:
                        return Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        );
                      case ConnectionState.done:
                        return ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            /* var date =
                                DateTime.tryParse(data[index].date_create!);

                            var time_start =
                                DateTime.tryParse(data[index].date_debut!);
                            var time_go =
                                DateTime.tryParse(data[index].date_fin!); */

                            return GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                        width: width,
                                        height: height * .3,
                                        color: Colors.black,
                                        child: Column(
                                          children: [
                                            /* SizedBox(
                                          height: height * .05,
                                        ), */
                                            Container(
                                              width: double.infinity,
                                              height: height * .2,
                                              padding: const EdgeInsets.all(15),
                                              // color: Colors.black,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: .1,
                                                      color: Colors.white)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          const Icon(
                                                              Icons.message,
                                                              color:
                                                                  Colors.white),
                                                          Text(
                                                            ' TE-${data[index].id_rdv}',
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    color: Colors
                                                                        .white),
                                                          )
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          const Icon(
                                                              Icons.person,
                                                              color:
                                                                  Colors.white),
                                                          Text(
                                                            '${data[index].nomuser} ${data[index].prenomuser}',
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    color: Colors
                                                                        .white),
                                                          )
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          const Icon(
                                                              Icons
                                                                  .calendar_month,
                                                              color:
                                                                  Colors.white),
                                                          Text(
                                                            '${data[index].day}',
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    fontSize:
                                                                        10,
                                                                    color: Colors
                                                                        .white),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          const Icon(
                                                              Icons
                                                                  .supervised_user_circle,
                                                              color:
                                                                  Colors.white),
                                                          SizedBox(
                                                            width: width * .23,
                                                            child: Text(
                                                              '${data[index].titre}',
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                      fontSize:
                                                                          10,
                                                                      color: Colors
                                                                          .white),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          const Icon(
                                                              Icons.history,
                                                              color:
                                                                  Colors.white),
                                                          Container(
                                                            // margin: EdgeInsets.only(left: 20),
                                                            child: Text(
                                                              ' ${data[index].status}',
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                      fontSize:
                                                                          10,
                                                                      color: Colors
                                                                          .green),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          const Icon(
                                                              Icons
                                                                  .monetization_on_rounded,
                                                              color:
                                                                  Colors.white),
                                                          Text(
                                                            ' ${data[index].montant}',
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    fontSize:
                                                                        10,
                                                                    color: Colors
                                                                        .white),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(
                                                  "Option:",
                                                  style: GoogleFonts.poppins(
                                                      color: Colors.white),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    IconButton(
                                                        onPressed: () {},
                                                        icon: Icon(
                                                          Icons.calendar_month,
                                                          color: Colors.white,
                                                        )),
                                                    IconButton(
                                                        onPressed: () {
                                                          Get.to(() =>
                                                              ChatScreenAdmin(
                                                                data:
                                                                    data[index],
                                                                telephoneuser:
                                                                    widget
                                                                        .telephoneuser,
                                                              ));

                                                          /* Send().launchWhatsApp(
                                                          22898418900,
                                                          "Je suis ${data[index].nomuser} pour la réservation de ${data[index].titre}"); */
                                                        },
                                                        icon: Icon(
                                                          Icons.sms,
                                                          color: Colors.white,
                                                        )),
                                                    IconButton(
                                                        onPressed: () {
                                                          Alert(
                                                              context: context,
                                                              desc:
                                                                  'Voulez-vous supprimer votre demande du ${data[index].date_create} programmé le ${data[index].day} pour ${data[index].date_debut} à ${data[index].date_fin}',
                                                              buttons: [
                                                                DialogButton(
                                                                    width:
                                                                        width *
                                                                            .3,
                                                                    color: Colors
                                                                        .black,
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        'Confirmer',
                                                                        style: GoogleFonts.poppins(
                                                                            color:
                                                                                Colors.white),
                                                                      ),
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                      ApiRdv().deleteRdv(
                                                                          data[index]
                                                                              .id_rdv);
                                                                      // Api().updateRdv(date_debut, date_fin, date_create, widget.telephoneuser, data[index].id_rdv);
                                                                      setState(
                                                                          () {
                                                                        data[
                                                                            index];
                                                                      });
                                                                      showSnackBarText(
                                                                          'Votre rendez-vous est supprimé');
                                                                      Navigator.pop(
                                                                          context);
                                                                    }),
                                                                DialogButton(
                                                                    width:
                                                                        width *
                                                                            .3,
                                                                    color: Colors
                                                                        .red,
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        'Annuler',
                                                                        style: GoogleFonts.poppins(
                                                                            color:
                                                                                Colors.white),
                                                                      ),
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    })
                                                              ]).show();
                                                        },
                                                        icon: Icon(
                                                          Icons.delete,
                                                          color: Colors.white,
                                                        )),
                                                    IconButton(
                                                        onPressed: () {
                                                          ApiRdv()
                                                              .updateStatus1(
                                                                  data[index]
                                                                      .id_rdv);
                                                          setState(() {
                                                            data[index].status;
                                                          });
                                                          showSnackBarText(
                                                              "Vous venez de modifier l'état de la demande");
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        icon: Icon(
                                                            Icons.refresh,
                                                            color:
                                                                Colors.white))
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    });
                              },
                              child: Container(
                                width: double.infinity,
                                height: height * .22,
                                padding: const EdgeInsets.all(15),
                                // color: Colors.black,
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 24, 23, 23)
                                    /* border:
                                    Border.all(width: .1, color: Colors.white) */
                                    ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(Icons.message,
                                                color: Colors.white),
                                            Text(
                                              ' TE-${data[index].id_rdv}',
                                              style: GoogleFonts.poppins(
                                                  color: Colors.white),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Icon(Icons.person,
                                                color: Colors.white),
                                            Text(
                                              '${data[index].nomuser} ${data[index].prenomuser}',
                                              style: GoogleFonts.poppins(
                                                  color: Colors.white),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Icon(Icons.calendar_month,
                                                color: Colors.white),
                                            Text(
                                              '${data[index].date_debut} de ${data[index].date_fin}',
                                              style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  color: Colors.white),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(
                                                Icons.supervised_user_circle,
                                                color: Colors.white),
                                            SizedBox(
                                              width: width * .23,
                                              child: Text(
                                                '${data[index].titre}',
                                                style: GoogleFonts.poppins(
                                                    fontSize: 10,
                                                    color: Colors.white),
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Icon(Icons.history,
                                                color: Colors.white),
                                            Container(
                                              // margin: EdgeInsets.only(left: 20),
                                              child: Text(
                                                '  ${data[index].status}',
                                                style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    color: Colors.green),
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                                Icons.monetization_on_rounded,
                                                color: Colors.white),
                                            Text(
                                              ' ${data[index].montant}',
                                              style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  color: Colors.white),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      case ConnectionState.none:
                        return Center(
                          child: Text(
                            "Erreur lors de l'établissement de la connexion ",
                            style: GoogleFonts.poppins(color: Colors.white),
                          ),
                        );
                      default:
                        return Text(
                          'Erreur inconnue',
                          style: GoogleFonts.poppins(color: Colors.white),
                        );
                    }
                    /* if (data.length == 0) {
                      return Center(
                        child: Text(
                          'Aucune demande',
                          style: GoogleFonts.poppins(color: Colors.white),
                        ),
                      );
                    } else {} */
                  }),
            )
          ],
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
