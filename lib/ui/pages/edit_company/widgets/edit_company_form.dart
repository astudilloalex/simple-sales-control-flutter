import 'package:flutter/material.dart';

class EditCompanyForm extends StatefulWidget {
  const EditCompanyForm({super.key});

  @override
  State<EditCompanyForm> createState() => _EditCompanyFormState();
}

class _EditCompanyFormState extends State<EditCompanyForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();

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
          ),
        ],
      ),
    );
  }
}
