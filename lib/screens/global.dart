import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m_admin/api/rdv.dart';
import 'package:m_admin/models/global.dart';

class GlobalNotif extends StatefulWidget {
  const GlobalNotif({super.key});

  @override
  State<GlobalNotif> createState() => _GlobalNotifState();
}

class _GlobalNotifState extends State<GlobalNotif> {
  late double width = MediaQuery.of(context).size.width;
  late double height = MediaQuery.of(context).size.height;
  late bool select = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                SizedBox(
                  height: height * .06,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: width * .2,
                        height: height * .09,
                        color: Color.fromARGB(255, 17, 16, 16),
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text(
                      'Notifications ',
                      style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox()
                  ],
                )
                /* Row(
                  children: [
                    Text(
                      'Masculine ',
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'vos notifications',
                      style: GoogleFonts.poppins(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ), */
                ,
                SizedBox(
                    height: height * .8,
                    width: width * .9,
                    child: FutureBuilder(
                      future: ApiRdv().getGlobalNotif(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData)
                          return Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 1,
                              color: Colors.white,
                            ),
                          );

                        List<GlobalNotifModel> data = snapshot.data;

                        if (data.length == 0) {
                          return Center(
                            child: Text(
                              'Aucune notification',
                              style: GoogleFonts.poppins(color: Colors.white),
                            ),
                          );
                        } else {
                          return ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              var date =
                                  DateTime.tryParse(data[index].date_create);
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    select = !select;
                                  });
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: height * .18,
                                  padding: EdgeInsets.all(15),
                                  margin: EdgeInsets.only(bottom: 20),
                                  // color: Colors.black,
                                  decoration: BoxDecoration(
                                      color:
                                          select ? Colors.black : Colors.white,
                                      border: Border.all(
                                          width: .1,
                                          color: select
                                              ? Colors.white
                                              : Colors.black)),
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Column(
                                          children: [
                                            Text(
                                              "${date!.day}/${date.month}/${date.year} - ${date.hour}:${date.minute}:${date.second}",
                                              style: GoogleFonts.poppins(
                                                  color: select
                                                      ? Colors.white
                                                      : Colors.black),
                                            ),
                                            Container(
                                              width: width * .1,
                                              height: 1,
                                              margin:
                                                  EdgeInsets.only(bottom: 10),
                                              color: select
                                                  ? Colors.white
                                                  : Colors.black,
                                            )
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(Icons.messenger_outline_sharp,
                                              color: select
                                                  ? Colors.white
                                                  : Colors.black),
                                          SizedBox(
                                            width: width * .75,
                                            child: Text(
                                              data[index].content,
                                              maxLines: 5,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.poppins(
                                                  color: select
                                                      ? Colors.white
                                                      : Colors.black),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                    )),
              ],
            ),
          )),
    );
  }
}
