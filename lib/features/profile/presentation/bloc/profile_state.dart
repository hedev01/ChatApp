import 'dart:io';

enum ProfileStatus { initial, loading, success, failure }

class ProfileState {
  final File? avatar;
  final ProfileStatus status;
  final String? error;

  const ProfileState({
    this.avatar,
    this.status = ProfileStatus.initial,
    this.error,
  });

  ProfileState copyWith({File? avatar, ProfileStatus? status, String? error}) {
    return ProfileState(
      avatar: avatar ?? this.avatar,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
