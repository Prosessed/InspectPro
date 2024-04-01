import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:processed/features/inspection/controllers/InspectionController.dart';
import 'package:signature/signature.dart';

class SignaturePadController extends GetxController {
  SignatureController signatureController = SignatureController();

  Future<void> exportImage(BuildContext context) async {
    if (signatureController.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          key: Key('snackbarPNG'),
          content: Text('No content'),
        ),
      );
      return;
    }

    final Uint8List? data =
        await signatureController.toPngBytes(height: 1000, width: 1000);

    print(data);
    if (data == null) {
      return;
    }

    InspectionController.instance.signature.value = data;
  }

}
