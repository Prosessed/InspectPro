import 'dart:io';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:processed/features/completed/models/completed_inspection_model.dart';
import 'package:processed/features/drafts/models/draft_model.dart';
import 'package:processed/features/inspection/models/ItemModel.dart';
import 'package:processed/features/inspection/models/ReferenceModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;

  static Database? _database;

  // tableName
  String references = 'references';
  String draftTable = 'drafts';
  String completedTable = 'completed';
  String itemTable = 'items';

  // all columns in Drafts table
  String draftId = 'draftId';
  String userId = 'userId';
  String eventId = 'eventId';
  String reportDate = 'reportDate';
  String inspectionType = 'inspectionType';
  String referenceType = 'referenceType';
  String isSystemIntegrated = 'isSystemIntegrated';
  String isDocumentLevel = 'isDocumentLevel';
  String referenceName = 'referenceName';
  String inspectionTemplate = 'inspectionTemplate';
  String itemCode = 'itemCode';
  String serialNo = 'serialNo';
  String batchNo = 'batchNo';
  String sampleSize = 'sampleSize';
  String documentName = 'documentName';
  String moisturePercentage = 'moisturePercentage';
  String sortexPercentage = 'sortexPercentage';
  String brokenPercentage = 'brokenPercentage';
  String doesExportQuality = 'doesExportQuality';
  String noOfLayers = 'noOfLayers';
  String countryNutrition = 'countryNutrition';
  String lengthOfGrain = 'lengthOfGrain';
  String allowancePercentage = 'allowancePercentage';
  String color = 'color';
  String certificate = 'certificate';
  String lengthImageFilePath = 'lengthImageFilePath';
  String riceColourImagePath = 'riceColourImagePath';
  String sortexPercentageImagePath = 'sortexPercentageImagePath';
  String exportQualityImagePath = 'exportQualityImagePath';
  String labelContentPath = 'labelContentPath';
  String moistureContentImagePath = 'moistureContentImagePath';
  String brokenContentImagePath = 'brokenContentImagePath';
  String complicanceContentImagePath = 'complicanceContentImagePath';
  String noOfLayersImagePath = 'noOfLayersImagePath';

  // all columns in Completed table

  String completedInspectionId = 'completedId';
  String inspectionName = 'inspectionName';
  String companyName = 'companyName';
  String reportDateCompleted = 'reportDateCompleted';
  String userIdCompleted = 'userId';
  String completedEventId = 'eventId';
  String inspectionTemplateName = 'inspectionTemplateName';
  String completedItemName = 'completedItemName';
  String completedReportUrl = 'completedReportUrl';

  // all columns in references table

  String type = 'type';
  String data = 'data';

  // all columns in items table

  String itemName = 'item_name';
  String templateName = 'template_name';

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    _databaseHelper ??= DatabaseHelper._createInstance();
    return _databaseHelper!;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}drafts.db';

    var draftsDatabase =
        await openDatabase(path, version: 1, onCreate: createDatabase);

    return draftsDatabase;
  }

  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  void createDatabase(Database db, int newVersion) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $draftTable (

      $draftId INTEGER PRIMARY KEY AUTOINCREMENT,
      $userId TEXT,
      $eventId TEXT,
      $reportDate TEXT,
      $inspectionType TEXT,
      $referenceType TEXT,
      $isSystemIntegrated INTEGER,
      $isDocumentLevel INTEGER,
      $referenceName TEXT,
      $inspectionTemplate TEXT,
      $itemCode TEXT,
      $serialNo TEXT,
      $batchNo TEXT,
      $sampleSize INTEGER,
      $documentName TEXT,
      $moisturePercentage INTEGER,
      $sortexPercentage INTEGER,
      $brokenPercentage INTEGER,
      $doesExportQuality INTEGER,
      $noOfLayers INTEGER,
      $countryNutrition INTEGER,
      $lengthOfGrain INTEGER,
      $allowancePercentage INTEGER,
      $color TEXT,
      $certificate TEXT,
      $lengthImageFilePath TEXT,
      $riceColourImagePath TEXT,
      $sortexPercentageImagePath TEXT,
      $exportQualityImagePath TEXT,
      $labelContentPath TEXT,
      $moistureContentImagePath TEXT,
      $brokenContentImagePath TEXT,
      $complicanceContentImagePath TEXT,
      $noOfLayersImagePath TEXT
    )
  ''');

    await db.execute('''
