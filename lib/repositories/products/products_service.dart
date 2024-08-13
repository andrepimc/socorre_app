import 'package:socorre_app/main.dart';

class ProductsService {
  fetchAll() async {
    final data = await supabase.from("products").select().order("name");
    return data;
  }

  findById(List<String> ids) async {
    final data = await supabase
        .from("products")
        .select()
        .inFilter("id", ids)
        .order('name');
    return data;
  }
}
