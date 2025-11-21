import 'package:get/get.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import '../models/video_model.dart';

class VideoDetailController extends GetxController {
  // 视频数据
  final VideoModel video = Get.arguments;
  
  // 播放器控制器
  late final Player player;
  late final VideoController videoController;
  
  // 播放状态
  final isPlaying = false.obs;
  final currentPosition = Duration.zero.obs;
  final duration = Duration.zero.obs;
  final volume = 100.obs;
  final isMuted = false.obs;
  final playbackSpeed = 1.0.obs;
  
  @override
  void onInit() {
    super.onInit();
    // 初始化播放器
    _initializePlayer();
  }
  
  @override
  void onClose() {
    // 释放播放器资源
    player.dispose();
    super.onClose();
  }
  
  // 初始化播放器
  void _initializePlayer() {
    // 创建播放器实例
    player = Player(
      configuration: const PlayerConfiguration(
        autoPlay: true,
        volume: 100,
      ),
    );
    
    // 创建视频控制器实例
    videoController = VideoController(
      player,
      configuration: const VideoControllerConfiguration(
        enableHardwareAcceleration: true,
      ),
    );
    
    // 设置视频源
    player.open(Media(video.videoUrl));
    
    // 监听播放状态变化
    player.stream.playing.listen((playing) {
      isPlaying.value = playing;
    });
    
    // 监听当前播放位置变化
    player.stream.position.listen((position) {
      currentPosition.value = position;
    });
    
    // 监听视频总时长变化
    player.stream.duration.listen((duration) {
      if (duration != null) {
        this.duration.value = duration;
      }
    });
    
    // 监听音量变化
    player.stream.volume.listen((volume) {
      this.volume.value = volume.round();
    });
  }
  
  // 播放/暂停切换
  void togglePlay() {
    player.playOrPause();
  }
  
  // 快进
  void fastForward() {
    player.seek(player.state.position + const Duration(seconds: 10));
  }
  
  // 快退
  void fastRewind() {
    player.seek(player.state.position - const Duration(seconds: 10));
  }
  
  // 调整音量
  void setVolume(int value) {
    player.setVolume(value.toDouble());
    isMuted.value = value == 0;
  }
  
  // 静音切换
  void toggleMute() {
    if (isMuted.value) {
      player.setVolume(volume.value.toDouble());
      isMuted.value = false;
    } else {
      player.setVolume(0.0);
      isMuted.value = true;
    }
  }
  
  // 调整播放速度
  void setPlaybackSpeed(double speed) {
    player.setRate(speed);
    playbackSpeed.value = speed;
  }
  
  // 跳转到指定位置
  void seekTo(Duration position) {
    player.seek(position);
  }
}