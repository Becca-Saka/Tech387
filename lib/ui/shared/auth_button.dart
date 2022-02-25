import 'package:flutter/material.dart';

import 'app_colors.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    Key? key,
    required this.title,
    this.onTap,
    this.color = appColor,
    this.isLoading = false,
  }) : super(key: key);
  final String title;
  final void Function()? onTap;
  final Color color;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      switchInCurve: Curves.elasticIn,
      switchOutCurve: Curves.elasticOut,
      transitionBuilder: (Widget child, Animation<double> animation) {
        return SizeTransition(
          child: child,
          sizeFactor: animation,
          axis: Axis.horizontal,
        );
      },
      child: isLoading
          ? Center(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30), color: appColor),
                child: Transform.scale(
                  scale: height * 0.001,
                  child: CircularProgressIndicator(
                      backgroundColor: secondaryColor.withOpacity(0.5),
                      strokeWidth: 10,
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(secondaryColor)),
                ),
              ),
            )
          : InkWell(
              onTap: onTap,
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  gradient: LinearGradient(colors: [
                    color.withOpacity(0.8),
                    color,
                    color.withOpacity(0.5),
                  ]),
                ),
                height: 60,
                child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
    );
  }
}
