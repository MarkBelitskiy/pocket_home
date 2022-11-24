import 'dart:io';

import 'upload_files_enums.dart';

class UploadFileModel {
  bool isReady;
  String filePath;
  String? videoThumbnailPath;
  final FILE_TYPE type;
  int id;
  String? duration;

  @override
  UploadFileModel(
      {required this.isReady,
      required this.filePath,
      required this.type,
      required this.id,
      this.videoThumbnailPath,
      this.duration});
}

class FileFromNetworkModel {
  final String linkToFile;
  final Function onRemoveFileCallBack;
  bool isReady;
  File? videoThumbnail;
  FILE_TYPE? type;
  String? duration;
  FileFromNetworkModel(
      {required this.linkToFile,
      required this.onRemoveFileCallBack,
      this.isReady = false,
      this.duration});
}
