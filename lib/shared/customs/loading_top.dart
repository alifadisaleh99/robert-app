import 'package:flutter/cupertino.dart';

import '../styles/color.dart';

class LoadingManager extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  const LoadingManager({
    super.key,
    required this.isLoading,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (!isLoading) return child;
    return Container(
        padding: const EdgeInsets.only(top: 150),
        alignment: Alignment.center,
        child: const CupertinoActivityIndicator(
          radius: 30,
          color: AppColor.blueColor,
        ));
  }
}
