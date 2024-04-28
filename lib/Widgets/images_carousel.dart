import 'package:flutter/material.dart';
import 'dart:async';

class ImageCarouselWidget extends StatefulWidget {
  const ImageCarouselWidget({Key? key}) : super(key: key);

  @override
  _ImageCarouselWidgetState createState() => _ImageCarouselWidgetState();
}

class _ImageCarouselWidgetState extends State<ImageCarouselWidget> {
  int currentIndex = 0;
  final List<String> imageAssets = [
    'assets/images/image1.png',
    'assets/images/image 2.png',
    'assets/images/image 3.jpg',
    'assets/images/image 4.png',


    // Add more image URLs here
  ];
  late Timer timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (mounted) {
        setState(() {
          currentIndex = (currentIndex + 1) % imageAssets.length;
        });
      }
    });
  }

  void stopTimer() {
    timer.cancel();
  }

  @override
  void dispose() {
    stopTimer();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            for (int i = 0; i < imageAssets.length; i++)
              AnimatedOpacity(
                opacity: i == currentIndex ? 1.0 : 0.0,
                duration: Duration(milliseconds: 500),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    imageAssets[i],
                    fit: BoxFit.fill,
                   width: 403.64825439453125,
                height: 180,
                  ),
                ),
              ),
            Positioned(
              left: 0,
              child: IconButton(
                onPressed: () {
                  setState(() {
                    currentIndex = (currentIndex - 1) % imageAssets.length;
                    if (currentIndex < 0) {
                      currentIndex = imageAssets.length - 1;
                    }
                  });
                },
                icon: Icon(Icons.arrow_back_ios_outlined,
                    color: Colors.transparent, size: 20),
              ),
            ),
            Positioned(
              right: 0,
              child: IconButton(
                onPressed: () {
                  setState(() {
                    currentIndex = (currentIndex + 1) % imageAssets.length;
                  });
                },
                icon: Icon(Icons.arrow_forward_ios_outlined,
                    color: Colors.transparent, size: 20),
              ),
            ),
          ],
        ),
                const SizedBox(height: 20),
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
                  color: currentIndex == index
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
}
