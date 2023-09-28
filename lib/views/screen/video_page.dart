import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/video_controller.dart';

class video_page extends StatelessWidget {
  const video_page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Music App",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Image.asset("assets/images/app.png")),
        ),
        backgroundColor: Color(0xff0002FF),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Consumer<VideoController>(
          builder: (context, provider, _) {
            return Center(
              child: provider.videoPlayerController.value.isInitialized
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AspectRatio(
                          aspectRatio:
                              provider.videoPlayerController.value.aspectRatio,
                          child: Chewie(
                            controller: provider.chewieController,
                          ),
                        ),
                        SizedBox(
                          height: 300,
                          child: ListView.separated(
                            itemCount: provider.myVideos.length,
                            separatorBuilder: (context, index) =>
                                const Divider(),
                            itemBuilder: (context, index) => ListTile(
                              onTap: () {
                                provider.changeIndex(index: index,);
                              },
                              title: Text("${index + 1}",style: TextStyle(color: Colors.white),),
                            ),
                          ),
                        ),
                      ],
                    )
                  : const CircularProgressIndicator(
                      color: Colors.white,
                    ),
            );
          },
        ),
      ),
      backgroundColor: Color(0xff0002FF),
    );
  }
}
