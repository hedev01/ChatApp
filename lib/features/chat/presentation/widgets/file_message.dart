import 'package:chat_app/core/constans/constans.dart';
import 'package:chat_app/core/helper/helper.dart';
import 'package:chat_app/features/chat/domain/entities/message_entity.dart';
import 'package:chat_app/features/download/presentation/cubit/download_cubit.dart';
import 'package:chat_app/features/download/presentation/cubit/download_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FileMessage extends StatelessWidget {
  final MessageEntity message;
  final bool isMe;

  const FileMessage({super.key, required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        context.read<DownloadCubit>().open(message.fileName!);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildLeading(isMe),

          const SizedBox(width: 12),

          Expanded(child: _buildFileInfo()),

          const SizedBox(width: 8),

          BlocBuilder<DownloadCubit, DownloadState>(
            builder: (context, state) {
              return _buildTrailing(context, state);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLeading(bool isMe) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: isMe ? Colors.white : Colors.grey.shade800,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Icon(Icons.insert_drive_file, color: Colors.blue),
    );
  }

  Widget _buildFileInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          message.fileName ?? "",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),

        const SizedBox(height: 4),

        Text(Helper.format(message.fileSize ?? 0)),
      ],
    );
  }

  Widget _buildTrailing(BuildContext context, DownloadState state) {
    switch (state.status) {
      case DownloadStatus.initial:
        return IconButton(
          onPressed: () {
            context.read<DownloadCubit>().download(
              url: Constans.baseUrl + message.fileUrl!,
              fileName: message.fileName!,
            );
          },
          icon: Icon(
            Icons.download,
            color: isMe ? Colors.black54 : Colors.white70,
          ),
        );

      case DownloadStatus.downloading:
        return SizedBox(
          width: 30,
          height: 30,
          child: CircularProgressIndicator(
            value: state.progress,
            strokeWidth: 2.5,
          ),
        );

      case DownloadStatus.downloaded:
        return IconButton(
          onPressed: () {
            context.read<DownloadCubit>().open(message.fileName!);
          },
          icon: const Icon(Icons.insert_drive_file),
        );

      case DownloadStatus.failure:
        return IconButton(
          onPressed: () {
            context.read<DownloadCubit>().download(
              url: Constans.baseUrl + message.fileUrl!,
              fileName: message.fileName!,
            );
          },
          icon: const Icon(Icons.refresh, color: Colors.red),
        );
    }
  }
}
