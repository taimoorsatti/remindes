import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../controllers/checkinternet/checkinternet_controller.dart';
import '../../../../utils/assets_image_path.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/global.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  static const routeName="/privacyPolicy";
   PrivacyPolicyScreen({Key? key}) : super(key: key);
  CheckConnectionStream checkConnectionStream = Get.put(CheckConnectionStream());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 15.0.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h,),
                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    child: Image.asset(AppAssets.backArrowPic, color: Color(0xff36308b),height: 40.h,width: 40.h,),
                  ),
                ),
                SizedBox(height: 20.h,),
                GradientText(
                  "Privacy Policy",
                  style:  TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Quicksand",
                    color: Constant.primaryColor,

                  ),
                  gradient:LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Constant.primaryColor,
                      Constant.secondaryColor,
                    ],
                  ),
                ),
                Html(
                  data: """<p>Thank you for using our Remindes app. We are committed to protecting your privacy and personal information. This privacy policy explains how we collect, use, and disclose your information when you use our app.</p><p><b>Information we collect:</b><br>- Personal information such as your name, email address, and phone number.<br>- Information about your use of our app such as the time and date of your use, the actions you take within the app, and the reminders you create.</p><p><b>How we use your information:</b><br>- To provide and improve our app and services.<br>- To communicate with you about our app and services.<br>- To personalize your experience with our app and services.<br>- To detect and prevent fraud and other illegal activities.<br>- To comply with legal obligations.<br><p><b>Security of Personal Information:</b><br>- We take reasonable measures to protect your information from unauthorized access, use, or disclosure.<br>- We make sure to securely store all your personal information and protect this information against unauthorized access.</p><p><b>User Rights:</b><br>- You can choose not to provide us with certain information, but this may limit your ability to use our app and services.<br>- You can opt out of receiving marketing communications from us at any time by following the instructions in the communication.<br><p><b>Use of Cookies &amp; Tracking Technologies:</b><br>- We may use cookies that allow us to remember your preferences in order to provide you with personalized advertisements.<br>- We use Tracking technologies to analyze how users interact with our app. <br>- This information helps us to improve our services and to better understand our users&rsquo; needs.</p><br><p>Note: You can disable cookies and other tracking technologies in your device settings</p><br><p><b>Changes to this policy:</b><br>- We may update this privacy policy from time to time. We will notify you of any changes by posting the new policy on our app.<br></p>""",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



class TermsUse extends StatelessWidget {
  const TermsUse({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 15.0.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h,),
                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    child: Image.asset(AppAssets.backArrowPic, color: Color(0xff36308b),height: 40.h,width: 40.h,),
                  ),
                ),
                SizedBox(height: 20.h,),
                GradientText(
                  "Terms of use",
                  style:  TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Quicksand",
                    color: Constant.primaryColor,
                  ),
                  gradient:LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Constant.primaryColor,
                      Constant.secondaryColor,
                    ],
                  ),
                ),
                Html(
                  data: "<p><strong>Remindes app</strong> with a subscription helps you stay on top of your schedule. You may subscribe to access additional features. By using this app, you are agreeing to our terms of use. Here are the terms of service for a remindes app:&nbsp;</p><ul><li>We may collect data to improve the app&rsquo;s functionality. We will not share your data with third parties.</li><li>You may cancel your subscription at any time. &nbsp;</li><li>We do not offer refunds for any unused portion of your subscription.</li><li>There is no age limit to use this app. However, it is recommended for ages above 13. &nbsp;</li><li>Community guidelines are applicable, using bots, spam messages, infringing copyrights, and links to inappropriate websites in the feedback section may lead to cancellation of subscription without prior notice or ban from the app as well without explanation.</li><li>Disputes of any sort will be settled in the light of available legal provisions but the company is not liable for settlements within any time limitation.</li><li>The subscription fee may be submitted through <strong>one link</strong> any erroneous act deliberately or otherwise will lead to legal action.</li><li>We reserve the right, in our sole discretion, to make changes or modifications to these Terms of Service at any time and for any reason.</li><li>We will alert you about any changes by updating the 'Last updated' date of these Terms of Service, and you waive any right to receive specific notice of each such change.</li><li>These terms are subject to change. Any change will be notified through an upgraded version of app, installing that will mean accepting new terms of use.</li></ul><p><strong>Users are required to accept and comply with these Terms of Service. You agree that by accessing the app offerings, you have read, understood, and agree to be bound by all of these Terms of Service. Note</strong>: &nbsp;&nbsp;IF YOU DO NOT AGREE WITH ALL OF THESE TERMS OF SERVICE, THEN YOU ARE EXPRESSLY PROHIBITED FROM USING THE APP AND YOU MUST DISCONTINUE USE IMMEDIATELY.</p>",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}