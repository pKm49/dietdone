import 'dart:developer';

import 'package:diet_diet_done/auth/sign_up/api/get_area_&_block_service.dart';
import 'package:diet_diet_done/auth/sign_up/model/area_&_block_model.dart';
import 'package:get/get.dart';

class AreaAndBlockController extends GetxController {
  RxList<GetAreaModel> areas = <GetAreaModel>[].obs;
  RxList<GetBlockModel> blocks = <GetBlockModel>[].obs;
  Rx<GetAreaModel> selectedArea =
      GetAreaModel(id: -1, name: '', arabicName: '').obs;
  Rx<GetBlockModel> selectedBlock = GetBlockModel(id: -1, name: '').obs;
  RxInt? areaSelectedToSendBackend;
  RxInt? blockSelectedToSendBackend;
  RxBool isLoading = false.obs;
  @override
  void onInit() async {
    await GetAreaAndBlockAPiServices().fetchArea();
    await GetAreaAndBlockAPiServices().fetchBlock();
    super.onInit();
  }

  Future<void> fetchAreas() async {
    isLoading = true.obs;
    try {
      final fetchedAreas = await GetAreaAndBlockAPiServices().fetchArea();
      areas.value = fetchedAreas;
      log(areas.toString(), name: "areas list");
      selectedArea.value = fetchedAreas.isNotEmpty
          ? fetchedAreas.first
          : GetAreaModel(id: -1, name: 'testing', arabicName: '');
    } catch (e) {
      isLoading = false.obs;

      log("failed to fetch area $e");
    } finally {
      isLoading = false.obs;
    }
    isLoading = false.obs;
  }

  Future<void> fetchBlocks() async {
    try {
      isLoading = true.obs;
      final fetchedBlocks = await GetAreaAndBlockAPiServices().fetchBlock();
      blocks.value = fetchedBlocks;
      log(areas.toString(), name: "block list");

      selectedBlock.value = fetchedBlocks.isNotEmpty
          ? fetchedBlocks.first
          : GetBlockModel(id: -1, name: 'testing');
    } catch (e) {
      isLoading = false.obs;
      log("failed to fetch block $e");
    } finally {
      isLoading = false.obs;
    }
  }
}
