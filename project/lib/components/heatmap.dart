import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:project/tools/datetime.dart';

class MyHeatMap extends StatelessWidget {
 final Map<DateTime, int> datasets;
  final String startDate;
  const MyHeatMap({super.key, 
    required this.startDate,
    required this.datasets
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: HeatMap(
        startDate: createDateTime(startDate),
        endDate: DateTime.now().add(const Duration(days: 0)),
        datasets: datasets,
        colorMode: ColorMode.color,
        defaultColor: Colors.grey[200],
        textColor: Colors.white,
        showText: true,
        size: 30,
        colorsets: const{
          1: Colors.green
        },
      )
    );
    
  }
}