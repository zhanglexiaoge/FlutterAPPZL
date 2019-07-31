import 'package:flutter/material.dart';
import 'package:flutter_zlapp/APi/bannerApi.dart';
import 'package:flutter_zlapp/Model/bannerApiModel/banner_model.dart';
import 'package:flutter_zlapp/Model/bannerApiModel/staff_infro_model.dart';
import 'package:flutter_zlapp/Swiper/swiperView.dart';
class ApplicationPage extends StatefulWidget {
  @override
  _ApplicationPageState createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage> {
  String homePageContent='正在获取数据';
  List<BannerModel> bannerList = [];
  List menusList = [];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      _getBannerData();
      _postStaffInfroModel();
    });
  }

   //获取轮播图数据
    void _getBannerData ()async {
      /*轮播图Banner*/
      bannerList = await BannerApi.getInstance().getBannerModelData(context, true);
   }
   //获取个人信息数据
   void _postStaffInfroModel ()async {
     staffInfroModel infroModel =  await BannerApi.getInstance().postSelfInfro(context, true);
     //List rolemenus = infroModel.self.roleMenu;
     //根据权限分组 查看 rolemenus 包含哪些权限
     Map menusGroup =  {"考勤模块":['打卡','请假']};
     menusList.add(menusGroup);
     Map menusSecondGroup = {"办公软件":['思维导图','办公文档','会议','收藏']};
     menusList.add(menusSecondGroup);
     Map menusthreeGroup = {"内部资讯":['他山石','公司文档','公司制度','调查分析']};
     menusList.add(menusthreeGroup);
   }

    // 列表项
  Widget _buildListItem(BuildContext context, int index){
    return ListTile(
      title: Text('list tile index $index')
    );
  }
  // Widget _headerItemWidget(BuildContext context, int index) {
  //    List<BannerModel> listModel = _getBannerData();
  //    return SwiperView(swiperDataList: listModel);
  // }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              child: SwiperView(swiperDataList:bannerList),
            ),
            Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.all(10),
              children: <Widget>[
                //getitem(),
              ],
            ),
          )
          ],
        ),
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return new  MaterialApp(
  //     home: new Scaffold(
  //       appBar: new AppBar(
  //         title: const Text('发现'),
  //       ),
  //       body: new TabBarView(
  //         controller: _tabController,
  //         children: <Widget>[


  //         ],

  //       ),
  //       // body:  FutureBuilder <List<BannerModel>>(
  //       //   future: _getBannerData(),
  //       //   builder: (BuildContext context, AsyncSnapshot<List<BannerModel>> snapshot){
  //       //     return new Column(children: <Widget>[
  //       //               SwiperView(swiperDataList: snapshot.data,)
  //       //             ]);
  //       //   } ,

  //       // )
  //    ),
  //   );
  // }

}

