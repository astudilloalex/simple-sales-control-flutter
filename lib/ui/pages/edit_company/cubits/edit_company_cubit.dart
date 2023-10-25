import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_control/src/company/application/company_service.dart';
import 'package:sales_control/ui/pages/edit_company/states/edit_company_state.dart';

class EditCompanyCubit extends Cubit<EditCompanyState> {
  EditCompanyCubit({
    required this.id,
    required this.companyService,
  }) : super(const EditCompanyState());

  final String id;
  final CompanyService companyService;
}
