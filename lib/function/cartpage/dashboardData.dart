import 'package:flutter/material.dart';

class Dashboarddata {
  static final ValueNotifier<double> totalRevenueNotifier =
      ValueNotifier<double>(0.0);
  static final ValueNotifier<int> soldProductNotifier = ValueNotifier(0);
}
