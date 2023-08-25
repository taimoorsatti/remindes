import 'package:remindly_app/utils/assets_image_path.dart';

class OnboardingContents {
  final String title;
  final String image;


  OnboardingContents({
    required this.title,
    required this.image,
  });
}

List<OnboardingContents> contents = [
  OnboardingContents(
    title: "Schedule a special event & make every moment count!",
    image: AppAssets.onBoardingCalender,
  ),
  OnboardingContents(
    title: "'Keep your love life on track with our anniversary reminders!'",
    image: AppAssets.onBoardingCouple,
  ),
  OnboardingContents(
    title: "Be prepared for every meeting by scheduling work meetings now!",
    image: AppAssets.onBoardingMeeting,
  ),
];
