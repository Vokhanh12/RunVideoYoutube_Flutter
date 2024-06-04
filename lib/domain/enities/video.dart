
import 'package:runvideoapp/domain/enities/user.dart';

class Video {
  final String id;
  final String screenUrl;
  final String title;
  final String numView;
  final User owner;

  Video({
    required this.id,
    required this.screenUrl,
    required this.title,
    required this.numView,
    required this.owner,
  });

  Video.fromJson(Map<String, dynamic> map)
      : id = map['id'],
        screenUrl = map['screenUrl'],
        title = map['title'],
        numView = map['numView'],
        owner = User.fromJson(map['owner']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'screenUrl': screenUrl,
        'title': title,
        'numView': numView,
        'owner': owner.toJson(),
      };
}