import 'package:sales_control/src/company/domain/company.dart';

class EditCompanyState {
  const EditCompanyState({
    this.company,
  });

  final Company? company;

  EditCompanyState copyWith({
    Company? company,
  }) {
    return EditCompanyState(
      company: company ?? this.company,
    );
  }
}
