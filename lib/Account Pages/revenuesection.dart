import 'package:cultiva/model/sellinfo.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class Revenuesection extends StatefulWidget {
  const Revenuesection({super.key});

  @override
  State<Revenuesection> createState() => _RevenuesectionState();
}

class _RevenuesectionState extends State<Revenuesection> {
  String? selectedDate;
  Map<String, num> revenueByDate = {};

  @override
  void initState() {
    super.initState();
    calculateRevenue();
  }

  void calculateRevenue() {
    final sellBox = Hive.box<Sellinfo>('sellBox').values.toList();
    revenueByDate = calculateRevenueByDate(sellBox);
    setState(() {});
  }

  Map<String, num> calculateRevenueByDate(List<Sellinfo> sales) {
    for (var sale in sales) {
      if (sale.sellDate != null && sale.totalPrice != null) {
        String formattedDate = DateFormat('dd-MM-yyyy').format(sale.sellDate!);

        if (revenueByDate.containsKey(formattedDate)) {
          revenueByDate[formattedDate] =
              revenueByDate[formattedDate]! + sale.totalPrice!;
        } else {
          revenueByDate[formattedDate] = sale.totalPrice!;
        }
      }
    }
    return revenueByDate;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheigth = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Revenue Section",
          style: GoogleFonts.judson(
              textStyle: const TextStyle(
            fontSize: 26,
          )),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: const Color.fromARGB(255, 176, 251, 178),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: screenWidth,
                  height: screenheigth * 0.07,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(12)),
                  child: DropdownButton<String>(
                    underline: SizedBox(),
                    icon: Icon(Icons.calendar_month, color: Colors.green),
                    hint: Text("Select a Date"),
                    items: revenueByDate.keys.map((String date) {
                      return DropdownMenuItem<String>(
                        value: date,
                        child: Text(date),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedDate = newValue;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                if (selectedDate != null)
                  Container(
                    alignment: Alignment.center,
                    width: screenWidth * 0.5,
                    height: screenheigth * 0.2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              "Revenue on: $selectedDate:",
                              style: GoogleFonts.judson(
                                  textStyle: TextStyle(
                                      color: const Color.fromARGB(
                                          255, 137, 235, 140),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          Text(
                            "₹${revenueByDate[selectedDate]!.toStringAsFixed(2)}",
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      ),
                    ),
                  ),
                if (selectedDate == null)
                  Text(
                    "Please select a date to View the Revenue",
                    style:
                        GoogleFonts.judson(textStyle: TextStyle(fontSize: 19)),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
