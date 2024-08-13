import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:socorre_app/main.dart';
import 'package:socorre_app/models/adress_model.dart';
import 'package:socorre_app/models/user_model.dart';
import 'package:socorre_app/repositories/adresses/adresses_service.dart';
import 'package:socorre_app/repositories/orders/orders_service.dart';
import 'package:socorre_app/repositories/products/products_service.dart';
import 'package:socorre_app/components/et_loading_component.dart';
import 'package:socorre_app/components/home_card_component.dart';
import 'package:socorre_app/screens/account/account_page.dart';
import 'package:socorre_app/screens/adresses/adresses_page.dart';
import 'package:socorre_app/screens/order/order_page.dart';
import 'package:socorre_app/services/alerts/alerts_service.dart';
import 'package:socorre_app/services/storage/local_storage.dart';
import 'package:socorre_app/services/store/user_store.dart';
import 'package:socorre_app/services/utils/string_formatters.dart';
import 'package:socorre_app/theme/my_app_colors.dart';
import 'package:socorre_app/theme/my_app_text_styles.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List products = [];

  List adresses = [];

  List selected = [];
  bool loading = true;
  bool allOptionsSelected = false;

  fetchProducts() async {
    final data = await ProductsService().fetchAll();
    setState(() {
      products.addAll(data);
      loading = false;
    });
  }

  handleToggleSelected(String value) {
    if (selected.contains(value)) {
      return setState(() {
        selected.remove(value);
      });
    }
    setState(() {
      selected.add(value);
    });
  }

  handleAllSelected() {
    selected.clear();
    setState(() {
      allOptionsSelected = !allOptionsSelected;
    });
  }

  handleClear() async {
    AlertsService().showAlertDialog(
        BackButtonBehavior.close, 'Deseja limpar tudo ?', 'Sim', 'Não',
        cancel: () {}, confirm: () {
      setState(() {
        selected.clear();
      });
    });
  }

  final User user = supabase.auth.currentUser!;

  @action
  Future getAdressesByUserId(String userId) async {
    final data = await AdressesService().getByUserId(userId);
    final res = await LocalStorageRepo.recoverSelectedAdress();
    if (res == null) {
      if (data.runtimeType == List<Map<String, dynamic>>) {
        AdressModel adress = AdressModel.fromMap(data[0]);
        await LocalStorageRepo.selectAdress(adress);
      }
    } else {
      await GetIt.I<UserStore>().getAdress(res);
    }
    setState(() {
      adresses.addAll(data);
    });
  }

  @action
  Future getUserData() async {
    final String id = user.id;
    final data = await supabase.from('profiles').select().eq('id', id).single();
    if (data != null) {
      //salvar na instancia global GetIt
      String? username = data["username"];
      String? tel = data["tel"];
      String? avatarUrl = data["avatar_url"];
      String email = user.email!;
      int atIndex = email.indexOf('@');
      String _username = email.substring(0, atIndex);

      UserModel userModel = UserModel(
          id: id,
          email: user.email!,
          username: username ?? _username,
          tel: tel,
          avatar_url: avatarUrl);
      await GetIt.I<UserStore>().getUser(userModel);
      await getAdressesByUserId(userModel.id);
    }
  }

  @override
  void initState() {
    getUserData().then((res) {
      fetchProducts();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: loading
          ? AppBar()
          : AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              actions: [
                Observer(builder: (_) {
                  //caso não tenha nada cadastrado
                  return Padding(
                    padding: const EdgeInsets.only(left: 24.0),
                    child: InkWell(
                      onTap: () {
                        if (mounted) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AdressesPage(
                                        adresses: adresses,
                                      )));
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: MyAppColors.darkSecondaryText),
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(right: 8.0),
                                child: Icon(
                                  Icons
                                      .pin_drop, //casa ou trabalho - fazer cond. ternário
                                  size: 20,
                                ),
                              ),
                              Text(
                                  GetIt.I<UserStore>()
                                              .adressSelected
                                              .runtimeType ==
                                          AdressModel
                                      ? GetIt.I<UserStore>()
                                              .adressSelected!
                                              .nome ??
                                          StringFormatters.streetFormatter(
                                              GetIt.I<UserStore>()
                                                  .adressSelected!
                                                  .rua)
                                      : "Meu endereço",
                                  style: MyAppTextStyles.loginNormal),
                              const Icon(
                                Icons.arrow_drop_down,
                                size: 20,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
                const Spacer(),
                Observer(builder: (_) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 24.0),
                    child: InkWell(
                      onTap: () {
                        if (mounted) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AccountPage(
                                        adresses: adresses,
                                      )));
                        }
                      },
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text(
                              GetIt.I<UserStore>().user.username!,
                              style: MyAppTextStyles.loginBold,
                            ),
                          ),
                          SizedBox(
                            height: 32,
                            width: 32,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child:
                                  GetIt.I<UserStore>().user.avatar_url == null
                                      ? const Icon(Icons.person_3)
                                      : Image.network(
                                          GetIt.I<UserStore>().user.avatar_url!,
                                          fit: BoxFit.cover,
                                        ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                })
              ],
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Visibility(
        visible: selected.isNotEmpty || allOptionsSelected,
        child: FloatingActionButton.extended(
          backgroundColor: MyAppColors.darkMainGreen,
          shape: RoundedRectangleBorder(
              side: const BorderSide(
                width: 3,
                color: MyAppColors.darkSecondaryGreen,
              ),
              borderRadius: BorderRadius.circular(16)),
          onPressed: () async {
            if (GetIt.I<UserStore>().adressSelected.runtimeType !=
                AdressModel) {
              BotToast.showText(text: 'Você deve selecionar um endereço.');
              return;
            }
            if (GetIt.I<UserStore>().user.tel == null) {
              BotToast.showText(
                  text: 'Você deve possuir um telefone cadastrado.');
              return;
            }
            List productsBySelectedIds = [];
            if (selected.isEmpty) {
              productsBySelectedIds
                  .add({"name": 'Todas as opções', "image": ''});
            } else {
              productsBySelectedIds = products
                  .where((item) => selected.contains(item['id']))
                  .toList();
            }

            AlertsService().showAlertDialog(BackButtonBehavior.close,
                'Confirmar pedido', 'Confirmar', 'Cancelar',
                cancel: () {},
                content: SizedBox(
                  height: 400,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Icon(
                              Icons.house,
                              color: MyAppColors.darkMainBrown,
                              size: 16,
                            ),
                          ),
                          Text(
                            'Seu endereço:',
                            style: MyAppTextStyles.loginNormal
                                .copyWith(color: MyAppColors.darkMainBrown),
                          ),
                        ],
                      ),
                      Text(
                          '${StringFormatters.streetFormatter(GetIt.I<UserStore>().adressSelected!.rua)}, ${GetIt.I<UserStore>().adressSelected!.numero}',
                          style: MyAppTextStyles.loginBold),
                      Text(GetIt.I<UserStore>().adressSelected!.bairro,
                          style: MyAppTextStyles.loginBold),
                      Text(
                          '${GetIt.I<UserStore>().adressSelected!.cidade}-${GetIt.I<UserStore>().adressSelected!.uf}',
                          style: MyAppTextStyles.loginLight),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 4.0),
                              child: Icon(
                                Icons.shopping_basket,
                                color: MyAppColors.darkMainBrown,
                                size: 16,
                              ),
                            ),
                            Text('Itens:',
                                style: MyAppTextStyles.loginNormal.copyWith(
                                    color: MyAppColors.darkMainBrown)),
                          ],
                        ),
                      ),
                      ...productsBySelectedIds.map((e) => Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                e['image'].isEmpty
                                    ? const Icon(
                                        Icons.arrow_circle_right,
                                        size: 16,
                                      )
                                    : SizedBox(
                                        height: 16,
                                        child: Image.network(
                                          '${dotenv.env['SUPABASE_STORAGE'].toString()}/${e['image']}',
                                        ),
                                      ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 4.0),
                                  child: Text(
                                    e['name'],
                                    style: MyAppTextStyles.loginBold,
                                  ),
                                )
                              ],
                            ),
                          )),
                    ],
                  ),
                ), confirm: () async {
              final res = await OrdersService().createNew(
                  GetIt.I<UserStore>().user.id,
                  GetIt.I<UserStore>().adressSelected!.id,
                  selected.isEmpty
                      ? ["Todas as opções"]
                      : selected.map((e) => e.toString()).toList());
              if (res != null) {
                if (mounted) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OrderPage(
                                dataOrder: res,
                              )),
                      (Route<dynamic> route) => false);
                }
              }
            });
          },
          label: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48.0),
            child: Row(
              children: [
                Transform.scale(scaleX: -1, child: const Icon(Icons.sort)),
                Image.asset(
                  'assets/images/logotipo-white.png',
                )
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8),
              child: Text(
                "Escolha\nos produtos",
                style: MyAppTextStyles.homeBold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 28.0),
              child: Text("Explore as categorias abaixo",
                  style: MyAppTextStyles.homeNormal),
            ),
            Visibility(
              visible: selected.isNotEmpty,
              child: Row(
                children: [
                  Text(
                    "${selected.length} produto(s) selecionado(s)",
                    style: MyAppTextStyles.homeCardLabel,
                  ),
                  TextButton.icon(
                    style: TextButton.styleFrom(
                      foregroundColor: MyAppColors.darkMainGreen,
                    ),
                    onPressed: () async {
                      handleClear();
                    },
                    label: const Text("Limpar"),
                    icon: const Icon(Icons.clear),
                  )
                ],
              ),
            ),
            loading
                ? const SlideTransitionWidget()
                : Column(
                    children: [
                      GridView.builder(
                        shrinkWrap: true,

                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount:
                                    3, // number of items in each row
                                mainAxisSpacing: 20, // spacing between rows
                                crossAxisSpacing: 0, // spacing between columns,
                                mainAxisExtent: 42),
                        // padding around the grid
                        itemCount: products.length, // total number of items
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () =>
                                handleToggleSelected(products[index]['id']),
                            child: HomeCardComponent(
                              key: Key(products[index]['id']),
                              name: products[index]['name'],
                              image: Image.network(
                                '${dotenv.env['SUPABASE_STORAGE'].toString()}/${products[index]['image']}',
                              ),
                              selected:
                                  selected.contains(products[index]['id']),
                            ),
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: GestureDetector(
                          onTap: () => handleAllSelected(),
                          child: HomeCardComponent(
                            key: const Key('kfdkfjkdefj'),
                            name: "Todas as opções",
                            image: const Icon(Icons.arrow_circle_right),
                            selected: allOptionsSelected,
                          ),
                        ),
                      )
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
