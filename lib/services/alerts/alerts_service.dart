import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:socorre_app/theme/my_app_colors.dart';
import 'package:socorre_app/theme/my_app_text_styles.dart';

class AlertsService {
  void showAlertDialog(
    BackButtonBehavior backButtonBehavior,
    String title,
    String positiveLabel,
    String negativeLabel, {
    Widget? content,
    VoidCallback? cancel,
    VoidCallback? confirm,
    VoidCallback? backgroundReturn,
  }) {
    BotToast.showAnimationWidget(
        clickClose: false,
        allowClick: false,
        onlyOne: true,
        crossPage: true,
        backButtonBehavior: backButtonBehavior,
        wrapToastAnimation: (controller, cancel, child) => Stack(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    cancel();
                    backgroundReturn?.call();
                  },
                  //The DecoratedBox here is very important,he will fill the entire parent component
                  child: AnimatedBuilder(
                    builder: (_, child) => Opacity(
                      opacity: controller.value,
                      child: child,
                    ),
                    animation: controller,
                    child: const DecoratedBox(
                      decoration: BoxDecoration(color: Colors.black87),
                      child: SizedBox.expand(),
                    ),
                  ),
                ),
                CustomOffsetAnimation(
                  controller: controller,
                  child: child,
                )
              ],
            ),
        toastBuilder: (cancelFunc) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              title: Text(
                title,
                style: MyAppTextStyles.alertTitle,
              ),
              content: content,
              actionsAlignment: MainAxisAlignment.spaceAround,
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    cancelFunc();
                    cancel?.call();
                  },
                  child: Text(
                    negativeLabel,
                    style: MyAppTextStyles.alertOptions,
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    cancelFunc();
                    confirm?.call();
                  },
                  child: Text(positiveLabel,
                      style: MyAppTextStyles.alertOptions
                          .copyWith(color: MyAppColors.darkMainGreen)),
                ),
              ],
            ),
        animationDuration: const Duration(milliseconds: 300));
  }
}

class CustomOffsetAnimation extends StatefulWidget {
  final AnimationController controller;
  final Widget child;

  const CustomOffsetAnimation(
      {Key? key, required this.controller, required this.child})
      : super(key: key);

  @override
  _CustomOffsetAnimationState createState() => _CustomOffsetAnimationState();
}

class _CustomOffsetAnimationState extends State<CustomOffsetAnimation> {
  late Tween<Offset> tweenOffset;
  late Tween<double> tweenScale;

  late Animation<double> animation;

  @override
  void initState() {
    tweenOffset = Tween<Offset>(
      begin: const Offset(0.0, 0.8),
      end: Offset.zero,
    );
    tweenScale = Tween<double>(begin: 0.3, end: 1.0);
    animation =
        CurvedAnimation(parent: widget.controller, curve: Curves.decelerate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      child: widget.child,
      animation: widget.controller,
      builder: (BuildContext context, Widget? child) {
        return FractionalTranslation(
            translation: tweenOffset.evaluate(animation),
            child: ClipRect(
              child: Transform.scale(
                scale: tweenScale.evaluate(animation),
                child: Opacity(
                  child: child,
                  opacity: animation.value,
                ),
              ),
            ));
      },
    );
  }
}
