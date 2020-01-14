import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zlapp/Tool/HTTP/HttpUtil.dart';
import 'package:flutter_zlapp/Config/serviceUrl.dart';
import 'package:flutter_zlapp/Model/Home/home_model_entity.dart';
import 'package:flutter_zlapp/Page/Widget/cachedImage.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_zlapp/Tool/colors.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_zlapp/Page/Home/electricity.dart';
import 'package:flutter_zlapp/Page/Home/oneApp.dart';
import 'package:flutter_zlapp/Tool/CustomDialog/LoadingDialog.dart';
import 'package:flutter_zlapp/Tool/application/application.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin  {
  //保持状态
  bool get wantKeepAlive => true;
  List <HomeModelBannerlist>bannerList = []; //轮播图列表
  List <HomeModelLocalnavlist>localNavList = []; //local导航
  HomeModelGridnav gridNavList; //grid导航
  List <HomeModelSubnavlist> subNavList = []; //导航
  HomeModelSalesbox salesboxModel; //活动
  String city = '上海市';
  HomeModelEntity homeModel;
  //瀑布流 数据
  List staggeredList = [];


  final RefreshController _refreshController = RefreshController(
      initialRefresh: true);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future <void> getHomeData() async {
    Loading.showLoading(context);
    //'http://www.devio.org/io/flutter_app/json/home_page.json',
    HttpUtil.instance.get('/io/flutter_app/json/home_page.json',
        customBaseUrl: 'https://www.devio.org').then((data) {
          Loading.hideLoading(context);
      homeModel = HomeModelEntity.fromJson(data);
      //加载数据
      for (int i = 0;i < 20; i ++) {
        staggeredList.add(i);
      }
      updateData(homeModel);
    },onError: (error){
    });
  }

  void updateData(HomeModelEntity homeModel) {
    bannerList.addAll(homeModel.bannerList);
    localNavList.addAll(homeModel.localNavList);
    gridNavList = homeModel.gridNav;
    subNavList.addAll(homeModel.subNavList);
    salesboxModel = homeModel.salesBox;
    setState(() {

    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshConfiguration(
          child: SmartRefresher(
            header: WaterDropMaterialHeader(
              backgroundColor: Colors.pink,
              offset: MediaQuery.of(context).padding.top + 15.0,
            ),
            child: CustomScrollView(
                physics: ClampingScrollPhysics(),
                slivers: <Widget>[
                  SliverAppBar(
                    title: Text('首页'),
                    backgroundColor: Colors.pink,
                    floating: true,
                    snap: false,
                    pinned: true,
                    actions: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 15),
                        child: Icon(Icons.add),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 15),
                        child: Icon(Icons.keyboard_voice),
                      ),
                    ],
                    leading:Icon(Icons.supervised_user_circle),
//                    leading: Padding(
//                        padding: EdgeInsets.only(left: 15,right: 15),
//                        child: Row(
//                          children: <Widget>[
//                            Icon(Icons.supervised_user_circle),
//                            Text('上海'),
//                          ],
//                        ),
//                    ),
                  ),
                  // 如果不是Sliver家族的Widget，需要使用SliverToBoxAdapter做层包裹
                  SliverToBoxAdapter(
                    child:_headerMenus(context) ,
                  ),
                  SliverToBoxAdapter(
                    child:_headerview(context) ,
                  ),
                  SliverToBoxAdapter(
                    child:_headerBottoMenus(context) ,
                  ),
                  new SliverStaggeredGrid.count(
                    crossAxisCount: 4,
                    mainAxisSpacing: 4.0,
                    crossAxisSpacing: 4.0,
                    children: _getStaggeredList(context),
                    staggeredTiles: _staggeredTileList(context),
                  )
                ],
            ),
            controller: _refreshController,
            enablePullUp: true,
            onRefresh: () async {
              //monitor fetch data from network
              await Future.delayed(Duration(milliseconds: 1000));
              //if (mounted) setState(() {});
              //刷新数据
              bannerList.clear();
              localNavList.clear();
              gridNavList = null;
              subNavList.clear();
              salesboxModel = null;
              homeModel = null;
              staggeredList.clear();
              getHomeData();
              setState(() {});
              _refreshController.refreshCompleted();
            },
            onLoading: () async {
              //monitor fetch data from network
              await Future.delayed(Duration(milliseconds: 1000));
              // if (mounted) setState(() {});
              //加载数据
              for (int i = 0;i < 20; i ++) {
                staggeredList.add(i);
              }
              setState(() {});
              _refreshController.loadComplete();
            },
          ),
      ),
    );
  }

  List<Widget>_getStaggeredList (BuildContext context) {
    List<Widget> _list = [];
    staggeredList.forEach((title){
      _list.add(_getStaggeredItem(context));
    });
    return _list;
  }
  List<StaggeredTile>_staggeredTileList (BuildContext context) {
    List<StaggeredTile> _list = [];
    for (int i = 0;i < staggeredList.length; i ++) {
      _list.add(StaggeredTile.count(2, i.isEven ? 2 : 1));
    }
    return _list;
  }
  Widget _getStaggeredItem(BuildContext context ) {
    return new GestureDetector(
      onTap: (){

      },
      child: new Container(
        width: 80,
        height: 150,
        color: Color(0xFF2FC77D), //Colors.blueAccent,
        child: CachedImage(
          imageUrl: 'https://p0.meituan.net/msmerchant/a2882e0d3554785e27c7e7b3c99038f88269514.jpg@736w_416h_1e_1c',
          fit: BoxFit.fill,
        ),
        ),
    );
  }
  Widget _getSliverGrid(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 15,top: 10)
    );
  }
  Widget _headerBottoMenus(BuildContext context){
    List<Widget> items = [];
    List menus  = ['商城','电影/演出','酒店','美食'];
    menus.forEach((menustring){
      items.add(_itemMenus(context, menustring,'https://s0.meituan.net/bs/fe-web-meituan/fa5f0f0/img/logo.png'));
    });
    return Padding(
      padding: EdgeInsets.only(left: 15,top: 10,right: 15,bottom: 10),
      child: Row(
        children: items.sublist(0, items.length),
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
    );
  }



  Widget _headerview(BuildContext context){
    return Column(
      children: <Widget>[
        _banner(context),
        SubNav(subNavList: subNavList,),
        SalesBoxWidget(salesboxModelData: salesboxModel,),
      ],
    );
  }

  /*扫一扫*/
  Widget _headerMenus(BuildContext context) {
    List<Widget> items = [];
    List menus  = ['OneApp','详情页面','红包/卡券','骑车'];
    menus.forEach((menustring){
      items.add(_itemMenus(context, menustring,'https://s0.meituan.net/bs/fe-web-meituan/fa5f0f0/img/logo.png'));
    });
    return Padding(
      padding: EdgeInsets.only(left: 15,top: 10,right: 15,bottom: 10),
      child: Row(
        children: items.sublist(0, items.length),
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
    );

  }

  Widget _itemMenus(BuildContext context,String title ,String urlIcon) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          if(title == '商城') {
            //跳转商城界面
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ElectricityPage(),
                ));
          }else if(title == 'OneApp') {
            //跳转商城界面
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OneAppPage(),
                ));
          }else if(title == '详情页面') {
            //详情页面
            String message = "json1222";
            String hexCode = "#FFFFFF";
            String result = "1111111";
            //*********参数不能包含中文
            String route = "/detail?message=$message&color_hex=$hexCode";
            if (result != null) {
              route = "$route&result=$result";
            }
            print('route >>>>>>' + route);
            Application.router.navigateTo(context, route).then((jsonStr){
               print('>>>>>>  ' + jsonStr);
            });

          }
        },
        child: Column(
          children: <Widget>[
            Image.network(
              urlIcon,
              width: 18.0,
              height: 18.0,
            ),
            Padding(
              padding: EdgeInsets.only(top: 3.0),
              child: Text(
                title,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 12,color: Colours.text_dark,decoration: TextDecoration.none),
              ),
            )
          ],
        ),
      ),
    );
  }

  /*banner轮播图*/
  Widget  _banner(BuildContext context) {
    if (bannerList.length > 0) {
      return Container(
          height: 160.0,
          child: Swiper(
        itemBuilder: (BuildContext context, int index){
          return CachedImage(
            imageUrl: bannerList[index].icon,
            fit: BoxFit.fill,
          );
        },
        pagination: new SwiperPagination(
          builder: DotSwiperPaginationBuilder(
              color: Colors.white,
              activeColor: Colors.blue,
              size: 5.0,
              activeSize: 5.0),
        ),
        itemCount: bannerList.length,
        autoplay: true,
      ) ,
      );
    }else {
      return Container(
          height: 160.0,
      );
    }
  }
}




