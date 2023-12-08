import 'package:base/src/base/stateful/base_stateful_state.dart';
import 'package:base/src/base/stateful/base_stateful_widget.dart';
import 'package:flutter/material.dart';

mixin BaseStatefulScreen<T extends BaseStatefulWidget>
    on BaseStateFullState<T> {
  @override
  Widget build(BuildContext context) {
    return isFullScreen() ? rootView()! : SafeArea(child: rootView()!);
  }

  Widget? rootView() {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,
        appBar: appBar(),
        drawer: drawer(),
        bottomNavigationBar: bottomNavigationBar(),
        backgroundColor: rootBackgroundColor(),
        body: _layoutBuilderBody());
  }

  bool isFullScreen() => false;

  Widget? drawer() {
    return null;
  }

  PreferredSizeWidget? appBar() {
    return null;
  }

  Widget _layoutBuilderBody() {
    return LayoutBuilder(builder: (context, constraints) {
      return body(constraints);
    });
  }

  Widget body(BoxConstraints constraints);

  Widget? bottomNavigationBar() {
    return null;
  }

  Color rootBackgroundColor() {
    return const Color.fromRGBO(0, 139, 255, 1);
  }
}