CREATE TABLE IF NOT EXISTS $completedTable (

  $userIdCompleted TEXT,
  $completedInspectionId INTEGER PRIMARY KEY AUTOINCREMENT,
  $inspectionName TEXT,
  $companyName TEXT,
  $reportDateCompleted TEXT,
  $completedEventId TEXT,
  $inspectionTemplateName TEXT,
  $completedItemName TEXT,
  $completedReportUrl TEXT


    )
  
  ''');

    await db.execute('''
        CREATE TABLE IF NOT EXISTS `$references` (
          `$type` TEXT PRIMARY KEY,
          `$data` TEXT
        )
      ''');

    await db.execute('''
        CREATE TABLE IF NOT EXISTS `$itemTable` (
          `$itemName` TEXT PRIMARY KEY,
          `$templateName` TEXT
        )
      ''');

    print('Database Created');

    // print all values
  }

  // Insert Draft into Database

  Future<int> insertOrUpdateDraft(DraftModel draftModel) async {
    try {
      Database db = await database;

      {
        // If no draft with the same reportDate exists, insert a new one
        var result = await db.insert(draftTable, draftModel.toMap());

        print('Draft Inserted');

        print(draftModel.toMap());

        return result;
      }
    } catch (e) {
      print(e);
      return 0;
    }
  }

  // Get all drafts from database

  Future<List<Map<String, dynamic>>> getDraftMapList(String userId) async {
    try {
      Database db = await database;
      var result =
          await db.query(draftTable, where: 'userId = ?', whereArgs: [userId]);
      print(result);
      return result;
    } catch (e) {
      print(e);
      return [];
    }
  }

  // Get all map list from database and convert to Draft List

  Future<List<DraftModel>> getDraftList(String userId) async {
    var draftMapList = await getDraftMapList(userId);
    int count = draftMapList.length;
    // print('Draft Count: $count');

    List<DraftModel> draftList = <DraftModel>[];
    for (int i = 0; i < count; i++) {
      draftList.add(DraftModel.fromJson(draftMapList[i]));
    }
    return draftList;
  }

  // get draft by draft id

  Future<DraftModel> getDraftById(int draftId) async {
    Database db = await database;

    var result =
        await db.query(draftTable, where: '$draftId = ?', whereArgs: [draftId]);

    print('Draft Fetched by Id ${result[draftId]}');

    return DraftModel.fromJson(result[draftId]);
  }

  // insert completed inspection

  Future<int> insertCompletedInspection(
      CompletedInspection completedInspectionModel) async {
    try {
      // Check if the inspection name is not null
      if (completedInspectionModel.inspectionName != null) {
        Database db = await database;

        // Query to check if a record with the same inspection name already exists
        List<Map<String, dynamic>> existingRows = await db.query(
          completedTable,
          where: '$inspectionName = ?',
          whereArgs: [completedInspectionModel.inspectionName],
        );

        // If no existing record with the same inspection name found, insert the new record
        if (existingRows.isEmpty) {
          var result = await db.insert(
            completedTable,
            completedInspectionModel.toMap(),
          );

          print('Completed Inspection Inserted');
          print(completedInspectionModel.toMap());

          return result;
        } else {
          // Record with the same inspection name already exists
          print(
              'Completed Inspection with the same inspection name already exists');
          return 0;
        }
      } else {
        // Inspection name is null, do not perform the insertion
        print('Inspection name is null, insertion aborted');
        return 0;
      }
    } catch (e) {
      print(e);
      return 0;
    }
  }

  // return

  Future<bool> isEventIdExists(String eventId) async {
    Database db = await database;
    var result = await db
        .query(completedTable, where: 'eventId = ?', whereArgs: [eventId]);
    if (result.isNotEmpty) {
      return true;
    }
    return false;
  }

  // get all completed Inspections map list

  Future<List<Map<String, dynamic>>> getCompletedInspectionMapList(
      String userId) async {
    try {
      Database db = await database;
      var result = await db
          .query(completedTable, where: 'userId = ?', whereArgs: [userId]);
      print(result);
      return result;
    } catch (e) {
      print(e);
      return [];
    }
  }

  // Get all map list from database and convert to Draft List

  Future<List<CompletedInspection>> getAllCompletedInspections(
    String userId,
  ) async {
    var completedInspectionMapList =
        await getCompletedInspectionMapList(userId);
    int count = completedInspectionMapList.length;

    List<CompletedInspection> completedInspectionList = <CompletedInspection>[];
    for (int i = 0; i < count; i++) {
      completedInspectionList
          .add(CompletedInspection.fromMap(completedInspectionMapList[i]));
    }
    return completedInspectionList;
  }

  // update draft with id

  Future<int> updateDraft(DraftModel draftModel) async {
    try {
      Database db = await database;
      var result = await db.update(
        draftTable,
        draftModel.toMap(),
        where: '$draftId = ?',
        whereArgs: [draftModel.draftId],
      );

      print('Draft Updated');
      print(draftModel.toMap());

      return result;
    } catch (e) {
      print(e);
      return 0;
    }
  }

  // delete a draft

  Future<int> deleteDraft(int draftId) async {
    try {
      Database db = await database;
      var result = await db.delete(
        draftTable,
        where: '$draftId = ?',
        whereArgs: [draftId],
      );

      print('Draft Deleted with id $draftId');
      return result;
    } catch (e) {
      print(e);
      return 0;
    }
  }

  Future<void> saveReferencesToDatabase(
      Map<String, RxList<dynamic>> referencesMap) async {
    Database db = await database;

    for (var entry in referencesMap.entries) {
      String type = entry.key;
      List<dynamic> data = entry.value.toList();
      await db.insert(
        references,
        ReferenceModel(type: type, data: data).toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('Reference Inserted');
      print(ReferenceModel(type: type, data: data).toMap());
    }
  }

  Future<List<dynamic>> getReferencesByType(String type) async {
    Database database = await this.database;
    final List<Map<String, dynamic>> maps = await database.query(
      references,
      where: 'type = ?',
      whereArgs: [type],
    );

    if (maps.isEmpty) {
      return []; // Return an empty list if no references found for the provided type
    }

    // Extract the data from the first map as all maps have the same type
    print(
        'Reference Data for $type - ${ReferenceModel.fromMap(maps.first).data}');
    return ReferenceModel.fromMap(maps.first).data;
  }

  // insert an item with its template name
  Future<int> insertItem(ItemModel itemModel) async {
    try {
      Database db = await database;

      // Check if item with the same item_name already exists
      List<Map<String, dynamic>> existingItems = await db.query(
        itemTable,
        where: 'item_name = ?',
        whereArgs: [itemModel.itemName],
      );

      if (existingItems.isEmpty) {
        // Item does not exist, insert it
        var result = await db.insert(itemTable, itemModel.toMap());
        print('Item Inserted');
        print(itemModel.toMap());
        return result;
      } else {
        // Item already exists, do nothing
        print('Item with name ${itemModel.itemName} already exists');
        return -1; // Return -1 to indicate that the item was not inserted
      }
    } catch (e) {
      print(e);
      return 0;
    }
  }

  // check if with given item code exists

  Future<bool> doesItemExistByCode(String itemCode) async {
    final Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      itemTable,
      where: 'item_code = ?',
      whereArgs: [itemCode],
    );
    return result.isNotEmpty;
  }

  // does item exist by name

  Future<bool> doesItemExistByName(String itemName) async {
    final Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      itemTable,
      where: 'item_name = ?',
      whereArgs: [itemName],
    );
    return result.isNotEmpty;
  }

  // get all item names

  Future<List<String>> getAllItemNames() async {
    final Database db = await database;
    final List<Map<String, dynamic>> result =
        await db.query(itemTable, where: 'template_name IS NOT NULL');
    return result.map((e) => e['item_name'].toString()).toList();
  }

  Future<List<String>> getAllInspectionTemplateNames() async {
    final Database db = await database;
    final List<Map<String, dynamic>> result = await db.query(itemTable);
    final List<String> templateNames = result
        .where((e) => e['template_name'] != null)
        .map((e) => e['template_name'].toString())
        .toSet()
        .toList();

    return templateNames;
  }

  // get template based on item name , if not found return null

  Future<String?> getTemplateByItemName(String itemName) async {
    final Database db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      itemTable,
      where: 'item_name = ?',
      whereArgs: [itemName],
    );
    if (result.isEmpty) {
      return null;
    }
    return result.first['template_name'].toString();
  }
}
