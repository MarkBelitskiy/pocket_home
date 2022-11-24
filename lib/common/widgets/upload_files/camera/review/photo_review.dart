import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CameraPhotoReview extends StatelessWidget {
  final String photoPath;

  const CameraPhotoReview({Key? key, required this.photoPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.file(File(photoPath), fit: BoxFit.cover),
          Positioned(
              top: 35,
              left: 16,
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: SvgPicture.asset(
                  'assets/icons_svg/arrow_left_blue.svg',
                  color: Colors.white,
                ),
              )),
          // Positioned(
          //     bottom: 35,
          //     right: 24,
          //     child: BigGradientButton(
          //       width: 170,
          //       func: () => Navigator.of(context).pop(photoPath),
          //       name: getLocale(context)?.send ?? '',
          //     )),
        ],
      ),
    );
  }
}
