import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fuodz/constants/app_routes.dart';
import 'package:fuodz/models/carusel_image.dart';

import 'package:fuodz/services/auth.service.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/welcome.vm.dart';
import 'package:fuodz/views/pages/order/orders.page.dart';
import 'package:fuodz/views/pages/profile/profile.page.dart';
import 'package:fuodz/views/pages/search/search.page.dart';
import 'package:fuodz/widgets/custom_list_view.dart';
import 'package:fuodz/widgets/list_items/vendor_type.list_item.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/welcome.i18n.dart';

class EmptyWelcome extends StatefulWidget {
  const EmptyWelcome({this.vm, Key key}) : super(key: key);

  final WelcomeViewModel vm;

  @override
  _EmptyWelcomeState createState() => _EmptyWelcomeState();
}

class _EmptyWelcomeState extends State<EmptyWelcome>
    with SingleTickerProviderStateMixin {
  int _current = 0;
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  AnimationController animationController;
  Animation degOneTranslationAnimation,
      degTwoTranslationAnimation,
      degThreeTranslationAnimation;
  Animation rotationAnimation;

  double getRadiansFromDegree(double degree) {
    double unitRadian = 57.295779513;
    return degree / unitRadian;
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    degOneTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.2), weight: 75.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.2, end: 1.0), weight: 25.0),
    ]).animate(animationController);
    degTwoTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.4), weight: 55.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.4, end: 1.0), weight: 45.0),
    ]).animate(animationController);
    degThreeTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.75), weight: 35.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.75, end: 1.0), weight: 65.0),
    ]).animate(animationController);
    rotationAnimation = Tween<double>(begin: 180.0, end: 0.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut));
    super.initState();
    animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        child: Stack(
          children: <Widget>[
            Positioned(
                right: 20,
                bottom: 20,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: <Widget>[
                    IgnorePointer(
                      child: Container(
                        color: Colors.transparent,
                        height: 150.0,
                        width: 150.0,
                      ),
                    ),
                    Transform.translate(
                      offset: Offset.fromDirection(getRadiansFromDegree(270),
                          degOneTranslationAnimation.value * 100),
                      child: Transform(
                        transform: Matrix4.rotationZ(
                            getRadiansFromDegree(rotationAnimation.value))
                          ..scale(degOneTranslationAnimation.value),
                        alignment: Alignment.center,
                        child: CircularButton(
                          color: Colors.blue,
                          width: 50,
                          height: 50,
                          icon: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          onClick: () {
                            context.navigator.push(
                              MaterialPageRoute(
                                  builder: (context) => ProfilePage()),
                            );

                            // print('First Button');
                          },
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset.fromDirection(getRadiansFromDegree(225),
                          degTwoTranslationAnimation.value * 100),
                      child: Transform(
                        transform: Matrix4.rotationZ(
                            getRadiansFromDegree(rotationAnimation.value))
                          ..scale(degTwoTranslationAnimation.value),
                        alignment: Alignment.center,
                        child: CircularButton(
                          color: Colors.pink[200],
                          width: 50,
                          height: 50,
                          icon: Icon(
                            FlutterIcons.search_fea,
                            color: Colors.white,
                          ),
                          onClick: () {
                            context.navigator.push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SearchPage(showCancel: false)),
                            );
                          },
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset.fromDirection(getRadiansFromDegree(180),
                          degThreeTranslationAnimation.value * 100),
                      child: Transform(
                        transform: Matrix4.rotationZ(
                            getRadiansFromDegree(rotationAnimation.value))
                          ..scale(degThreeTranslationAnimation.value),
                        alignment: Alignment.center,
                        child: CircularButton(
                          color: Colors.orangeAccent,
                          width: 50,
                          height: 50,
                          icon: Icon(
                            FlutterIcons.inbox_ant,
                            color: Colors.white,
                          ),
                          onClick: () {
                            context.navigator.push(
                              MaterialPageRoute(
                                  builder: (context) => OrdersPage()),
                            );
                          },
                        ),
                      ),
                    ),
                    Transform(
                      transform: Matrix4.rotationZ(
                          getRadiansFromDegree(rotationAnimation.value)),
                      alignment: Alignment.center,
                      child: CircularButton(
                        color: Colors.blueGrey[800],
                        width: 50,
                        height: 50,
                        icon: !animationController.isCompleted
                            ? Icon(
                                Icons.menu,
                                color: Colors.amber[300],
                              )
                            : Icon(
                                Icons.close,
                                color: Colors.red[200],
                              ),
                        onClick: () {
                          if (animationController.isCompleted) {
                            animationController.reverse();
                          } else {
                            animationController.forward();
                          }
                        },
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 25),
          HStack(
            [
              ("Welcome".i18n +
                      ((widget.vm.isAuthenticated() &&
                              " ${AuthServices.currentUser?.name}" != "null")
                          ? " ${AuthServices.currentUser?.name}"
                          : ""))
                  .text
                  .color(Colors.green[500])
                  .xl2
                  .semiBold
                  .make(),
            ],
            crossAlignment: CrossAxisAlignment.center,
          ).px24().py12(),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 16, right: 16),
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 190,
                  child: Swiper(
                    onIndexChanged: (index) {
                      setState(() {
                        _current = index;
                      });
                    },
                    autoplay: true,
                    layout: SwiperLayout.DEFAULT,
                    itemCount: carusels.length,
                    itemBuilder: (BuildContext context, index) {
                      return CachedNetworkImage(
                        placeholder: (context, url) =>
                            Image.asset("assets/images/welcomeload.png"),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        imageUrl: carusels[index].image,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.fill)),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 18),
            child: Row(
              children: map<Widget>(carusels, (index, image) {
                return Container(
                  alignment: Alignment.centerLeft,
                  height: 6,
                  width: 6,
                  margin: EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _current == index
                          ? Colors.green[500]
                          : Colors.grey[300]),
                );
              }),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: SingleChildScrollView(
                child: VStack(
              [
                VStack(
                  [
                    SafeArea(
                        child: CustomListView(
                      noScrollPhysics: true,
                      dataSet: widget.vm.vendorTypes,
                      isLoading: widget.vm.isBusy,
                      itemBuilder: (context, index) {
                        final vendorType = widget.vm.vendorTypes[index];
                        return VendorTypeListItem(
                          vendorType,
                          onPressed: () {
                            widget.vm.pageSelected(vendorType);
                          },
                        );
                      },
                      separatorBuilder: (context, index) =>
                          UiSpacer.emptySpace(),
                    )),
                  ],
                ).px16(),
              ],
            )),
          ),
        ],
      ),
    );
  }
}

class CircularButton extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final Icon icon;
  final Function onClick;

  CircularButton(
      {this.color, this.width, this.height, this.icon, this.onClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      width: width,
      height: height,
      child: IconButton(icon: icon, enableFeedback: true, onPressed: onClick),
    );
  }
}
