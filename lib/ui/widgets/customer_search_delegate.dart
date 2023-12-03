import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sales_control/app/services/get_it_service.dart';
import 'package:sales_control/src/customer/application/customer_service.dart';
import 'package:sales_control/src/customer/domain/customer.dart';
import 'package:sales_control/src/customer_search_history/application/customer_search_history_service.dart';
import 'package:sales_control/src/customer_search_history/domain/customer_search_history.dart';

class CustomerSearchDelegate extends SearchDelegate<Customer?> {
  CustomerSearchDelegate({
    this.history = const [],
    required this.companyId,
  });

  final List<CustomerSearchHistory> history;
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
    return FutureBuilder<List<Customer>?>(
      future: getIt<CustomerService>().getByIdCardOrFullName(
        companyId,
        query.trim(),
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LinearProgressIndicator();
        }
        final List<Customer> customers =
            snapshot.data == null ? [] : snapshot.data!;
        customers.sort(
          (a, b) => a.fullName.compareTo(b.fullName),
        );
        if (customers.isEmpty) {
          return Center(
            child: Text(AppLocalizations.of(context)!.noResults),
          );
        }
        getIt<CustomerSearchHistoryService>().addOrUpdate(
          CustomerSearchHistory(value: query.trim(), date: DateTime.now()),
        );
        return ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              leading: const FaIcon(FontAwesomeIcons.arrowUpRightDots),
              title: Text(customers[index].fullName),
              subtitle: Text(customers[index].idCard),
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
    final List<CustomerSearchHistory> filtered =
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
