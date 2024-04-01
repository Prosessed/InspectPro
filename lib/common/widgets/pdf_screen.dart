
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:processed/common/controllers/pdf_controller.dart';
import 'package:processed/features/completed/controllers/completed_controller.dart';
import 'package:processed/utils/constants/colors.dart';
import 'package:processed/utils/helpers/helper_functions.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfView extends StatelessWidget {
  PdfView({super.key});

  PdfController controller = Get.put(PdfController());

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.share,
              color: isDark ? TColors.white : TColors.primary,
            ),
            onPressed: () {
              // controller.fetchReportFile();
              controller.shareUint8List(
                CompletedController.instance.currentReportPdf.value,
              );
            },
          ),
        ],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? TColors.white : TColors.primary,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        centerTitle: false,
        title: Text(
          'Your Report',
          style: TextStyle(color: isDark ? TColors.white : TColors.primary),
        ),
      ),
      body: FutureBuilder<void>(
        future: loadPdfAfterDelay(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Display a loading indicator while waiting for the PDF to load
            return const Center(child: CircularProgressIndicator());
          } else {
            return Obx(
              () => Container(
                decoration: const BoxDecoration(
                    // color: isDark ? TColors.white : TColors.white,
                    ),
                child: SfPdfViewer.memory(
                  CompletedController.instance.currentReportPdf.value,
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Future<void> loadPdfAfterDelay() async {
    // Simulate a delay of 2 seconds
    await Future.delayed(const Duration(seconds: 2));

    // Assuming you have loaded the PDF data into CompletedController.instance.currentReportPdf.value
    // Example data

    // You can replace the example data with your actual Uint8List PDF data
  }
}
