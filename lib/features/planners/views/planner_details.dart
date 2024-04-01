import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:processed/features/dashboard/controllers/homecontroller.dart';
import 'package:processed/features/inspection/views/inspection_flow/inspection_form.dart';
import 'package:processed/features/planners/controllers/plannercontroller.dart';
import 'package:processed/utils/constants/colors.dart';
import 'package:processed/utils/constants/sizes.dart';
import 'package:processed/utils/helpers/helper_functions.dart';

class PlannerDetails extends StatelessWidget {
  const PlannerDetails({super.key});

  @override
  Widget build(BuildContext context) {
    PlannerController controller = Get.put(PlannerController());

    final isDark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        titleTextStyle: Theme.of(context).textTheme.headlineSmall,

        // ),
        title: const Text('Planner Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              // height: 200.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Details for your selected planner event \nare ready. Time to craft your Inspection form! Make sure to enter these details.',
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),

                  // change date
                  const SizedBox(height: TSizes.defaultSpace),

                  PlannerItem(
                    title: 'Subject',
                    description: controller.arguments[0].toString(),
                  ),

                  PlannerItem(
                    title: 'Company',
                    description: controller.arguments[1].toString(),
                  ),

                  PlannerItem(
                    title: 'Starts On',
                    description: controller.arguments[2].toString(),
                  ),
                  PlannerItem(
                    title: 'Ends On',
                    description: controller.arguments[3].toString(),
                  ),

                  PlannerItem(
                    title: 'Event ID',
                    description: controller.arguments[4].toString(),
                  ),

                  PlannerItem(
                    title: 'Reference Type',
                    description: controller.arguments[5].toString(),
                  ),

                  PlannerItem(
                    title: 'System Integrated',
                    description:
                        controller.arguments[6] == true ? 'true' : 'false',
                  ),

                  PlannerItem(
                    title: 'Document Level',
                    description:
                        controller.arguments[7] == true ? 'true' : 'false',
                  ),

                  PlannerItem(
                    title: 'Document Name',
                    description: controller.arguments[8].toString().isEmpty
                        ? 'None'
                        : controller.arguments[8].toString(),
                  ),

                  PlannerItem(
                    title: 'Reference  Name',
                    description: controller.arguments[9].toString().isEmpty
                        ? 'None'
                        : controller.arguments[9].toString(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: TSizes.defaultSpace),
            Container(
              alignment: Alignment.bottomCenter,
              // padding: EdgeInsets.all(5.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: isDark ? TColors.primary : TColors.black,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: isDark ? TColors.white : TColors.primary,
                      ),
                      onPressed: () {
                        Get.back();
                      },
                      color: Colors.white,
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: isDark ? TColors.primary : TColors.black,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_forward,
                        color: isDark ? TColors.white : TColors.primary,
                      ),
                      onPressed: () {
                        HomeController.instance.isNewForm.value = false;
                        Get.to(
                          () => const InspectionForm(),
                        );
                      },
                      color: isDark ? TColors.white : TColors.primary,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PlannerItem extends StatelessWidget {
  const PlannerItem({
    super.key,
    required this.title,
    required this.description,
  });
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    PlannerController instance = PlannerController.instance;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$title - ${description.toString().isEmpty ? 'None' : description.toString()}',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const Divider(),
        const SizedBox(height: TSizes.sm),
      ],
    );
  }
}
