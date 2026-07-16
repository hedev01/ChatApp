enum UploadFileStatus { initial, loading, success, failure }

class UploadFileState {
  final UploadFileStatus status;
  final String? url;
  final String? error;

  UploadFileState({
    this.status = UploadFileStatus.initial,
    this.url,
    this.error,
  });

  UploadFileState copyWith(
    {UploadFileStatus? status,
    String? url,
    String? error,}
  ) {
    return UploadFileState(
      status: status ?? this.status,
      url: url ?? this.url,
      error: error ?? this.error,
    );
  }
}
