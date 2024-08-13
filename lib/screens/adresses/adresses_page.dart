import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:socorre_app/components/adress_card_component.dart';
import 'package:socorre_app/components/base_appbar_component.dart';
import 'package:socorre_app/models/adress_model.dart';
import 'package:socorre_app/screens/adresses/adress_details_page.dart';
import 'package:socorre_app/screens/home/home_page.dart';
import 'package:socorre_app/services/storage/local_storage.dart';
import 'package:socorre_app/services/store/user_store.dart';
import 'package:socorre_app/theme/my_app_colors.dart';

class AdressesPage extends StatefulWidget {
  final List adresses;
  const AdressesPage({super.key, required this.adresses});

  @override
  State<AdressesPage> createState() => _AdressesPageState();
}

class _AdressesPageState extends State<AdressesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const BaseAppBar(
          title: "Meus endereços",
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: MyAppColors.darkMainGreen,
          shape: RoundedRectangleBorder(
              side: const BorderSide(
                width: 3,
                color: MyAppColors.darkSecondaryGreen,
              ),
              borderRadius: BorderRadius.circular(16)),
          onPressed: () async {
            //navigate to add/edit adress page
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AdressDetailsPage()));
          },
          icon: const Icon(Icons.add),
          label: const Text("Adicionar"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: ((context, index) {
              AdressModel adressModel =
                  AdressModel.fromMap(widget.adresses[index]);
              return AdressCardComponent(
                key: Key(adressModel.id),
                adressModel: adressModel,
                index: index,
                selected: GetIt.I<UserStore>().adressSelected == adressModel,
                onSelected: () async {
                  await LocalStorageRepo.selectAdress(adressModel);
                  if (mounted) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()),
                              (Route<dynamic> route) => false);
                        }
                }, //selecionar via localStorage
                onEdit: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AdressDetailsPage(
                                adressModel: adressModel,
                              )));
                },
              );
            }),
            separatorBuilder: (context, _) => const Divider(),
            itemCount: widget.adresses.length,
          ),
        ));
  }
}
