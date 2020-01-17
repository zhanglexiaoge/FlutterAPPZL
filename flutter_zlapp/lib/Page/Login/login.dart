import 'package:flutter/material.dart';
import 'package:flutter_zlapp/Config/serviceUrl.dart';
import 'dart:ui';
import 'package:flutter_zlapp/Tool/timerUtil.dart';
import 'package:flutter_zlapp/Tool/HTTP/HttpUtil.dart';
import 'package:flutter_zlapp/Model/provider/userModel.dart';
import 'package:provider/provider.dart';
import 'package:flutter_zlapp/Tool/CustomDialog/LoadingDialog.dart';
import 'package:flutter_zlapp/Tool/application/application.dart';
import 'package:flutter_zlapp/Router/routes.dart';
import 'package:flutter_zlapp/Tool/objectisEmpty.dart';
import 'package:flutter/foundation.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:flutter_zlapp/Tool/toastUtil.dart';


class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  //controller常用于赋值和取值操作
  TextEditingController _usernameEtController = TextEditingController();
  TextEditingController _passwordEtController = TextEditingController();
  TextEditingController _verifyEtController = TextEditingController();

  FocusNode usernameFocusNode = new FocusNode();
  FocusNode passwordFocusNode = new FocusNode();
  FocusNode verifyFocusNode = new FocusNode();

  var _isShowClear = false;//密码是否显示输入框尾部的清除按钮

  bool isButtonEnable = true;  //按钮状态 是否可点击
  String buttonText ='验证码'; //初始文本
  TimerUtil timerCountDown;

  bool isLoginEnable = false;  //登录按钮状态 是否可点击

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //监听输入改变
    _usernameEtController.addListener(_verify);
    _passwordEtController.addListener(_verify);
    _verifyEtController.addListener(_verify);

  }

  void _verify() {
    String name =  _usernameEtController.text;
    String passwordStr = _passwordEtController.text;
    String verifyStr = _verifyEtController.text;
    bool isClick = false;
    if(!ObjectUtil.isEmptyString(name) && !ObjectUtil.isEmptyString(passwordStr)  && !ObjectUtil.isEmptyString(verifyStr)) {
      isClick = true;
    }else {
      isClick = false;
    }
    /// 状态不一样在刷新，避免重复不必要的setState
    if (isClick != isLoginEnable) {
      setState(() {
        isLoginEnable = isClick;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // 移除焦点监听
    _usernameEtController.dispose();
    _passwordEtController.dispose();
    _verifyEtController.dispose();
    super.dispose();
  }
 //ios FormKeyboardActions第一次关闭 项目是在 最外层包裹一层，点击的时候进行关闭，
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  defaultTargetPlatform == TargetPlatform.iOS ? FormKeyboardActions(
        child: _buildBody(),
      ) : SingleChildScrollView(
        child: _buildBody(),
      ),
    );
  }

  _buildBody() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: Application.screenHeight <= 667 ? 80 : 106 ),
          child: loginIconImage(),
        ),
        Padding(
          padding: EdgeInsets.only(top: Application.screenHeight <= 667 ? 40 : 55, left: 25, right: 25),
          child: userNameTextField(),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 25, right: 25),
          child: passWordTextField(),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 25),
                child: verifyTextField(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 15),
              child: sendverifyButton(),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15, left: 25, right: 25),
          child: Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              Expanded(
                flex: 1,
                //child: loginButton(),
                child: Consumer<UserModel>(
                  builder: (BuildContext context, UserModel value, Widget child) {
                    return  FlatButton(
                      disabledColor: Colors.blue.withOpacity(0.1),  //按钮禁用时的颜色
                      disabledTextColor: Colors.black,     //按钮禁用时的文本颜色
                      textColor:isLoginEnable?Colors.white:Colors.black.withOpacity(0.2),       //文本颜色
                      color: isLoginEnable ?Color(0xff44c5fe):Colors.grey.withOpacity(0.1),       //按钮的颜色
                      splashColor: isLoginEnable?Colors.white.withOpacity(0.1):Colors.transparent,
                      shape: StadiumBorder(side: BorderSide.none),
                      onPressed: (){
                        usernameFocusNode.unfocus();
                        passwordFocusNode.unfocus();
                        verifyFocusNode.unfocus();
                        loginAction(context,value);
                      },
                      child: Text('登录',style: TextStyle(fontSize: 13,),),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );

  }

  Image loginIconImage() {
    return Image(
        image: AssetImage('assets/images/login_icon@2x.png'),
        width: 113.0,
        height: 113.0);
  }
  TextField userNameTextField() {
    return new TextField(
        controller: _usernameEtController,
        maxLines:1,
        obscureText: false,
        enableInteractiveSelection: false, //长按是否出现【剪切/复制/粘贴】菜单
        keyboardType: TextInputType.text, //键盘类型
        textInputAction: TextInputAction.done, //通常为键盘右下角操作类型
        autofocus: false,//是否自动获取焦点，进入页面优先获取焦点，并弹出键盘
        focusNode: usernameFocusNode, //focusNode 手动获取焦点，可配合键盘输入等减少用户操作次数，直接获取下一个 TextField 焦点；
        onSubmitted: (input) {
          usernameFocusNode.unfocus();
          FocusScope.of(context).requestFocus(passwordFocusNode);
        },
        enabled: true, //enabled 设为 false 之后 TextField 为不可编辑状态；
        //decoration 为边框修饰，可以借此来调整 TextField 展示效果；可以设置前置图标，后置图片，边框属性，内容属性等，会在后续集中尝试；若要完全删除装饰，将 decoration 设置为空即可
        decoration:InputDecoration(
          icon:new Image.asset('assets/images/login_icon_id@2x.png',width: 20, height: 20),
          hintText: "用户名",
            enabledBorder: UnderlineInputBorder(
              /*边角*/
              borderRadius: BorderRadius.all(
                Radius.circular(5), //边角为5
              ),
              borderSide: BorderSide(
                color: Colors.grey, //边线颜色
                width: 0.5, //边线宽度
              ),
            ),
        ),
    );
  }

  TextField passWordTextField() {
    return new TextField(
      controller: _passwordEtController,
      maxLines:1,
      obscureText: true, //隐藏输入内容
      enableInteractiveSelection: false, //长按是否出现【剪切/复制/粘贴】菜单
      keyboardType: TextInputType.text, //键盘类型
      textInputAction: TextInputAction.done, //通常为键盘右下角操作类型
      autofocus: false,//是否自动获取焦点，进入页面优先获取焦点，并弹出键盘
      focusNode: passwordFocusNode, //focusNode 手动获取焦点，可配合键盘输入等减少用户操作次数，直接获取下一个 TextField 焦点；
      onSubmitted: (input) {
        passwordFocusNode.unfocus();
        FocusScope.of(context).requestFocus(verifyFocusNode);
      },
      enabled: true, //enabled 设为 false 之后 TextField 为不可编辑状态；
      //decoration 为边框修饰，可以借此来调整 TextField 展示效果；可以设置前置图标，后置图片，边框属性，内容属性等，会在后续集中尝试；若要完全删除装饰，将 decoration 设置为空即可
      decoration:InputDecoration(
        icon:new Image.asset('assets/images/login_icon_password@2x.png',width: 20, height: 20),
        hintText: "请输入密码",
 //       errorText: "密码不正确",//错误提示信息，如果该属性不为null的话，labelText失效。
        //未选中
        enabledBorder: UnderlineInputBorder(
          /*边角*/
          borderRadius: BorderRadius.all(
            Radius.circular(5), //边角为5
          ),
          borderSide: BorderSide(
            color: Colors.grey, //边线颜色
            width: 0.5, //边线宽度
          ),
        ),
          suffixIcon: new Container(
            width: 20.0,
            height: 20.0,
            child: new IconButton(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(0.0),
              iconSize: 18.0,
              icon: Icon(Icons.cancel),
              onPressed: () {
                setState(() {
                  _passwordEtController.text = '';
                });
              },
            ),
          ),
      ),
    );
  }

  /*发送验证码button */
  Widget sendverifyButton() {
    return FlatButton(
      disabledColor: Colors.grey.withOpacity(0.1),  //按钮禁用时的颜色
      disabledTextColor: Colors.white,     //按钮禁用时的文本颜色
      textColor:isButtonEnable?Colors.white:Colors.black.withOpacity(0.2),       //文本颜色
      color: isButtonEnable?Color(0xff44c5fe):Colors.grey.withOpacity(0.1),       //按钮的颜色
      splashColor: isButtonEnable?Colors.white.withOpacity(0.1):Colors.transparent,
      shape: StadiumBorder(side: BorderSide.none),
      onPressed: (){
        _buttonClickverify();
      },
      child: Text('$buttonText',style: TextStyle(fontSize: 13,),),
    );
  }

  void _buttonClickverify(){
    _initTimer();
    sendSmsAction();
  }
  //初始化定时器
  void _initTimer() {
    timerCountDown = new TimerUtil(mInterval: 1000, mTotalTime: 60 * 1000);
    timerCountDown.setOnTimerTickCallback((int value) {
      double count = (value / 1000);
      int tick =  count.toInt();
      //NSLog.e("CountDown: " + tick.toString());
      setState(() {
        if(tick == 0) {
          if (timerCountDown != null)
            timerCountDown.cancel(); //dispose() //销毁计时器
          isButtonEnable=true;  //按钮可点击
          buttonText='发送验证码';  //重置按钮文本
        }else {
          buttonText='重新发送($tick)'; //更新文本内容
        }
      });
    });
    timerCountDown.startCountDown();
  }


  TextField verifyTextField() {
    return new TextField(
      controller: _verifyEtController,
      maxLines:1,
      enableInteractiveSelection: false, //长按是否出现【剪切/复制/粘贴】菜单
      keyboardType: TextInputType.number, //键盘类型
      textInputAction: TextInputAction.done, //通常为键盘右下角操作类型
      autofocus: false,//是否自动获取焦点，进入页面优先获取焦点，并弹出键盘
      focusNode: verifyFocusNode, //focusNode 手动获取焦点，可配合键盘输入等减少用户操作次数，直接获取下一个 TextField 焦点；
      decoration:InputDecoration(
        icon:new Image.asset('assets/images/verification_code@2x.png',width: 20, height: 20),
        hintText: "请输入验证码",
//        errorText: "验证码不正确",//错误提示信息，如果该属性不为null的话，labelText失效。
        //未选中
        enabledBorder: UnderlineInputBorder(
          /*边角*/
          borderRadius: BorderRadius.all(
            Radius.circular(5), //边角为5
          ),
          borderSide: BorderSide(
            color: Colors.grey, //边线颜色
            width: 0.5, //边线宽度
          ),
        ),
      ),
    );
  }


  Future<void> loginAction( BuildContext context, UserModel value ) async {
    Loading.showLoading(context);
    String name =  _usernameEtController.text;
    String passwordStr = _passwordEtController.text;
    String verifyStr = _passwordEtController.text;
    value.login(context, name, passwordStr, verifyStr).then((loginModel) {
      Loading.hideLoading(context);
      if(value != null){
        //Provider.of<PlayListModel>(context).user = value;
        //NavigatorUtil.goHomePage(context);
        //Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (context) => TabarWidget()), (route) => route == null);
        Application.router.navigateTo(context, Routes.tabbarpage,clearStack: true);
      }
    },onError: (error) {
      Loading.hideLoading(context);
    });
  }

  Future<void> sendSmsAction() async {
    String name =  _usernameEtController.text;
    String passwordStr = _passwordEtController.text;
    Map<String, dynamic> params = {"username": name,"password":passwordStr};
    HttpUtil.instance.post(sendSms,params: params).then((data) {
      print('data: ' + data.toString());
    },onError: (error){
      ToastUtil.text(error);
    });
  }

}

