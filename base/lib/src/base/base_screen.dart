import 'package:base/src/base/base_state.dart';
import 'package:base/src/base/base_widget.dart';
import 'package:flutter/material.dart';

mixin BaseScreen<T extends BaseWidget> on BaseState<T> {
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
