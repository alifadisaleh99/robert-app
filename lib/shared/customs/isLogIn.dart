import 'package:flutter/material.dart';

class IsLogIn extends StatelessWidget {
  final bool isLogIn;
  final Widget child1;
  final Widget child2;

  const IsLogIn({
    Key? key,
    required this.isLogIn,
    required this.child1,
    required this.child2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!isLogIn) return child1;
    return child2;
  }
}
