import 'package:search_cep/search_cep.dart';

class CepService {
  static Future cepRetrieve(String cep) async {
    final viaCepSearchCep = ViaCepSearchCep();
    final infoCepJSON = await viaCepSearchCep.searchInfoByCep(cep: cep.replaceAll('-', ''));
    // if (infoCepJSON.runtimeType == ViaCepInfo) {
      
    // } else {
      
    // }
    return infoCepJSON;
  }
}
