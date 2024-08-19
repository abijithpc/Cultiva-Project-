import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselItems extends StatelessWidget {
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
        ]
            .map((item) => Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      item,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
