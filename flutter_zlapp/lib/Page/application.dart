import 'package:flutter/material.dart';
import 'package:flutter_zlapp/APi/bannerApi.dart';
import 'package:flutter_zlapp/Model/bannerApiModel/banner_model.dart';
import 'package:flutter_zlapp/Model/bannerApiModel/staff_infro_model.dart';
import 'package:flutter_zlapp/Swiper/swiperView.dart';
import 'package:flutter_zlapp/Page/cellView/customMenusView.dart';
import 'package:flutter_zlapp/UI/section_view.dart';
import 'package:flutter_zlapp/Tool/Utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_zlapp/Page/applicationPage/sysfile/sysfile.dart';

class ApplicationPage extends StatefulWidget {
  @override
  _ApplicationPageState createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage> {
  String homePageContent = '正在获取数据';
  List<BannerModel> bannerList = [];

  List menusList = [];
  @override
  void initState() {
    super.initState();
    _getBannerData();
    _postStaffInfroModel();
    _getData();
  }

  //获取轮播图数据
  Future<void> _getBannerData() async {
    /*轮播图Banner*/
    List<BannerModel> banner =
        await BannerApi.getInstance().getBannerModelData(context, false);
    setState(() {
      bannerList = banner;
    });
  }
 //获取公司文档
  Future<void> _getData() async {
      await BannerApi.getInstance().getsysfile(context, false,1);
  }
  //获取个人信息数据
  Future<void> _postStaffInfroModel() async {
    staffInfroModel infroModel =
        await BannerApi.getInstance().postSelfInfro(context, false);
    //List rolemenus = infroModel.self.roleMenu;
    //根据权限分组 查看 rolemenus 包含哪些权限

    setState(() {
      List listmenusGroup = [
        {"title": "考勤模块", "icon": "assets/images/menu_punch@2x.png"},
        {"title": "请假", "icon": "assets/images/menu_leave@2x.png"}
      ];
      Map menusGroup = {"title": "考勤模块", "data": listmenusGroup};
      this.menusList.add(menusGroup);
      List listmenusSecondGroup = [
        {"title": "思维导图", "icon": "assets/images/menu_xmind@2x.png"},
        {"title": "办公文档", "icon": "assets/images/menu_hword@2x.png"},
        {"title": "会议", "icon": "assets/images/menu_meeting@2x.png"},
        {"title": "收藏", "icon": "assets/images/menu_collect@2x.png"}
      ];
      Map menusSecondGroup = {"title": "办公软件", "data": listmenusSecondGroup};
      this.menusList.add(menusSecondGroup);
      List listmenusthreeGroup = [
        {"title": "他山石", "icon": "assets/images/menu_punch@2x.png"},
        {"title": "公司文档", "icon": "assets/images/menu_article@2x.png"},
        {"title": "公司制度", "icon": "assets/images/menu_program@2x.png"}
      ];
      Map menusthreeGroup = {"title": "内部资讯", "data": listmenusthreeGroup};
      this.menusList.add(menusthreeGroup);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo'),
      ),
      body: bodyView(),
    );
  }

  Widget bodyView() {
    if (menusList.length == 0 || bannerList.length == 0) {
      return getLoadingWidget();
    } else {
      return ListView(
        physics: const BouncingScrollPhysics(),
        children: _getmeusItem(this.menusList),
      );
    }
  }

  Widget getLoadingWidget(
      {String text: '加载中...', Color bgColor: const Color(0x4b000000)}) {
    return Material(
        /// 透明
        type: MaterialType.transparency,
        /// 保证控件居中显示
        child: Center(
            child: Container(
                width: 60.0,
                height: 60.0,
                decoration: ShapeDecoration(
                    color: bgColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)))),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: Text('', style: TextStyle(fontSize: 12.0)),
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: Text(text, style: TextStyle(fontSize: 12.0)))
                    ]))));
  }

  List<Widget> _getmeusItem(List list) {
    List<Widget> listmeusItem = [];
    listmeusItem.add(SwiperView(swiperDataList: this.bannerList));
    for (var item in list) {
      listmeusItem.add(SectionView(
        item['title'],
        onPressed: () {
          //点击事件
        },
      ));
      listmeusItem.add(Container(
        padding: EdgeInsets.only(left: 30,right: 30,top: 10,bottom: 10),
        color: Colors.white,
        child: Wrap(
          spacing: 30,
          runSpacing: 10,
          children: _getmeusGridView(item['data']),
        ),
      ));
    }
    return listmeusItem;
  }

  List<Widget> _getmeusGridView(List list) {
    List<Widget> listGridView = [];
    for (var item in list) {
      listGridView.add(CustomMenusView(
        iconData: item['icon'],
        title: item['title'],
        onTap: () {
          if (item['title'] == '公司文档') {
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                      return new SysfileWidget();
                    }));
          } else {

          }
        },
      ));
    }
    return listGridView;
  }
}