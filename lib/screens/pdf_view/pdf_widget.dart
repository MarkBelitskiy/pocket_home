import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import 'package:rxdart/rxdart.dart';

class PdfWidget extends StatefulWidget {
  final String pdfPath;
  final bool isVertical;
  final Uint8List pdfData;
  PdfWidget(
      {Key? key,
      required this.pdfPath,
      required this.pdfData,
      this.isVertical = true})
      : super(key: key);

  @override
  _PdfViewScreenState createState() => _PdfViewScreenState();
}

class _PdfViewScreenState extends State<PdfWidget> {
  final pagesIndicator = BehaviorSubject<String>.seeded("-/-");

  Stream<String> get pagesIndicatorStream => pagesIndicator.stream;
  bool _isInitComplete = false;
  ValueNotifier<bool> _notifier = ValueNotifier(!Platform.isAndroid);
  @override
  void initState() {
    if (Platform.isAndroid) {
      Future.delayed(Duration(milliseconds: 500))
          .then((value) => _notifier.value = true);
    }

    super.initState();
  }

  @override
  void dispose() {
    pagesIndicator.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _notifier,
      builder: (context, value, child) => Stack(
        children: [
          if (value)
            PDFView(
              pageFling: false,
              gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                Factory<VerticalDragGestureRecognizer>(
                  () => VerticalDragGestureRecognizer()..onUpdate = (_) {},
                ),
                Factory<HorizontalDragGestureRecognizer>(
                    () => HorizontalDragGestureRecognizer()..onUpdate = (_) {})
              },
              pdfData: widget.pdfData,
              preventLinkNavigation: true,
              onRender: (int? value) {
                Future.delayed(Duration(milliseconds: 100))
                    .then((value) => setState(() {
                          _isInitComplete = true;
                        }));
              },
              onViewCreated: (controller) {
                try {
                  controller.getPageCount().then((value) {
                    pagesIndicator.sink.add("1/${value ?? '-'}");
                  });
                } catch (e) {
                  pagesIndicator.sink.add("-/-");
                }
              },
              onLinkHandler: (String? link) {},
              onPageChanged: (current, count) {
                pagesIndicator.sink.add(
                    "${current != null ? current + 1 : '-'}/${count ?? '-'}");
              },
            ),
          if (value)
            StreamBuilder<String>(
                stream: pagesIndicatorStream,
                builder: (context, snapshot) {
                  return snapshot.connectionState == ConnectionState.active &&
                          snapshot.hasData
                      ? pageCounterWidget(snapshot.data!)
                      : const SizedBox.shrink();
                }),
          // if (!_isInitComplete)
        ],
      ),
    );
  }

  Widget pageCounterWidget(String indicator) {
    return Positioned(
      top: 10,
      left: 10,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Text(
          "$indicator",
        ),
      ),
    );
  }
}
