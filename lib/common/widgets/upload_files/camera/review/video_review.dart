import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:video_player/video_player.dart';

class CameraVideoReview extends StatefulWidget {
  final String videoPath;

  const CameraVideoReview({Key? key, required this.videoPath})
      : super(key: key);

  @override
  State<CameraVideoReview> createState() => _CameraVideoReviewState();
}

class _CameraVideoReviewState extends State<CameraVideoReview> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _controller = VideoPlayerController.file(File(widget.videoPath));
    _initializeVideoPlayerFuture = _controller.initialize();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          FutureBuilder(
              future: _initializeVideoPlayerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    _controller.value.isInitialized) {
                  return VideoPlayer(_controller);
                } else {
                  return CircularProgressIndicator();
                }
              }),
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
          //       func: () => Navigator.of(context).pop(widget.videoPath),
          //       name: getLocale(context)?.send ?? '',
          //     )),
          Center(
            child: InkWell(
              onTap: () {
                setState(() {
                  if (_controller.value.isPlaying) {
                    _controller.pause();
                  } else {
                    _controller.play();
                  }
                });
              },
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                ),
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  "assets/icons_svg/upload_files_icons/${_controller.value.isPlaying ? "pause" : "play_arrow"}.svg",
                  width: 24,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
