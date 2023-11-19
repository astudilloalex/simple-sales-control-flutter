import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sales_control/app/app.dart';
import 'package:sales_control/src/product/domain/product.dart';
import 'package:sales_control/ui/pages/edit_product/cubits/edit_product_cubit.dart';

class EditProductForm extends StatefulWidget {
  const EditProductForm({super.key});

  @override
  State<EditProductForm> createState() => _EditProductFormState();
}

class _EditProductFormState extends State<EditProductForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  List<XFile?> imageList = [null, null, null];

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
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
            maxLength: 100,
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: descriptionController,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.description,
            ),
            minLines: 3,
            maxLines: 4,
            keyboardType: TextInputType.text,
            maxLength: 300,
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: priceController,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.price,
            ),
            keyboardType: TextInputType.number,
          ),
          if (context.read<EditProductCubit>().id == null)
            const SizedBox(height: 16.0),
          if (context.read<EditProductCubit>().id == null)
            TextFormField(
              controller: quantityController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.quantity,
              ),
              keyboardType: TextInputType.number,
            ),
          const SizedBox(height: 16.0),
          Text(AppLocalizations.of(context)!.images),
          const SizedBox(height: 16.0),
          // Images picker
          SizedBox(
            height: 125.0,
            child: Center(
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: [
                  SizedBox(
                    height: 120.0,
                    width: 120.0,
                    child: Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () => _pickImage(0),
                              child: Center(
                                child: imageList[0] == null
                                    ? const FaIcon(FontAwesomeIcons.plus)
                                    : Center(
                                        child: Image.file(
                                          File(imageList[0]!.path),
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                          if (imageList[0] != null)
                            SizedBox(
                              width: double.infinity,
                              child: InkWell(
                                onTap: () => _removeImage(0),
                                child: const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: FaIcon(
                                      FontAwesomeIcons.trash,
                                      size: 15.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 120.0,
                    width: 120.0,
                    child: Card(
                      child: Column(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () => _pickImage(1),
                              child: Center(
                                child: imageList[1] == null
                                    ? const FaIcon(FontAwesomeIcons.plus)
                                    : Image.file(
                                        File(imageList[1]!.path),
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                          ),
                          if (imageList.elementAtOrNull(1) != null)
                            SizedBox(
                              width: double.infinity,
                              child: InkWell(
                                onTap: () => _removeImage(1),
                                child: const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: FaIcon(
                                      FontAwesomeIcons.trash,
                                      size: 15.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 120.0,
                    width: 120.0,
                    child: Card(
                      child: Column(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () => _pickImage(2),
                              child: Center(
                                child: imageList[2] == null
                                    ? const FaIcon(FontAwesomeIcons.plus)
                                    : Image.file(
                                        File(imageList[2]!.path),
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                          ),
                          if (imageList[2] != null)
                            SizedBox(
                              width: double.infinity,
                              child: InkWell(
                                onTap: () => _removeImage(2),
                                child: const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: FaIcon(
                                      FontAwesomeIcons.trash,
                                      size: 15.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          // save button
          ElevatedButton.icon(
            onPressed: () async {
              context.loaderOverlay.show();
              final String? error =
                  await context.read<EditProductCubit>().addProduct(
                        Product(
                          name: nameController.text.trim(),
                          description: descriptionController.text.trim(),
                          price: double.tryParse(priceController.text.trim()) ??
                              0.0,
                          quantity:
                              double.tryParse(quantityController.text.trim()) ??
                                  0.0,
                        ),
                      );
              if (!context.mounted) return;
              context.loaderOverlay.hide();
              if (error != null) {
                showErrorSnackbar(context, error);
              }
            },
            icon: const FaIcon(FontAwesomeIcons.solidFloppyDisk),
            label: Text(AppLocalizations.of(context)!.save),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage(int index) async {
    const int maxFileSizeInBytes = 2 * 1048576;
    final ImagePicker picker = ImagePicker();
    final XFile? xFile = await picker.pickImage(source: ImageSource.camera);
    if (xFile == null) return;
    final Uint8List data = await xFile.readAsBytes();
    if (!mounted) return;
    if (data.length > maxFileSizeInBytes) {
      showErrorSnackbar(
        context,
        AppLocalizations.of(context)!.fileSizeExceeded,
      );
    } else {
      setState(() {
        imageList[index] = xFile;
      });
    }
  }

  void _removeImage(int index) {
    if (imageList[index] == null) return;
    setState(() {
      imageList[index] = null;
    });
  }
}
