import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pocket_home/common/theme/theme_getter.dart';
import 'package:pocket_home/common/widgets/file_picker_widget/src/bloc/file_picker_bloc.dart';
import 'package:pocket_home/common/widgets/main_app_bottom_sheet/main_app_bottom_sheet.dart';

part 'src/widget.dart';

class MainAppFilePicker extends StatelessWidget {
  const MainAppFilePicker(
      {super.key,
      required this.maxFiles,
      required this.onFilesAddedCallBack,
      this.isProfilePhotoWidget = false,
      this.profilePhotoPath});
  final int maxFiles;
  final String? profilePhotoPath;
  final Function(List<String>) onFilesAddedCallBack;
  final bool isProfilePhotoWidget;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FilePickerBloc(maxFiles == 1)
        ..add(profilePhotoPath != null && profilePhotoPath!.isNotEmpty
            ? PickedFilesEvent(filePickerPaths: [profilePhotoPath!])
            : InitEvent()),
      child: _FilePickerWidget(
          maxFiles: maxFiles,
          isProfilePhotoWidget: isProfilePhotoWidget,
          onFilesAddedCallBack: onFilesAddedCallBack,
          profilePhotoPath: profilePhotoPath),
    );
  }
}
