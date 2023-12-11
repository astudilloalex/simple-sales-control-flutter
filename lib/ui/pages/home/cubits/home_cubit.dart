import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_control/src/auth/application/auth_service.dart';
import 'package:sales_control/src/auth/domain/auth.dart';
import 'package:sales_control/src/sale_summary/application/sale_summary_service.dart';
import 'package:sales_control/src/sale_summary/domain/sale_summary.dart';
import 'package:sales_control/ui/pages/home/states/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required this.authService,
    required this.saleSummaryService,
  }) : super(const HomeState());

  final AuthService authService;
  final SaleSummaryService saleSummaryService;

  Future<void> load() async {
    String error = '';
    Auth? auth;
    try {
      emit(state.copyWith(loading: true, loadingError: error));
      auth = await authService.current;
      saleSummaryService
          .getLastSixMonths(auth?.uid ?? '', DateTime.now())
          .listen((event) {
        final DateTime now = DateTime.now();
        for (int i = 5; i >= 0; i--) {
          final DateTime monthToCheck = DateTime(now.year, now.month - i);
          final SaleSummary? summaryForMonth = event.firstWhereOrNull(
            (summary) =>
                summary.dateTime.year == monthToCheck.year &&
                summary.dateTime.month == monthToCheck.month,
          );
          if (summaryForMonth == null) {
            event.insert(i, SaleSummary(dateTime: monthToCheck));
          }
        }
        event.sort((a, b) => a.dateTime.compareTo(b.dateTime));
        emit(state.copyWith(salesSummary: event));
      });
    } on Exception {
      error = 'loading-error';
    } finally {
      emit(
        state.copyWith(
          loading: false,
          loadingError: error,
          companyId: auth?.uid,
        ),
      );
    }
  }
}
