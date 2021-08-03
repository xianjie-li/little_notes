import 'dart:math';

import 'package:flutter/material.dart';

class Wallet extends StatelessWidget {
  const Wallet({Key? key}) : super(key: key);

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
                    '预算 ',
                    style: TextStyle(color: Colors.white70),
                  ),
                  Text('￥592551',
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
