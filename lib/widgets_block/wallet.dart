import 'dart:math';

import 'package:flutter/material.dart';

class Wallet extends StatelessWidget {
  final String label;
  final String value;

  const Wallet({Key? key, required this.label, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'lib/assets/wallet.png',
          height: 120,
        ),
        Positioned(
          right: 48,
          top: 36,
          child: Transform(
            transform: Matrix4.skewX(0.1)..rotateZ(-(pi / 14)),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '$label ',
                    style: TextStyle(color: Colors.white70),
                  ),
                  Text('￥$value',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 17)),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
