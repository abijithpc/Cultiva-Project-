import 'package:cultiva/productPage/indoor.dart';
import 'package:cultiva/productPage/outdoor.dart';
import 'package:cultiva/widget/carousel2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    double ScreenWidth = MediaQuery.of(context).size.width;
    double Screenheigth = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: GradientText(
            'Greening up my spaces',
            style: GoogleFonts.judson(
                textStyle: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w600,
            )),
            colors: [Colors.green, Color.fromARGB(255, 199, 194, 194)],
          ),
        ),
      ),
      body: SizedBox(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  child: TextFormField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        // border: OutlineInputBorder(
                        //     borderRadius: BorderRadius.circular(12)),
                        hintText: 'Search Plant',
                        filled: true,
                        fillColor: Colors.grey.withOpacity(0.3)),
                  ),
                ),
              ),
              SizedBox(
                height: Screenheigth * 0.01,
              ),
              Text(
                "Product Category",
                style: GoogleFonts.judson(
                    textStyle:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
              ),
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color.fromARGB(255, 228, 228, 228)),
                          width: 100,
                          height: 100,
                          child: IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Outdoor()));
                              },
                              icon: Image.asset(
                                'Assets/park.png',
                                fit: BoxFit.cover,
                              )),
                        ),
                        Text("Outdoor")
                      ],
                    ),
                    Column(
                      children: [
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color:
                                      const Color.fromARGB(255, 229, 229, 229)),
                              width: 100,
                              height: 100,
                              child: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Indoor()));
                                },
                                icon: Image.asset(
                                  'Assets/plant-pot.png',
                                  fit: BoxFit.cover,
                                  color: Colors.orange,
                                ),
                              ),
                            ),
                            const Text("Indoor")
                          ],
                         ),
                      ],
                    )
                  ],
                ),
              ),
              GestureDetector(child: Carousel2())
            ],
          ),
        ),
      ),
    );
  }
}
