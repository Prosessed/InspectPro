import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:processed/common/widgets/banner_component.dart';
import 'package:processed/common/widgets/circular_container_component.dart';
import 'package:processed/features/authentication/controllers/login_controller.dart';
import 'package:processed/features/dashboard/controllers/homecontroller.dart';
import 'package:processed/features/inspection/views/inspection_flow/inspection_form.dart';
import 'package:processed/features/planners/views/planner_details.dart';
import 'package:processed/utils/constants/colors.dart';
import 'package:processed/utils/constants/image_strings.dart';
import 'package:processed/utils/constants/sizes.dart';
import 'package:processed/utils/helpers/helper_functions.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());
    HomeController controller = Get.put(HomeController());

    final isDark = THelperFunctions.isDarkMode(context);
    return PopScope(
      onPopInvoked: (didpop) {
        if (GetStorage().read('isLoggedIn')) {
          // pop the screen
          didpop = true;
        }
      },
      canPop: true,
      child: Scaffold(
          floatingActionButton: isDark
              ? FloatingActionButton(
                  onPressed: () {
                    // Planne.isNewForm.value = true;
                    controller.isNewForm.value = true;
                    controller.isDraft.value = false;
                    controller.isSaveEnabled.value = true;

                    Get.to(
                      () => const InspectionForm(),
                    );
                  },
                  child: const Icon(Icons.add),
                )
              : FloatingActionButton(
                  onPressed: () {
                    // InspectionController.isNewForm.value = true;

                    controller.isNewForm.value = true;
                    controller.isDraft.value = false;
                    controller.isSaveEnabled.value = true;

                    Get.to(
                      () => const InspectionForm(),
                    );
                  },
                  backgroundColor: TColors.primary,
                  child: const Icon(Icons.add),
                ),
          // bottomNavigationBar: NavigationMenu(),Phytosanitary
          appBar: AppBar(
            automaticallyImplyLeading: false,
            actions: [
              GestureDetector(
                onTap: () => authController.logout(),
                child: Container(
                  margin: EdgeInsets.only(right: 16.w),
                  child: Icon(Iconsax.logout,
                      color: isDark ? TColors.white : TColors.primary,
                      size: 20),
                ),
              ),
            ],
            centerTitle: true,
            title: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Welcome ',
                    style: TextStyle(
                        color: TColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp),
                  ),
                  TextSpan(
                    text: GetStorage().read('user_name'),
                    style: TextStyle(
                        color: isDark ? TColors.white : TColors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          body: Obx(
            () => controller.isLoading.value
                ? const Center(
                    child: LoadingDialog(),
                  )
                : Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                                padding:
                                    const EdgeInsets.all(TSizes.defaultSpace),
                                child: Column(
                                  children: [
                                    CarouselSlider(
                                      options: CarouselOptions(
                                        onPageChanged: (index, _) => controller
                                            .updateCarouselIndex(index),
                                        viewportFraction: 1,
                                        autoPlay: true,
                                        autoPlayInterval:
                                            const Duration(seconds: 2),
                                        autoPlayAnimationDuration:
                                            const Duration(milliseconds: 800),
                                      ),
                                      items: [
                                        BannerComponent(
                                          imageUrl: isDark
                                              ? TImages.onboardingImage1Dark
                                              : TImages.onboardingImage1,
                                        ),
                                        BannerComponent(
                                          imageUrl: isDark
                                              ? TImages.onboardingImage2Dark
                                              : TImages.onboardingImage2,
                                        ),
                                        BannerComponent(
                                          imageUrl: isDark
                                              ? TImages.onboardingImage3Dark
                                              : TImages.onboardingImage3,
                                        ),
                                        BannerComponent(
                                          imageUrl: isDark
                                              ? TImages.onboardingImage4Dark
                                              : TImages.onboardingImage4,
                                        ),
                                        BannerComponent(
                                          imageUrl: isDark
                                              ? TImages.onboardingImage5Dark
                                              : TImages.onboardingImage5,
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: TSizes.spaceBtwInputFields,
                                    ),
                                    Obx(
                                      () => Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          for (int i = 0; i < 5; i++)
                                            CircularContainerComponent(
                                              margin: const EdgeInsets.only(
                                                  right: 10),
                                              width: 20,
                                              backgroundColor: controller
                                                          .carouselIndex
                                                          .value ==
                                                      i
                                                  ? TColors.primary
                                                  : TColors.grey,
                                              height: 5,
                                            ),

                                          // for(int i = 0 ; i< 5 ; i++)
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: TSizes.spaceBtwInputFields,
                                    ),
                                    Text(
                                      controller.imageTitles[controller
                                          .carouselIndex.value]['title']!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                  ],
                                ))
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 12.h, top: 30.h),
                              child: Text(
                                'Pending Tasks',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          indent: 0,
                          endIndent: 0,
                        ),
                        Expanded(
                          child: Obx(() => controller.allPendingTasks.isEmpty
                              ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Iconsax.empty_wallet,
                                        size: 30.sp,
                                        color: TColors.primary,
                                      ),
                                      const SizedBox(
                                          height: TSizes.defaultSpace),
                                      Text(
                                        'No Pending Tasks',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall,
                                      ),
                                    ],
                                  ),
                                )
                              : RefreshIndicator(
                                  onRefresh: () async {
                                    controller.updatePendingList();
                                  },
                                  child: Obx(() => ListView.builder(
                                        physics:
                                            const AlwaysScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemBuilder:
                                            (BuildContext context, index) {
                                          return InkWell(
                                            onTap: () {
                                              controller.isNewForm.value =
                                                  false;
                                              controller.isDraft.value = false;
                                              controller.isSaveEnabled.value =
                                                  false;

                                              Get.to(
                                                  () => const PlannerDetails(),
                                                  arguments: [
                                                    controller
                                                        .allPendingTasks[index]
                                                            ['subject']
                                                        .toString(),
                                                    controller
                                                        .allPendingTasks[index]
                                                            ['company']
                                                        .toString(),
                                                    controller
                                                        .allPendingTasks[index]
                                                            ['starts_on']
                                                        .toString()
                                                        .split(' ')[0]
                                                        .toString(),
                                                    controller
                                                        .allPendingTasks[index]
                                                            ['ends_on']
                                                        .toString()
                                                        .split(' ')[0]
                                                        .toString(),
                                                    controller.allPendingTasks[
                                                        index]['name'],
                                                    controller
                                                        .allPendingTasks[index]
                                                            ['ref_doc']
                                                        .toString(),
                                                    controller.allPendingTasks[
                                                                    index][
                                                                'system_integrated'] ==
                                                            1
                                                        ? true
                                                        : false,
                                                    controller.allPendingTasks[
                                                                    index][
                                                                'document_level'] ==
                                                            1
                                                        ? true
                                                        : false,
                                                    controller.allPendingTasks[
                                                        index]['document_name'],
                                                    controller.allPendingTasks[
                                                            index][
                                                        'reference_document_name'],
                                                  ],
                                                  transition: Transition.zoom);
                                            },
                                            child: TaskItem(
                                                serial_no:
                                                    (index + 1).toString(),
                                                title: controller
                                                    .allPendingTasks[index]
                                                        ['subject']
                                                    .toString(),
                                                subTitle: controller
                                                    .allPendingTasks[index]
                                                        ['company']
                                                    .toString(),
                                                quantity: controller
                                                    .allPendingTasks[index]
                                                        ['name']
                                                    .toString()),
                                          );
                                        },
                                        itemCount:
                                            controller.allPendingTasks.length,
                                      )),
                                )),
                        )
                      ],
                    ),
                  ),
          )),
    );
  }
}

class TaskItem extends StatelessWidget {
  const TaskItem(
      {super.key,
      required this.title,
      required this.subTitle,
      // required this.imageLink,
      required this.quantity,
      required this.serial_no});

  final String title;
  final String subTitle;
  final String serial_no;
  // final String imageLink;
  final String quantity;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 30.w,
        height: 30.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.green),
        ),
        child: Center(
          child: Text(
            serial_no,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.green),
          ),
        ),
      ),

      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      subtitle: Text(
        subTitle,
        style: Theme.of(context).textTheme.bodySmall,
      ),
      // isThreeLine: true,
    );
  }
}

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        decoration: const BoxDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            SizedBox(height: 10.h),
            Text(
              'Loading data\n Please wait...',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
