part of 'file_picker_bloc.dart';

abstract class FilePickerEvent {}

class PickedFilesEvent extends FilePickerEvent {
  List<String> filePickerPaths;

  PickedFilesEvent({required this.filePickerPaths});
}

class RemoveFileEvent extends FilePickerEvent {
  final int fileIndex;

  RemoveFileEvent({required this.fileIndex});
}
