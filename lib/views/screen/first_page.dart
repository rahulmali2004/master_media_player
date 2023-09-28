import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:media_player/modals/myRoutes.dart';
import 'package:media_player/views/uttils/music_utils.dart';
import 'package:provider/provider.dart';

import '../../controller/indicator_controller.dart';
import '../../controller/songs_controller.dart';

class First_Page extends StatefulWidget {
  First_Page({super.key});

  @override
  State<First_Page> createState() => _First_PageState();
}

class _First_PageState extends State<First_Page> {
  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
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
          child: Image.asset("assets/images/app.png"),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(MyRoutes.video_page);
            },
            icon: Icon(Icons.video_collection,color: Colors.white,),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(MyRoutes.Tab_Page,);
            },
            icon: Icon(Icons.change_circle,color: Colors.white,),
          ),
        ],
        backgroundColor: Color(0xff0002FF),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Enjoy Your Favorite Music",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ],
              ),
            ),
            Consumer<indicator>(
              builder: (context, provider, _) => Column(
                children: [
                  CarouselSlider(
                    items: all_music.post.map((imageUrl) {
                      return Builder(builder: (context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Image.asset(
                            imageUrl,
                            fit: BoxFit.cover,
                          ),
                        );
                      });
                    }).toList(),
                    options: CarouselOptions(
                      onPageChanged: (index, reason) {
                        provider.change_index(index: index);
                      },
                      height: 150,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      viewportFraction: 0.8,
                    ),
                  ),
                  SizedBox(
                    height: s.height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      all_music.post.length,
                      (index) => Container(
                        height: 10,
                        width: 10,
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: provider.currentindex == index
                              ? const Color(0xff54281F)
                              : Colors.grey,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10,left: 18,right: 18),
              child: Text(
                "Trending Song",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 180,
              child: GridView.builder(
                scrollDirection: Axis.horizontal,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 2 / 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                ),
                itemCount: all_music.musics.length,
                itemBuilder: (context, index) => Card(
                  child: Stack(
                    children: [
                      Container(
                        height: 180,
                        padding: EdgeInsets.all(5),
                        child: GridTile(
                          child: Image.asset(
                            "${thubnail_path + all_music.musics[index]['thumbnail']}",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                            onPressed: () {
                              Provider.of<audio_controller>(context,
                                      listen: false)
                                  .get_index(index: index);
                              Navigator.of(context).pushNamed(MyRoutes.Tab_Page,
                                  arguments: index);
                            },
                            icon: const Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10, left: 18, right: 18),
              child: Text(
                "Popular Song",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Container(
                  height: s.height,
                  width: s.width,
                  child: ListView.builder(
                    itemCount: all_music.musics.length,
                    itemBuilder: (context, index) {
                      int maxTitleLength = 15;
                      String title = all_music.musics[index]['title'];
                      if (title.length > maxTitleLength) {
                        title = title.substring(0, maxTitleLength) + '...';
                      }
                      return Card(
                        color: Colors.black45,
                        child: ListTile(
                          // tileColor: Colors.brown,
                          leading: CircleAvatar(
                            foregroundImage: AssetImage(
                              "${thubnail_path + all_music.musics[index]['thumbnail']}",
                            ),
                          ),
                          title: Text(
                            "${title}",
                            style: TextStyle(color: Colors.white),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              Provider.of<audio_controller>(context,
                                      listen: false)
                                  .get_index(index: index);
                              Navigator.of(context).pushNamed(MyRoutes.Tab_Page,
                                  arguments: index);
                            },
                            icon: const Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xff0002FF),
    );
  }
}
