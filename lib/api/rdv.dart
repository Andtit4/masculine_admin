import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:m_admin/api/service.dart';
import 'package:m_admin/models/categorieModel.dart';
import 'package:m_admin/models/global.dart';
import 'package:m_admin/models/message.dart';
import 'package:m_admin/models/rdv.dart';

class ApiRdv {
  List<RdvModel> rdv = [];
  List<Message> message = [];
  List<ServiceModel> service = [];
  List<GlobalNotifModel> global = [];
  List<CategorieModel> categories = [];
  var nb = 0;
  initializeEndPoint(middlware, endpoint) async {
    // final url = "https://masuline-grkb.onrender.com/$middlware/$endpoint";
    final url =
        "https://drab-puce-peacock-gear.cyclic.app/$middlware/$endpoint";
    // final url = "http://192.168.100.40:3000/$middlware/$endpoint";
    return url;
  }

  createGlobal(content) async {
    const middleware = "api/global";
    var endpoint = "notif/create";
    String apiUrl = await initializeEndPoint(middleware, endpoint);

    var response = await http
        .post(Uri.parse(apiUrl), body: {'content': content.toString()});

    if (response.statusCode == 200) {
      print('___CREATE__NOTIF__OK');
    } else {
      print('___ERROR____${response.statusCode}');
    }
  }

  getGlobalNotif() async {
    const middleware = "api/global";
    var endpoint = "notif";
    String apiUrl = await initializeEndPoint(middleware, endpoint);
    var response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      // print("___NUMBER__$telephoneuser");
      print("ALL___DATA___GET");
      print("__DATA___${jsonData}");
      global = (jsonData as List<dynamic>)
          .map((json) => GlobalNotifModel.fromJson(json))
          .toList();

      return global;
      // return jsonData;
    } else {
      print('___ERROR____${response.statusCode}');
    }
  }

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

  getNbAttente() async {
    const middleware = "api/rdv";
    var endpoint = "nb/attente";
    String apiUrl = await initializeEndPoint(middleware, endpoint);
    var response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      nb = jsonData[0]['nb'];
      print("__NB__ATTENTE__$nb");

      return nb;
    } else {
      print('___ERROR____${response.statusCode}');
    }
  }

  getNbRecu() async {
    const middleware = "api/rdv";
    var endpoint = "nb/recu";
    String apiUrl = await initializeEndPoint(middleware, endpoint);
    var response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      nb = jsonData[0]['nb'];
      print("__NB__RECU__$nb");

      return nb;
    } else {
      print('___ERROR____${response.statusCode}');
    }
  }

  getAttente() async {
    const middleware = "api/rdv";
    var endpoint = "attente";
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

  getService() async {
    const middleware = "api/service";
    var endpoint = "all";
    String apiUrl = await initializeEndPoint(middleware, endpoint);

    var response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      // print("___NUMBER__$telephoneuser");
      print("ALL___DATA___GET");
      print("__DATA___$jsonData");
      service = (jsonData as List<dynamic>)
          .map((json) => ServiceModel.fromJson(json))
          .toList();

      return service;
      // return jsonData;
    } else {
      print('___ERROR____${response.statusCode}');
    }
  }

  getCategorie() async{
    const middleware = "api/categorie";
    var endpoint = "all";
    String apiUrl = await initializeEndPoint(middleware, endpoint);

    var response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      // print("___NUMBER__$telephoneuser");
      print("ALL__GET__categories");
      print("__DATA___$jsonData");
      categories = (jsonData as List<dynamic>)
          .map((json) => CategorieModel.fromJson(json))
          .toList();

      return categories;
      // return jsonData;
    } else {
      print('___ERROR____${response.statusCode}');
    }
  }

  getRecu() async {
    const middleware = "api/rdv";
    var endpoint = "recu";
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

// FUNCTION CONCERN SERVICE'S CATEGORIES

  insertCategorie(
      titre_categorie, img_categorie, description_categorie, sexe) async {
    const middleware = "api/categorie";
    var endpoint = "create";
    String apiUrl = await initializeEndPoint(middleware, endpoint);

    var response = await http.post(Uri.parse(apiUrl), body: {
      'titre_categorie': titre_categorie.toString(),
      'img_categorie': img_categorie.toString(),
      'description_categorie': description_categorie.toString(),
      'sexe': sexe.toString()
    });

    if (response.statusCode == 200) {
      print('___MESSAGE_SEND____');
    } else {
      print('___ERROR __WHILE__CREATING_CATEGORY____${response.statusCode}');
    }
  }

  getAllCategories() async {
    const middleware = "api/categorie";
    var endpoint = "";
    String apiUrl = await initializeEndPoint(middleware, endpoint);

    var response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      categories = (jsonData as List<dynamic>)
          .map((json) => CategorieModel.fromJson(json))
          .toList();
      return categories;
    } else {
      print('___ERROR__GETTING_CATEGORIES__${response.statusCode}');
    }
  }

  deleteCategorieById(id_categorie) async {
    const middleware = "api/categorie";
    var endpoint = "?id_categorie=$id_categorie";
    String apiUrl = await initializeEndPoint(middleware, endpoint);

    var response = await http.delete(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      print('___CATEGORIE_DELETE____');
    } else {
      print('___ERROR __WHILE__DELETING_CATEGORY____${response.statusCode}');
    }
  }

  // concern table services

  insertService(
    title,
    heure_debut,
    heure_fin,
    genre,
    description,
    img_url,
    titre_categorie,
    montant,
    day_begin,
    day_end,
  ) async {
    const middleware = "api/service";
    var endpoint = "create";
    String apiUrl = await initializeEndPoint(middleware, endpoint);
    var response = await http.post(Uri.parse(apiUrl), body: {
      'title': title.toString(),
      'heure_debut': heure_debut.toString(),
      'heure_fin': heure_fin.toString(),
      'genre': genre.toString(),
      'description': description.toString(),
      'img_url': img_url.toString(),
      'titre_categorie': titre_categorie.toString(),
      'montant': montant.toString(),
      'day_begin': day_begin.toString(),
      'day_end': day_end.toString()
    });
    if (response.statusCode == 200) {
      print('___SERVICE_ADD_SUCCESS____');
    } else {
      print('___ERROR __WHILE__ADDING_SETRVICE_${response.statusCode}');
    }
  }

  deleteServiceBy(id_service) async {
    const middleware = "api/service";
    var endpoint = "?id_service=$id_service";
    String apiUrl = await initializeEndPoint(middleware, endpoint);
    var response = await http.delete(Uri.parse(apiUrl));
     if (response.statusCode == 200) {
      print('___SERVICE_DELETE____');
    } else {
      print('___ERROR __WHILE__DELETING_SERVICE_${response.statusCode}');
    }
  }
}
