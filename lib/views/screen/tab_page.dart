import 'package:flutter/material.dart';
import 'package:media_player/views/screen/first_page.dart';
import 'package:media_player/views/screen/song_page.dart';
import 'package:media_player/views/screen/video_page.dart';
import 'package:provider/provider.dart';

import '../../controller/songs_controller.dart';

class Tab_Page extends StatefulWidget {
  const Tab_Page({super.key});

  @override
  State<Tab_Page> createState() => _Tab_PageState();
}

class _Tab_PageState extends State<Tab_Page>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(
      length: 2,
      vsync: this,
      animationDuration: Duration(milliseconds: 400),
      initialIndex: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Music App",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: TabBar(
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorColor: Colors.white,
          controller: tabController,
          tabs: [
            Tab(
              icon: Icon(Icons.audiotrack,color: Colors.white,),
            ),
            Tab(
              icon: Icon(Icons.video_collection,color: Colors.white,),
            ),
          ],
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: GestureDetector(
              onTap: () {
                Provider.of<audio_controller>(context, listen: false).pause();
                Navigator.of(context).pop();
              },
              child: Image.asset("assets/images/app.png")),
        ),
        backgroundColor: Color(0xff0002FF),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          songs_page(),
          songs_page(),
        ],
      ),
    );
  }
}
