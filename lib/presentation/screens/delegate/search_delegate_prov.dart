import 'package:flutter/material.dart';

import '../../../models/provinsi_mode.dart';
import '../../../utils/utils.dart';

class SearchDelegateProv extends SearchDelegate<String> {
  final List<Provinsi> allProvList;
  final List<Provinsi> allProvListSuggest;

  final TextEditingController provController;
  final TextEditingController provIdController;

  SearchDelegateProv({
    required this.allProvList,
    required this.allProvListSuggest,
    required this.provController,
    required this.provIdController,
  });

  @override
  String get searchFieldLabel => 'Cari Provinsi';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return Utils.styleBuildActionAppBarSearch(() {
      query = '';
    }, query != '' ? true : false);
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return Utils.styleBuildLeadingAppBarSearch(() {
      close(context, query);
    });
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<Provinsi> allProv = allProvList
        .where((item) => item.nama.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: allProv.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 5, left: 5, right: 5),
          child: ListTile(
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1),
              borderRadius: BorderRadius.circular(20),
            ),
            title: Text(allProv[index].nama),
            onTap: () {
              provController.text = allProv[index].nama;
              provIdController.text = allProv[index].id.toString();

              close(context, allProv[index].nama);
            },
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<Provinsi> allProvSugest = allProvListSuggest
        .where((item) => item.nama.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: allProvSugest.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 5, left: 5, right: 5),
          child: ListTile(
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            title: Text(allProvSugest[index].nama),
            onTap: () {
              provController.text = allProvSugest[index].nama;
              provIdController.text = allProvSugest[index].id.toString();

              close(context, allProvSugest[index].nama);
            },
          ),
        );
      },
    );
  }
}
