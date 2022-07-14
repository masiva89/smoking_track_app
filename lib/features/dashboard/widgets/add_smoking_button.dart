import 'package:flutter/material.dart';
import 'package:flutter_projects/core/constants/color_constants.dart';
import 'package:flutter_projects/core/database/sqflite_manager.dart';
import 'package:flutter_projects/core/providers/dashboard_provider.dart';
import 'package:flutter_projects/features/dashboard/model/smoking.dart';
import 'package:flutter_projects/features/dashboard/service/dashboard_service.dart';
import 'package:provider/provider.dart';

class AddSmokingButton extends StatefulWidget {
  const AddSmokingButton({super.key});

  @override
  State<AddSmokingButton> createState() => _AddSmokingButtonState();
}

class _AddSmokingButtonState extends State<AddSmokingButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(MAIN_ORANGE),
            foregroundColor: MaterialStateProperty.all(LIGHT_COLOR),
            elevation: MaterialStateProperty.all(0),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            )),
        onPressed: () {
          final service = DashboardService();
          //SqfliteManager(path: "smoking_track.db").delete();
          service.getSmokingPrice().then((value) {
            final smoking = Smoking(
              dateTime: DateTime.now().toString(),
              price: value,
            );
            context.read<DashboardProvider>().addSmoking(smoking);
          });
          //service.getSmokingPrice();
          //service.clearSmokings();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.smoking_rooms, color: LIGHT_COLOR),
            SizedBox(width: 10),
            Text(
              "Sigara içtim",
              style: TextStyle(
                color: LIGHT_COLOR,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
