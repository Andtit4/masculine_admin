import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m_admin/api/rdv.dart';
import 'package:m_admin/models/rdv.dart';

class PlanifScreen extends StatefulWidget {
  final String? telephoneuser;
  const PlanifScreen({super.key, this.telephoneuser});

  @override
  State<PlanifScreen> createState() => _PlanifScreenState();
}

class _PlanifScreenState extends State<PlanifScreen> {
  late double width = MediaQuery.of(context).size.width;
  late double height = MediaQuery.of(context).size.height;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height * .05,
            ),
            Container(
              margin: EdgeInsets.only(top: height * .03, bottom: height * .02),
              padding: EdgeInsets.only(left: 20),
              child: Text(
                'Liste des Finances',
                style: GoogleFonts.poppins(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            /*  SizedBox(
              height: height * .05,
            ), */
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: width,
                height: height * .8,
                child: FutureBuilder(
                  future: ApiRdv().getAll(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData)
                      return Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      );

                    List<RdvModel> data = snapshot.data ?? [];

                    return ListView.builder(
                        itemCount: data.length,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container(
                            width: width * .8,
                            height: height * .2,
                            margin: EdgeInsets.only(bottom: 10),
                            color: Color.fromARGB(255, 27, 27, 27),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                      Text(
                                        data[index].status!,
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
                                      const Icon(Icons.attach_money,
                                          color: Colors.white),
                                      Text(
                                        '${data[index].montant}',
                                        style: GoogleFonts.poppins(
                                            color: Colors.white),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.payment,
                                          color: Colors.white),
                                      Text(
                                        '${data[index].mode_payement}',
                                        style: GoogleFonts.poppins(
                                            color: Colors.white),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
