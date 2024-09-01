import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Carousel2 extends StatelessWidget {
  const Carousel2({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: CarouselSlider(
        options: CarouselOptions(
          height: 280.0,
          autoPlay: true,
          aspectRatio: 16 / 9,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
        ),
        items: [
          'Assets/CarouselImage/stephanie-harvey-vHkj3fX9wCk-unsplash.jpg',
          'Assets/CarouselImage/pexels-delaney-van-vranken-3119898-4977455.jpg',
          'Assets/CarouselImage/kari-shea-3_cyj5YkhTs-unsplash.jpg',
        ]
            .map((item) => Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          item,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                      Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: Container(
                              height: 100,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 90.0, vertical: 20.0),
                              color: Colors.black.withOpacity(0.5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text("Indoor Plants",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10.0,
                                      )),
                                  Text("Dori Succulent",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13.0,
                                      )),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text("200",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10.0,
                                      ))
                                ],
                              ),
                            ),
                          ))
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }
}
