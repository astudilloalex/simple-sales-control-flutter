import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_control/src/company/application/company_service.dart';
import 'package:sales_control/ui/pages/edit_user/states/edit_user_state.dart';

class EditUserCubit extends Cubit<EditUserState> {
  EditUserCubit({
    required this.companyService,
  }) : super(const EditUserState());

  final CompanyService companyService;
}
