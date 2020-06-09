import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'const.dart';
import 'dao/users_dao.dart';
import 'model/user.dart';
import 'home.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Global setting here.
    Firestore.instance.settings(timestampsInSnapshotsEnabled: true);
    return MaterialApp(
      title: 'My Chat',
      theme: ThemeData(
        primaryColor: themeColor,
      ),
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  final String title;

  LoginScreen({Key key, this.title}) : super(key: key);

  @override
  LoginScreenState createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  SharedPreferences _sharedPreferences;
  bool _isLoading = false;
  bool _isLoggedIn = false;
  User _currentUser;

  @override
  void initState() {
    super.initState();
    _isSignedIn();
  }

  Widget _buildMainPage() {
    String id = _sharedPreferences.getString('id');
    return MainScreen(userId: id);
  }

  void _isSignedIn() async {
    this.setState(() {
      _isLoading = true;
    });
    _sharedPreferences = await SharedPreferences.getInstance();
    _isLoggedIn = await _googleSignIn.isSignedIn();

    if (_isLoggedIn) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => _buildMainPage()));
    }

    this.setState(() {
      _isLoading = false;
    });
  }

  Future<Null> handleSignIn() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    this.setState(() {
      _isLoading = true;
    });

    try {
      final GoogleSignInAccount googleSignInAccount = await _googleSignIn
          .signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      FirebaseUser firebaseUser = await _firebaseAuth.signInWithCredential(credential);

      if (firebaseUser != null) {
        User clientUser = await userDaoGetUser(firebaseUser.uid);
        if (clientUser == null) {
          clientUser = User(
              id: firebaseUser.uid,
              nickname: firebaseUser.displayName,
              photoUrl: firebaseUser.photoUrl,
              aboutMe: '');
          userDaoAddUser(clientUser);
          _currentUser = clientUser;
        }
        await _sharedPreferences.setString('id', clientUser.id);
        await _sharedPreferences.setString('nickname', clientUser.nickname);
        await _sharedPreferences.setString('photoUrl', clientUser.photoUrl);
        await _sharedPreferences.setString('aboutMe', clientUser.aboutMe);

//        Fluttertoast.showToast(msg: 'Sign in success');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => _buildMainPage()));
      } else {
//        Fluttertoast.showToast(msg: 'Sign in fail');
      }
    } catch (e) {}

    this.setState(() {
      this._isLoading = false;
    });
  }

  Future<Null> handleFacebookSignIn() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    this.setState(() {
      _isLoading = true;
    });

    try {
      final facebookLogin = FacebookLogin();
      facebookLogin.loginBehavior = FacebookLoginBehavior.webViewOnly;
      final result = await facebookLogin.logInWithReadPermissions(['email', 'public_profile']);
      var token;
      switch (result.status) {
        case FacebookLoginStatus.loggedIn:
          token = result.accessToken.token;
          break;
        default:
          token = null;
          break;
      }
      if (token != null) {
        AuthCredential facebookAuthCredential = FacebookAuthProvider.getCredential(accessToken: token);
        FirebaseUser firebaseUser = await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
        if (firebaseUser != null) {
          User clientUser = await userDaoGetUser(firebaseUser.uid);
          if (clientUser == null) {
            clientUser = User(
                id: firebaseUser.uid,
                nickname: firebaseUser.displayName,
                photoUrl: firebaseUser.photoUrl,
                aboutMe: '');
            userDaoAddUser(clientUser);
            _currentUser = clientUser;
          }

          await _sharedPreferences.setString('id', clientUser.id);
          await _sharedPreferences.setString('nickname', clientUser.nickname);
          await _sharedPreferences.setString('photoUrl', clientUser.photoUrl);
          await _sharedPreferences.setString('aboutMe', clientUser.aboutMe);

          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => _buildMainPage()));
        } else {}
      }
    } catch (e) {}

    this.setState(() {
      this._isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: Column(
              children: <Widget>[
                FlatButton(
                  onPressed: handleSignIn,
                  child: Text(
                    'Sing in with Google',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  color: Color(0xffdd4b39),
                  highlightColor: Color(0xffff7f7f),
                  splashColor: Colors.transparent,
                  textColor: Colors.white,
                  padding: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0),
                ),
                FlatButton(
                  onPressed: handleFacebookSignIn,
                  child: Text(
                    'Sing in with Facbook',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  color: Color(0xffdd4b39),
                  highlightColor: Color(0xffff7f7f),
                  splashColor: Colors.transparent,
                  textColor: Colors.white,
                  padding: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0),
                ),
              ],
            ),
          ),
          Positioned(
              child: _isLoading
                  ? Container(
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(themeColor),
                  ),
                ),
              )
                  : Container()),
        ],
      ),
    );
  }
}
