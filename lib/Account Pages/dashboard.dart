import 'package:cultiva/function/dashboard/dashboard_helper.dart';
import 'package:cultiva/function/dashboard/showeditproductdialog.dart';
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
  TextEditingController editController = TextEditingController();
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

  void saveTotalProduct() {
    final dashboardData = DashboardData(totalProduct: totalProduct);
    dashboardBox.put('dashboardData', dashboardData);
  }

  void handleEditPorductDialog() {
    showEditProductDialog(
      context,
      editController,
      (newValue) {
        setState(() {
          totalProduct = newValue;
        });
        saveTotalProduct();
      },
    );
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
                            onTap: handleEditPorductDialog,
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
              SizedBox(
                height: 20,
              ),
              Container(
                  height: 250,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            spreadRadius: 5,
                            blurRadius: 10)
                      ]),
                  child: PieChart(PieChartData(
                      sections:
                          getDoughNutData(widget.soldProducts, totalProduct),
                      centerSpaceRadius: 60,
                      sectionsSpace: 4))),
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Container(
                    width: 16,
                    height: 16,
                    color: Colors.green,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text('Sold Products')
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 16,
                    height: 16,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text('Total Products')
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 16,
                    height: 16,
                    color: Colors.blue,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text('Unsold Products')
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
                    width: getChartData(selectedTImeRange).length * 80.0,
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceAround,
                        maxY: 20,
                        barGroups: getChartData(selectedTImeRange),
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: true),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) => getTitlesWidget(
                                  value, meta, selectedTImeRange),
                            ),
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
            ],
          ),
        ),
      ),
    );
  }
}
