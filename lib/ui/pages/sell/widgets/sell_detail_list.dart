import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_control/src/sale_detail/domain/sale_detail.dart';
import 'package:sales_control/ui/pages/sell/cubits/sell_cubit.dart';
import 'package:sales_control/ui/pages/sell/states/sell_state.dart';
import 'package:sales_control/ui/pages/sell/widgets/sell_product_detail.dart';

class SellDetailList extends StatelessWidget {
  const SellDetailList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SellCubit, SellState, List<SaleDetail>>(
      selector: (state) => state.sale.saleDetails,
      builder: (context, state) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return SellProductDetail(saleDetail: state[index]);
            },
            childCount: state.length,
          ),
        );
      },
    );
  }
}
