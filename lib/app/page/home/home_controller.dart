import 'package:runvideoapp/app/page/home/home_presenter.dart';
import 'package:runvideoapp/domain/enities/video.dart';

class HomeController {
  Future<List<Video>>? _videos;
  Future<List<Video>>? get videos => _videos;

  final HomePresenter _homePresenter;

  HomeController(videoRepo)
      : _homePresenter = HomePresenter(videoRepo),
        super();

  Future<List<Video>> getVideos() => _homePresenter.getVideos();
}
