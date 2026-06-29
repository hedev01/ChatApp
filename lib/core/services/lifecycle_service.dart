import 'package:flutter/material.dart';

import '../../features/chat/domain/usecases/stop_chat_usecase.dart';

class LifecycleService with WidgetsBindingObserver {
  final StopChatUsecase stopChatUsecase;

  LifecycleService(this.stopChatUsecase);

  void init() {
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      stopChatUsecase();
    }
  }
}
