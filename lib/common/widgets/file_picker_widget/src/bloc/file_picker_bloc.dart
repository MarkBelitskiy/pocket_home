import 'package:bloc/bloc.dart';

part 'file_picker_event.dart';
part 'file_picker_state.dart';

class FilePickerBloc extends Bloc<FilePickerEvent, FilePickerState> {
  final List<String> paths = [];
  FilePickerBloc() : super(FileAddedSuccessState([])) {
    on<FilePickerEvent>((event, emit) {
      if (event is PickedFilesEvent) {
        _pickedFilesEvent(event, emit);
      }
      if (event is RemoveFileEvent) {
        _fileDeleteEvent(event, emit);
      }
    });
  }
  Future<void> _pickedFilesEvent(
    PickedFilesEvent event,
    Emitter<FilePickerState> emit,
  ) async {
    try {
      paths.addAll(event.filePickerPaths);

      emit(FileAddedSuccessState(paths));
    } catch (e) {
      emit(FilePickerErrorState(e.toString()));
    }
  }

  Future<void> _fileDeleteEvent(
    RemoveFileEvent event,
    Emitter<FilePickerState> emit,
  ) async {
    try {
      paths.removeAt(event.fileIndex);
      emit(FileAddedSuccessState(paths));
    } catch (e) {
      emit(FilePickerErrorState(e.toString()));
    }
  }
}
