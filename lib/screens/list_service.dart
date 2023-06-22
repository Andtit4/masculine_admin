import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m_admin/api/rdv.dart';
import 'package:m_admin/api/service.dart';
import 'package:m_admin/partials/bottom_nav_bar.dart';
import 'package:http/http.dart' as http;
import 'package:m_admin/partials/button.dart';
import 'package:m_admin/screens/view_service.dart';

class ListService extends StatefulWidget {
  const ListService({super.key});

  @override
  State<ListService> createState() => _ListServiceState();
}

class _ListServiceState extends State<ListService> {
  List<ServiceModel> service = [];
  /*  getService() async {
    const middleware = "api/service";
    var endpoint = "all";
    String apiUrl = "https://drab-puce-peacock-gear.cyclic.app/api/service/all";

    var response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      // print("___NUMBER__$telephoneuser");
      service = (jsonData as List<dynamic>)
          .map((json) => ServiceModel.fromJson(json))
          .toList();
      print(service);
      // print("__DATA___$jsonData");
      print("get all services");

      // return service;
      // return jsonData;
    } else {
      print('___ERROR____${response.statusCode}');
    }
  } */

  @override
  void initState() {
    // getService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    late double width = MediaQuery.of(context).size.width;
    late double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
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
                      'Liste des services',
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
              SizedBox(
                height: height * .08,
              ),
              SizedBox(
                width: width,
                height: height * .7,
                child: FutureBuilder(
                  future: ApiRdv().getService(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 1,
                        ),
                      );
                    }
                    List<ServiceModel> data = snapshot.data ?? [];
                    print('item length == ${data.length}');
                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: width,
                          height: height * .1,
                          color: const Color.fromARGB(255, 36, 36, 36),
                          margin:
                              EdgeInsets.only(bottom: 10, left: 5, right: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: width * .7,
                                height: height * .1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${data[index].title}  (${data[index].genre}) du   ${data[index].day_begin} - ${data[index].day_end}',
                                      style: GoogleFonts.poppins(
                                          color: Colors.white),
                                    ),
                                    Text(
                                      'Catégorie -- ${data[index].titre_categorie}',
                                      style: GoogleFonts.poppins(
                                          color: Colors.white),
                                    ),
                                    Text(
                                      'de ${data[index].heure_debut}h à ${data[index].heure_fin}h',
                                      style: GoogleFonts.poppins(
                                        fontSize: 10,
                                          color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.offAll(
                                          () => ViewService(data: data[index]),
                                          transition: Transition.leftToRight,
                                          duration: const Duration(seconds: 1));
                                      /* ApiRdv()
                                          .deleteServiceBy(data[index].id_service); */
                                      showSnackBarText(
                                          'Suppression effectuée avec succès');

                                      setState(() {
                                        data[index];
                                      });
                                    },
                                    child: CustomButton(
                                      width: width * .1,
                                      height: height * .05,
                                      backgroundColor: Colors.white,
                                      child: Icon(Icons.remove_red_eye_rounded),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      ApiRdv().deleteServiceBy(
                                          data[index].id_service);
                                      showSnackBarText(
                                          'Suppression effectuée avec succès');

                                      setState(() {
                                        data[index];
                                      });
                                    },
                                    child: CustomButton(
                                      width: width * .1,
                                      height: height * .05,
                                      backgroundColor: Colors.white,
                                      child: Icon(Icons.delete),
                                    ),
                                  ),
                                ],
                              ),
                            ],
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
