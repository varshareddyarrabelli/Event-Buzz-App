import 'package:eventbuzz/services/database.dart';
import 'package:eventbuzz/widgets/Clubhead_home.dart';
import 'package:eventbuzz/widgets/Clubhome.dart';
import 'package:eventbuzz/widgets/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String selectedType = '';

  // final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Login'),
      //   centerTitle: true,
      //   automaticallyImplyLeading: false,
      // ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
               // color: Colors.blue,
            decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage('https://www.oyorooms.com/blog/wp-content/uploads/2018/02/event.jpg'),
              fit: BoxFit.cover,
            ),
            ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [


                       Padding(
                        padding: const EdgeInsets.fromLTRB(85,20,8,105),
                        child: Text('EventBuzz',
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.white
                          ),),
                      ),

                  ],
                ),
                // height: 20,
              ),
            ),
            Container(
              // color: Colors.green,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 30, 10, 100),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 20.0),
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black,
                                  minimumSize: Size(double.infinity,50),
                                ),
                                icon: FaIcon(FontAwesomeIcons.google,color:Colors.red),
                                label: Text('Sign In With Google'),
                                onPressed: () {
                                  signInWithGoogle();
                                  // final provider =
                                  //     Provider.of<GoogleSignInProvider>(context,listen:false);
                                  // provider.googleLogin();
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.0),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                          ),
                          onPressed: () {

                            Navigator.pushNamed(context, '/widget_tree');
                          },
                          icon: Icon(Icons.login_rounded,
                          color: Colors.black,),
                          label: Text('Login as Head',
                          style: TextStyle(
                            color: Colors.black
                          ),),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  signInWithGoogle() async {
    GoogleSignInAccount? googleUser= await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken
    );
    UserCredential user = await FirebaseAuth.instance.signInWithCredential(credential);
    print(user.user?.displayName);
    // var estring = user.user?.email?.substring(-11);
    var estring = user.user?.email?.endsWith('@nitc.ac.in');
    // if(estring == "@nitc.ac.in") {
    if(estring!) {
      if (user.user != null) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Home(),
        ));
      }
    }
    else
    {
      await GoogleSignIn().signOut();
      FirebaseAuth.instance.signOut();
      // Navigator.of(context).push(MaterialPageRoute(
      //     builder: (context) => LoginScreen()));
    }
  }

}

