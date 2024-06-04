import 'dart:async';
import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:runvideoapp/app/page/home/home_controller.dart';
import 'package:runvideoapp/data/repositories/data_video_repository.dart';
import 'package:runvideoapp/domain/enities/video.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late HomeController _homeController;

  var _controller = YoutubePlayerController.fromVideoId(
    videoId: 'JgHal4kVOiE',
    autoPlay: false,
    params: const YoutubePlayerParams(showFullscreenButton: true),
  );

  String? _currentVideoId = null;

  Queue<Video> _queueVideo = Queue<Video>();

  @override
  void initState() {
    super.initState();

    _homeController = HomeController(DataVideoRepository());
    _fetchVideos();
  }

  Future<void> _fetchVideos() async {
    try {
      final videos = await _homeController.getVideos();
      for (var video in videos!) {
        setState(() {
          _queueVideo.add(video);
        });
      }
    } catch (e) {
      print("Error fetching videos: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildHomeFormWidget());
  }

  Widget _buildHomeFormWidget() {
    return Padding(
        padding: const EdgeInsets.all(4.0),
        child: (_currentVideoId != null)
            ? Column(
                children: [
                  YoutubePlayer(
                    controller: _controller,
                  ),
                  StreamBuilder<YoutubeVideoState>(
                      stream: _controller.videoStateStream,
                      builder:
                          (context, AsyncSnapshot<YoutubeVideoState> snapshot) {
                        return Text(snapshot.data?.position.toString() ?? "a");
                      }),
                  FutureBuilder(
                      future: _controller.duration,
                      builder: (context, snapshot) {
                        return Text(snapshot.data.toString());
                      }),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ..._queueVideo
                              .map((video) => videoCard(video))
                              .toList(),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    ..._queueVideo.map((video) => videoCard(video)).toList(),
                  ],
                ),
              ));
  }

  Widget videoCard(Video video) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Center(
      child: Column(
        children: [
          Card(
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              splashColor: Colors.blue.withAlpha(30),
              onTap: () {
                setState(() {
                  _currentVideoId = video.id;
                  _controller.loadVideoById(videoId: _currentVideoId!);
                });
                _queueVideo.remove(video);
              },
              child: Container(
                width: screenWidth,
                height: screenHeight / 5,
                child: Image.network(
                  'https://opensource.google/images/projects/os-projects-flutter_thumbnail.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        video.title,
                        style: const TextStyle(fontSize: 22.0),
                      )),
                ),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(video.screenUrl),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(video.owner.name),
                  ],
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: Text("View:${video.numView}")),
              ],
            ),
          )
        ],
      ),
    );
  }
}
