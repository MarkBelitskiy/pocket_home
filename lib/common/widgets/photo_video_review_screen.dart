import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'upload_files/components/UploadFileModel.dart';
import 'upload_files/components/upload_files_enums.dart';

class ShowMediaDocumentScreen extends StatefulWidget {
  final UploadFileModel? file;
  final FileFromNetworkModel? fileFromNetwork;

  const ShowMediaDocumentScreen(
      {Key? key, required this.file, this.fileFromNetwork})
      : super(key: key);

  @override
  _ShowMediaDocumentScreenState createState() =>
      _ShowMediaDocumentScreenState();
}

class _ShowMediaDocumentScreenState extends State<ShowMediaDocumentScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    switch (widget.fileFromNetwork != null) {
      case true:
        {
          if (widget.fileFromNetwork!.type == FILE_TYPE.VIDEO) {
            _controller = VideoPlayerController.network(
                widget.fileFromNetwork!.linkToFile);
            _initializeVideoPlayerFuture = _controller.initialize();
          }
        }
        break;
      default:
        if (widget.file!.type == FILE_TYPE.VIDEO) {
          _controller = VideoPlayerController.file(File(widget.file!.filePath));
          _initializeVideoPlayerFuture = _controller.initialize();
        }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "Просмотр медиа документа",
          ),
          centerTitle: true,
        ),
        body: widget.fileFromNetwork?.type == FILE_TYPE.PHOTO ||
                widget.file?.type == FILE_TYPE.PHOTO
            ? photoView()
            : videoPlayer(),
        floatingActionButton: widget.fileFromNetwork?.type == FILE_TYPE.VIDEO ||
                widget.file?.type == FILE_TYPE.VIDEO
            ? FloatingActionButton(
                onPressed: () {
                  setState(() {
                    if (_controller.value.isPlaying) {
                      _controller.pause();
                    } else {
                      _controller.play();
                    }
                  });
                },
                child: Icon(
                  _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                ),
              )
            : const SizedBox.shrink());
  }

  Widget photoView() {
    return Container(
      decoration: BoxDecoration(
          image: widget.fileFromNetwork != null
              ? DecorationImage(
                  image: NetworkImage(widget.fileFromNetwork!.linkToFile),
                  fit: BoxFit.contain)
              : DecorationImage(
                  image: FileImage(File(widget.file!.filePath)),
                  fit: BoxFit.contain)),
      width: double.infinity,
    );
  }

  Widget videoPlayer() {
    return FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              alignment: Alignment.bottomCenter,
              fit: StackFit.loose,
              children: <Widget>[
                AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
                VideoProgressIndicator(_controller, allowScrubbing: true),
              ],
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
