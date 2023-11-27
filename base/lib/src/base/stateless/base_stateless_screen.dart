import 'package:flutter/material.dart';

abstract class BaseStatelessScreen<T extends StatelessWidget> {
  @override
  Widget build(BuildContext context) {
    return isFullScreen() ? rootView()! : SafeArea(child: rootView()!);
  }

  Widget? rootView() {
    return Scaffold(
        extendBody: true,
        appBar: appBar(),
        drawer: drawer(),
        bottomNavigationBar: bottomNavigationBar(),
        backgroundColor: rootBackgroundColor(),
        body: body());
  }

  bool isFullScreen() => false;

  Widget? drawer() {
    return null;
  }

  PreferredSizeWidget? appBar() {
    return null;
  }

  Widget body();

  Widget? bottomNavigationBar() {
    return null;
  }

  Color rootBackgroundColor() {
    return const Color.fromRGBO(0, 139, 255, 1);
  }
}
