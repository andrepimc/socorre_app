import 'package:flutter/material.dart';
import 'package:socorre_app/theme/my_app_colors.dart';
import 'package:socorre_app/theme/my_app_text_styles.dart';

class ButtonComponent extends StatelessWidget {
  final VoidCallback func;
  final String text;
  final IconData? iconData;
  final bool loading;
  final List<Color>? colors;

  const ButtonComponent(
      {super.key,
      required this.func,
      required this.text,
      this.iconData,
      required this.loading,
      this.colors});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: func,
      child: Container(
          width: 335,
          height: 50,
          decoration: BoxDecoration(
            // color: AppTheme.colors.majorGreen,
            border: Border.all(
              color: MyAppColors.darkSecondaryGreen,
              width: 3
            ),
            gradient: LinearGradient(
                colors: colors ??
                    [
                      MyAppColors.darkMainGreen,
                      MyAppColors.darkSecondaryGreen,
                    ],
                begin: Alignment.bottomRight,
                end: Alignment.bottomLeft,
                stops: const [0.0, 1.0],
                tileMode: TileMode.repeated),
          ),
          child: Center(
            child: loading
                ? const CircularProgressIndicator()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      iconData == null
                          ? const SizedBox()
                          : Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Icon(
                                iconData,
                                color: Colors.white,
                              ),
                            ),
                      Text(text, style:MyAppTextStyles.button),
                    ],
                  ),
          )),
    );
  }
}
