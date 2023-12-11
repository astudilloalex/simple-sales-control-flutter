import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sales_control/src/sale_summary/domain/sale_summary.dart';
import 'package:sales_control/ui/pages/home/cubits/home_cubit.dart';
import 'package:sales_control/ui/pages/home/states/home_state.dart';

class SaleLineChart extends StatelessWidget {
  const SaleLineChart({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          color: const Color(0xFF342A55),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 37,
              ),
              const Text(
                'Monthly Sales',
                style: TextStyle(
                  color: Color(0xFF50E4FF),
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 37,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 20.0,
                    top: 16.0,
                    bottom: 16.0,
                  ),
                  child: BlocSelector<HomeCubit, HomeState, List<SaleSummary>>(
                    selector: (state) => state.salesSummary,
                    builder: (context, state) {
                      final List<FlSpot> spots = state
                          .mapIndexed(
                            (index, e) => FlSpot(index.toDouble(), e.total),
                          )
                          .toList();
                      final LineChartData data = LineChartData(
                        minY: 0.0,
                        maxY: state
                                .reduce(
                                  (currentMax, next) =>
                                      next.total > currentMax.total
                                          ? next
                                          : currentMax,
                                )
                                .total
                                .toInt() +
                            15,
                        gridData: const FlGridData(show: false),
                        borderData: FlBorderData(
                          show: true,
                          border: const Border(
                            bottom: BorderSide(
                              color: Color(0xFF42395B),
                              width: 4,
                            ),
                            left: BorderSide(color: Colors.transparent),
                            right: BorderSide(color: Colors.transparent),
                            top: BorderSide(color: Colors.transparent),
                          ),
                        ),
                        lineBarsData: [
                          LineChartBarData(spots: spots, isCurved: true),
                        ],
                        titlesData: FlTitlesData(
                          topTitles: const AxisTitles(),
                          rightTitles: const AxisTitles(),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 40.0,
                              getTitlesWidget: (value, meta) {
                                return SideTitleWidget(
                                  axisSide: meta.axisSide,
                                  child: Text(
                                    '${value.toInt()}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF6A608F),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 32,
                              interval: 1,
                              getTitlesWidget: (value, meta) {
                                return SideTitleWidget(
                                  space: 10,
                                  axisSide: meta.axisSide,
                                  child: Text(
                                    DateFormat('MMM').format(
                                      state[value.toInt()].dateTime,
                                    ),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Color(0xFF6A608F),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                      return LineChart(
                        data,
                        duration: const Duration(milliseconds: 250),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
