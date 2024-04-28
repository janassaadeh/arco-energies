import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class SlideShow extends StatefulWidget {
  const SlideShow({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SlideShowState();
  }
}

class _SlideShowState extends State<SlideShow> {
  int _currentSlide = 0; // track the current slide index

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: [
            _buildRoundedImage('assets/images/image1.png'),
            _buildRoundedImage('assets/images/image 2.png'),
            _buildRoundedImage('assets/images/image 3.jpg'),
            _buildRoundedImage('assets/images/image 4.png'),
            // _buildRoundedImage('assets/images/slide5.jpg'),
            // _buildRoundedImage('assets/images/slide6.jpg'),
            // _buildRoundedImage('assets/images/slide7.jpg'),
          ],
          options: CarouselOptions(
            aspectRatio: 13 / 5,
            viewportFraction: 0.8,
            initialPage: 0,
            enableInfiniteScroll: true,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 6),
            onPageChanged: (index, reason) {
              setState(() {
                _currentSlide = index;
              });
            },
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            7, //nb of images in the slideshow
            (index) {
              return Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentSlide == index
                      ? const Color.fromARGB(255, 61, 59, 59)
                      : const Color.fromARGB(255, 187, 183, 183),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRoundedImage(String imagePath) {
    //this widget helps to wrap the child widget with rounded corneres
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          imagePath,
          width: double.infinity,
          // height: 250,
        ),
      ),
    );
  }
}