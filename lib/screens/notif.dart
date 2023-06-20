import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m_admin/api/rdv.dart';
import 'package:m_admin/api/user.dart';
import 'package:m_admin/models/user.dart';
import 'package:m_admin/screens/global.dart';
import 'package:m_admin/widget/input.dart';

class NotifScreen extends StatefulWidget {
  final String? telephoneuser;
  const NotifScreen({super.key, this.telephoneuser});

  @override
  State<NotifScreen> createState() => _NotifScreenState();
}

class _NotifScreenState extends State<NotifScreen>
    with TickerProviderStateMixin {
  late double width = MediaQuery.of(context).size.width;
  late double height = MediaQuery.of(context).size.height;
  late bool showprogress = false;
  late String notiftext = "";

  late final AnimationController _controller = AnimationController(
    duration: Duration(seconds: 2),
    vsync: this,
  )
    ..forward()
    ..addListener(() {
      if (_controller.isCompleted) {
        _controller.stop();
      }
    });

  TextEditingController _notifTextController = TextEditingController();
  TextEditingController _notifController = TextEditingController();

  @override
  void initState() {
    super.initState();
    ApiUser().getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * .06,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Notifications',
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  IconButton(
                      onPressed: () {
                        Get.to(() => GlobalNotif());
                      },
                      icon: Icon(
                        Icons.history,
                        color: Colors.white,
                      ))
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  height: height * .1,
                  child: TextField(
                    // on
                    controller: _notifTextController,
                    style: GoogleFonts.poppins(color: Colors.white),
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 50, horizontal: 10),
                        filled: true,
                        hintText: 'Entrez le contenu',
                        hintStyle: GoogleFonts.poppins(color: Colors.white),
                        fillColor: Color.fromARGB(255, 20, 20, 20),
                        enabledBorder:
                            OutlineInputBorder(borderSide: BorderSide.none),
                        focusedBorder:
                            OutlineInputBorder(borderSide: BorderSide.none)),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      showprogress = true;
                    });
                    ApiRdv().createGlobal(_notifTextController.text);
                    showSnackBarText('Notification ajoutée avec succès');
                    setState(() {
                      showprogress = false;
                      _notifTextController.text = '';
                    });
                  },
                  child: Container(
                    width: width * .3,
                    height: height * .08,
                    color: Color.fromARGB(255, 20, 20, 20),
                    child: Center(
                      child: showprogress == true
                          ? CircularProgressIndicator(
                              strokeWidth: 1,
                              color: Colors.white,
                            )
                          : Text(
                              'Envoyer',
                              style: GoogleFonts.poppins(color: Colors.white),
                            ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * .03,
              ),
              /*  Container(
                width: width * .3,
                height: 2,
                color: Colors.white,
              ), */
              SizedBox(
                width: width,
                height: height * .6,
                child: FutureBuilder(
                  future: ApiUser().getAll(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      const CircularProgressIndicator(
                        strokeWidth: 1,
                        color: Colors.white,
                      );
                    }

                    List<UserModel> data = snapshot.data ?? [];
                    return ListView.builder(
                      itemCount: data.length,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          width: width,
                          height: height * .22,
                          margin: EdgeInsets.only(bottom: 15),
                          color: Color.fromARGB(255, 26, 25, 25),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
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
                                          ' TE-${data[index].id}',
                                          style: GoogleFonts.poppins(
                                              color: Colors.white),
                                        )
                                      ],
                                    ),
                                    Text(
                                      data[index].telephoneuser!,
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
                                      '${data[index].type_compte}',
                                      style: GoogleFonts.poppins(
                                          color: Colors.white),
                                    )
                                  ],
                                ),
                                Container(
                                  height: height * .09,
                                  margin: EdgeInsets.only(top: 10),
                                  child: TextField(
                                    readOnly: false,

                                    // on
                                    // controller: _notifController,
                                    onChanged: (String value) {
                                      notiftext = value;
                                      /* setState(() {
                                      }); */
                                      print(
                                          '\n\nnotiftext______${notiftext.toString()}');
                                    },
                                    style: GoogleFonts.poppins(
                                        color: Colors.white),
                                    decoration: InputDecoration(
                                        /*  contentPadding:
                                            EdgeInsets.symmetric(vertical: 50), */

                                        filled: true,
                                        hintText: 'Envoyer une notification',
                                        hintStyle: GoogleFonts.poppins(
                                            color: Colors.white),
                                        fillColor: Color.fromARGB(255, 0, 0, 0),
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            ApiRdv().insertnotif(
                                                data[index].telephoneuser,
                                                notiftext);
                                            setState(() {
                                              notiftext == "";
                                            });

                                            showSnackBarText(
                                                'Notification envoyé!');
                                          },
                                          icon: Icon(
                                            Icons.send,
                                            color: Colors.white,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white,
                                                width: .8))),
                                  ),
                                ),
                                /*  Row(
                                      children: [
                                        const Icon(Icons.payment,
                                            color: Colors.white),
                                        Text(
                                          '${data[index].telephoneuser}',
                                          style: GoogleFonts.poppins(
                                              color: Colors.white),
                                        )
                                      ],
                                    ) */
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
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
