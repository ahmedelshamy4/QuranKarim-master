import 'package:flutter/material.dart';

class MyPopUpMenuItem<T> extends PopupMenuItem<T> {
  final VoidCallback onClick;
  final Widget child;
  final T? value;

  const MyPopUpMenuItem(
      {Key? key, required this.child, required this.onClick, this.value})
      : super(key: key, child: child, value: value);

  @override
  PopupMenuItemState<T, PopupMenuItem<T>> createState() {
    return MyPopUpMenuItemState();
  }
}

class MyPopUpMenuItemState<T, PopUpMenuItem>
    extends PopupMenuItemState<T, MyPopUpMenuItem<T>> {
  @override
  void handleTap() {
    widget.onClick();
  }
}
