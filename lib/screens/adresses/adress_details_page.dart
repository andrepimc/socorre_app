import 'package:bot_toast/bot_toast.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:socorre_app/components/base_appbar_component.dart';
import 'package:socorre_app/components/button_component.dart';
import 'package:socorre_app/components/text_input_component.dart';
import 'package:socorre_app/main.dart';
import 'package:socorre_app/models/adress_model.dart';
import 'package:socorre_app/repositories/cep/cep_service.dart';
import 'package:socorre_app/screens/home/home_page.dart';
import 'package:socorre_app/theme/my_app_colors.dart';
import 'package:socorre_app/theme/my_app_text_styles.dart';

class AdressDetailsPage extends StatefulWidget {
  final AdressModel? adressModel;
  const AdressDetailsPage({super.key, this.adressModel});

  @override
  State<AdressDetailsPage> createState() => _AdressDetailsPageState();
}

class _AdressDetailsPageState extends State<AdressDetailsPage> {
  final _formKey = GlobalKey<FormState>();

  //cep text controller
  TextEditingController cepController = TextEditingController();

  //rua text controller
  TextEditingController ruaController = TextEditingController();

  //bairro text controller
  TextEditingController bairroController = TextEditingController();

  //cidade text controller
  TextEditingController cidadeController = TextEditingController();

  //uf text controller
  TextEditingController ufController = TextEditingController();

  //numero text controller
  TextEditingController numeroController = TextEditingController();

  //complemento text controller
  TextEditingController complementoController = TextEditingController();

  //pontoRef text controller
  TextEditingController pontoRefController = TextEditingController();

  List<String> nameOptions = ['Casa', 'Trabalho'];
  List selectedOption = [];

  bool loading = false;

