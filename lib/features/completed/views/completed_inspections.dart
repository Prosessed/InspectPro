import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:processed/common/widgets/pdf_screen.dart';
import 'package:processed/features/completed/controllers/completed_controller.dart';
import 'package:processed/features/dashboard/controllers/homecontroller.dart';
import 'package:processed/utils/constants/colors.dart';
import 'package:processed/utils/constants/sizes.dart';
import 'package:processed/utils/constants/text_strings.dart';
import 'package:processed/utils/helpers/helper_functions.dart';

class CompletedInspectionsScreen extends StatelessWidget {
  const CompletedInspectionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CompletedController controller = Get.put(CompletedController());
    HomeController homeController = Get.find<HomeController>();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(TTexts.completedInspections),
        titleTextStyle: Theme.of(context).textTheme.headlineSmall,
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Obx(() => controller.all.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Iconsax.empty_wallet,
                      size: 50.sp,
                      color: TColors.primary,
                    ),
                    const SizedBox(height: TSizes.defaultSpace),
                    Text(
                      'No Completed Inspections',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  // Accessing attributes using appropriate methods or properties
                  var completedInspection = controller.all[index];

                  return CompletedItem(
                      title: completedInspection.inspectionTemplateName == ''
                          ? completedInspection.completedItemName!.toString()
                          : completedInspection.inspectionTemplateName
                              .toString(),
                      reportDate:
                          completedInspection.reportDateCompleted!.toString(),
                      // id: completedInspection.completedId!.toString(),

                      subTitle: completedInspection.companyName!,
                      reportLink: completedInspection.inspectionName,
                      //   'https://app.prosessed.com/printview?doctype=Inspection%20Form&name=${completedInspection.inspectionName!}&format=Inspection%20Report%20Format',
                      completedId: (index + 1).toString());
                },
                itemCount: controller.all.length,
              )),
      ),
    );
  }
}

class CompletedItem extends StatelessWidget {
  const CompletedItem({
    super.key,
    required this.title,
    required this.subTitle,
    required this.reportDate,
    required this.reportLink,
    required this.completedId,
  });

  final String title;
  final String subTitle;
  final String reportDate;
  final String reportLink;
  final String completedId;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: TSizes.lg),
          width: double.infinity,
          child: Card(
            color: isDark ? TColors.black : TColors.black,
            elevation: 4,
            child: Container(
              // height: 200.h,
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        // width: 180.w,
                        child: Text(
                          title,
                          style: const TextStyle(
                            color: TColors.white,
                            // fontSize: ,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: TColors.primary,
                          ),
                          shape: BoxShape.circle,
                          // color: TColors.primary,
                        ),
                        width: 25.w,
                        height: 25.h,
                        child: Center(
                          child: Text(
                            completedId,
                            style: const TextStyle(
                              color: Colors.white,
                              // fontSize: ,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: TSizes.lg),
                  Text(
                    'Company : $subTitle',
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: TSizes.lg),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Report Date : $reportDate',
                        style: TextStyle(
                          color: TColors.white,
                          fontSize: 13.sp,
                        ),
                      ),
                      const SizedBox(width: TSizes.lg),
                      InkWell(
                        onTap: () async {
                          CompletedController.instance
                              .getFileContent(reportLink);

                          // CompletedController.instance.launchReportUrl();
                          // print('Current Report Link : $reportLink'),
                          Get.to(
                            () => PdfView(),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Report Link',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                decoration: TextDecoration.underline,
                                decorationThickness:
                                    1.0, // Adjust the thickness
                                decorationStyle: TextDecorationStyle
                                    .solid, // Adjust the style

                                fontSize: 10.sp,

                                decorationColor:
                                    isDark ? TColors.primary : TColors.white,
                                // fontStyle: FontStyle.italic,
                                color: TColors
                                    .primary, // Example color for the link
                              ),
                            ),
                            Icon(
                              Icons.arrow_outward_rounded,
                              color: TColors.primary,
                              size: 16.sp,
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