class GirderNav extends StatelessWidget{
  final HomeModelGridnav gridnavModel;
  const GirderNav({Key key, this.gridnavModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration( //BoxDecoration类提供了多种绘制盒子的方法。这个盒子有边框、主体、阴影组成。
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(5),
          child:_items(context),
        ),
      ),
    );
  }


  _items(BuildContext context){
    if(gridnavModel == null) return null;
    List<Widget> itemsWidget = [];
    List<HomeModelGridnavHotel> modelList= [];
    HomeModelGridnavFlight flightModel = gridnavModel.flight;
    HomeModelGridnavHotel hotelModel = gridnavModel.hotel;
    HomeModelGridnavTravel travelModel = gridnavModel.travel;
    HomeModelGridnavHotel hotelFlight =  HomeModelGridnavHotel.fromJson(flightModel.toJson());
    HomeModelGridnavHotel hotelTravel =  HomeModelGridnavHotel.fromJson(travelModel.toJson());
    modelList.add(hotelModel,);
    modelList.add(hotelFlight);
    modelList.add(hotelTravel);
    modelList.forEach((model) {
      itemsWidget.add(_getFlightItem(context, model));
    });
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround, //将主轴空白区域均分，使各个子控件间距相等
      crossAxisAlignment: CrossAxisAlignment.center, //将子控件放在交叉轴的中间位置
      children: itemsWidget,
    );

  }

  _getFlightItem(BuildContext context,HomeModelGridnavHotel model){
    return Row(
      children: <Widget>[
        _mainitem(context, model.mainItem),
        _item12(context, model.item1, model.item2,model.item3),
      ],
    );
  }

  Widget _mainitem(BuildContext context,HomeModelGridnavHotelMainitem mainitemModel) {
    return GestureDetector(
      onTap: (){

      },
      child: Column( //上下
        children: <Widget>[
          CachedImage(
            imageUrl:mainitemModel.icon,
            fit: BoxFit.fill,
            width: 120,
            height:30 ,
          ),
          SizedBox(height: 5.0,),
          Text(mainitemModel.title),
        ],
      ),
    );
  }

  Widget _item12(BuildContext context,HomeModelGridnavHotelItem1 itemModel1,HomeModelGridnavHotelItem2 itemModel2,HomeModelGridnavHotelItem3 itemModel3) {
    return Row (
      mainAxisAlignment: MainAxisAlignment.spaceAround, //将主轴空白区域均分，使各个子控件间距相等
      crossAxisAlignment: CrossAxisAlignment.center, //将子控件放在交叉轴的中间位置
      children: <Widget>[
        _getHotelItemItem(context,itemModel1.title,false),
        _getHotelItemItem(context,itemModel2.title,false),
        _getHotelItemItem(context,itemModel3.title,true),
        ],
    );
  }

  _getHotelItemItem(BuildContext context,String title,bool last){
    return Text(title,textAlign: TextAlign.center,style: TextStyle(fontSize: 14,color:Colours.text_dark),);
  }
}


