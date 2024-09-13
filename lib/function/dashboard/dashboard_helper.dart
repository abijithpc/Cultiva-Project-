import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

List<PieChartSectionData> getDoughNutData(int soldProducts, int totalProduct) {
  final unsoldProducts = totalProduct - soldProducts;

  return [
    PieChartSectionData(
      color: Colors.green,
      value: soldProducts.toDouble(),
      title: '$soldProducts',
      radius: 50,
      titleStyle: TextStyle(
          fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
    ),
    PieChartSectionData(
      color: Colors.black,
      value: soldProducts.toDouble(),
      title: '$totalProduct',
      radius: 50,
      titleStyle: TextStyle(
          fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
    ),
    PieChartSectionData(
      color: Colors.blue,
      value: unsoldProducts.toDouble(),
      title: '$unsoldProducts',
      radius: 50,
      titleStyle: TextStyle(
          fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
    )
  ];
}

  final List<BarChartGroupData> weeklyData = [
    BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 1, width: 16)]),
    BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 3, width: 16)]),
    BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 2, width: 16)]),
    BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 4, width: 16)]),
    BarChartGroupData(x: 4, barRods: [BarChartRodData(toY: 3, width: 16)]),
    BarChartGroupData(x: 5, barRods: [BarChartRodData(toY: 5, width: 16)]),
    BarChartGroupData(x: 6, barRods: [BarChartRodData(toY: 4, width: 16)]),
  ];

  final List<BarChartGroupData> monthlyData = [
    BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 5, width: 16)]),
    BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 6, width: 16)]),
    BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 8, width: 16)]),
    BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 7, width: 16)]),
    BarChartGroupData(x: 4, barRods: [BarChartRodData(toY: 6, width: 16)]),
    BarChartGroupData(x: 5, barRods: [BarChartRodData(toY: 9, width: 16)]),
    BarChartGroupData(x: 6, barRods: [BarChartRodData(toY: 8, width: 16)]),
    BarChartGroupData(x: 7, barRods: [BarChartRodData(toY: 5, width: 16)]),
    BarChartGroupData(x: 8, barRods: [BarChartRodData(toY: 6, width: 16)]),
    BarChartGroupData(x: 9, barRods: [BarChartRodData(toY: 8, width: 16)]),
    BarChartGroupData(x: 10, barRods: [BarChartRodData(toY: 7, width: 16)]),
    BarChartGroupData(x: 11, barRods: [BarChartRodData(toY: 6, width: 16)]),
  ];

  List<BarChartGroupData> getChartData(String selectedTImeRange) {
    if (selectedTImeRange == 'Week') {
      return weeklyData;
    } else {
      return monthlyData;
    }
  }

  Widget getTitlesWidget(double value, TitleMeta meta, String selectedTImeRange) {
    if (selectedTImeRange == 'Week') {
      switch (value.toInt()) {
        case 0:
          return const Text('Mon');
        case 1:
          return const Text('Tue');
        case 2:
          return const Text('Wed');
        case 3:
          return const Text('Thu');
        case 4:
          return const Text('Fri');
        case 5:
          return const Text('Sat');
        case 6:
          return const Text('Sun');
      }
    } else if (selectedTImeRange == 'Month') {
      switch (value.toInt()) {
        case 0:
          return const Text('Jan');
        case 1:
          return const Text('Feb');
        case 2:
          return const Text('Mar');
        case 3:
          return const Text('Apr');
        case 4:
          return const Text('May');
        case 5:
          return const Text('Jun');
        case 6:
          return const Text('Jul');
        case 7:
          return const Text('Aug');
        case 8:
          return const Text('Sep');
        case 9:
          return const Text('Oct');
        case 10:
          return const Text('Nov');
        case 11:
          return const Text('Dec');
      }
    }
    return const Text('');
  }