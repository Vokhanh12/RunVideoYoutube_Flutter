import 'package:runvideoapp/domain/enities/video.dart';
import 'package:runvideoapp/domain/repositories/video_repository.dart';

class GetVideoUseCase{

  final VideoRepository _videoRepository;

  late Future<List<Video>> videos;

  GetVideoUseCase(this._videoRepository){

    videos =  _videoRepository.getVideos();

  }

}