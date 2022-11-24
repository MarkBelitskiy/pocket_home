part of 'feature.dart';

class _UploadFilesWidget extends StatelessWidget {
  final int? maxFilesCount;
  final List<STORAGE_TYPE> storageTypes;
  final List<String>? incomingFilePaths;
  final List<FileFromNetworkModel>? filesFromNetwork;
  final Function(List<UploadFileModel>)? getFilesCallback;

  const _UploadFilesWidget(
      {Key? key,
      this.maxFilesCount,
      required this.storageTypes,
      this.getFilesCallback,
      this.incomingFilePaths,
      this.filesFromNetwork})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _Body(
      storageTypes: storageTypes,
      maxFilesCount: maxFilesCount,
    );
  }

  void _handleChooseFile(
    BuildContext context,
  ) {
    _handleChooseCameraFile(
      context,
    );

    _handleChooseGalleryFile(
      context,
    );
  }

  Future _handleChooseCameraFile(
    BuildContext context,
  ) async {
    // final cameras = await availableCameras();
    // File? file =
    //     await Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
    //         builder: (_) => Camera(
    //               cameras: cameras,
    //             )));
    // if (file != null) {}
  }

  Future _handleChooseGalleryFile(
    BuildContext context,
  ) async {
    List<String?>? pickedFilePaths;

    pickedFilePaths = (await FilePicker.platform.pickFiles(
            type: FileType.image, allowMultiple: true, allowCompression: true))
        ?.files
        .map((e) => e.path)
        .toList();

    pickedFilePaths = (await FilePicker.platform.pickFiles(
            type: FileType.video, allowMultiple: true, allowCompression: false))
        ?.files
        .map((e) => e.path)
        .toList();

    pickedFilePaths = (await FilePicker.platform.pickFiles(
            type: FileType.custom,
            allowedExtensions: [
              "pdf",
              "rtf",
              "txt",
              "doc",
              "docx",
              "docm",
              "xlsx",
              "xlsm",
              "xls"
            ],
            allowMultiple: true))
        ?.files
        .map((e) => e.path)
        .toList();

    if (pickedFilePaths != null) {
      pickedFilePaths.removeWhere((element) => element == null);
      var tempPaths = <String>[];
      pickedFilePaths.forEach((element) {
        if (element != null) {
          tempPaths.add(element);
        }
      });
    }
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key, this.maxFilesCount, required this.storageTypes})
      : super(key: key);
  final int? maxFilesCount;

  final List<STORAGE_TYPE> storageTypes;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 1,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          // state.files.length + state.filesFromNetwork.length == 0 ? 1 : 3,
          mainAxisSpacing: 8,
          mainAxisExtent: 109,
          crossAxisSpacing: 8),
      itemBuilder: (context, index) {
        // if ((maxFilesCount == null || 1 >= maxFilesCount!) &&
        //     index == 0)
        return _AddButton(types: storageTypes, currentFilesLength: 1);

        // return _FilePreview(
        //   file:File(),
        // );
      },
    );
  }
}
