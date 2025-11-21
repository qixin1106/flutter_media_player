import 'package:get/get.dart';
import '../controllers/video_detail_controller.dart';

class VideoDetailBinding extends Bindings {
  @override
  void dependencies() {
    // 使用Get.put注册VideoDetailController，因为它需要在页面创建时立即初始化
    Get.put(VideoDetailController());
  }
}