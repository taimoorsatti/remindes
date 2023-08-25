import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:remindly_app/screens/ads.dart';
import 'package:remindly_app/screens/event/event_view.dart';
import 'package:remindly_app/screens/login_signup/login/login_view.dart';
import 'package:remindly_app/screens/login_signup/signup/signup_view.dart';
import 'package:remindly_app/screens/onboarding/components/newonboarding.dart';
import 'package:remindly_app/screens/searchevent/searchview.dart';
import 'package:remindly_app/screens/setting/components/changepassword/changepassword.dart';
import 'package:remindly_app/screens/setting/components/editprofile/editprofile.dart';
import 'package:remindly_app/screens/setting/components/privacy_policy/privacy_policy_view.dart';
import 'package:remindly_app/screens/setting/components/subscription/subscription_view.dart';
import 'package:remindly_app/screens/setting/setting_view.dart';

import 'addevent/add_event_view.dart';
import 'myevent/tableclander.dart';
import 'newevent/new_event_view.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case OnboardingScreen.routeName:
        return PageTransition(
          child: OnboardingScreen(),
          type: PageTransitionType.fade,
          settings: settings,
        );


      case EventScreen.routeName:
        return PageTransition(
          child: EventScreen(),
          type: PageTransitionType.fade,
          duration: Duration(microseconds: 2),
          childCurrent:EventScreen(),
          settings: settings,
        );


      case AddEventViewScreen.routeName:
        return PageTransition(
          child: AddEventViewScreen(),
          type: PageTransitionType.fade,
          duration: Duration(microseconds: 2),
          settings: settings,
        );


      case SearchView.routeName:
        return PageTransition(
          child: SearchView(),
          type: PageTransitionType.fade,
          settings: settings,
        );

      case LoginViewScreen.routeName:
        return PageTransition(
          child: LoginViewScreen(),
          type: PageTransitionType.fade,
          settings: settings,
        );

      case SignUpView.routeName:
        return PageTransition(
          child: SignUpView(),
          type: PageTransitionType.fade,
          settings: settings,
        );

      case TableEventsExample.routeName:
        return PageTransition(
          child: TableEventsExample(),
          type: PageTransitionType.fade,

          duration: Duration(microseconds: 2),
          childCurrent:TableEventsExample(),
          settings: settings,
        );

      case SettingView.routeName:
        return PageTransition(
          child: SettingView(),
          duration: Duration(microseconds: 2),
          type: PageTransitionType.fade,


          childCurrent:SettingView(),
          settings: settings,
        );

      case EditProfileScreen.routeName:
        return PageTransition(
          child: EditProfileScreen(),
          type: PageTransitionType.fade,
          settings: settings,
        );
      case ChangePassword.routeName:
        return PageTransition(
          child: ChangePassword(),
          type: PageTransitionType.fade,
          settings: settings,
        );
      case PrivacyPolicyScreen.routeName:
        return PageTransition(
          child: PrivacyPolicyScreen(),
          type: PageTransitionType.fade,
          settings: settings,
        );
      case SubsriptionScreen.routeName:
        return PageTransition(
          child: SubsriptionScreen(),
          type: PageTransitionType.fade,
          settings: settings,
        );
      // case HomeScreen.routeName:
      //   return PageRouteBuilder(
      //       pageBuilder: (context, animation, Animation secondaryAnimation) =>
      //           HomeScreen(),
      //       transitionsBuilder:
      //           (context, animation, secondaryAnimation, child) {
      //         return ScaleTransition(
      //           scale: Tween<double>(
      //             begin: 0.0,
      //             end: 1.0,
      //           ).animate(
      //             CurvedAnimation(
      //               parent: animation,
      //               curve: Curves.fastOutSlowIn,
      //             ),
      //           ),
      //           child: child,
      //         );
      //       });

      //
      // case AddApplePayScreen.routeName:
      // // Validation of correct data type
      //   if (args is PayMethodsModal) {
      //     return MaterialPageRoute(
      //       builder: (_) => AddApplePayScreen(
      //         args: args,
      //       ),
      //     );
      //   }
      //   // If args is not of the correct type, return an error page.
      //   // You can also throw an exception while in development.
      //   return _errorRoute();
      // case RidePersonalProfileScreen.routeName:
      //   return MaterialPageRoute(
      //     builder: (_) => RidePersonalProfileScreen(),
      //   );
      //
      // case EditProfileNameScreen.routeName:
      //   return MaterialPageRoute(
      //     builder: (_) => EditProfileNameScreen(),
      //   );
      //
      // case AddBusinessProfileScreen.routeName:
      //   return MaterialPageRoute(
      //     builder: (_) => AddBusinessProfileScreen(),
      //   );
      //

      //   // If args is not of the correct type, return an error page.
      //   // You can also throw an exception while in development.
      //   return _errorRoute();
      //
      // case PaymentOptionScreen.routeName:
      //   return MaterialPageRoute(
      //     builder: (_) => PaymentOptionScreen(),
      //   );
      //
      // case HelpSupportQuestionAnswerScreen.routeName:
      //   return MaterialPageRoute(
      //     builder: (_) => HelpSupportQuestionAnswerScreen(),
      //   );
      //
      // case ChangePasswordScreen.routeName:
      //   return MaterialPageRoute(
      //     builder: (_) => ChangePasswordScreen(),
      //   );
      //
      // case AddAddressToMylistScreen.routeName:
      // // Validation of correct data type
      //   if (args is AddAddressToMylistScreenArguments) {
      //     return MaterialPageRoute(
      //       builder: (_) => AddAddressToMylistScreen(
      //         arguments: args,
      //       ),
      //     );
      //   }
      //   // If args is not of the correct type, return an error page.
      //   // You can also throw an exception while in development.
      //   return _errorRoute();
      //
      // case LocationFromMapScreen.routeName:
      // // Validation of correct data type
      //   if (args is LocationFromMapScreenArguments) {
      //     return MaterialPageRoute(
      //       builder: (_) => LocationFromMapScreen(
      //         arguments: args,
      //       ),
      //     );
      //   }
      //   // If args is not of the correct type, return an error page.
      //   // You can also throw an exception while in development.
      //   return _errorRoute();
      //
      // case WhereToScreen.routeName:
      // // Validation of correct data type
      //   if (args is WhereToScreenArguments) {
      //     return MaterialPageRoute(
      //       builder: (_) => WhereToScreen(
      //         arguments: args,
      //       ),
      //     );
      //   }
      //   // If args is not of the correct type, return an error page.
      //   // You can also throw an exception while in development.
      //   return _errorRoute();
      //
      // case VehicleInformationScreen.routeName:
      // // Validation of correct data type
      //   if (args is VehicleInformationScreenArguments) {
      //     return MaterialPageRoute(
      //       builder: (_) => VehicleInformationScreen(
      //         arguments: args,
      //       ),
      //     );
      //   }
      //   // If args is not of the correct type, return an error page.
      //   // You can also throw an exception while in development.
      //   return _errorRoute();
      // case RattingScreen.routeName:
      //   return MaterialPageRoute(
      //     builder: (_) => RattingScreen(),
      //   );
      default:
        return _errorRoute();
    }

    /*switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => FirstPage());
      case '/second':
        // Validation of correct data type
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => SecondPage(
              data: args,
            ),
          );
        }
        // If args is not of the correct type, return an error page.
        // You can also throw an exception while in development.
        return _errorRoute();
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }*/
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Error'),
          ),
          body: Center(
            child: Text('ERROR'),
          ),
        ),
      );
    });
  }
}
