import 'package:socorre_app/main.dart';

class AdressesService {
  getByUserId(String userId) async {
    final data =
        await supabase.from("adresses").select().eq("profile_id", userId);
    return data;
  }

  createNew(
      String profile_id,
      String cep,
      String rua,
      String bairro,
      String numero,
      String cidade,
      String uf,
      String? complemento,
      String? ponto_ref,
      String? nome) async {
    final data = await supabase.from("adresses").insert({
      "profile_id": profile_id,
      "cep": cep,
      "rua": rua,
      "bairro": bairro,
      "numero": numero,
      "cidade": cidade,
      "uf": uf,
      "complemento": complemento,
      "ponto_ref": ponto_ref,
      "nome": nome,
    });
    return data;
  }
}
