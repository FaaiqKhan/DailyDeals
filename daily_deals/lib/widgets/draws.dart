import 'package:daily_deals/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:video_player/video_player.dart';

class Draws extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DrawsState();
}

class _DrawsState extends State<Draws> {
  double cardWidth = 0.0;
  double cardHeight = 0.0;
  double videoHeight = 0.0;
  List<Widget>? sequence;
  VideoPlayerController? _videoPlayerController;
  bool isVideoPlaying = false;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _videoPlayerController = VideoPlayerController.network(
        "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4");
    _initializeVideoPlayerFuture = _videoPlayerController!.initialize().then((value) {
      _videoPlayerController!.setLooping(false);
      _videoPlayerController!.setVolume(0.0);
    });
    super.initState();
  }

  @override
  void dispose() {
    if (_videoPlayerController != null) _videoPlayerController!.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (cardHeight == 0.0) {
      cardWidth = MediaQuery.of(context).size.width;
      cardHeight = MediaQuery.of(context).size.height / 2;
      videoHeight = cardHeight / 2.1;
    }
    super.didChangeDependencies();
  }

  Widget viewsAndShare(String elementName, String views, bool isShare) {
    String iconPath =
        isShare ? "assets/images/share_icon.png" : "assets/images/eye_icon.png";
    return Column(
      children: [
        Container(
          width: 35,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: HexColor("#1C2027"),
          ),
          child: Image.asset(
            iconPath,
            color: Colors.white,
            scale: isShare ? 2 : 1.7,
          ),
        ),
        SizedBox(height: 5.0),
        Visibility(
          visible: !isShare,
          child: Text(
            "$views K",
            style: TextStyle(
              color: Colors.white,
              fontSize: 8,
              fontFamily: Theme.of(context).textTheme.bodyText1!.fontFamily,
            ),
          ),
        ),
        Text(
          elementName,
          style: TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontFamily: Theme.of(context).textTheme.bodyText1!.fontFamily,
          ),
        ),
      ],
    );
  }

  Widget currentLikesAndShares(String likes, String shares, bool isShare) {
    String iconPath = isShare
        ? "assets/images/share_icon.png"
        : "assets/images/like_icon.png";
    return Column(
      children: [
        CircleAvatar(
          radius: 12,
          backgroundColor: Colors.white,
          child: Container(
            width: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: !isShare ? Colors.blue : Colors.redAccent,
            ),
            child: Image.asset(iconPath, color: Colors.white, scale: 3),
          ),
        ),
        SizedBox(height: 5),
        Text(
          isShare ? shares : likes,
          style: TextStyle(
            color: Colors.white,
            fontSize: 8,
            fontFamily: Theme.of(context).textTheme.bodyText1!.fontFamily,
          ),
        ),
        Text(
          isShare ? "Shares" : "Likes",
          style: TextStyle(
            color: Colors.white,
            fontSize: 8,
            fontFamily: Theme.of(context).textTheme.bodyText1!.fontFamily,
          ),
        )
      ],
    );
  }

  Future<bool> startVideo() async {
    if (_videoPlayerController != null &&
        _videoPlayerController!.value.isInitialized) {
      await _videoPlayerController!.play();
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }

  Future<bool> stopVideo() async {
    if (_videoPlayerController != null &&
        _videoPlayerController!.value.isInitialized) {
      await _videoPlayerController!.pause();
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    sequence = WidgetUtils.generateSequenceView(
        context, ['11', '17', '32', '48', '99', '20'],
        size: 25);
    return Container(
      width: cardWidth,
      height: cardHeight,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: HexColor("#363636"),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Guess & win",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily:
                          Theme.of(context).textTheme.bodyText2!.fontFamily,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: sequence ?? [],
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Winning prize Gold",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                      fontFamily:
                          Theme.of(context).textTheme.bodyText2!.fontFamily,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    "AED 15,000",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily:
                          Theme.of(context).textTheme.bodyText2!.fontFamily,
                    ),
                  )
                ],
              )
            ],
          ),
          FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return GestureDetector(
                  onTap: () {
                    if (isVideoPlaying) {
                      stopVideo().then((value) {
                        setState(() {
                          isVideoPlaying = !value;
                        });
                      });
                    } else {
                      startVideo().then((value) {
                        setState(() {
                          isVideoPlaying = value;
                        });
                      });
                    }
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: cardWidth,
                        height: videoHeight,
                        child: VideoPlayer(_videoPlayerController!),
                      ),
                      Visibility(
                        visible: !isVideoPlaying,
                        child: Container(
                          width: 50,
                          height: 50,
                          color: Theme
                              .of(context)
                              .primaryColor
                              .withOpacity(0.7),
                          child: Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return WidgetUtils.progressIndicator(context);
              }
            }
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Draw Date 15 sep 2021",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily:
                            Theme.of(context).textTheme.bodyText2!.fontFamily,
                        fontSize: 13,
                      ),
                    ),
                    Container(
                      width: 40,
                      height: 15,
                      decoration: BoxDecoration(
                        color: HexColor("#F83615"),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "New",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                          fontFamily:
                              Theme.of(context).textTheme.bodyText1!.fontFamily,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        viewsAndShare("Views", "1.2", false),
                        const SizedBox(width: 20.0),
                        viewsAndShare("Share", "", true)
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        currentLikesAndShares("456", "120", false),
                        const SizedBox(width: 20.0),
                        currentLikesAndShares("456", "120", true),
                      ],
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
