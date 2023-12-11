import 'package:flutter/material.dart';

abstract class BaseStatelessScreen<T extends StatelessWidget> {
  @override
  Widget build(BuildContext context) {
    return isFullScreen() ? rootView()! : SafeArea(child: rootView()!);
  }

  Widget? rootView() {
    return PopScope(
        canPop: isCanPop(),
        onPopInvoked: (didPop) {
          onPopInvokedHere();
        },
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            extendBody: true,
            appBar: appBar(),
            drawer: drawer(),
            bottomNavigationBar: bottomNavigationBar(),
            backgroundColor: rootBackgroundColor(),
            body: _layoutBuilderBody()));
  }

  void onPopInvokedHere() {}

  bool isFullScreen() => false;

  bool isCanPop() => true;

  Widget? drawer() {
    return null;
  }

  Widget _layoutBuilderBody() {
    return LayoutBuilder(builder: (context, constraints) {
      return body(constraints);
    });
  }

  Widget body(BoxConstraints constraints);

  PreferredSizeWidget? appBar() {
    return null;
  }

  Widget? bottomNavigationBar() {
    return null;
  }

  Color rootBackgroundColor() {
    return const Color.fromRGBO(0, 139, 255, 1);
  }
}
