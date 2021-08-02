import 'package:flutter/material.dart';
import 'package:little_notes/style/style_vars.dart';
import 'count_fields.dart';
import 'wallet.dart';
import 'entrys.dart';

class HomeBanner extends StatelessWidget {
  const HomeBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/assets/bg.jpg'),
                fit: BoxFit.cover,
              ),
              border: Border(
                  bottom: BorderSide(color: Colors.pink.shade100, width: 1))),
          child: Stack(
            children: [
              Positioned(
                top: 72,
                left: StyleVars.paddingLG,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(top: StyleVars.paddingSM),
                        child: Wallet()),
                    Divider(
                      indent: StyleVars.padding,
                    ),
                    CountFields(),
                  ],
                ),
              ),
              Positioned(
                right: 12,
                bottom: 12,
                child: Entrys(),
              )
            ],
          ),
        ));
  }
}
