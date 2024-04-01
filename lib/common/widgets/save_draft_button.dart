import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:processed/features/inspection/controllers/InspectionController.dart';
import 'package:processed/utils/constants/colors.dart';
import 'package:processed/utils/helpers/helper_functions.dart';

class SaveDraftButton extends StatelessWidget {
  const SaveDraftButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return PopupMenuButton(
      itemBuilder: (context) => [
        PopupMenuItem(
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(
              Icons.save,
              color: isDark ? TColors.white : TColors.primary,
            ),
            title: Text(
              'Save as Draft',
              style: Theme.of(context).textTheme.labelSmall,
            ),
            onTap: () {
              InspectionController.instance.createDraft();
            },
          ),
        ),
      ],
    );
  }
}
