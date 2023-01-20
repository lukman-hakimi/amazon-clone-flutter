import 'package:flutter/material.dart';

class AccountBtns extends StatelessWidget {
  final Function()? onTap;
  final Color? color;
  final double radius;
  final Widget? child;

  const AccountBtns({Key? key, required this.child, required this.onTap,required this.radius, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(radius),
      child: InkWell(
        borderRadius: BorderRadius.circular(radius),
        onTap: onTap, 
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
          ),
          child: Center(
              child: child),
        ),
      ),
    );
  }
}
