import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sales_control/app/app.dart';
import 'package:sales_control/app/cubits/app_cubit.dart';
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

  List<String?> imageUrls = [null, null, null];

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
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.name,
            ),
            maxLength: 100,
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value == null || value.trim().length < 3) {
                return AppLocalizations.of(context)!.invalidName;
              }
              return null;
            },
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
            validator: (value) {
              if (value == null || double.tryParse(value.trim()) == null) {
                return AppLocalizations.of(context)!.invalidPrice;
              }
              return null;
            },
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
              validator: (value) {
                if (value == null || double.tryParse(value.trim()) == null) {
                  return AppLocalizations.of(context)!.invalidQuantity;
                }
                if (double.parse(value.trim()) < 0) {
                  return AppLocalizations.of(context)!.invalidQuantity;
                }
                return null;
              },
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
                                child: imageUrls[0] == null
                                    ? const FaIcon(FontAwesomeIcons.plus)
                                    : Center(
                                        child: Image.network(
                                          imageUrls[0]!,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                          if (imageUrls[0] != null)
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
                                child: imageUrls[1] == null
                                    ? const FaIcon(FontAwesomeIcons.plus)
                                    : Image.network(
                                        imageUrls[1]!,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                          ),
                          if (imageUrls[1] != null)
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
                                child: imageUrls[2] == null
                                    ? const FaIcon(FontAwesomeIcons.plus)
                                    : Image.network(
                                        imageUrls[2]!,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                          ),
                          if (imageUrls[2] != null)
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
              if (!formKey.currentState!.validate()) return;
              context.loaderOverlay.show();
              final List<String> photoUrls = [];
              for (final String? url in imageUrls) {
                if (url != null) photoUrls.add(url);
              }
              final Product product = Product(
                name: nameController.text.trim(),
                companyId: context.read<AppCubit>().state.companyId,
                description: descriptionController.text.trim(),
                price: double.tryParse(priceController.text.trim()) ?? 0.0,
                quantity:
                    double.tryParse(quantityController.text.trim()) ?? 0.0,
                photoUrls: photoUrls,
              );
              final String? error =
                  await context.read<EditProductCubit>().addProduct(product);
              if (!context.mounted) return;
              context.loaderOverlay.hide();
              if (error != null) {
                showErrorSnackbar(context, error);
              } else {
                context.pop(product);
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
    try {
      context.loaderOverlay.show();
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
        final String url =
            await context.read<EditProductCubit>().addImage(File(xFile.path));
        setState(() {
          imageUrls[index] = url;
        });
      }
    } on Exception catch (e) {
      if (mounted) showErrorSnackbar(context, e.toString());
    } finally {
      if (mounted) context.loaderOverlay.hide();
    }
  }

  Future<void> _removeImage(int index) async {
    if (imageUrls[index] == null) return;
    try {
      context.loaderOverlay.show();
      await context.read<EditProductCubit>().removeImage(imageUrls[index]!);
      setState(() {
        imageUrls[index] = null;
      });
    } on Exception catch (e) {
      if (mounted) showErrorSnackbar(context, e.toString());
    } finally {
      if (mounted) context.loaderOverlay.hide();
    }
  }
}
