import 'package:flutter/material.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';
import 'package:petropal/screens/superadmin_dashboard/chart_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ApprovePricing extends StatefulWidget {
  const ApprovePricing({super.key});

  @override
  State<ApprovePricing> createState() => _ApprovePricingState();
}

class _ApprovePricingState extends State<ApprovePricing> {
  late List<ChartData> data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = [
      ChartData(17, 200),
      ChartData(18, 205),
      ChartData(19, 190),
      ChartData(20, 201),
      ChartData(21, 196),
      ChartData(22, 206),
      ChartData(23, 209),
      ChartData(24, 202),
      ChartData(25, 191),
      ChartData(26, 195),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Approve prices',
            style: displayBigBoldBlack,
          ),
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Shell Limited',
                style: displayBigBoldBlack,
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: SfCartesianChart(
                  margin: const EdgeInsets.all(0),
                  borderWidth: 0,
                  borderColor: Colors.transparent,
                  plotAreaBorderWidth: 0,
                  primaryXAxis: NumericAxis(
                      minimum: 17,
                      maximum: 26,
                      borderColor: primaryDarkColor,
                      borderWidth: 0,
                      labelStyle: const TextStyle(color: primaryDarkColor),
                      isVisible: false),
                  primaryYAxis: NumericAxis(
                      minimum: 188,
                      maximum: 211,
                      //interval: 1,
                      borderWidth: 0,
                      //borderColor: primaryDarkColor,
                      labelStyle: const TextStyle(color: primaryDarkColor),
                      isVisible: false),
                  series: <ChartSeries<ChartData, int>>[
                    SplineAreaSeries(
                        dataSource: data,
                        xValueMapper: (ChartData data, _) => data.day,
                        yValueMapper: (ChartData data, _) => data.price,
                        splineType: SplineType.natural,
                        gradient: LinearGradient(
                            colors: [
                              primaryDarkColor.withOpacity(0.1),
                              Colors.white,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
                    SplineSeries(
                      dataSource: data,
                      color: primaryDarkColor,
                      // markerSettings: const MarkerSettings(
                      //     color: primaryDarkColor,
                      //     borderWidth: 3,
                      //     shape: DataMarkerType.circle,
                      //     isVisible: true),
                      xValueMapper: (ChartData data, _) => data.day,
                      yValueMapper: (ChartData data, _) => data.price,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Text(
                    'Current average price: ',
                    style: bodyText,
                  ),
                  Text(
                    'KES 200',
                    style: m_title,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Current price shared:',
                            style: bodyText,
                          ),
                          Text(
                            'Current Commission Rate',
                            style: bodyText,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'KES 150',
                            style: m_title,
                          ),
                          Text(
                            'KES 1',
                            style: m_title,
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: primaryDarkColor),
                        borderRadius: BorderRadius.circular(5)),
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.close,
                        color: primaryDarkColor,
                      ),
                      label: const Text(
                        'Cancel',
                        style: TextStyle(color: primaryDarkColor),
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primaryDarkColor),
                    icon: const Icon(
                      Icons.check,
                      size: 24.0,
                    ),
                    label: const Text('Approve'), // <-- Text
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
