import 'package:flutter/material.dart';
import 'package:flutter_zlapp/Tool/application/application.dart';
import 'package:flutter_zlapp/Page/Login/login.dart';
class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> with AutomaticKeepAliveClientMixin  {
  //保持状态
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    return new  MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('我的'),
          actions: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 15),
              child: FlatButton(
                  disabledColor: Colors.blue.withOpacity(0.1),  //按钮禁用时的颜色
                  disabledTextColor: Colors.black,     //按钮禁用时的文本颜色
                  textColor:Colors.white,       //文本颜色
                  color: Color(0xff44c5fe),       //按钮的颜色
                  onPressed: (){
                    //退出登录
                   Application.spstance.remove('loginfo');
                   Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (context) => LoginView()), (route) => route == null);
                  },
                  child: Text('退出登录',style: TextStyle(fontSize: 13,),),
            ),),
          ],
        ),
      ),
    );
  }
}