part of '../../feature.dart';

class _PreviewItem extends StatelessWidget {
  const _PreviewItem(
      {Key? key,
      this.imageProvider,
      this.path = '',
      this.fileType = FILE_TYPE.PHOTO})
      : super(key: key);

  final ImageProvider? imageProvider;

  final FILE_TYPE fileType;
  final String path;

  @override
  Widget build(BuildContext context) {
    try {
      // return Image.file(File(path), cacheHeight: 200, cacheWidth: 200, fit: BoxFit.cover,);
      return Container(
          key: ValueKey("$fileType/$path"),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            color: Colors.white,
            image: imageProvider != null
                ? DecorationImage(image: imageProvider!, fit: BoxFit.cover)
                : null,
          ),
          alignment: Alignment.center,
          child: fileType != FILE_TYPE.PHOTO && fileType != FILE_TYPE.VIDEO
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                      Container(
                          margin: const EdgeInsets.only(left: 8, top: 8),
                          alignment: Alignment.topLeft,
                          child: SvgPicture.asset(
                            'assets/icons_svg/upload_files_icons/${_getDocIcon()}.svg',
                          )),
                      const SizedBox(height: 4),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          basenameWithoutExtension(path),
                          maxLines: 2,
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ])
              : const SizedBox.shrink());
    } catch (e) {
      return const SizedBox.shrink();
    }
  }

  String _getDocIcon() {
    String docIcon = '';
    switch (fileType) {
      case FILE_TYPE.TABLEDOCUMENT:
        {
          docIcon = 'Excel';
        }

        break;
      case FILE_TYPE.TEXTDOCUMENT:
        {
          docIcon = 'Word';
        }
        break;
      default:
        docIcon = "PDF";
    }
    return docIcon;
  }
}

class _PreviewItemLocal extends StatelessWidget {
  const _PreviewItemLocal(
      {Key? key,
      required this.imagePath,
      this.path = '',
      this.fileType = FILE_TYPE.PHOTO})
      : super(key: key);

  final String imagePath;

  final FILE_TYPE fileType;
  final String path;

  @override
  Widget build(BuildContext context) {
    try {
      return Stack(
        fit: StackFit.expand,
        children: [
          if (imagePath.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              child: Image.file(
                File(imagePath),
                cacheWidth: (MediaQuery.of(context).size.width / 3).round(),
                fit: BoxFit.cover,
              ),
            ),
          fileType != FILE_TYPE.PHOTO && fileType != FILE_TYPE.VIDEO
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                      Container(
                          margin: const EdgeInsets.only(left: 8, top: 8),
                          alignment: Alignment.topLeft,
                          child: SvgPicture.asset(
                            'assets/icons_svg/upload_files_icons/${_getDocIcon()}.svg',
                          )),
                      const SizedBox(height: 4),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          basenameWithoutExtension(path),
                          maxLines: 2,
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ])
              : const SizedBox.shrink()
        ],
      );
    } catch (e) {
      return const SizedBox.shrink();
    }
  }

  String _getDocIcon() {
    String docIcon = '';
    switch (fileType) {
      case FILE_TYPE.TABLEDOCUMENT:
        {
          docIcon = 'Excel';
        }

        break;
      case FILE_TYPE.TEXTDOCUMENT:
        {
          docIcon = 'Word';
        }
        break;
      default:
        docIcon = "PDF";
    }
    return docIcon;
  }
}
