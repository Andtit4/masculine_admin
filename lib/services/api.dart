// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:m_admin/models/message.dart';
import 'package:m_admin/models/notification.dart';
import 'package:m_admin/models/rdv.dart';
import 'package:m_admin/models/user.dart';


class Api extends StatefulWidget {
  Api({super.key});

  List<RdvModel> rdv = [];
  List<Message> message = [];
  List<NotificationModel> notifications = [];
  List<UserModel> users = [];

  initializeEndPoint(middlware, endpoint) async {
    // final url = "https://masuline-grkb.onrender.com/$middlware/$endpoint";
/*       final url =
        "https://drab-puce-peacock-gear.cyclic.app/$middlware/$endpoint"; */

    final url = "http://192.168.100.40:3000/$middlware/$endpoint";

    // final middlewarre = ""
    return url;
  }

  insertOtp(nomuser, prenomuser, telephoneuser) async {
    const middleware = "api/user";
    const endpoint = "create";

    String apiUrl = await initializeEndPoint(middleware, endpoint);

    var response = await http.post(Uri.parse(apiUrl), body: {
      'nomuser': nomuser,
      'prenomuser': prenomuser,
      'telephoneuser': telephoneuser,
      'type_compte': 'USER'
    });

    if (response.statusCode == 200) {
      print('___INSERT___SUCCESS___');
    } else {
      print('___ERROR____${response.statusCode}');
    }
  }

