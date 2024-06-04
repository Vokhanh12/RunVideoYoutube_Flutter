import 'package:runvideoapp/domain/enities/video.dart';

abstract class VideoRepository{

  Future<List<Video>> getVideos();

}