import 'package:flutter/material.dart';
import 'package:media_player/views/uttils/music_utils.dart';
import '../../controller/songs_controller.dart';
import 'package:provider/provider.dart';

class songs_page extends StatefulWidget {
  const songs_page({super.key});

  @override
  State<songs_page> createState() => _songs_pageState();
}

class _songs_pageState extends State<songs_page> with TickerProviderStateMixin {
  SliderComponentShape myThumbshape = SliderComponentShape.noThumb;
  late AnimationController animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
  }

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;

    int index = ModalRoute.of(context)?.settings.arguments as int;
    return Scaffold(
      body: Container(
        child: Consumer<audio_controller>(builder: (context, provider, _) {
          return StreamBuilder(
            stream: provider.currentposition,
            builder: (context, AsyncSnapshot<Duration> snapshot) {
              if (snapshot.hasData) {
                double currentposition = snapshot.data!.inSeconds.toDouble();
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      // Container(
                      //   height: 300,
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(20),
                      //   ),
                      //   child: Image.asset(
                      //     "${thubnail_path + all_music.musics[index]['thumbnail']}",
                      //     fit: BoxFit.fill,
                      //   ),
                      // ),
                      CircleAvatar(
                        radius: 130,
                        foregroundImage: AssetImage(
                          "${thubnail_path + all_music.musics[index]['thumbnail']}",
                        ),
                      ),
                      SizedBox(
                        height: s.height * 0.02,
                      ),
                      Text(
                        all_music.musics[index]['title'],
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: s.height * 0.01,
                      ),
                      Theme(
                        data: ThemeData(
                          useMaterial3: true,
                          sliderTheme: SliderThemeData(
                            thumbShape: myThumbshape,
                            overlayShape: SliderComponentShape.noOverlay,
                          ),
                        ),
                        child: Slider(
                          min: 0,
                          max: provider.totalDuration.inSeconds.toDouble(),
                          inactiveColor: Colors.grey,
                          activeColor: Colors.brown,
                          onChangeStart: (val) {
                            setState(() {
                              myThumbshape = SliderComponentShape.noThumb;
                            });
                          },
                          onChangeEnd: (val) {
                            setState(() {
                              myThumbshape = SliderComponentShape.noOverlay;
                            });
                          },
                          value: currentposition,
                          onChanged: (val) {
                            provider.seek(secondes: val.toInt());
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${snapshot.data!.inMinutes.toString().padLeft(2, '0')}:${(snapshot.data!.inSeconds % 60).toString().padLeft(2, '0')}",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "${provider.totalDuration.inMinutes.toString().padLeft(2, '0')}:${(provider.totalDuration.inSeconds % 60).toString().padLeft(2, '0')}",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              provider.skip(seconds: -10);
                            },
                            icon: Icon(
                              Icons.fast_rewind,
                              color: Colors.white,
                            ),
                          ),
                          StreamBuilder(
                            stream: provider.assetsAudioPlayer.isPlaying,
                            builder: (context, AsyncSnapshot<bool> snapshot) {
                              return IconButton(
                                  onPressed: () {
                                    if (snapshot.data!) {
                                      provider.pause();
                                      animationController.reverse();
                                      setState(() {});
                                    } else {
                                      provider.play();
                                      animationController.forward();
                                      setState(() {});
                                    }
                                  },
                                  icon: AnimatedIcon(
                                    icon: AnimatedIcons.play_pause,
                                    color: Colors.white,
                                    progress: animationController,
                                    size: 50,
                                  ));
                            },
                          ),
                          IconButton(
                            onPressed: () {
                              provider.skip(seconds: 10);
                            },
                            icon: Icon(
                              Icons.fast_forward,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          );
        }),
      ),
      backgroundColor: Color(0xff0002FF),
    );
  }
}
