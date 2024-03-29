import 'package:flutter/material.dart';
import 'package:flutter_projects/core/providers/dashboard_provider.dart';
import 'package:flutter_projects/features/dashboard/model/smoking.dart';
import 'package:provider/provider.dart';

class DashboardMonthlyView extends StatefulWidget {
  const DashboardMonthlyView({super.key});

  @override
  State<DashboardMonthlyView> createState() => _DashboardMonthlyViewState();
}

class _DashboardMonthlyViewState extends State<DashboardMonthlyView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 500,
          width: MediaQuery.of(context).size.width,
          color: Colors.black12,
          child: FutureBuilder<List<Smoking>>(
              future: context.read<DashboardProvider>().setSmokings(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  itemCount: context.watch<DashboardProvider>().smokings.length,
                  itemBuilder: (context, index) {
                    final smoking =
                        context.watch<DashboardProvider>().smokings[index];
                    return Card(
                      child: ListTile(
                        title: Text(smoking.id.toString()),
                        subtitle: Text(smoking.dateTime),
                        trailing: Text(smoking.price.toString()),
                      ),
                    );
                  },
                );
              }),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () async {
            final smoking = Smoking.fromJson({
              'date': DateTime.now().toIso8601String(),
              'price': 2.0,
            });
            await context.read<DashboardProvider>().addSmoking(smoking);
          },
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            color: Colors.green,
            child: const Center(
              child: Text(
                'Add',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
        Spacer(),
        GestureDetector(
          onTap: () async {
            await context.read<DashboardProvider>().clearSmokings();
          },
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            color: Colors.green,
            child: const Center(
              child: Text(
                'Clear',
                style: TextStyle(
                  color: Colors.yellow,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
        Spacer(),
      ],
    );
  }
}