  alreadyExiste(telephoneuser) async {
    const middleware = "api/user";
    var endpoint = "nb?telephoneuser=${telephoneuser.toString()}";
    String apiUrl = await initializeEndPoint(middleware, endpoint);

    var response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      print("___INSERT___SUCCESS___${jsonData[0]['nb']}");
      return jsonData[0]['nb'];
    } else {
      print('___ERROR____${response.statusCode}');
    }
  }

  // NOTIFICATIONS
  insertnotif(telephoneuser, content) async {
    const middleware = "api/notif";
    var endpoint = "create";
    String apiUrl = await initializeEndPoint(middleware, endpoint);
    var response = await http.post(Uri.parse(apiUrl), body: {
      'telephoneuser': telephoneuser.toString(),
      'content': content.toString(),
    });

    if (response.statusCode == 200) {
      // var jsonData = json.decode(response.body);
      print("___INSERT___SUCCESS___NOTIFICATION");
      // return jsonData[0]['nb'];
    } else {
      print('___ERROR____${response.statusCode}');
    }
  }

  getNotif(telephoneuser) async {
    const middleware = "api/notif";
    var endpoint = "all?telephoneuser=$telephoneuser";
    String apiUrl = await initializeEndPoint(middleware, endpoint);
    var response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      // print("___NUMBER__$telephoneuser");
      print("ALL___DATA___GET");
      print("__DATA___${jsonData}");
      notifications = (jsonData as List<dynamic>)
          .map((json) => NotificationModel.fromJson(json))
          .toList();

      return notifications;
      // return jsonData;
    } else {
      print('___ERROR____${response.statusCode}');
    }
  }

  getNbNotif(telephoneuser) async {
    const middleware = "api/notif";
    var endpoint = "nb?telephoneuser=$telephoneuser";
    String apiUrl = await initializeEndPoint(middleware, endpoint);

    var response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      print('___RESPONSE__FROM__API___${jsonData[0]['nb']}');
      return jsonData[0]['nb'];
    } else {
      print('___ERROR____${response.statusCode}');
    }
  }

  insertDemande(
    titre,
    description,
    montant,
    date_debut,
    date_fin,
    telephoneuser,
    mode_payement
  ) async {
    const middleware = "api/rdv";
    var endpoint = "create";
    String apiUrl = await initializeEndPoint(middleware, endpoint);

    var response = await http.post(Uri.parse(apiUrl), body: {
      'titre': titre.toString(),
      'description': description.toString(),
      'montant': montant.toString(),
      'date_debut': date_debut.toString(),
      'date_fin': date_fin.toString(),
      'telephoneuser': telephoneuser.toString(),
      'status': 'En attente',
      'mode_payement': mode_payement.toString(),
    });

    if (response.statusCode == 200) {
      // var jsonData = json.decode(response.body);
      insertnotif(telephoneuser,
          'Vous avez fait une demande de $titre pour le montant de $montant ce $date_debut');

      print("___INSERT___SUCCESS___demande");
      // return jsonData[0]['nb'];
    } else {
      print('___ERROR____${response.statusCode}');
    }
  }

  getTypeUser(telephoneuser) async {
    print('___FROM_API___GET__NUMBER_FROM__TYPEUSER__$telephoneuser');
    const middleware = "api/user";
    var endpoint = "?telephoneuser=${telephoneuser.toString()}";
    String apiUrl = await initializeEndPoint(middleware, endpoint);
    var response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      var jsonData = await json.decode(response.body);
      var type = jsonData[0]['type_compte'];
      print("______TYPE___${type}");
      return type;
    } else {
      print('___ERROR____${response.statusCode}');
    }
  }

  getUser(telephoneuser) async {
    print('___FROM_API___GET__USER_INFORMATION__$telephoneuser');
    const middleware = "api/user";
    var endpoint = "?telephoneuser=${telephoneuser.toString()}";
    String apiUrl = await initializeEndPoint(middleware, endpoint);
    var response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      var jsonData = await json.decode(response.body);
      users = (jsonData as List<dynamic>)
          .map((json) => UserModel.fromJson(json))
          .toList();
      return users;
    } else {
      print('___ERROR____${response.statusCode}');
    }
  }

  updateUser(nomuser, prenomuser, telephoneuser, id) async {
    const middleware = "api/user";
    var endpoint = "update";
    String apiUrl = await initializeEndPoint(middleware, endpoint);
    var response = await http.put(Uri.parse(apiUrl), body: {
      'nomuser': nomuser.toString(),
      'prenomuser': prenomuser.toString(),
      'telephoneuser': telephoneuser.toString(),
      'id': id.toString()
    });

    if (response.statusCode == 200) {
      print('___UPDATED____');
    } else {
      print('___ERROR____${response.statusCode}');
    }
  }

  Future getAll() async {
    const middleware = "api/rdv";
    var endpoint = "all";
    String apiUrl = await initializeEndPoint(middleware, endpoint);

    var response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      // print("___NUMBER__$telephoneuser");
      print("ALL___DATA___GET");
      print("__DATA___${jsonData}");
      rdv = (jsonData as List<dynamic>)
          .map((json) => RdvModel.fromJson(json))
          .toList();

      return rdv;
      // return jsonData;
    } else {
      print('___ERROR____${response.statusCode}');
    }
  }

  getDemandeBy(telephoneuser) async {
    const middleware = "api/rdv";
    var endpoint = "?telephoneuser=$telephoneuser";
    String apiUrl = await initializeEndPoint(middleware, endpoint);

    var response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      print('__GET_DEMAND_LIST__');
      print("___NUMBER__$telephoneuser");
      print("___DATA___GET");
      print("__DATA___${jsonData}");
      rdv = (jsonData as List<dynamic>)
          .map((json) => RdvModel.fromJson(json))
          .toList();
      print('__GETTING__FINISH_DEMAND_LIST');

      return rdv;
      // return jsonData;
    } else {
      print('___ERROR____${response.statusCode}');
    }
  }

  updateRdv(date_debut, date_fin, date_create, telephoneuser, id_rdv) async {
    const middleware = "api/rdv";
    var endpoint = "update";
    String apiUrl = await initializeEndPoint(middleware, endpoint);

    var response = await http.put(Uri.parse(apiUrl), body: {
      'date_debut': date_debut.toString(),
      'date_fin': date_fin.toString(),
      'date_create': date_create.toString(),
      'telephoneuser': telephoneuser.toString(),
      'id_rdv': id_rdv.toString()
    });

    if (response.statusCode == 200) {
      print('___UPDATED____');
    } else {
      print('___ERROR____${response.statusCode}');
    }
  }

  updateStatus1(id_rdv) async {
    const middleware = "api/rdv";
    var endpoint = "update/status";
    String apiUrl = await initializeEndPoint(middleware, endpoint);

    var response = await http.put(Uri.parse(apiUrl),
        body: {'status': 'Reçu', 'id_rdv': id_rdv.toString()});

    if (response.statusCode == 200) {
      print('___UPDATED____');
    } else {
      print('___ERROR____${response.statusCode}');
    }
  }

  addMessage(from_num, to_num, content, nom, id_rdv) async {
    const middleware = "api/message";
    var endpoint = "create";
    String apiUrl = await initializeEndPoint(middleware, endpoint);

    var response = await http.post(Uri.parse(apiUrl), body: {
      'from_num': from_num.toString(),
      'to_num': to_num.toString(),
      'content': '${nom.toString()}:  ${content.toString()}',
      'id_rdv': id_rdv.toString()
    });
    if (response.statusCode == 200) {
      print('___MESSAGE_SEND____');
    } else {
      print('___ERROR __WHILE__SENDING____${response.statusCode}');
    }
  }

  getMessageBy(id_rdv, from_num) async {
    const middleware = "api/message";
    var endpoint = "?id_rdv=$id_rdv&from_num=$from_num";
    String apiUrl = await initializeEndPoint(middleware, endpoint);

    var response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      print('___UPDATED____');
      var jsonData = json.decode(response.body);
      // print("___NUMBER__$telephoneuser");
      print("___MESSAGE");
      print("__DATA___${jsonData}");
      message = (jsonData as List<dynamic>)
          .map((json) => Message.fromJson(json))
          .toList();
      return message;
    } else {
      print('___ERROR____${response.statusCode}');
    }
  }

  deleteRdv(id_rdv) async {
    const middleware = "api/rdv";
    var endpoint = "?id_rdv=$id_rdv";
    String apiUrl = await initializeEndPoint(middleware, endpoint);
    var response = await http.delete(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      print('___DELETED____');
    } else {
      print('___ERROR____${response.statusCode}');
    }
  }

  @override
  State<Api> createState() => _ApiState();
}

class _ApiState extends State<Api> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
