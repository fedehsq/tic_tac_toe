import 'package:flutter/material.dart';

class MyCell extends StatelessWidget {
  final String? player; 
  final void Function() onTap;
  const MyCell({super.key,  this.player, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 100,
        child: Icon(player == 'X'
            ? Icons.close
            : player == 'O'
                ? Icons.circle_outlined
                : null),
      ),
    );
  }
}