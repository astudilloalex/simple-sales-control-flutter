import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_control/src/auth/domain/auth.dart';
import 'package:sales_control/src/company/application/company_service.dart';
import 'package:sales_control/src/company/domain/company.dart';
import 'package:sales_control/ui/pages/edit_company/states/edit_company_state.dart';

class EditCompanyCubit extends Cubit<EditCompanyState> {
  EditCompanyCubit({
    required this.id,
    required this.companyService,
  }) : super(const EditCompanyState());

  final String id;
  final CompanyService companyService;

  Future<Company> get company async {
    if (state.company == null) {
      emit(state.copyWith(company: await companyService.getMyCompany()));
    }
    return state.company ??
        const Company(
          id: '',
          name: '',
          owner: Auth(uid: ''),
        );
  }

  Future<String?> update(Company company) async {
    try {
      await companyService.update(company);
    } on Exception catch (e) {
      return e.toString();
    }
    return null;
  }
}
