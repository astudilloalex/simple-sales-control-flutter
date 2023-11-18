import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_control/src/auth/domain/auth.dart';
import 'package:sales_control/src/company/application/company_service.dart';
import 'package:sales_control/src/company/domain/company.dart';
import 'package:sales_control/ui/pages/user/states/user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit({
    required this.companyService,
  }) : super(const UserState());

  final CompanyService companyService;

  Future<void> load() async {
    emit(state.copyWith(loading: true));
    final List<Auth> users = [];
    try {
      final Company? company = await companyService.getMyCompany();
      if (company == null) return;
      company.users.sort(
        (a, b) => a.displayName?.compareTo(b.displayName ?? '') ?? 0,
      );
      users.addAll(company.users);
    } finally {
      emit(state.copyWith(loading: false, users: users));
    }
  }

  Future<String?> addUser(String uid) async {
    try {
      emit(state.copyWith(loading: true));
      final Company? company = await companyService.getById(uid);
      if (company == null) return 'user-does-not-exists';
      final Company? myCompany = await companyService.getMyCompany();
      if (myCompany == null) return 'company-does-not-exists';
      final Auth? user = myCompany.users.firstWhereOrNull(
        (element) => element.uid == company.owner.uid,
      );
      if (user != null) return null;
      myCompany.users.add(company.owner);
      await companyService.update(myCompany, updateUsers: true);
      emit(state.copyWith(users: myCompany.users));
    } on Exception catch (e) {
      emit(state.copyWith(loading: false));
      return e.toString();
    }
    return null;
  }
}
