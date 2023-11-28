import 'package:injectable/injectable.dart';

@injectable
class ApiServices {

   static const String BaseURL = "https://identitytoolkit.googleapis.com";
   static const String ServerVersion = "/v1/";

   // WebAPI KEY_Value firebase projects
   static const String WebAPI_KEY_Value = "AIzaSyDSFOpJ7KtAbUVPio-UXJx1SAVX91dH3W8";


   static const String WebAPI_KEY = "key=";
   static const int apiStatusSuccessful = 200;


   // Accounts

   static const String loginPassword = "accounts:signInWithPassword?";
   static const String createAccount = "accounts:signUp?";
   static const String updateProfile = "accounts:update?";
   static const String getProfile = "accounts:lookup?";


//


}