import 'package:chat_app/features/upload/domain/usecase/upload_file_usecase.dart';
import 'package:chat_app/features/upload/presentation/bloc/upload_file_event.dart';
import 'package:chat_app/features/upload/presentation/bloc/upload_file_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UploadFileBloc extends Bloc<UploadFileEvent, UploadFileState> {
  final UploadFileUsecase usecase;
  UploadFileBloc(this.usecase) : super(UploadFileState()) {
    on<Uploaded>(_uploadFile);
  }
  Future<void> _uploadFile(
    Uploaded event,
    Emitter<UploadFileState> emit,
  ) async {
    try {
      emit(state.copyWith(status: UploadFileStatus.loading));
      String url = await usecase(event.entity);
      if (url.isEmpty) return;
      emit(state.copyWith(status: UploadFileStatus.success, url: url));
    } catch (e) {
      emit(
        state.copyWith(status: UploadFileStatus.failure, error: e.toString()),
      );
    }
  }
}
