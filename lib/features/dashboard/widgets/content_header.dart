import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_projects/core/constants/size_constants.dart';

class ContentHeader extends StatelessWidget {
  const ContentHeader({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    sizeConfigInit(context);
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: contentHeaderTextStyle,
      ),
    );
  }
}
