import 'package:flutter/material.dart';
import 'package:flutter_projects/core/constants/color_constants.dart';
import 'package:flutter_projects/core/constants/size_constants.dart';
import 'package:flutter_projects/features/dashboard/model/smoking.dart';

class OldSmokingCard extends StatefulWidget {
  final Smoking smoking;

  const OldSmokingCard({
    super.key,
    required this.smoking,
  });

  @override
  State<OldSmokingCard> createState() => _OldSmokingCardState();
}

class _OldSmokingCardState extends State<OldSmokingCard> {
  @override
  Widget build(BuildContext context) {
    sizeConfigInit(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.all(8.0),
      height: 50,
      width: screenWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: MAIN_GREEN,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.smoking_rooms_rounded, color: LIGHT_COLOR),
              const SizedBox(width: 6),
              Text(
                widget.smoking.dateTime,
                style: cardTitleText,
              ),
            ],
          ),
          Row(
            children: const [
              Icon(Icons.edit, color: LIGHT_COLOR),
              SizedBox(width: 16),
              Icon(Icons.delete_forever_rounded, color: LIGHT_COLOR),
            ],
          )
        ],
      ),
    );
  }
}
