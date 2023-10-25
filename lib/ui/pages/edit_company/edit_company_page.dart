import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sales_control/ui/pages/edit_company/widgets/edit_company_form.dart';

class EditCompanyPage extends StatelessWidget {
  const EditCompanyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.editCompany),
      ),
      body: ListView(
        children: const [
          SizedBox(height: 16.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: EditCompanyForm(),
          ),
        ],
      ),
    );
  }
}
