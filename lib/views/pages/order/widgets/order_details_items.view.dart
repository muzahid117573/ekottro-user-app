import 'package:flutter/material.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/order_details.vm.dart';
import 'package:fuodz/views/pages/cart/widgets/amount_tile.dart';
import 'package:fuodz/widgets/custom_image.view.dart';
import 'package:fuodz/widgets/custom_list_view.dart';
import 'package:fuodz/widgets/list_items/order_product.list_item.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/order_details.i18n.dart';

class OrderDetailsItemsView extends StatelessWidget {
  const OrderDetailsItemsView(this.vm, {Key key}) : super(key: key);
  final OrderDetailsViewModel vm;

  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        (vm.order.isPackageDelivery ? "Package Details" : "Products")
            .i18n
            .text
            .gray500
            .semiBold
            .xl
            .make()
            .pOnly(bottom: Vx.dp10),
        vm.order.isPackageDelivery
            ? VStack(
                [
                  AmountTile(
                    "Package Type".i18n,
                    vm.order.packageType.name,
                  ),
                  AmountTile("Product Price".i18n, vm.order.width + " Tk"),
                  AmountTile("Account Type".i18n, vm.order.length),
                  AmountTile("Account Number".i18n, vm.order.height),
                  AmountTile("Weight".i18n, vm.order.weight + "kg"),
                ],
                crossAlignment: CrossAxisAlignment.end,
              )
            : CustomListView(
                noScrollPhysics: true,
                dataSet: vm.order.orderProducts,
                itemBuilder: (context, index) {
                  //
                  final orderProduct = vm.order.orderProducts[index];
                  return OrderProductListItem(
                    orderProduct: orderProduct,
                  );
                },
              ),

        //order photo
        (vm.order.photo != null && !vm.order.photo.contains("default.png"))
            ? CustomImage(
                imageUrl: vm.order.photo,
                boxFit: BoxFit.fill,
              ).h(context.percentHeight * 30).wFull(context)
            : UiSpacer.emptySpace(),
      ],
    );
  }
}
