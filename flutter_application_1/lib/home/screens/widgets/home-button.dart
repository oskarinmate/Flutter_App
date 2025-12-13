import 'package:flutter/material.dart';

class HomeButton extends StatelessWidget {
  final Icon icon;
  const HomeButton({Key? key, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: icon,
      onPressed: () {
        print("Exit to app");
      },
    );
  }
}
