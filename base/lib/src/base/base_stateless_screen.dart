import 'package:flutter/material.dart';

abstract class BaseStatelessScreen<T extends StatelessWidget> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          extendBody: true,
          appBar: appBar(),
          drawer: drawer(),
          bottomNavigationBar: bottomNavigationBar(),
          backgroundColor: rootBackgroundColor(),
          body: body()),
    );
  }

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
