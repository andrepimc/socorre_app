import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socorre_app/models/adress_model.dart';
import 'package:socorre_app/services/store/user_store.dart';

class LocalStorageRepo {
  static const String keyAdress = 'clients-key';

  static selectAdress(AdressModel adress) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      keyAdress,
      jsonEncode({"adressSelected": adress}),
    );
   await GetIt.I<UserStore>().getAdress(adress);
  }

  static recoverSelectedAdress() async {
    var prefs = await SharedPreferences.getInstance();
    var jsonRes = prefs.getString(keyAdress);
    if (jsonRes == null) {
      return null;
    }
    var map = jsonDecode(jsonRes);
    AdressModel adress = AdressModel.fromJson(map["adressSelected"]);
    return adress;
  }

  static deleteAdressStorage() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.remove(keyAdress);
  }
}
