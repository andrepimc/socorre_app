import 'package:mobx/mobx.dart';
import 'package:socorre_app/models/adress_model.dart';
import 'package:socorre_app/models/user_model.dart';
part 'user_store.g.dart';

class UserStore = _UserStoreBase with _$UserStore;

abstract class _UserStoreBase with Store {
  @observable
  UserModel user = UserModel();

  @action
  getUser(UserModel _user) {
    user = _user;
  }

  @observable
  dynamic adressSelected;

  @action
  getAdress(AdressModel adress) {
    adressSelected = adress;
  }
}