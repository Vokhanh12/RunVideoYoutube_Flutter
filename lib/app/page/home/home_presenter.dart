import 'package:runvideoapp/app/page/home/home_view.dart';
import 'package:runvideoapp/domain/enities/video.dart';
import 'package:runvideoapp/domain/repositories/video_repository.dart';
import 'package:runvideoapp/domain/usecases/video/get_videos_usecase.dart';

class HomePresenter{


  // Repsitory
  VideoRepository _videoRepository;

  // Usecase
  late final GetVideoUseCase _getVideoUseCase;

  HomePresenter(this._videoRepository){

    _getVideoUseCase = GetVideoUseCase(_videoRepository);

  }

  Future<List<Video>> getVideos(){
    return _getVideoUseCase.videos;
  }

}