  @override
  void initState() {
    if (widget.adressModel != null) {
      setState(() {
        cepController.text = widget.adressModel!.cep;
        ruaController.text = widget.adressModel!.rua;
        bairroController.text = widget.adressModel!.bairro;
        cidadeController.text = widget.adressModel!.cidade;
        ufController.text = widget.adressModel!.uf;
        numeroController.text = widget.adressModel!.numero;
        if (widget.adressModel!.complemento != null) {
          complementoController.text = widget.adressModel!.complemento!;
        }
        if (widget.adressModel!.ponto_ref != null) {
          pontoRefController.text = widget.adressModel!.ponto_ref!;
        }
        if (widget.adressModel!.nome != null) {
          selectedOption.add(widget.adressModel!.nome!);
        }
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar(
        title: "Endereço",
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0, top: 8),
                child: TextInputComponent(
                    color: MyAppColors.darkDarkerGrey,
                    controller: cepController,
                    formatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CepInputFormatter(ponto: false),
                    ],
                    type: TextInputType.number,
                    text: "CEP",
                    onChanged: (value) async {
                      if (value.length == 9) {
                        final result =
                            await CepService.cepRetrieve(cepController.text);
                        setState(() {
                          ruaController.text = result.value.logradouro;
                          cidadeController.text = result.value.localidade;
                          ufController.text = result.value.uf;
                          bairroController.text = result.value.bairro;
                        });
                      }
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: TextInputComponent(
                  color: MyAppColors.darkDarkerGrey,
                  controller: ruaController,
                  text: "Rua",
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: TextInputComponent(
                  color: MyAppColors.darkDarkerGrey,
                  controller: bairroController,
                  text: "Bairro",
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: TextInputComponent(
                          color: MyAppColors.darkDarkerGrey,
                          controller: numeroController,
                          text: "Número",
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Expanded(
                        child: TextInputComponent(
                          color: MyAppColors.darkDarkerGrey,
                          controller: complementoController,
                          text: "Complemento (opcional)",
                          mandatory: false,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: TextInputComponent(
                          color: MyAppColors.darkDarkerGrey,
                          controller: cidadeController,
                          text: "Cidade",
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: TextInputComponent(
                        color: MyAppColors.darkDarkerGrey,
                        controller: ufController,
                        text: "UF",
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: TextInputComponent(
                  color: MyAppColors.darkDarkerGrey,
                  controller: complementoController,
                  text: "Ponto de referência (opcional)",
                  mandatory: false,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          if (selectedOption.firstOrNull == "Trabalho" ||
                              selectedOption.isEmpty) {
                            selectedOption.clear();
                            selectedOption.add("Casa");
                          } else {
                            selectedOption.clear();
                          }
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: selectedOption.firstOrNull == "Casa"
                                  ? Colors.transparent
                                  : const Color(0xff323238),
                            ),
                            borderRadius: BorderRadius.circular(12),
                            color: selectedOption.firstOrNull == "Casa"
                                ? const Color(0xff323238)
                                : Colors.transparent),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.house,
                                color: selectedOption.firstOrNull == "Casa"
                                    ? Colors.white
                                    : const Color(0xff323238),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  "Casa",
                                  style: MyAppTextStyles.loginBold.copyWith(
                                      color:
                                          selectedOption.firstOrNull == "Casa"
                                              ? Colors.white
                                              : const Color(0xff323238)),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          if (selectedOption.firstOrNull == "Casa" ||
                              selectedOption.isEmpty) {
                            selectedOption.clear();
                            selectedOption.add("Trabalho");
                          } else {
                            selectedOption.clear();
                          }
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: selectedOption.firstOrNull == "Trabalho"
                                  ? Colors.transparent
                                  : const Color(0xff323238),
                            ),
                            borderRadius: BorderRadius.circular(12),
                            color: selectedOption.firstOrNull == "Trabalho"
                                ? const Color(0xff323238)
                                : Colors.transparent),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.work,
                                color: selectedOption.firstOrNull == "Trabalho"
                                    ? Colors.white
                                    : const Color(0xff323238),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  "Trabalho",
                                  style: MyAppTextStyles.loginBold.copyWith(
                                      color: selectedOption.firstOrNull ==
                                              "Trabalho"
                                          ? Colors.white
                                          : const Color(0xff323238)),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ButtonComponent(
                  func: () async {
                    FocusScope.of(context).unfocus();
                    if (_formKey.currentState!.validate()) {
                      final cepTrim = cepController.text.trim();
                      final ruaTrim = ruaController.text.trim();
                      final bairroTrim = bairroController.text.trim();
                      final cidadeTrim = cidadeController.text.trim();
                      final ufTrim = ufController.text.trim();
                      final numeroTrim = numeroController.text.trim();
                      dynamic complementoTrim;
                      dynamic pontoRefTrim;
                      if (complementoController.text.isNotEmpty) {
                        complementoTrim = complementoController.text.trim();
                      }
                      if (pontoRefController.text.isNotEmpty) {
                        pontoRefTrim = pontoRefController.text.trim();
                      }
                      final userId = supabase.auth.currentUser!.id;
                      setState(() {
                        loading = true;
                      });
                      try {
                        if (widget.adressModel != null) {
                          //atualizar
                          await supabase.from('adresses').update({
                            'profile_id': userId,
                            'cep': cepTrim,
                            'rua': ruaTrim,
                            'bairro': bairroTrim,
                            'numero': numeroTrim,
                            'cidade': cidadeTrim,
                            'uf': ufTrim,
                            'complemento': complementoTrim,
                            'ponto_ref': pontoRefTrim,
                            'nome': selectedOption.firstOrNull
                          }).eq('id', userId);
                        } else {
                          //criar
                          await supabase.from('adresses').insert({
                            'profile_id': userId,
                            'cep': cepTrim,
                            'rua': ruaTrim,
                            'bairro': bairroTrim,
                            'numero': numeroTrim,
                            'cidade': cidadeTrim,
                            'uf': ufTrim,
                            'complemento': complementoTrim,
                            'ponto_ref': pontoRefTrim,
                            'nome': selectedOption.firstOrNull
                          });
                        }
                        BotToast.showText(text: "Sucesso!");
                        if (mounted) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()),
                              (Route<dynamic> route) => false);
                        }
                      } on Exception catch (e) {
                        // TODO
                      } finally {
                        setState(() {
                          loading = false;
                        });
                      }
                    }
                  },
                  text: widget.adressModel != null ? "Atualizar" : "Adicionar",
                  loading: loading)
            ],
          ),
        ),
      ),
    );
  }
}
