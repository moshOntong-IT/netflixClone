import 'package:flutter/material.dart';
import 'package:flutter_netflix_responsive_ui/constant.dart';

class VerticalIconButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function onTap;

  const VerticalIconButton({
    Key key,
    this.icon,
    this.title,
    this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          const SizedBox(
            height: 2.0,
          ),
          Text(title, style: KTextStyle1),
        ],
      ),
    );
  }
}
