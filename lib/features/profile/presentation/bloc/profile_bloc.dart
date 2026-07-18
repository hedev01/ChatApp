import 'dart:io';

import 'package:chat_app/core/services/upload/picker_repository.dart';
import 'package:chat_app/features/profile/domain/entities/upload_avatar_entity.dart';
import 'package:chat_app/features/profile/domain/usecases/upload_avatar_usecase.dart';
import 'package:chat_app/features/profile/presentation/bloc/profile_event.dart';
import 'package:chat_app/features/profile/presentation/bloc/profile_state.dart';
import 'package:chat_app/features/user/domain/usecase/update_avatar_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final PickerRepository pickerRepository;
  final UploadAvatarUsecase uploadAvatarUsecase;
  final UpdateAvatarUsecase updateAvatarUsecase;
  ProfileBloc(
    this.pickerRepository,
    this.uploadAvatarUsecase,
    this.updateAvatarUsecase,
  ) : super(const ProfileState()) {
    on<PickAvatarRequested>(_onPickAvatar);
  }

  Future<void> _onPickAvatar(
    PickAvatarRequested event,
    Emitter<ProfileState> emit,
  ) async {
    final image = await pickerRepository.pickImage();
    emit(state.copyWith(status: ProfileStatus.loading));
    if (image == null) {
      emit(
        state.copyWith(
          error: "Image Not Uploaded",
          status: ProfileStatus.failure,
        ),
      );
    }
    String avatarUrl = await uploadAvatarUsecase(
      UploadAvatarEntity(file: File(image!.path), userId: event.userId),
    );
    await updateAvatarUsecase(avatarUrl);

    emit(state.copyWith(avatar: File(image.path)));
  }
}
