import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sales_control/app/app.dart';
import 'package:sales_control/src/company/domain/company.dart';
import 'package:sales_control/ui/pages/edit_company/cubits/edit_company_cubit.dart';

class EditCompanyForm extends StatefulWidget {
  const EditCompanyForm({super.key});

  @override
  State<EditCompanyForm> createState() => _EditCompanyFormState();
}

class _EditCompanyFormState extends State<EditCompanyForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _load();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.name,
            ),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton.icon(
            onPressed: () async {
              context.loaderOverlay.show();
              final EditCompanyCubit cubit = context.read<EditCompanyCubit>();
              final Company company = await cubit.company;
              final String? error = await cubit.update(
                company.copyWith(name: nameController.text),
              );
              if (mounted) {
                context.loaderOverlay.hide();
                if (error != null) {
                  showErrorSnackbar(context, error);
                  return;
                }
                context.pop();
              }
            },
            icon: const Icon(FontAwesomeIcons.solidFloppyDisk),
            label: Text(AppLocalizations.of(context)!.save),
          ),
        ],
      ),
    );
  }

  Future<void> _load() async {
    context.loaderOverlay.show();
    try {
      final Company company = await context.read<EditCompanyCubit>().company;
      nameController.text = company.name;
    } finally {
      if (mounted) context.loaderOverlay.hide();
    }
  }
}
