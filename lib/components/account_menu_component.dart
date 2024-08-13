import 'package:flutter/material.dart';
import 'package:socorre_app/theme/my_app_colors.dart';
import 'package:socorre_app/theme/my_app_text_styles.dart';

class AccountMenuComponent extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final IconData icon;
  final Color? color;
  final Color? color2;
  const AccountMenuComponent({
    super.key,
    required this.label,
    required this.icon,
    this.color,
    this.color2,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              color: color ?? MyAppColors.darkDarkerGrey,
              borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Container(
                  //box com ícone
                  decoration: BoxDecoration(
                      color: color2 ?? MyAppColors.darkLighterGrey,
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4),
                    child: Icon(
                      icon,
                      size: 20,
                    ),
                  ),
                ),
                Padding(
                  //texto
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    label,
                    style: MyAppTextStyles.loginBold,
                  ),
                ),
                const Spacer(),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
