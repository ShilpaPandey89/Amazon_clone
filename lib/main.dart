import 'package:flutter/material.dart';
import 'layout/screen_layout.dart';
import 'providers/user_details_provider.dart';
import 'screens/sign_in_screen.dart';
import 'utils/color_themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'dart:io' show Platform;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyADBr879w4U7R7lWe_NZjoeELTa4JhYGo0",
            authDomain: "clone-d3eee.firebaseapp.com",
            projectId: "clone-d3eee",
            storageBucket: "clone-d3eee.appspot.com",
            messagingSenderId: "715477373463",
            appId: "1:715477373463:web:d1ec0a9a8d9293f3df0252",
            measurementId: "G-16RWLTWDK2"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const AmazonClone());
}

// void main() async {
//   //hello
//     WidgetsFlutterBinding.ensureInitialized();
//     Platform.isAndroid?
//     await Firebase.initializeApp(
//         options: const FirebaseOptions(
//             apiKey: "AIzaSyADBr879w4U7R7lWe_NZjoeELTa4JhYGo0",
//             authDomain: "clone-d3eee.firebaseapp.com",
//             projectId: "clone-d3eee",
//             storageBucket: "clone-d3eee.appspot.com",
//             messagingSenderId: "715477373463",
//             appId: "1:715477373463:web:d1ec0a9a8d9293f3df0252",
//             measurementId: "G-16RWLTWDK2",
//          ),
//    )
//    : await Firebase.initializeApp();
//     runApp(const AmazonClone());
// }





class AmazonClone extends StatelessWidget {
  const AmazonClone({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UserDetailsProvider())],
      child: MaterialApp(
        title: "Amazon Clone",
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: backgroundColor,
        ),
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, AsyncSnapshot<User?> user) {
              if (user.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.orange,
                  ),
                );
              } else if (user.hasData) {
                return const ScreenLayout();
              } else {
                return const SignInScreen();
              }
            }),
      ),
    );
  }
}



