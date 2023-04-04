import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:pocket_home/common/widgets/button_widget.dart';

import 'package:rxdart/rxdart.dart';
import 'package:share_plus/share_plus.dart';

class PdfWidget extends StatefulWidget {
  final String path;
  final bool isVertical;

  const PdfWidget({Key? key, this.isVertical = true, required this.path}) : super(key: key);

  @override
  State<PdfWidget> createState() => _PdfWidgetState();
}

class _PdfWidgetState extends State<PdfWidget> {
  final pagesIndicator = BehaviorSubject<String>.seeded("-/-");

  Stream<String> get pagesIndicatorStream => pagesIndicator.stream;
  final ValueNotifier<bool> _notifier = ValueNotifier(!Platform.isAndroid);
  @override
  void initState() {
    if (Platform.isAndroid) {
      Future.delayed(const Duration(milliseconds: 500)).then((value) => _notifier.value = true);
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
                Factory<HorizontalDragGestureRecognizer>(() => HorizontalDragGestureRecognizer()..onUpdate = (_) {})
              },
              filePath: widget.path,
              preventLinkNavigation: true,
              onRender: (int? value) {
                Future.delayed(const Duration(milliseconds: 100)).then((value) => setState(() {}));
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
                pagesIndicator.sink.add("${current != null ? current + 1 : '-'}/${count ?? '-'}");
              },
            ),
          if (value)
            StreamBuilder<String>(
                stream: pagesIndicatorStream,
                builder: (context, snapshot) {
                  return snapshot.connectionState == ConnectionState.active && snapshot.hasData
                      ? pageCounterWidget(snapshot.data!)
                      : const SizedBox.shrink();
                }),
          Positioned(
              bottom: 60,
              left: 40,
              right: 40,
              child: MainAppButton(
                onPressed: () {
                  Share.shareXFiles([XFile(widget.path)]);
                },
                title: 'share',
              ))
        ],
      ),
    );
  }

  Widget pageCounterWidget(String indicator) {
    return Positioned(
      top: 10,
      left: 10,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: const BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Text(
          indicator,
        ),
      ),
    );
  }
}
