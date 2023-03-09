import 'package:flutter/material.dart';
import 'package:my_amazon/models/sales.dart';
import 'package:my_amazon/services/admin_service.dart';
import 'package:my_amazon/widgets/admin/category_chart.dart';
import 'package:my_amazon/widgets/base/loader.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final AdminService adminService = AdminService();
  int? totalEarnings;
  List<Sales>? earnings;

  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  Future<void> getEarnings() async {
    var earningsData = await adminService.getEarnings(context: context);

    totalEarnings = earningsData['totalEarnings'];
    earnings = earningsData['sales'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return (earnings == null || totalEarnings == null)
        ? const Loader()
        : Column(
            children: [
              Text(
                "\$$totalEarnings",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 250,
                child: CategoryChart(seriesList: [
                  charts.Series(
                    id: 'Sales',
                    data: earnings!,
                    domainFn: (Sales sales, _) => sales.label,
                    measureFn: (Sales sales, _) => sales.earning,
                  )
                ]),
              )
            ],
          );
  }
}
