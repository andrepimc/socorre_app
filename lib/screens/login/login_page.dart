import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:socorre_app/components/bg_image_component.dart';
import 'package:socorre_app/components/button_component.dart';
import 'package:socorre_app/components/text_input_component.dart';
import 'package:socorre_app/main.dart';
import 'package:socorre_app/screens/home/home_page.dart';
import 'package:socorre_app/theme/my_app_text_styles.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //login text controller
  TextEditingController email = TextEditingController();

  //password text controller
  TextEditingController password = TextEditingController();

  late final StreamSubscription<AuthState> _streamSubscription;

  var focusNodeEmail = FocusNode();
  var focusNodePassword = FocusNode();

  final _formKey = GlobalKey<FormState>();

  bool loading = false;

  @override
  void initState() {
    _streamSubscription = supabase.auth.onAuthStateChange.listen((event) {
      final session = event.session;
      if (session != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomePage(
             
            )));
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    _streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BgImageComponent(assetImage: 'assets/images/login-bg.jpg'),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 124,
                    ),
                    Center(
                      child: SizedBox(
                          height: 128,
                          width: 250,
                          child: Image.asset("assets/images/logo-white.png")),
                    ),
                    Center(
                      child: Text("Faça sua mente sem sair de casa",
                          style: MyAppTextStyles.loginBold),
                    ),
                    const SizedBox(
                      height: 112,
                    ),
                    Text("Esperando o que ?",
                        style: MyAppTextStyles.loginNormal),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Text("Insira suas credenciais de acesso",
                                  style: MyAppTextStyles.loginLight),
                            ),
                            TextInputComponent(
                              focusNode: focusNodeEmail,
                              color: Colors.grey,
                              type: TextInputType.emailAddress,
                              controller: email,
                              text: "E-mail",
                              onTap: () {
                                FocusScope.of(context)
                                    .requestFocus(focusNodeEmail);
                              },
                              icon: const Icon(
                                Icons.email,
                                size: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            TextInputComponent(
                              focusNode: focusNodePassword,
                              color: Colors.grey,
                              controller: password,
                              text: "Senha",
                              password: true,
                              icon: const Icon(
                                Icons.key,
                                size: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            Center(
                              child: ButtonComponent(
                                func: () async {
                                  FocusScope.of(context).unfocus();
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      loading = true;
                                    });
                                    try {
                                      final emailText = email.text.trim();
                                      final passwordText = password.text.trim();
                                      await supabase.auth.signInWithPassword(
                                        email: emailText,
                                        password: passwordText,
                                      );
                                    } on AuthException catch (e) {
                                      BotToast.showText(text: e.message);
                                    } catch (e) {
                                      BotToast.showText(
                                          text:
                                              "Erro inesperado, tente novamente...");
                                    } finally {
                                      setState(() {
                                        loading = false;
                                      });
                                    }
                                  }
                                },
                                text: "Entrar",
                                loading: loading,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                          "2024, SO CORRE TODOS OS DIREITOS RESERVADOS.",
                          style: MyAppTextStyles.loginLight),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
