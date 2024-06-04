import 'package:runvideoapp/domain/enities/user.dart';
import 'package:runvideoapp/domain/enities/video.dart';
import 'package:runvideoapp/domain/repositories/video_repository.dart';

class DataVideoRepository extends VideoRepository {
  late List<Video> videos;

  // Singleton pattern
  static final DataVideoRepository _instance = DataVideoRepository._internal();
  DataVideoRepository._internal() {
    videos = <Video>[
      Video(
        id: '_CLfOGykrPk',
        screenUrl: 'http://example.com/video1',
        title: 'Sample Video 1',
        numView: '1000',
        owner: User(id: 'owner-uid', name: 'John Smith', avatarUrl: 'http://example.com/avatar1'),
      ),
      Video(
        id: '_CLfOGykrPk',
        screenUrl: 'http://example.com/video2',
        title: 'Sample Video 2',
        numView: '2000',
        owner: User(id: 'owner-uid2', name: 'John Shelby', avatarUrl: 'http://example.com/avatar2'),
      ),
      Video(
        id: '_CLfOGykrPk',
        screenUrl: 'http://example.com/video1',
        title: 'Sample Video 3',
        numView: '1000',
        owner: User(id: 'owner-uid', name: 'Tommy Shelby', avatarUrl: 'http://example.com/avatar1'),
      ),
      Video(
        id: 'test-uid2',
        screenUrl: 'http://example.com/video2',
        title: 'Sample Video 4',
        numView: '2000',
        owner: User(id: 'owner-uid2', name: 'Arthur Shelby', avatarUrl: 'http://example.com/avatar2'),
      ),
    ];
  }
  
  factory DataVideoRepository() => _instance;

  @override
  Future<List<Video>> getVideos() async {
    // Simulate async operation, e.g., fetching from an API or database
    await Future.delayed(Duration(seconds: 1));
    return videos;
  }
}
