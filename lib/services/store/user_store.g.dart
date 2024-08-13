// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserStore on _UserStoreBase, Store {
  late final _$userAtom = Atom(name: '_UserStoreBase.user', context: context);

  @override
  UserModel get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(UserModel value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  late final _$adressSelectedAtom =
      Atom(name: '_UserStoreBase.adressSelected', context: context);

  @override
  dynamic get adressSelected {
    _$adressSelectedAtom.reportRead();
    return super.adressSelected;
  }

  @override
  set adressSelected(dynamic value) {
    _$adressSelectedAtom.reportWrite(value, super.adressSelected, () {
      super.adressSelected = value;
    });
  }

  late final _$_UserStoreBaseActionController =
      ActionController(name: '_UserStoreBase', context: context);

  @override
  dynamic getUser(UserModel _user) {
    final _$actionInfo = _$_UserStoreBaseActionController.startAction(
        name: '_UserStoreBase.getUser');
    try {
      return super.getUser(_user);
    } finally {
      _$_UserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic getAdress(AdressModel adress) {
    final _$actionInfo = _$_UserStoreBaseActionController.startAction(
        name: '_UserStoreBase.getAdress');
    try {
      return super.getAdress(adress);
    } finally {
      _$_UserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
user: ${user},
adressSelected: ${adressSelected}
    ''';
  }
}
