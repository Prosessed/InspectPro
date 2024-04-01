import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:processed/common/widgets/masterapp_button.dart';
import 'package:processed/common/widgets/save_draft_button.dart';
import 'package:processed/features/dashboard/controllers/homecontroller.dart';
import 'package:processed/features/inspection/controllers/InspectionController.dart';
import 'package:processed/features/inspection/views/inspection_flow/inspection_part_one.dart';
import 'package:processed/features/planners/controllers/plannercontroller.dart';
import 'package:processed/utils/constants/colors.dart';
import 'package:processed/utils/constants/sizes.dart';
import 'package:processed/utils/constants/text_strings.dart';
import 'package:processed/utils/helpers/helper_functions.dart';
import 'package:dropdown_search/dropdown_search.dart';

class InspectionForm extends StatelessWidget {
  const InspectionForm({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    InspectionController inspectionController = Get.put(InspectionController());
    HomeController homeController = Get.find<HomeController>();

    return Scaffold(
      appBar: AppBar(
        actions: [
          homeController.isSaveEnabled.value
              ? const SaveDraftButton()
              : const SizedBox.shrink(),
        ],
        leading: isDark
            ? GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  isDark ? Iconsax.arrow_left_2 : Iconsax.arrow_left_2,
                  // size: 20.sp
                  color: isDark ? TColors.white : TColors.primary,
                ),
              )
            : null,
        centerTitle: true,
        title: const Text(
          TTexts.createInspection,
        ),
        titleTextStyle: Theme.of(context).textTheme.headlineSmall,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => TextFormField(
                    readOnly: true,
                    controller: inspectionController.reportDateController,
                    onTap: () => inspectionController.selectReportDate(
                        context, inspectionController.reportDateController),
                    decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 12.sp),
                      border: const OutlineInputBorder(),
                      hintText: homeController.isDraft.value
                          ? InspectionController.draftModel.value.reportDate
                          : 'Report Date*',
                      suffixIcon: const Icon(Icons.calendar_today),
                    ),
                    // readOnly: true,
                  ),
                ),

                const SizedBox(
                  height: TSizes.spaceBtwInputFields,
                ),

                !homeController.isNewForm.value &&
                        homeController.isDraft.value == false
                    ? TextFormField(
                        initialValue: homeController.isNewForm.value
                            ? ''
                            : PlannerController.instance.arguments[4],
                        decoration: const InputDecoration(
                          labelText: 'Event Id',
                          prefixIcon: Icon(Iconsax.note),
                        ),
                      )
                    : const SizedBox.shrink(),

                !homeController.isNewForm.value && !homeController.isDraft.value
                    ? const SizedBox(
                        height: TSizes.spaceBtwInputFields,
                      )
                    : const SizedBox.shrink(),

                const SizedBox(
                  height: TSizes.spaceBtwInputFields,
                ),

                !homeController.isNewForm.value &&
                        homeController.isDraft.value == false
                    ? TextFormField(
                        readOnly: true,
                        initialValue:
                            PlannerController.instance.arguments[5].toString(),
                        decoration: const InputDecoration(
                          labelText: 'Reference Name',
                          prefixIcon: Icon(Iconsax.building),
                        ),
                      )
                    : Obx(
                        () => DropdownSearch<String>(
                          popupProps: PopupProps.dialog(
                              dialogProps: DialogProps(
                                barrierColor: Colors.black.withOpacity(0.5),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                backgroundColor:
                                    isDark ? Colors.black : Colors.white,
                              ),
                              fit: FlexFit.loose,
                              scrollbarProps: const ScrollbarProps(
                                trackColor: TColors.primary,
                              )),
                          items: inspectionController.referenceTypeList,
                          dropdownDecoratorProps: const DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                                // labelText: "Menu mode",
                                ),
                          ),
                          onChanged: (selectedValue) {
                            inspectionController.referenceTypeValue.value =
                                selectedValue!;

                            inspectionController
                                .getReferencesListBasedOnReferenceType(
                                    selectedValue);

                            inspectionController.referenceNameValue.value =
                                'Select Reference Name*';
                          },
                          selectedItem:
                              inspectionController.referenceTypeValue.value,
                        ),
                      ), // drop down no. 1
                // drop down no2
                // ),

                const SizedBox(
                  height: TSizes.spaceBtwInputFields,
                ),

                // homeController.isNewForm.value
                //     ? Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Text(
                //             TTexts.isSystemIntegrated,
                //             style: Theme.of(context).textTheme.bodySmall,
                //           ),
                //           SizedBox(
                //             width: 24,
                //             height: 24,
                //             child: Obx(() => Checkbox(
                //                   value: inspectionController
                //                       .isSystemIntegrated.value,
                //                   onChanged: (value) {
                //                     inspectionController
                //                         .isSystemIntegrated.value = value!;
                //                   },
                //                 )),
                //           ),
                //         ],
                //       )
                //     : const SizedBox.shrink(),

                const SizedBox(
                  height: TSizes.spaceBtwInputFields,
                ),
                homeController.isNewForm.value ||
                        homeController.isDraft.value == true
                    ? Obx(
                        () => inspectionController.isSystemIntegrated.value
                            ? DropdownSearch<String>(
                                popupProps: PopupProps.dialog(
                                    searchDelay: Duration.zero,
                                    dialogProps: DialogProps(
                                      barrierColor:
                                          Colors.black.withOpacity(0.5),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      backgroundColor:
                                          isDark ? Colors.black : Colors.white,
                                    ),
                                    searchFieldProps: const TextFieldProps(
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(10),
                                        hintText: 'Search here...',
                                        prefixIcon:
                                            Icon(Iconsax.search_favorite),
                                      ),
                                    ),
                                    showSearchBox: true,
                                    fit: FlexFit.loose,
                                    scrollbarProps: const ScrollbarProps(
                                      trackColor: TColors.primary,
                                    )),
                                items: inspectionController.referenceNames,
                                dropdownDecoratorProps:
                                    const DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(),
                                ),
                                onChanged: (selectedValue) {
                                  inspectionController.referenceNameValue
                                      .value = selectedValue!;
                                },
                                selectedItem: inspectionController
                                    .referenceNameValue.value,
                              )
                            : TextFormField(
                                controller:
                                    inspectionController.documentNameController,
                                decoration: InputDecoration(
                                  labelText: TTexts.documentName,
                                  labelStyle: TextStyle(fontSize: 12.sp),
                                  suffixIcon: const Icon(Iconsax.document),
                                ),
                              ),
                      )
                    : PlannerController.instance.arguments[6] == true
                        ? TextFormField(
                            readOnly: true,
                            initialValue: PlannerController
                                .instance.arguments[9]
                                .toString(),
                            decoration: const InputDecoration(
                              labelText: TTexts.documentName,
                              prefixIcon: Icon(Iconsax.document),
                            ),
                          )
                        : TextFormField(
                            readOnly: true,
                            initialValue: PlannerController
                                .instance.arguments[8]
                                .toString(),
                            decoration: const InputDecoration(
                              labelText: TTexts.documentName,
                              prefixIcon: Icon(Iconsax.document),
                            ),
                          ),

                const SizedBox(
                  height: TSizes.spaceBtwInputFields,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 2.w, top: 5.h),
                      child: Text(
                        TTexts.isDocumentLevel,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: Obx(() => Checkbox(
                            value: inspectionController.isDocument.value,
                            onChanged: (value) {
                              inspectionController.serialNoController.clear();
                              inspectionController.batchNoController.clear();
                              inspectionController.sampleSizeController.clear();
                              inspectionController.productValue.value =
                                  'Select Item Name';

                              inspectionController.inspectionTemplateValue
                                  .value = 'Select Inspection Template*';

                              inspectionController.isDocument.value = value!;
                            },
                          )),
                    ),
                  ],
                ),

                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),

                Obx(
                  () => !inspectionController.isDocument.value
                      ? Column(
                          children: [
                            DropdownSearch<String>(
                              popupProps: PopupProps.dialog(
                                  searchFieldProps: const TextFieldProps(
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(10),
                                      hintText: 'Search here...',
                                      prefixIcon: Icon(Iconsax.search_favorite),
                                    ),
                                  ),
                                  dialogProps: DialogProps(
                                    backgroundColor:
                                        isDark ? Colors.black : Colors.white,
                                  ),
                                  searchDelay: Duration.zero,
                                  showSearchBox: true),
                              items: inspectionController.itemCodeValues,
                              dropdownDecoratorProps:
                                  const DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(),
                              ),
                              onChanged: (selectedValue) {
                                inspectionController.productValue.value =
                                    selectedValue!;

                                inspectionController
                                        .inspectionTemplateValue.value =
                                    inspectionController
                                        .getTemplateByItemName(selectedValue)
                                        .toString();
                              },
                              selectedItem:
                                  inspectionController.productValue.value,
                            ),
                            const SizedBox(
                              height: TSizes.spaceBtwInputFields,
                            ),
                            TextFormField(
                              controller:
                                  inspectionController.serialNoController,
                              decoration: InputDecoration(
                                  labelText: TTexts.serial_no,
                                  labelStyle: TextStyle(fontSize: 12.sp),
                                  prefixIcon: const Icon(Iconsax.note)),
                            ),
                            const SizedBox(
                              height: TSizes.spaceBtwInputFields,
                            ),
                            TextFormField(
                              controller:
                                  inspectionController.batchNoController,
                              decoration: InputDecoration(
                                  labelStyle: TextStyle(fontSize: 12.sp),
                                  labelText: TTexts.batchNo,
                                  prefixIcon: const Icon(Iconsax.note)),
                            ),
                            const SizedBox(
                              height: TSizes.spaceBtwInputFields,
                            ),
                            TextFormField(
                              controller:
                                  inspectionController.sampleSizeController,
                              decoration: InputDecoration(
                                  labelText: TTexts.sampleSize,
                                  labelStyle: TextStyle(fontSize: 12.sp),
                                  prefixIcon: const Icon(Iconsax.size)),
                            ),
                            const SizedBox(
                              height: TSizes.spaceBtwInputFields,
                            ),
                            Obx(
                              () => TextFormField(
                                onChanged: (value) {},
                                readOnly: true,
                                controller: TextEditingController(
                                    text: inspectionController
                                        .inspectionTemplateValue.value),
                                // initialValue: '',
                                decoration: const InputDecoration(
                                    labelText: TTexts.inspectionTemplate,
                                    prefixIcon: Icon(Iconsax.card)),
                              ),
                            )
                          ],
                        )
                      : DropdownSearch<String>(
                          popupProps: PopupProps.dialog(
                              searchFieldProps: const TextFieldProps(
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  hintText: 'Search here...',
                                  prefixIcon: Icon(Iconsax.search_favorite),
                                ),
                              ),
                              dialogProps: DialogProps(
                                backgroundColor:
                                    isDark ? Colors.black : Colors.white,
                              ),
                              searchDelay: Duration.zero,
                              showSearchBox: true),
                          items: inspectionController.inspectionTemplateList,
                          dropdownDecoratorProps: const DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(),
                          ),
                          onChanged: (selectedValue) {
                            inspectionController.inspectionTemplateValue.value =
                                selectedValue!;
                          },
                          selectedItem: inspectionController
                              .inspectionTemplateValue.value,
                        ),
                ),

                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),

                Obx(() =>
                    inspectionController.inspectionTemplateValue.isEmpty &&
                                inspectionController
                                        .inspectionTemplateValue.value ==
                                    'Select Inspection Template*' ||
                            inspectionController.productValue.isEmpty &&
                                inspectionController.productValue.value ==
                                    'Select Item Name'
                        ? const SizedBox.shrink()
                        : MasterAppButton(
                            hintText: 'Next',
                            onPressed: () => homeController.isNewForm.value
                                ? inspectionController.inspectionTemplateValue
                                                .value ==
                                            'Select Inspection Template*' ||
                                        // inspectionController.inspectionTypeValue.value ==
                                        //     'Select Inspection Type*' ||
                                        inspectionController
                                                .referenceTypeValue.value ==
                                            'Select Reference Type*' ||
                                        inspectionController
                                                .documentNameController.text ==
                                            '' ||
                                        inspectionController
                                            .reportDateController.text.isEmpty
                                    ? THelperFunctions.showSnackBar(
                                        'Please select all Mandatory Details to Continue!',
                                        '',
                                        Colors.red)
                                    : Get.to(() => const InspectionPartOne())
                                : inspectionController
                                            .inspectionTemplateValue.value ==
                                        'Select Inspection Template*'
                                    ? THelperFunctions.showSnackBar(
                                        '',
                                        'Please select all Mandatory Details to Continue!',
                                        Colors.red)
                                    : Get.to(() => const InspectionPartOne()),
                          )),
              ],
            ),
          ),

          //
        ),
      ),
    );
  }
}
