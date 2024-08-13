import 'package:flutter/material.dart';
import 'package:socorre_app/theme/my_app_colors.dart';

class BgImageComponent extends StatelessWidget {
  final String assetImage;
  const BgImageComponent({super.key, required this.assetImage});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [MyAppColors.darkMainGreen, MyAppColors.darkSecondaryGreen],
        begin: Alignment.bottomCenter,
        end: Alignment.center
      ).createShader(bounds),
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(assetImage),
                fit: BoxFit.cover,
                colorFilter:
                    const ColorFilter.mode(Colors.black45, BlendMode.darken))),
      ),
    );
  }
}
