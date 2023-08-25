const int timeoutDuration = 60;

const baseURL = 'http://54.226.145.28:3000';


abstract class ApiUrl{
  static const String sendNotification='/send-notification';
  static const String deleteNotification='/cancel-notification/';
  static const String sendEmail='/send-email';

}