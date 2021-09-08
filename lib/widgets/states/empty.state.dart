import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_images.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/widgets/buttons/custom_button.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/empty.i18n.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({
    Key key,
    this.imageUrl,
    this.title = "",
    this.actionText = "Action",
    this.description = "",
    this.showAction = false,
    this.showImage = true,
    this.actionPressed,
    this.auth = false,
  }) : super(key: key);

  final String title;
  final String actionText;
  final String description;
  final String imageUrl;
  final Function actionPressed;
  final bool showAction;
  final bool showImage;
  final bool auth;

  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        //
        (imageUrl != null && imageUrl.isNotBlank)
            ? Image.asset(imageUrl)
                .wh(
                  Vx.dp64 * 2,
                  Vx.dp64 * 2,
                )
                .box
                .makeCentered()
                .wFull(context)
            : UiSpacer.emptySpace(),

        //
        (title != null && title.isNotEmpty)
            ? title.text.xl.semiBold.center.makeCentered()
            : SizedBox.shrink(),

        //
        (auth && showImage)
            ? Image.asset("assets/images/loadingicon.png")
                .wh(
                  180,
                  180,
                )
                .box
                .makeCentered()
                .py12()
                .wFull(context)
            : SizedBox.shrink(),
        //
        auth
            ? "Please login To Access Your Profile"
                .i18n
                .text
                .center
                .lg
                .light
                .makeCentered()
                .py12()
            : description.isNotEmpty
                ? description.text.lg.light.center.makeCentered()
                : SizedBox.shrink(),

        //
        auth
            ? CustomButton(
                title: "Login".i18n,
                onPressed: actionPressed,
              ).centered()
            : showAction
                ? CustomButton(
                    title: actionText,
                    onPressed: actionPressed,
                  ).centered().py24()
                : SizedBox.shrink(),
      ],
    );
  }
}