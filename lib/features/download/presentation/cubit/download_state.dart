enum DownloadStatus { initial, downloading, downloaded, failure }

class DownloadState {
  final DownloadStatus status;

  final double progress;

  final String? error;

  const DownloadState({
    this.status = DownloadStatus.initial,

    this.progress = 0,

    this.error,
  });

  DownloadState copyWith({
    DownloadStatus? status,

    double? progress,

    String? error,
  }) {
    return DownloadState(
      status: status ?? this.status,

      progress: progress ?? this.progress,

      error: error,
    );
  }
}
