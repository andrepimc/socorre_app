import 'package:flutter/material.dart';
import 'package:socorre_app/models/adress_model.dart';
import 'package:socorre_app/services/utils/string_formatters.dart';
import 'package:socorre_app/theme/my_app_colors.dart';
import 'package:socorre_app/theme/my_app_text_styles.dart';

class AdressCardComponent extends StatelessWidget {
  final AdressModel adressModel;
  final int index;
  final VoidCallback onSelected;
  final VoidCallback onEdit;
  final bool selected;
  const AdressCardComponent(
      {super.key,
      required this.adressModel,
      required this.index,
      required this.onSelected,
      required this.onEdit,
      required this.selected});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelected,
      child: Container(
        decoration: BoxDecoration(
          color: MyAppColors.darkDarkerGrey,
          border: selected
              ? Border.all(width: 1.5, color: MyAppColors.darkSecondaryGreen)
              : Border.all(width: .5, color: MyAppColors.darkLighterGrey),
          borderRadius: BorderRadius.circular(12),
        ),
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Icon(
                adressModel.nome == null
                    ? Icons.pin_drop
                    : adressModel.nome! == "Casa"
                        ? Icons.house
                        : Icons.work,
                color: MyAppColors.darkLighterGrey,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      adressModel.nome ??
                          StringFormatters.streetFormatter(adressModel.rua),
                      style: MyAppTextStyles.adressCardBold,
                    ),
                    if (adressModel.nome != null)
                      Text(
                        StringFormatters.streetFormatter(adressModel.rua),
                        style: MyAppTextStyles.adressCardNormal,
                      ),
                    Text(adressModel.bairro,
                        style: MyAppTextStyles.adressCardNormal),
                    Text("${adressModel.cidade} - ${adressModel.uf}",
                        style: MyAppTextStyles.adressCardLight),
                    if (adressModel.complemento != null)
                      Text(adressModel.complemento!,
                          style: MyAppTextStyles.adressCardLight),
                  ],
                ),
              ),
              const Spacer(),
              if (selected)
                const Icon(
                  Icons.check,
                  color: MyAppColors.darkMainGreen,
                  size: 16,
                ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: InkWell(
                    onTap: onEdit,
                    child: const Icon(
                      Icons.more_vert,
                      size: 28,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
