import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../auth.dart';
class LoginPage1 extends StatefulWidget {
  const LoginPage1({Key? key}) : super(key: key);

  @override
  State<LoginPage1> createState() => _LoginPage1State();
}

class _LoginPage1State extends State<LoginPage1> {
  String? errorMessage = '';
  bool isLogin = true;
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try{
      await Auth().signInWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }
  Widget _title() {
    return const Text('Login as Admin');
  }
  Widget _entryField(
      String title,
      TextEditingController controller,
      ) {
    return TextField(
      controller: controller,
      obscureText: true,
      decoration: InputDecoration(
        labelText: title,

      ),
    );
  }
  Widget _entryField1(
      String title,
      TextEditingController controller,
      ) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: title,

      ),
    );
  }
  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : '$errorMessage');
  }
  Widget _submitButton(){
    return ElevatedButton(
      onPressed:
      isLogin ? signInWithEmailAndPassword : createUserWithEmailAndPassword,
      child: Text(isLogin ? 'Login' : 'Register'),
    );
  }
  Widget _loginOrRegisterButton(){
    return TextButton(
      onPressed: (){
        setState(() {
          isLogin = !isLogin;
        });
      },
      child: Text(isLogin ? 'Register instead' : 'Login instead'),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: (){
            Navigator.popUntil(context, ModalRoute.withName('/'));
          },
        ),
        title: _title(),
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                    width:160,
                    height:40,
                    child:ElevatedButton(onPressed: () {
                      Navigator.pushNamed(context, '/widget_tree');
                    }, child: Text('Login as clubhead',
                      style: TextStyle(
                          color: Colors.black
                      ),),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white
                      ),)
                ),
                SizedBox(
                  width:160,
                  height:40,
                  child:ElevatedButton(onPressed: () {
                    Navigator.pushNamed(context, '/widget_tree1');
                  }, child: Text('ADMIN'),
                  ),
                )
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _entryField1('email', _controllerEmail),
                  SizedBox(height: 20),
                  _entryField('password', _controllerPassword),
                  SizedBox(height: 20),
                  _errorMessage(),
                  SizedBox(height: 20),
                  _submitButton(),],),
              // _loginOrRegisterButton(),
            ),
          ],
        ),
      ),
    );
  }
}
