import 'package:flutter/material.dart';
import 'package:little_notes/common/common.dart';
import 'package:little_notes/models/index.dart';
import 'package:little_notes/service/app_service.dart';
import 'package:little_notes/style/style_vars.dart';
import 'package:provider/provider.dart';
import 'count_fields.dart';
import 'wallet.dart';
import 'entrys.dart';

/// 首页banner，其父级树中必须包含SliverAppBar
class HomeBanner extends StatefulWidget {
  const HomeBanner({Key? key}) : super(key: key);

  @override
  _HomeBannerState createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> {
  @override
  Widget build(BuildContext context) {
    SliverAppBar? sAppBar =
        context.findAncestorWidgetOfExactType<SliverAppBar>();
    var appBarHeight = sAppBar?.toolbarHeight ?? 0;

    var book = context.select<AppService, BookModel>((app) => app.currentBook!);
    var monthCounts = context
        .select<AppService, Map<String, double>>((app) => {...app.monthCounts});

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
                top: appBarHeight +
                    MediaQuery.of(context).padding.top /
                        2 /*  appBar高度加顶栏的一半 */,
                left: StyleVars.paddingLG,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(top: StyleVars.paddingSM),
                        child:
                            book.bookModelFocusEnum == BookModelFocusEnum.Budget
                                ? Wallet(
                                    label: '预算',
                                    value: removeDecimalZeroFormat(
                                        monthCounts['monthBudget']!),
                                  )
                                : Wallet(
                                    label: '余额',
                                    value: removeDecimalZeroFormat(
                                        monthCounts['balance']!),
                                  )),
                    Divider(
                      indent: StyleVars.padding,
                    ),
                    CountFields(
                      monthCounts: monthCounts,
                      type: book.bookModelFocusEnum,
                    ),
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
