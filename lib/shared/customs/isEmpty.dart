import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IsEmpty extends StatelessWidget {
  final bool isEmpty;
  final Widget child1;
  final Widget child2;

  const IsEmpty({
    Key? key,
    required this.isEmpty,
    required this.child1,
    required this.child2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!isEmpty) return child1;
    return child2;
  }
}
