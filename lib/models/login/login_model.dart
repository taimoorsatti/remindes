// ignore: camel_case_types
class currentUser{
   String? userID;
   String? name;
   String? email;
   String? fcmToken;
   String? isActive;
   String? platform;


   currentUser({this.name,this.email,this.fcmToken,this.isActive,this.platform,this.userID});


   currentUser.fromJson(Map<String, dynamic> map) {
     userID=map["userID"];
     name=map["name"];
     email=map["email"];
     fcmToken=map["fcmToken"];
     isActive=map["isActive"];
     platform=map["platform"];


}}