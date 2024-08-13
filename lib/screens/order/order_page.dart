import 'package:flutter/material.dart';
import 'package:socorre_app/components/base_appbar_component.dart';
import 'package:socorre_app/services/utils/string_formatters.dart';
import 'package:socorre_app/theme/my_app_text_styles.dart';

class OrderPage extends StatelessWidget {
  final List dataOrder;
  const OrderPage({super.key, required this.dataOrder});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> orderObj = dataOrder.first;
    String created = orderObj['created_at'];

    return Scaffold(
      appBar: BaseAppBar(
        title: "Socorre - ${StringFormatters.dateFormat(created)}",
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Image.asset('assets/images/logo-splash.png'),
          ),
          Text(
            "Obrigado pela solicitação!",
            style: MyAppTextStyles.orderh1,
          ),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 22),
            child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text:
                        "Em alguns minutos um de nossos operadores estará entrando em contato via ",
                    style: MyAppTextStyles.orderh3,
                    children: [
                      TextSpan(
                          text: orderObj['profiles']['tel'],
                          style: MyAppTextStyles.orderh2)
                    ])),
          )
        ],
      ),
    );
  }
}
