import 'package:flutter/material.dart';
import 'Tabar/tabar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_zlapp/Page/Login/login.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    _validateLogin().then((v){
//       if(v == false) {
//         Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (context) => LoginView()), (route) => route == null);
//       }
//    });

    return MaterialApp(
      home: TabarWidget(),
    );
  }

//  Future <bool>_validateLogin() async{
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    String token = prefs.getString('token');
//    print('token ===' + token);
//    if(token == null) {
//      return true;
//    }else {
//      return false;
//    }
//  }

}


