import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:remindly_app/utils/assets_image_path.dart';


class OnboardingController extends GetxController{

  int slideIndex = 0;
  final List<String> imgList = [
    AppAssets.onBoardingCalender,
    AppAssets.onBoardingCouple,
    AppAssets.onBoardingMeeting,

  ];
  final List<String> imgList1 = [
    'Schedule a special event & make every moment count!',
    'Keep your love life on track with our anniversary reminders!',
    'Be prepared for every meeting by scheduling work meetings now!',
  ];
  final List<String> imgList2= [
    '',
    '',
    '',
  ];
}
