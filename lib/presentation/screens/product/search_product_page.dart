import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/product/product_bloc.dart';
import '../../../models/product_model.dart';
import '../../../utils/skeleton_widget.dart';
import '../../../utils/utils.dart';
import '../bottom_navigation/main_menu.dart';
import 'item/product_item_widget.dart';
import 'item/search_product_widget.dart';

class SearchProductPage extends StatefulWidget {
  const SearchProductPage({super.key, required this.query});

  final String query;
  @override
  State<SearchProductPage> createState() => _SearchProductPageState();
}

class _SearchProductPageState extends State<SearchProductPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: SearchProductWidget(
            query: widget.query,
          ),
          actions: [
            Builder(builder: (context) {
              return InkWell(
                overlayColor: WidgetStatePropertyAll(Colors.transparent),
                onTap: () {
                  Scaffold.of(context).openEndDrawer();
                },
                child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Icon(Icons.filter_alt_outlined)),
              );
            }),
            InkWell(
              overlayColor: WidgetStatePropertyAll(Colors.transparent),
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    useSafeArea: true,
                    elevation: 0,
                    shape: BeveledRectangleBorder(),
                    builder: (context) => MainMenu());
              },
              child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(CupertinoIcons.line_horizontal_3)),
            ),
          ],
          bottom: TabBar(
              tabAlignment: TabAlignment.start,
              isScrollable: true,
              controller: tabController,
              tabs: [
                Tab(
                  text: 'Product',
                ),
                Tab(
                  text: 'Seller',
                )
              ]),
        ),
        endDrawer: Drawer(
            width: MediaQuery.of(context).size.width - 100,
            shape: BeveledRectangleBorder(),
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: DrawerHeader(
                    child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text('Search Filter')),
                  ),
                ),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text('Sort List Product')),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: BlocBuilder<ProductSearchBloc, ProductSearchState>(
                        builder: (context, state) {
                          return Row(
                            children: [
                              Expanded(
                                  child: Utils.buttonWigget(() {
                                context
                                    .read<ProductSearchBloc>()
                                    .add(SortProductEvent(type: 'desc'));
                                Navigator.pop(context);
                              }, Text('Descending'), true)),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Utils.buttonWigget(() {
                                context
                                    .read<ProductSearchBloc>()
                                    .add(SortProductEvent(type: 'asc'));
                                Navigator.pop(context);
                              }, Text('Ascending'), false))
                            ],
                          );
                        },
                      ),
                    )
                  ],
                )),
              ],
            )),
        body: TabBarView(controller: tabController, children: [
          BlocBuilder<ProductSearchBloc, ProductSearchState>(
            builder: (context, state) {
              if (state is ProductSearchLoading) {
                return SkeletonWidget.gridSkeleton(context);
              }
              if (state is ProductInitial) {
                context.read<ProductSearchBloc>().add(GetProductSearchEvent());
              }
              if (state is ProductSearchSuccess) {
                final List<Product> productSearch = state.products
                    .where((item) => item.title
                        .toLowerCase()
                        .contains(widget.query.toLowerCase()))
                    .toList();
                return Container(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                      crossAxisCount: 2,
                      childAspectRatio: 0.79,
                    ),
                    itemBuilder: (context, index) {
                      return ProductItemWidget(product: productSearch[index]);
                    },
                    itemCount: productSearch.length,
                  ),
                );
              }
              if (state is ProductSearchFailure) {
                return Center(child: Text('No Data'));
              }
              if (state is ProductSortFailure) {
                return Center(child: Text('No Data'));
              }
              return Center(child: Text('No Data'));
            },
          ),
          Center(child: Text('No Data'))
        ]));
  }
}
