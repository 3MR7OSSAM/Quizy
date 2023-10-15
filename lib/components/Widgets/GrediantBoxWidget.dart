import 'package:flutter/material.dart';

class GradientBoxWidget extends StatelessWidget {
   const GradientBoxWidget({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xff5D12D2).withOpacity(.6),
              const Color(0xff5D12D2).withOpacity(.48),
              const Color(0xff5D12D2).withOpacity(.54),
              const Color(0xff5D12D2).withOpacity(.6),
              const Color(0xff5D12D2).withOpacity(.65),

            ],
          ),
        ),
        child: child,
      ),
    );
  }
}
