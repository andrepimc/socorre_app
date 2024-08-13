import 'package:flutter/material.dart';
import 'package:socorre_app/components/account_menu_component.dart';
import 'package:socorre_app/components/base_appbar_component.dart';
import 'package:socorre_app/main.dart';
import 'package:socorre_app/screens/adresses/adresses_page.dart';
import 'package:socorre_app/screens/login/login_page.dart';
import 'package:socorre_app/screens/personal/personal_page.dart';

class AccountPage extends StatefulWidget {
   final List adresses;
  const AccountPage({super.key, required this.adresses});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar(
        title: "Conta",
      ),
      body: Column(
        children: [
          AccountMenuComponent(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PersonalPage()));
            },
            label: "Meus dados",
            icon: Icons.person_2,
          ),
          AccountMenuComponent(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AdressesPage(
                        adresses: widget.adresses,
                      )));
            },
            label: "Meus endereços",
            icon: Icons.pin_drop,
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: AccountMenuComponent(
              onTap: () async {
                await supabase.auth.signOut();
                if (mounted) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                }
              },
              label: "Sair",
              icon: Icons.exit_to_app,
              color: const Color.fromARGB(255, 36, 4, 1),
              color2: const Color.fromARGB(255, 74, 8, 2),
            ),
          ),
        ],
      ),
    );
  }
}
