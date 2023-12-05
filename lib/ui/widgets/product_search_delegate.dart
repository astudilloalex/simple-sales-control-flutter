import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sales_control/app/services/get_it_service.dart';
import 'package:sales_control/src/product/application/product_service.dart';
import 'package:sales_control/src/product/domain/product.dart';
import 'package:sales_control/src/product_search_history/application/product_search_history_service.dart';
import 'package:sales_control/src/product_search_history/domain/product_search_history.dart';

class ProductSearchDelegate extends SearchDelegate<Product?> {
  ProductSearchDelegate({
    this.history = const [],
    required this.companyId,
  });

  final List<ProductSearchHistory> history;
  final String companyId;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
          icon: const Icon(Icons.close_outlined),
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.adaptive.arrow_back_outlined),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<Product>?>(
      future: getIt<ProductService>().getByKeyword(
        companyId,
        query.trim(),
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LinearProgressIndicator();
        }
        final List<Product> customers =
            snapshot.data == null ? [] : snapshot.data!;
        customers.sort(
          (a, b) => a.name.compareTo(b.name),
        );
        if (customers.isEmpty) {
          return Center(
            child: Text(AppLocalizations.of(context)!.noResults),
          );
        }
        getIt<ProductSearchHistoryService>().addOrUpdate(
          ProductSearchHistory(value: query.trim(), date: DateTime.now()),
        );
        return ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              leading: const FaIcon(FontAwesomeIcons.arrowUpRightDots),
              title: Text(customers[index].name),
              subtitle: customers[index].description == null
                  ? null
                  : Text(customers[index].description!),
              onTap: () {
                close(context, customers[index]);
              },
            );
          },
          separatorBuilder: (context, index) => const Divider(height: 0.0),
          itemCount: customers.length,
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<ProductSearchHistory> filtered =
        history.where((element) => element.value.contains(query)).toList();
    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(height: 0.0),
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const FaIcon(FontAwesomeIcons.clockRotateLeft),
          title: Text(filtered[index].value),
          onTap: () {
            query = filtered[index].value;
            showResults(context);
          },
        );
      },
    );
  }
}
