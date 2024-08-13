import 'package:socorre_app/main.dart';

class OrdersService {
  getByUserId(String userId) async {
    final data =
        await supabase.from("orders").select().eq("profile_id", userId);
    return data;
  }

  createNew(
    String profile_id,
    String adress_id,
    List<String> products,
  ) async {
    final data = await supabase.from("orders").insert({
      "profile_id": profile_id,
      "adress_id": adress_id,
      "products": products,
    }).select('''
    id,
    products,
    created_at,
    adresses (
      cep,
      rua,
      bairro,
      numero,
      cidade,
      uf,
      complemento,
      ponto_ref
    ),
    profiles (
      username,
      full_name,
      tel
    )
  ''');
    return data;
  }
}
