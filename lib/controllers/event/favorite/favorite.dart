import 'package:get/get.dart';
import 'package:remindly_app/models/event/upcoming/upcoming_model.dart';
import 'package:remindly_app/utils/assets_image_path.dart';

import '../../../models/event/favorite/fav_model.dart';

class FavoriteController extends GetxController{

  List<Upcoming> upcomingEventList=<Upcoming>[];

  List<favModel> favList=<favModel>[].obs;



  favModel fModel=favModel();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    addList();
  }

  void addList(){

    upcomingEventList.add(
      Upcoming(
        ImageUrl: AppAssets.workPic,
        heartIcon: AppAssets.heartSelectedPic,
        date: "june 17, 2022",
        type: "monthly Meeting",
      ),

    );
    upcomingEventList.add(
      Upcoming(
        ImageUrl: AppAssets.lecturePic,
        heartIcon: AppAssets.heartSelectedPic,
        date: "May 15, 2022",
        type: "someone Birthday",
      ),

    );
  }


   getImagefav(String? iconName, favModel model) {

    switch (iconName) {
      case "Work":
        {
          fModel.iconUrl = AppAssets.workPic;
          break;
        }
      case "Birthday":
        {
          fModel.iconUrl = AppAssets.cakePic;
          break;
        }
      case "lecture":
        {
          model.iconUrl = AppAssets.lecturePic;
          break;
        }
      case "Anniversary":
        {
          model.iconUrl = AppAssets.weddingPic;
          break;
        }
      case "Lunch / Dinner":
        {
          model.iconUrl = AppAssets.breakFastPic;
          break;
        }
      case "Event":
        {
          model.iconUrl = AppAssets.calenderPic;
          break;
        }
      case "Concert / Party":
        {
          model.iconUrl = AppAssets.concertPic;
          break;
        }
      case "Seminar":
        {
          model.iconUrl = AppAssets.lecturePic;
          break;
        }
    }
  }
}

