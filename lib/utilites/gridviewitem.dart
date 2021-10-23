import 'package:flutter/material.dart';

class GridViewItem extends StatelessWidget {
  final Widget icon;
  final bool selected;
  final VoidCallback onTap;

  const GridViewItem({
    Key? key,
    required this.icon,
    required this.selected,
    required this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        child: Center(
          child: icon,
        ),
        color: selected ? const Color(0xFF5F5D70) : const Color(0xffececec),
      ),
    );
  }
}