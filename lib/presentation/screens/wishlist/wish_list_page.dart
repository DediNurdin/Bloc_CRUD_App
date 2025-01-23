import '../../../utils/colors_app.dart';

import '../../../gen/assets.gen.dart';
import '../delegate/search_delegate_product.dart';
import '../../../utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../product/recomended_page.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  final controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverList.list(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    height: 250,
                    child: PageView(
                      controller: controller,
                      children: [
                        buildPage(
                          urlImage: Assets.images.wishlist1.path,
                          title:
                              'Want to save items to buy later?, compare prices?, this is the place',
                        ),
                        buildPage(
                          urlImage: Assets.images.wishlist2.path,
                          title:
                              'Again lookings product. Is there anything you like? Click the heart icon to save in the wishlist',
                        ),
                        buildPage(
                          urlImage: Assets.images.wishlist3.path,
                          title:
                              'Use the collection feature to group your wishes',
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: SmoothPageIndicator(
                      controller: controller,
                      count: 3,
                      effect: ScrollingDotsEffect(
                        dotWidth: 5,
                        dotHeight: 5,
                        activeDotColor: colorDefaultGreen,
                      ),
                      onDotClicked: (index) => controller.animateToPage(index,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn),
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(
                          bottom: 10, left: 10, right: 10),
                      width: double.infinity,
                      height: 45,
                      child: Utils.buttonWigget(() async {
                        await showSearch(
                            context: context,
                            delegate: SearchDelegateProduct(initQuery: ''));
                      }, Text('Search Product'), false)),
                  Container(
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      width: double.infinity,
                      height: 45,
                      child: Utils.buttonWigget(
                          () {}, Text('Create Collection'), true)),
                ],
              ),
            ),
            RecomendedPage()
          ],
        )
      ],
    ));
  }

  Widget buildPage({required String urlImage, required String title}) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Image.asset(
              urlImage,
              fit: BoxFit.fill,
              width: 150,
              height: 150,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12),
            ),
          )
        ],
      );
}
