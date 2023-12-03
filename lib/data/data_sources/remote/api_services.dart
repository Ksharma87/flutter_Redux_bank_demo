import 'package:injectable/injectable.dart';

@injectable
class ApiServices {

   static const String BaseURL = "https://identitytoolkit.googleapis.com";
   static const String ServerVersion = "/v1/";
   static const String firebase_Database_URL = "https://redux-flutter-bank-default-rtdb.firebaseio.com";

   static const String user_prefix = "/users/";
   static const String accountDetails = "details/";
   static const String identity_prefix = "/identity/";

   // WebAPI KEY_Value firebase projects
   static const String WebAPI_KEY_Value = "AIzaSyDSFOpJ7KtAbUVPio-UXJx1SAVX91dH3W8";


   static const String WebAPI_KEY = "key=";
   static const int apiStatusSuccessful = 200;


   // Accounts

   static const String loginPassword = "accounts:signInWithPassword?";
   static const String createAccount = "accounts:signUp?";
   static const String getProfile = "accounts:lookup?";




//


}