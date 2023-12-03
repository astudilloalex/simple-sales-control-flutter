import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_control/src/product/domain/product.dart';
import 'package:sales_control/ui/pages/sell/cubits/sell_cubit.dart';
import 'package:sales_control/ui/pages/sell/states/sell_state.dart';

class SellDetailList extends StatelessWidget {
  const SellDetailList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SellCubit, SellState, List<Product>>(
      selector: (state) => state.products,
      builder: (context, state) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return ListTile(
                title: Text(state[index].name),
              );
            },
            childCount: state.length,
          ),
        );
      },
    );
  }
}
