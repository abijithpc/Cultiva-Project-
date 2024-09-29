import 'package:flutter/material.dart';

class LegendRow extends StatelessWidget {
  // ignore: use_super_parameters
  const LegendRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 16,
              height: 16,
              color: Colors.green,
            ),
            SizedBox(width: 8),
            Text('Number of Sales'),
          ],
        ),
        Row(
          children: [
            Container(
              width: 16,
              height: 16,
              color: Colors.blue,
            ),
            SizedBox(width: 8),
            Text('Total Products'),
          ],
        ),
      ],
    );
  }
}
