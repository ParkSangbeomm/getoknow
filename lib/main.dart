import 'package:flutter/material.dart';
import 'my_info.dart';
import 'organization_info.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

class _MyHomePageState extends State<MyHomePage> {

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
                FirebaseRequest().signInWithGoogle().
                then((result){
                  if(result != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SecondPage()),
                    );
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfilePage()));
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
      await _auth.signInWithCredential(credential);
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
