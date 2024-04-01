import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:processed/features/dashboard/controllers/homecontroller.dart';
import 'package:processed/features/drafts/controllers/draft_controller.dart';
import 'package:processed/features/inspection/views/inspection_flow/inspection_form.dart';
import 'package:processed/utils/constants/colors.dart';
import 'package:processed/utils/constants/sizes.dart';
import 'package:processed/utils/constants/text_strings.dart';
import 'package:processed/utils/helpers/helper_functions.dart';

class DraftScreen extends StatelessWidget {
  const DraftScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DraftController instance = Get.put(DraftController());
    HomeController homeController = Get.find<HomeController>();
    final isDark = THelperFunctions.isDarkMode(context);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text(TTexts.drafts),
          titleTextStyle: Theme.of(context).textTheme.headlineSmall,
        ),
        body: Obx(
          () => instance.draftList.isEmpty
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
                        'No Drafts',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(TSizes.defaultSpace),
                  child: SizedBox(
                      height: double.infinity,
                      child: ListView.builder(
                        itemCount: instance.draftList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Get.bottomSheet(
                                backgroundColor:
                                    isDark ? TColors.black : TColors.white,
                                Container(
                                  padding:
                                      const EdgeInsets.all(TSizes.defaultSpace),
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        readOnly: true,
                                        initialValue: instance.draftList[index]
                                            .inspectionTemplate!,

                                        decoration: InputDecoration(
                                          labelText: 'Inspection Template',
                                          hintStyle: TextStyle(
                                              color: isDark
                                                  ? TColors.white
                                                  : TColors.primary),
                                          border: const OutlineInputBorder(),
                                          suffixIcon:
                                              const Icon(Icons.copy_outlined),
                                        ),
                                        // readOnly: true,
                                      ),
                                      const SizedBox(
                                          height: TSizes.defaultSpace),
                                      TextFormField(
                                        readOnly: true,
                                        initialValue: instance
                                            .draftList[index].reportDate!,

                                        decoration: InputDecoration(
                                          labelText: 'Report Date',
                                          labelStyle: isDark
                                              ? const TextStyle(
                                                  color: TColors.white)
                                              : const TextStyle(
                                                  color: TColors.primary),
                                          hintStyle: TextStyle(
                                              color: isDark
                                                  ? TColors.white
                                                  : TColors.primary),
                                          border: const OutlineInputBorder(),
                                          suffixIcon:
                                              const Icon(Icons.calendar_today),
                                        ),
                                        // readOnly: true,
                                      ),
                                      const SizedBox(
                                          height: TSizes.defaultSpace),
                                      TextFormField(
                                        readOnly: true,
                                        initialValue: instance
                                            .draftList[index].referenceType!,

                                        decoration: InputDecoration(
                                          labelText: 'Reference Type',
                                          hintStyle: TextStyle(
                                              color: isDark
                                                  ? TColors.white
                                                  : TColors.primary),
                                          border: const OutlineInputBorder(),
                                          suffixIcon:
                                              const Icon(Icons.check_circle),
                                        ),
                                        // readOnly: true,
                                      ),
                                      const SizedBox(
                                          height: TSizes.defaultSpace),
                                      TextFormField(
                                        readOnly: true,
                                        initialValue: instance
                                            .draftList[index].documentName!,

                                        decoration: InputDecoration(
                                          labelText: 'Document Name',
                                          hintStyle: TextStyle(
                                              color: isDark
                                                  ? TColors.white
                                                  : TColors.primary),
                                          border: const OutlineInputBorder(),
                                          suffixIcon:
                                              const Icon(Icons.check_circle),
                                        ),
                                        // readOnly: true,
                                      ),
                                      const SizedBox(
                                          height: TSizes.defaultSpace),
                                      Container(
                                        alignment: Alignment.bottomCenter,
                                        // padding: EdgeInsets.all(5.sp),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              'Continue Inspection',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall
                                                  ?.copyWith(
                                                      color: isDark
                                                          ? TColors.white
                                                          : TColors.primary,
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                            CircleAvatar(
                                              backgroundColor: isDark
                                                  ? TColors.primary
                                                  : TColors.black,
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons.arrow_forward,
                                                  color: isDark
                                                      ? TColors.white
                                                      : TColors.primary,
                                                ),
                                                onPressed: () {
                                                  homeController.isDraft.value =
                                                      true;
                                                  homeController.isSaveEnabled
                                                      .value = false;
                                                  instance.currentSelectedDraft
                                                          .value =
                                                      instance.draftList[index]
                                                          .draftId!;

                                                  instance.getCurrentDraftById(
                                                      instance.draftList[index]
                                                          .draftId!);

                                                  Get.off(
                                                    () =>
                                                        const InspectionForm(),
                                                  );
                                                },
                                                color: isDark
                                                    ? TColors.white
                                                    : TColors.primary,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                            child: DraftItem(
                              draftId: '${index + 1}',
                              title: instance.draftList[index].reportDate!,
                              inspectionTemplateName: instance
                                  .draftList[index].inspectionTemplate
                                  .toString(),
                            ),
                          );
                        },
                      ))),
        ));
  }
}

class DraftItem extends StatelessWidget {
  const DraftItem(
      {super.key,
      required this.title,
      required this.inspectionTemplateName,
      required this.draftId});

  final String title;
  final String draftId;
  final String inspectionTemplateName;

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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: TColors.primary,
                          ),
                          shape: BoxShape.circle,
                          // color: TColors.primary,
                        ),
                        width: 20.w,
                        height: 20.h,
                        child: Center(
                          child: Text(
                            draftId,
                            style: const TextStyle(
                              color: Colors.white,
                              // fontSize: ,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: TSizes.lg,
                      ),
                      SizedBox(
                        // width: 220.w,
                        child: Text(
                          'Inspection For $inspectionTemplateName',
                          style: TextStyle(
                              color: TColors.white,
                              // fontSize: ,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.sp),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: TSizes.lg),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Report Date :',
                        style: TextStyle(
                          color: TColors.white,
                          fontSize: 13.sp,
                        ),
                      ),
                      Text(
                        title,
                        style: TextStyle(
                          color: TColors.white,
                          fontSize: 13.sp,
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
