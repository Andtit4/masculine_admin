import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m_admin/api/rdv.dart';
import 'package:m_admin/api/service.dart';
import 'package:m_admin/screens/add_service.dart';
// import 'package:m_admin/api/user.dart';

class PlannifScreen extends StatefulWidget {
  final String? telephoneuser;
  const PlannifScreen({super.key, this.telephoneuser});

  @override
  State<PlannifScreen> createState() => _PlannifScreenState();
}

class _PlannifScreenState extends State<PlannifScreen> {
  late double width = MediaQuery.of(context).size.width;
  late double height = MediaQuery.of(context).size.height;
  @override
  void initState() {
    super.initState();
    ApiRdv().getService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.off(() => AddService(),
              transition: Transition.rightToLeft,
              duration: Duration(seconds: 1));
        },
        backgroundColor: Colors.white,
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height * .06,
            ),
            Text(
              'Service\net planification ',
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            Container(
              width: width * .3,
              height: 2,
              margin: EdgeInsets.only(top: 10),
              color: Colors.white,
            ),
            SizedBox(
              width: width,
              height: height * .7,
              child: FutureBuilder(
                future: ApiRdv().getService(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    const CircularProgressIndicator(
                      strokeWidth: 1,
                      color: Colors.white,
                    );
                  }

                  List<ServiceModel> data = snapshot.data ?? [];
                  return ListView.builder(
                    itemCount: data.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        width: width,
                        height: height * .27,
                        margin: EdgeInsets.only(bottom: 15),
                        color: Color.fromARGB(255, 26, 25, 25),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: width * .4,
                                    height: height * .1,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                        color: Colors.transparent),
                                    child: CachedNetworkImage(
                                      imageUrl: data[index].img_url!,
                                    ),
                                  ),
                                  Text(
                                    data[index].genre!,
                                    style: GoogleFonts.poppins(
                                        color: Colors.white),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.history_edu_outlined,
                                          color: Colors.white),
                                      Text(
                                        ' SERVICE-${data[index].id_service}',
                                        style: GoogleFonts.poppins(
                                            color: Colors.white),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.bookmark_border,
                                      color: Colors.white),
                                  Text(
                                    '  ${data[index].title} ',
                                    style: GoogleFonts.poppins(
                                        fontSize: 12, color: Colors.white),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.timelapse,
                                      color: Colors.white),
                                  Text(
                                    '  ${data[index].heure_debut!} à ${data[index].heure_fin!}',
                                    style: GoogleFonts.poppins(
                                        fontSize: 12, color: Colors.white),
                                  )
                                ],
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
    );
  }
}
