import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_kit_video/media_kit_video.dart';
import '../../controllers/video_detail_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';

class VideoDetailView extends GetView<VideoDetailController> {
  const VideoDetailView({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.video.title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 视频播放器
            _buildVideoPlayer(),
            // 视频信息
            _buildVideoInfo(),
            // 播放控制
            _buildPlaybackControls(),
          ],
        ),
      ),
    );
  }
  
  // 构建视频播放器
  Widget _buildVideoPlayer() {
    return Obx(() {
      if (controller.videoController.videoPlayerController == null) {
        return const SizedBox(
          height: 250,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
      return SizedBox(
        height: 250,
        child: Video(controller: controller.videoController),
      );
    });
  }
  
  // 构建视频信息
  Widget _buildVideoInfo() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            controller.video.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            controller.video.description,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
  
  // 构建播放控制
  Widget _buildPlaybackControls() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        children: [
          // 进度条
          _buildProgressBar(),
          const SizedBox(height: 16),
          // 控制按钮
          _buildControlButtons(),
          const SizedBox(height: 16),
          // 音量控制
          _buildVolumeControl(),
          const SizedBox(height: 16),
          // 播放速度
          _buildPlaybackSpeedControl(),
        ],
      ),
    );
  }
  
  // 构建进度条
  Widget _buildProgressBar() {
    return Obx(() {
      final current = controller.currentPosition.value;
      final total = controller.duration.value;
      return Column(
        children: [
          Slider(
            value: current.inMilliseconds.toDouble(),
            max: total.inMilliseconds.toDouble(),
            onChanged: (value) {
              controller.seekTo(Duration(milliseconds: value.round()));
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_formatDuration(current)),
              Text(_formatDuration(total)),
            ],
          ),
        ],
      );
    });
  }
  
  // 构建控制按钮
  Widget _buildControlButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 快退按钮
        IconButton(
          icon: const Icon(Icons.replay_10),
          iconSize: 36,
          onPressed: () => controller.fastRewind(),
        ),
        const SizedBox(width: 24),
        // 播放/暂停按钮
        Obx(() {
          return IconButton(
            icon: Icon(
              controller.isPlaying.value ? Icons.pause : Icons.play_arrow,
            ),
            iconSize: 48,
            onPressed: () => controller.togglePlay(),
          );
        }),
        const SizedBox(width: 24),
        // 快进按钮
        IconButton(
          icon: const Icon(Icons.forward_10),
          iconSize: 36,
          onPressed: () => controller.fastForward(),
        ),
      ],
    );
  }
  
  // 构建音量控制
  Widget _buildVolumeControl() {
    return Row(
      children: [
        Obx(() {
          return IconButton(
            icon: Icon(
              controller.isMuted.value ? Icons.volume_off : Icons.volume_up,
            ),
            onPressed: () => controller.toggleMute(),
          );
        }),
        const SizedBox(width: 8),
        Expanded(
          child: Obx(() {
            return Slider(
              value: controller.volume.value.toDouble(),
              min: 0,
              max: 100,
              onChanged: (value) => controller.setVolume(value.round()),
            );
          }),
        ),
        Obx(() {
          return Text('${controller.volume.value}%');
        }),
      ],
    );
  }
  
  // 构建播放速度控制
  Widget _buildPlaybackSpeedControl() {
    final speeds = [0.25, 0.5, 0.75, 1.0, 1.25, 1.5, 1.75, 2.0];
    return Row(
      children: [
        const Text('播放速度: '),
        Obx(() {
          return DropdownButton<double>(
            value: controller.playbackSpeed.value,
            onChanged: (value) {
              if (value != null) {
                controller.setPlaybackSpeed(value);
              }
            },
            items: speeds.map((speed) {
              return DropdownMenuItem(
                value: speed,
                child: Text('${speed}x'),
              );
            }).toList(),
          );
        }),
      ],
    );
  }
  
  // 格式化时长
  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}