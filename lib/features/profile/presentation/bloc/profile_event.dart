import 'dart:io';

abstract class ProfileEvent {}

class PickAvatarRequested extends ProfileEvent{
  final String userId;

  PickAvatarRequested({required this.userId});
}