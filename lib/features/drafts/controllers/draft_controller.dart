import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:processed/features/drafts/models/draft_model.dart';
import 'package:processed/utils/local_storage/db_helper.dart';

class DraftController extends GetxController {
  RxList draftList = <DraftModel>[].obs;

  RxInt currentSelectedDraft = 0.obs;

  DatabaseHelper databaseHelper = DatabaseHelper();

  static DraftController get to => Get.find();

  // fetch all the drafts from the local database

  // insert a draft into the local database

  void createDraft(DraftModel draft) async {
    try {
      int res = await databaseHelper.insertOrUpdateDraft(draft);
      // print(res);
      draftList.value = await databaseHelper.getDraftList(
        GetStorage().read('user_email'),
      );

      print(draftList.length);
      for (int i = 0; i < draftList.length; i++) {
        print(draftList[i]);
      }

      update();
    } catch (e) {
      // print the error

      print(e);
    }
  }

  Future<DraftModel> getCurrentDraftById(int draftId) async {
    // final DraftModel curDraft = await databaseHelper.getDraftById(draftId);

    // get the first draft from the draftList where the draftId is equal to the draftId passed as an argument

    final DraftModel curDraft = draftList.firstWhere(
      (element) => element.draftId == draftId,
    );

    print(curDraft.toMap());
    print(curDraft.draftId);
    print(curDraft.inspectionType);
    print(curDraft.reportDate);

    return curDraft;
  }

  // print all the drafts for debugging purposes

  void printAllDrafts() {
    for (var draft in draftList) {
      print(draft.inspectionType);
    }
  }

  @override
  void onInit() async {
    draftList.value = await databaseHelper.getDraftList(
      GetStorage().read('user_email'),
    );

    print(draftList.length);
    for (int i = 0; i < draftList.length; i++) {
      print(draftList[i]);
    }
    super.onInit();
  }
}
