import 'package:flutter/material.dart';
import 'package:little_notes/common/enums.dart';
import 'package:little_notes/style/style_vars.dart';

var sizeMap = {
  SizeEnum.small: {
    'width': 36.0,
    'height': 36.0,
    'diff': 12.0,
  },
  SizeEnum.regular: {
    'width': 44.0,
    'height': 44.0,
    'diff': 16.0,
  },
  SizeEnum.large: {
    'width': 54.0,
    'height': 54.0,
    'diff': 22.0,
  },
};

/* 分类圆形图标 */
class CircularImage extends StatelessWidget {
  final String icon;
  final String? label;
  final SizeEnum? size;
  final bool? selected;

  const CircularImage({
    Key? key,
    required this.icon,
    this.label,
    this.size = SizeEnum.regular,
    this.selected,
  }) : super(key: key);

  Widget _buildMain() {
    var currentSize = sizeMap[size];

    var image = Container(
      width: currentSize!['width'],
      height: currentSize['height'],
      decoration: BoxDecoration(
        color: Colors.pink.shade100,
        borderRadius: BorderRadius.all(Radius.circular(50)),
        border: Border.all(color: StyleVars.theme),
      ),
      child: Center(
        child: Image.asset('lib/assets/twemoji/$icon.png', height: currentSize['width']! - currentSize['diff']!,),
      ),
    );

    if (label != null) return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        image,
        Text(label!, style: TextStyle(color: StyleVars.colorSecond),)
      ],
    );

    return image;
  }

  @override
  Widget build(BuildContext context) {
    if (selected == null) return _buildMain();

    // 有选中状态时，为其渲染容器
    return Container(
      child: _buildMain(),
      padding: EdgeInsets.symmetric(horizontal: StyleVars.padding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(StyleVars.radius)),
        border: Border.all(color: selected! ? StyleVars.theme : Colors.transparent, width: 1),
      ),
    );
  }
}
