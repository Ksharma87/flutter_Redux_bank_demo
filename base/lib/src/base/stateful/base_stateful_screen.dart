import 'package:base/src/base/stateful/base_stateful_state.dart';
import 'package:base/src/base/stateful/base_stateful_widget.dart';
import 'package:flutter/material.dart';

mixin BaseStatefulScreen<T extends BaseStatefulWidget> on BaseStateFullState<T> {
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
