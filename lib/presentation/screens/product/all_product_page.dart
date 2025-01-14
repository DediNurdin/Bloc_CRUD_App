import 'recomended_page.dart';
import 'package:flutter/material.dart';

class AllProductPage extends StatefulWidget {
  const AllProductPage({super.key});

  @override
  State<AllProductPage> createState() => _AllProductPageState();
}

class _AllProductPageState extends State<AllProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("All Products")),
        body: CustomScrollView(
          slivers: [
            SliverList.list(children: [
              RecomendedPage(
                visibleTitle: false,
              )
            ])
          ],
        ));
  }
}
