import 'package:get/get.dart';
import '../models/video_model.dart';

class HomeController extends GetxController {
  var videoList = <VideoModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadVideos();
  }

  void loadVideos() {
    // 模拟视频数据，使用可公开访问的视频URL
    videoList.assignAll([
      VideoModel(
        id: '1',
        title: 'Big Buck Bunny',
        description: 'Big Buck Bunny is a short computer-animated comedy film featuring a giant rabbit.',
        thumbnailUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/BigBuckBunny.jpg',
        videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
      ),
      VideoModel(
        id: '2',
        title: 'Elephant Dream',
        description: 'The first Blender Open Movie from 2006',
        thumbnailUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ElephantsDream.jpg',
        videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
      ),
      VideoModel(
        id: '3',
        title: 'For Bigger Blazes',
        description: 'A short sample video',
        thumbnailUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerBlazes.jpg',
        videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
      ),
      VideoModel(
        id: '4',
        title: 'For Bigger Escape',
        description: 'Another short sample video',
        thumbnailUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerEscapes.jpg',
        videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4',
      ),
      VideoModel(
        id: '5',
        title: 'Sintel',
        description: 'Sintel is an epic fantasy short film',
        thumbnailUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/Sintel.jpg',
        videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4',
      ),
    ]);
  }

  void playVideo(VideoModel video) {
    Get.toNamed('/video_detail', arguments: video);
  }
}
