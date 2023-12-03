import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sales_control/app/app.dart';
import 'package:sales_control/src/customer/domain/customer.dart';
import 'package:sales_control/ui/pages/edit_customer/cubits/edit_customer_cubit.dart';

class EditCustomerForm extends StatefulWidget {
  const EditCustomerForm({super.key});

  @override
  State<EditCustomerForm> createState() => _EditCustomerFormState();
}

class _EditCustomerFormState extends State<EditCustomerForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController idCardController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    load();
  }

  @override
  void dispose() {
    idCardController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            controller: idCardController,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.idCard,
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.length < 3) {
                return AppLocalizations.of(context)!.invalidIdCard;
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: firstNameController,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.firstName,
            ),
            validator: (value) {
              if (value == null || value.length < 3) {
                return AppLocalizations.of(context)!.invalidName;
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: lastNameController,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.lastName,
            ),
            validator: (value) {
              if (value == null || value.length < 3) {
                return AppLocalizations.of(context)!.invalidName;
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          ElevatedButton.icon(
            onPressed: () {
              if (!formKey.currentState!.validate()) return;
              save();
            },
            icon: const FaIcon(FontAwesomeIcons.solidFloppyDisk),
            label: Text(AppLocalizations.of(context)!.save),
          ),
        ],
      ),
    );
  }

  Future<void> save() async {
    context.loaderOverlay.show();
    final EditCustomerCubit cubit = context.read<EditCustomerCubit>();
    final Customer customer = Customer(
      id: cubit.id ?? '',
      companyId: cubit.companyId,
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      idCard: idCardController.text.trim(),
      fullName:
          '${firstNameController.text.trim()} ${lastNameController.text.trim()}',
    );
    final String? error = await cubit.saveOrUpdate(customer);
    if (!mounted) return;
    context.loaderOverlay.hide();
    if (error != null) {
      showErrorSnackbar(context, error);
    } else {
      context.pop(customer.copyWith(id: cubit.state.customer?.id));
    }
  }

  Future<void> load() async {
    context.loaderOverlay.show();
    final EditCustomerCubit cubit = context.read<EditCustomerCubit>();
    await cubit.load();
    final Customer? customer = cubit.state.customer;
    idCardController.text = customer?.idCard ?? '';
    firstNameController.text = customer?.firstName ?? '';
    lastNameController.text = customer?.lastName ?? '';
    if (!mounted) return;
    context.loaderOverlay.hide();
  }
}
