
// ignore_for_file: camel_case_types

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class carousel_Items extends StatelessWidget {
  const carousel_Items({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: CarouselSlider(
        options: CarouselOptions(
          height: 300.0,
          autoPlay: true,
          aspectRatio: 16 / 9,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
        ),
        items: [
          'Assets/CarouselImage/stephanie-harvey-vHkj3fX9wCk-unsplash.jpg',
          'Assets/CarouselImage/pexels-delaney-van-vranken-3119898-4977455.jpg',
          'Assets/CarouselImage/kari-shea-3_cyj5YkhTs-unsplash.jpg',
          'Assets/CarouselImage/igor-son-FV_PxCqgtwc-unsplash.jpg',
          'Assets/CarouselImage/kara-eads-EbLX7oRo4vI-unsplash.jpg',
          'Assets/CarouselImage/linh-le-Ebwp2-6BG8E-unsplash.jpg',
          'Assets/CarouselImage/saffu-Ct1Mx5OTn9A-unsplash.jpg',
          'Assets/CarouselImage/sarah-dorweiler-2s9aHF4eCjI-unsplash.jpg',
          'Assets/CarouselImage/sarah-dorweiler-x2Tmfd1-SgA-unsplash.jpg',
          'Assets/CarouselImage/scott-webb-hDyO6rr3kqk-unsplash.jpg',
          'Assets/CarouselImage/scott-webb-WwWkgOMU8H8-unsplash.jpg'
        ]
            .map((item) => ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.asset(
                item,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ))
            .toList(),
      ),
    );
  }
}