class SubNav extends StatelessWidget {
  final List<HomeModelSubnavlist> subNavList;

  const SubNav({Key key, this.subNavList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colours.gray_f5,
      padding: const EdgeInsets.all(10.0),
      child: _items(context),
    );
  }

  _items(BuildContext context) {
    if (subNavList == null) return null;
    List<Widget> items = [];
    subNavList.forEach((model) {
      items.add(_item(context, model));
    });
    //计算出第一行显示的行数
    int separate = (subNavList.length / 2 + 0.5).toInt();
    return Column(
      children: <Widget>[
        Row(
          children: items.sublist(0, separate),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
        Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Row(
            children: items.sublist(separate, subNavList.length),
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
        ),
      ],
    );
  }

  Widget _item(BuildContext context, HomeModelSubnavlist model) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
        },
        child: Column(
          children: <Widget>[
            Image.network(
              model.icon,
              width: 18.0,
              height: 18.0,
            ),
            Padding(
              padding: EdgeInsets.only(top: 3.0),
              child: Text(
                model.title,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 12,color: Colours.text_dark,decoration: TextDecoration.none),
              ),
            )
          ],
        ),
      ),
    );
  }
}

//热门活动
class SalesBoxWidget extends StatelessWidget {
  final HomeModelSalesbox salesboxModelData;
  const SalesBoxWidget({Key key, this.salesboxModelData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colours.gray_f5,
        padding: EdgeInsets.all(10),
        child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: _itemWidget(context),
          ),
        );
  }

  _itemWidget(BuildContext context) {
    if (salesboxModelData == null) return null;
    List<Widget> items = [];
    return Column(
      children: <Widget>[
        Container(
          height: 35,
          padding: EdgeInsets.only(left: 10,right: 10),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Color(0xfff2f2f2), width: 1.0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //将主轴空白位置进行均分，排列子元素，首尾子控件距边缘没有间隙
            children: <Widget>[
              Text('热门活动',
                  style: TextStyle(color: Colors.black54, fontSize: 14,decoration: TextDecoration.none)),
              GestureDetector(child: Text('更多  >   ',
                style: TextStyle(color: Colors.black54, fontSize: 13,decoration: TextDecoration.none),),
                onTap: () {},
              ),
            ],
          ),
        ),
        _getBigCard(
            context, salesboxModelData.bigCard1.icon, salesboxModelData.bigCard2.icon,true,false),
        _getBigCard(
            context, salesboxModelData.smallCard1.icon, salesboxModelData.smallCard2.icon,false,false),
        _getBigCard(
            context, salesboxModelData.smallCard3.icon, salesboxModelData.smallCard4.icon,false,true),

      ],
    );
  }

  _getBigCard(BuildContext context, String iconOne, String iconTwo,bool isbig,bool islastRow) {
    List<Widget> bigCarditems = [];
    bigCarditems.add(_bigCarditem(context, iconOne, false,isbig,islastRow));
    bigCarditems.add(_bigCarditem(context, iconTwo, true,isbig,islastRow));
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //将主轴空白位置进行均分，排列子元素，首尾子控件距边缘没有间隙
      children: bigCarditems,
    );
  }

  Widget _bigCarditem(BuildContext context, String icon, bool last,bool isbig,bool islastRow) {
    BorderSide borderSide = BorderSide(width: 1.0,color: Color(0xfff2f2f2));
    return GestureDetector(
      onTap: () {
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: islastRow ? BorderSide.none:borderSide,
            right: !last?borderSide:BorderSide.none,
          ),
        ),
        child: Image.network(
          icon,
          width: (MediaQuery.of(context).size.width- 20)/2-1,
          height: isbig ? 120 : 60,
        ),
      ),
    );
  }
}
