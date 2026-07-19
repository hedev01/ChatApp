import 'package:chat_app/features/download/domain/usecase/download_usecase.dart';
import 'package:chat_app/features/download/domain/usecase/is_downloaded_usecase.dart';
import 'package:chat_app/features/download/domain/usecase/open_file_usecase.dart';
import 'package:chat_app/features/download/presentation/cubit/download_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DownloadCubit extends Cubit<DownloadState> {

  final DownloadUsecase downloadFile;

  final OpenFileUseCase openFile;

  final IsDownloadedUseCase isDownloaded;

  DownloadCubit(

    this.downloadFile,

    this.openFile,

    this.isDownloaded,

  ) : super(const DownloadState());



  Future<void> check(String fileName) async {

    final downloaded = await isDownloaded(fileName);

    if (downloaded) {

      emit(
        state.copyWith(
          status: DownloadStatus.downloaded,
          progress: 1,
        ),
      );

    }

  }



  Future<void> download({

    required String url,

    required String fileName,

  }) async {

    emit(
      state.copyWith(
        status: DownloadStatus.downloading,
        progress: 0,
      ),
    );

    try {

      await downloadFile(

        url: url,

        fileName: fileName,

        onProgress: (progress) {

          emit(
            state.copyWith(
              progress: progress,
            ),
          );

        },

      );

      emit(

        state.copyWith(

          status: DownloadStatus.downloaded,

          progress: 1,

        ),

      );

    } catch (e) {

      emit(

        state.copyWith(

          status: DownloadStatus.failure,

          error: e.toString(),

        ),

      );

    }

  }

  Future<void> open(String fileName) {

    return openFile(fileName);

  }

}