import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductPieChart extends StatelessWidget {
  final int soldProducts;
  final int totalProduct;

  // ignore: use_super_parameters
  const ProductPieChart({
    Key? key,
    required this.soldProducts,
    required this.totalProduct,
  }) : super(key: key);

  List<PieChartSectionData> getDoughNutData() {
    return [
      PieChartSectionData(
        color: Colors.green,
        value: soldProducts.toDouble(),
        title: '$soldProducts',
        radius: 50,
        titleStyle: GoogleFonts.judson(
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      PieChartSectionData(
        color: Colors.blue,
        value: totalProduct.toDouble(),
        title: '$totalProduct',
        radius: 50,
        titleStyle: GoogleFonts.judson(
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: Colors.black12, spreadRadius: 5, blurRadius: 10),
        ],
      ),
      child: PieChart(
        PieChartData(
          sections: getDoughNutData(),
          centerSpaceRadius: 60,
          sectionsSpace: 4,
        ),
      ),
    );
  }
}
