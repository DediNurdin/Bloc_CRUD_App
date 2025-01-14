import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whitecodel_reels/whitecodel_reels.dart';

import '../../../utils/colors.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeUtils.darkTheme(false),
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
              ),
              leading: Icon(
                CupertinoIcons.search,
                color: Colors.white,
              ),
              title: TabBar(
                  tabAlignment: TabAlignment.start,
                  isScrollable: true,
                  indicatorColor: Colors.white,
                  labelColor: Colors.white,
                  tabs: [
                    Tab(
                      text: 'For You',
                    ),
                    Tab(
                      text: 'Folowing',
                    )
                  ]),
              actions: [
                IconButton(
                    onPressed: () {},
                    icon:
                        Icon(CupertinoIcons.photo_camera, color: Colors.white))
              ],
            ),
            body: TabBarView(children: [
              WhiteCodelReels(
                  key: UniqueKey(),
                  context: context,
                  loader: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  isCaching: true,
                  videoList: List.generate(
                    10,
                    (index) =>
                        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
                  ),
                  builder: (context, index, child, videoPlayerController,
                      pageController) {
                    bool isReadMore = false;
                    StreamController<double> videoProgressController =
                        StreamController<double>();

                    videoPlayerController.addListener(() {
                      double videoProgress = videoPlayerController
                              .value.position.inMilliseconds /
                          videoPlayerController.value.duration.inMilliseconds;
                      videoProgressController.add(videoProgress);
                    });

                    return Stack(
                      children: [
                        child,
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              StatefulBuilder(
                                builder: (context, setState) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isReadMore = !isReadMore;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.black.withValues(alpha: 0.0),
                                            Colors.black.withValues(alpha: 0.2),
                                            Colors.black.withValues(alpha: 0.5),
                                          ],
                                        ),
                                      ),
                                      child: Container(
                                        constraints: const BoxConstraints(
                                          maxHeight: 300,
                                        ),
                                        child: SingleChildScrollView(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 50, left: 10),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                                                maxLines: isReadMore ? 100 : 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.roboto(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 70,
                          right: 10,
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                        CupertinoIcons.hand_thumbsup),
                                    color: Colors.white,
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: Text(
                                      '10K',
                                      style: GoogleFonts.roboto(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      CupertinoIcons.text_bubble,
                                      color: Colors.white,
                                    ),
                                    color: Colors.white,
                                  ),
                                  InkWell(
                                    child: Text(
                                      '10K',
                                      style: GoogleFonts.roboto(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.share,
                                      color: Colors.white,
                                    ),
                                    color: Colors.white,
                                  ),
                                  Text(
                                    'Share',
                                    style: GoogleFonts.roboto(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.bookmark_border),
                                    color: Colors.white,
                                  ),
                                  Text(
                                    'Save',
                                    style: GoogleFonts.roboto(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        StreamBuilder(
                          stream: videoProgressController.stream,
                          builder: (context, snapshot) {
                            return Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  thumbShape: SliderComponentShape.noThumb,
                                  overlayShape: SliderComponentShape.noOverlay,
                                  trackHeight: 2,
                                ),
                                child: Slider(
                                  value: (snapshot.data ?? 0).clamp(0.0, 1.0),
                                  min: 0.0,
                                  max: 1.0,
                                  activeColor: Colors.green,
                                  inactiveColor: Colors.white,

                                  onChanged: (value) {
                                    final position = videoPlayerController
                                            .value.duration.inMilliseconds *
                                        value;
                                    videoPlayerController.seekTo(Duration(
                                        milliseconds: position.toInt()));
                                  },
                                  // onChangeEnd: (value) {
                                  //   videoPlayerController.play();
                                  // },
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  }),
              Center(
                child: Text('No Data'),
              )
            ])),
      ),
    );
  }
}
