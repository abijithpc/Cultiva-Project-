import 'package:cultiva/model/dashboard.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Dashboard extends StatefulWidget {
  final int soldProducts;
  final double totalRevenue;
  const Dashboard({Key? key, this.totalRevenue = 0.0, this.soldProducts = 0})
      : super(key: key);

  @override
  State<Dashboard> createState() => _OverviewState();
}

class _OverviewState extends State<Dashboard> {
  TextEditingController addQuantityCntlr = TextEditingController();
  TextEditingController editContoller = TextEditingController();
  int totalProduct = 1000;
  String selectedTImeRange = 'Week';

  late Box<DashboardData> dashboardBox;

  @override
  void initState() {
    super.initState();
    openDashboardBox();
  }

  Future<void> openDashboardBox() async {
    dashboardBox = await Hive.openBox<DashboardData>('dashboardBox');

    final savedData = dashboardBox.get('dashboardData');
    if (savedData != null) {
      setState(() {
        totalProduct = savedData.totalProduct ?? 1000;
      });
    }
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

  List<BarChartGroupData> getChartData() {
    if (selectedTImeRange == 'Week') {
      return weeklyData;
    } else {
      return monthlyData;
    }
  }

  Widget getTitlesWidget(double value, TitleMeta meta) {
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

  void addProductQuantity() {
    int quantityToAdd = int.tryParse(addQuantityCntlr.text) ?? 0;
    setState(() {
      totalProduct += quantityToAdd;
    });
    saveTotalProduct();
    addQuantityCntlr.clear();
  }

  void saveTotalProduct() {
    final dashboardData = DashboardData(totalProduct: totalProduct);
    dashboardBox.put('dashboardData', dashboardData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dashboard",
          style: GoogleFonts.judson(textStyle: TextStyle(fontSize: 26)),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 220,
                    height: 150,
                    decoration: BoxDecoration(
                        color: Colors.blue[400],
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Total Product:\n $totalProduct",
                          style: GoogleFonts.judson(
                              textStyle:
                                  TextStyle(fontSize: 20, color: Colors.white)),
                        ),
                        GestureDetector(
                            onTap: showEditProductDialog,
                            child: Icon(Icons.edit)),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 160,
                        height: 150,
                        decoration: BoxDecoration(
                            color: Colors.blue[400],
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: Text(
                            "Total Revenue:\n ₹${widget.totalRevenue.toStringAsFixed(2)}",
                            style: GoogleFonts.judson(
                                textStyle: TextStyle(
                                    fontSize: 18, color: Colors.white)),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 14,
              ),
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                        color: Colors.blue[200],
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Sold Product: ${widget.soldProducts}",
                          style: GoogleFonts.judson(
                              textStyle:
                                  TextStyle(fontSize: 20, color: Colors.white)),
                        ),
                        Text(
                          "Unsold Product : ${totalProduct - widget.soldProducts}",
                          style: GoogleFonts.judson(
                              textStyle:
                                  TextStyle(fontSize: 20, color: Colors.white)),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton<String>(
                    value: selectedTImeRange,
                    items: [
                      'Week',
                      'Month',
                    ].map((String range) {
                      return DropdownMenuItem(value: range, child: Text(range));
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedTImeRange = newValue!;
                      });
                    },
                  )
                ],
              ),
              Container(
                height: 300,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          spreadRadius: 5)
                    ]),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: getChartData().length * 80.0,
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceAround,
                        maxY: 20,
                        barGroups: getChartData(),
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: true),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: getTitlesWidget),
                          ),
                        ),
                        gridData: FlGridData(show: true),
                        borderData: FlBorderData(
                          show: true,
                          border: Border.all(color: Colors.grey, width: 1),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 300,
                    child: TextField(
                      controller: addQuantityCntlr,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Add Quantity',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              ElevatedButton(onPressed: addProductQuantity, child: Text("Add"))
            ],
          ),
        ),
      ),
    );
  }

  void showEditProductDialog() {
    editContoller.text = totalProduct.toString();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit Total Product"),
          content: TextField(
            controller: editContoller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: "Enter new total product"),
          ),
          actions: <Widget>[
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Cancel")),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    totalProduct =
                        int.tryParse(editContoller.text) ?? totalProduct;
                  });

                  saveTotalProduct();
                  Navigator.of(context).pop();
                },
                child: Text("Save"))
          ],
        );
      },
    );
  }
}
