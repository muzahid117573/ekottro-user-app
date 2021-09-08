import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fuodz/view_models/base.view_model.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/home.i18n.dart';

class VendorHeader extends StatelessWidget {
  const VendorHeader({
    Key key,
    this.model,
  }) : super(key: key);

  final MyBaseViewModel model;
  @override
  Widget build(BuildContext context) {
    return HStack(
      [
        //
        HStack(
          [
            //location icon
            Icon(
              FlutterIcons.location_on_mdi,
              size: 30,
            ).onInkTap(
              model.useUserLocation,
            ),

            //
            VStack(
              [
                //
                HStack(
                  [
                    //
                    "Current Location".i18n.text.lg.semiBold.make(),
                    //
                    Icon(
                      FlutterIcons.tools_ent,
                      size: 16,
                    ).px4(),
                  ],
                ),
                model.deliveryaddress.address.text.sm.make(),
              ],
            )
                .onInkTap(
                  model.pickDeliveryAddress,
                )
                .px12()
                .expand(),
          ],
        ).expand(),

        //
        Icon(
          FlutterIcons.search_faw,
          size: 16,
          color: context.brightness != Brightness.dark
              ? Colors.amber[300]
              : Colors.blueGrey[800],
        )
            .p8()
            .box
            .roundedFull
            .shadowSm
            .color(context.brightness != Brightness.dark
                ? Colors.blueGrey[800]
                : Colors.amber[300])
            .make()
            .onInkTap(
              model.openSearch,
            ),
      ],
    ).p12();
  }
}
