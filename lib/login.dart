
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'create_account.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class UserManagement {
  storeNewUser(user, context) {
    Firestore.instance.collection('users').document(user.uid).setData({
      'email': user.email==null? "anonymous":user.email,
      'uid': user.uid,
      'url': user.email==null
    }).then((value) {
      Navigator.of(context).pop();
    }).catchError((e) {
      print(e);
    });
  }
}


class LoginPage extends StatefulWidget {
  static const routeName = '/loginScreen';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> _handleSignIn() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final FirebaseUser currentUser = await _auth.currentUser();
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
    print("signed in " + user.displayName);
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: new EdgeInsets.symmetric(vertical: 160.0),
        child :
        SafeArea(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 80.0),
                    Column(
                      children: <Widget>[
                        //Image.asset('assets/diamond.png'),
                        SizedBox(height: 16.0),
                        Text('HandongSam'),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child : Container(
                  padding: EdgeInsets.all(30.0),
                  child: MakeTextFieldList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MakeTextFieldList extends StatefulWidget{

  @override
  MakeTextFieldListState createState(){
    return MakeTextFieldListState();
  }
}

class MakeTextFieldListState extends State<MakeTextFieldList>{
  String id = "";
  String pw = "";
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();
  Widget build(BuildContext context){
    return ListView(
      children: <Widget>[
        _makeText(context, 'ID',false ,_idController, TextInputType.text, id),
        _makeText(context,'Password', false, _passwordController,TextInputType.number, pw),
        Row(
          children: <Widget>[
            SizedBox(width: MediaQuery.of(context).size.width/2.7),
            FlatButton(
              child: Text('SiGN IN'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(width: 20.0),
            FlatButton(
              child: Text('SiGN UP', style:TextStyle(color:Colors.blueAccent)),
              onPressed: () {
                Navigator.pushNamed(context, CreateAccount.routeName);
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _makeText(BuildContext context, String label, bool flag, TextEditingController controllers, keyboardTypeThis, globalValue){
    return Row(
      children: <Widget>[
        Expanded(
          child:_makeTextField(context,label,false ,controllers, TextInputType.text, globalValue),
        ),
      ],
    );
  }

  TextFormField _makeTextField(BuildContext context, String label, bool flag, TextEditingController controllers, keyboardTypeThis, globalValue) {
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter ' + label;
        }
        return null;
      },
      keyboardType: keyboardTypeThis,
      controller: controllers,
      obscureText: flag,
      decoration: InputDecoration(
        filled: false,
        labelText: label,
      ),
    );
  }
}