import 'package:flutter/material.dart';

class SingleChildScrollViewWithColumn extends StatelessWidget {
  const SingleChildScrollViewWithColumn({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: constraints.maxHeight,
          ),
          child: child,
        ),
      );
    });
  }
}
