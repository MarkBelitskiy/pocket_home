part of '../../feature.dart';

class _FilePreview extends StatelessWidget {
  final UploadFileModel file;
  const _FilePreview({
    Key? key,
    required this.file,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
            onTap: () {},
            child: _PreviewItemLocal(
              imagePath: _getThumbnail(),
              path: file.filePath,
              fileType: file.type,
            )),
        _DeleteFileWidget(
          canDelete: file.isReady,
        ),
        if (file.type == FILE_TYPE.VIDEO && file.duration != null)
          _DurationWidget(duration: file.duration!)
      ],
    );
  }

  String _getThumbnail() {
    switch (file.type) {
      case FILE_TYPE.PHOTO:
        {
          return file.filePath;
        }
      case FILE_TYPE.VIDEO:
        {
          return file.videoThumbnailPath ?? file.filePath;
        }
      default:
        return "";
    }
  }
}
