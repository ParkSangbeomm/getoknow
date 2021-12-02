import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'calendar.dart';
import 'edit_info.dart';
import 'my_info.dart';
import 'organization_info.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'organizationchart.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  Future<void> init() async {
    await Firebase.initializeApp();
  }

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

bool? isNew = true;
class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Init.instance.initialize(),
        builder: (context, AsyncSnapshot snapshot) {
          // Show splash screen while waiting for app resources to load:
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MaterialApp(home: Splash());
          } else {
            return Scaffold(
              backgroundColor:const Color(0xffdfe4ee),
              body: Center(
                // Center is a layout widget. It takes a single child and positions it
                // in the middle of the parent.
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('assets/logo.png',width:MediaQuery.of(context).size.width,),
                    TextButton(
                      onPressed: (){
                        FirebaseRequest().signInWithGoogle().
                        then((result){
                          if(result != null) {
                            if (isNew == true) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SecondPage()),
                              );
                            }
                            else{
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChartPage()),
                              );
                            }
                          }
                        });
                      },
                      child:Text(
                        'Google Login', style: TextStyle(color: Colors.indigoAccent, fontSize: 17, decoration: TextDecoration.underline),),)
                  ],
                ),
              ),
            );
          }
        }
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffdfe4ee),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Image.asset('assets/logo.png',width:MediaQuery.of(context).size.width,),
            TextButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateAccount()));
                },
                child: const Text('Create getoknow chart!', style: TextStyle(color: Colors.indigoAccent, fontSize: 17, decoration: TextDecoration.underline),)),
            SizedBox(height:10),
            TextButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const MyProfilePage()));
                },
                child: const Text('Enter existing getoknow chart!', style: TextStyle(color: Colors.indigoAccent, fontSize: 17, decoration: TextDecoration.underline),)),
          ],
        ),
      ),
    );
  }
}

class FirebaseRequest{
//SIGN WITH GOOGLE
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  FirebaseAuth get auth => _auth;

  Future<User?> signInWithGoogle() async {
    try{
      await _googleSignIn.signOut();
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential authResult =
        await _auth.signInWithCredential(credential);

      if (authResult.additionalUserInfo!.isNewUser) {
        isNew = true;
      }
      else{
        isNew = false;
      }
      print(isNew);

      return _auth.currentUser;
    }on FirebaseAuthException catch (e){
      throw e;
    }
  }

  Future <void> logout() async{
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}

class Init {
  Init._();
  static final instance = Init._();

  Future initialize() async {
    // This is where you can initialize the resources needed by your app while
    // the splash screen is displayed.  Remove the following example because
    // delaying the user experience is a bad design practice!
    await Future.delayed(const Duration(seconds: 4));
  }
}

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:const Color(0xffdfe4ee),
        body: Center(
            child: Image.asset('assets/logo.png', scale: 1.5,)
        )
    );
  }
}
