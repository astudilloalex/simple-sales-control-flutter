import 'package:sales_control/src/sale_summary/domain/sale_summary.dart';

class HomeState {
  const HomeState({
    this.companyId = '',
    this.loading = false,
    this.loadingError = '',
    this.salesSummary = const [],
  });

  final String companyId;
  final String loadingError;
  final bool loading;
  final List<SaleSummary> salesSummary;

  HomeState copyWith({
    String? companyId,
    String? loadingError,
    bool? loading,
    List<SaleSummary>? salesSummary,
  }) {
    return HomeState(
      companyId: companyId ?? this.companyId,
      loading: loading ?? this.loading,
      loadingError: loadingError ?? this.loadingError,
      salesSummary: salesSummary ?? this.salesSummary,
    );
  }
}
