import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pocket_home/common/theme/theme_getter.dart';

import 'components/UploadFileModel.dart';
import 'components/upload_files_enums.dart';

part 'components/widgets/buttons.dart';

part 'components/widgets/dialogs.dart';

part 'components/widgets/duration_widget.dart';

part 'components/widgets/local_files_preview.dart';

part 'components/widgets/modals.dart';

part 'components/widgets/preview_item.dart';

part 'upload_files.dart';

class UploadFilesWidget extends StatelessWidget {
  final int? maxFilesCount;
  final List<STORAGE_TYPE> storageTypes;
  final List<String>? incomingFilePaths;
  final List<FileFromNetworkModel>? filesFromNetwork;
  final Function(List<UploadFileModel>)? getFilesCallback;

  const UploadFilesWidget(
      {Key? key,
      this.maxFilesCount,
      required this.storageTypes,
      this.getFilesCallback,
      this.incomingFilePaths,
      this.filesFromNetwork})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _UploadFilesWidget(
        maxFilesCount: maxFilesCount,
        storageTypes: storageTypes,
        incomingFilePaths: incomingFilePaths,
        filesFromNetwork: filesFromNetwork,
        getFilesCallback: getFilesCallback);
  }
}
