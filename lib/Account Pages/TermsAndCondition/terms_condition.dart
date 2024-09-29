import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';

class Termcondition extends StatelessWidget {
  const Termcondition({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Terms & Conditions",
          style: GoogleFonts.judson(
              textStyle: TextStyle(fontSize: 23, fontWeight: FontWeight.w600)),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
                child: FutureBuilder(
              future: Future.delayed(Duration(milliseconds: 150)).then(
                (value) {
                  return rootBundle.loadString('Assets/terms&condition.md');
                },
              ),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Markdown(data: snapshot.data!);
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
