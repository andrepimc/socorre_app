import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:socorre_app/theme/my_app_colors.dart';
import 'package:socorre_app/theme/my_app_text_styles.dart';

class HomeCardComponent extends StatelessWidget {
  final String name;
  final Widget image;
  final bool? selected;
  const HomeCardComponent({
    super.key,
    required this.name,
    required this.image,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Container(
        height: 42,
        decoration: BoxDecoration(
          color: selected! ? MyAppColors.darkMainBrown : Colors.transparent,
          border: Border.all(
            width: 2,
            color: selected!
                ? MyAppColors.darkSecondaryBrown
                : MyAppColors.darkGrey,
          ),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
                child: image,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Text(
                  name,
                  style: MyAppTextStyles.homeCardLabel,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
