import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_zlapp/Tool/HTTP/HttpUtil.dart';
import 'package:flutter_zlapp/Page/Home/oneAppModel/one_page_list_model_entity.dart';
import 'package:flutter_zlapp/Page/Home/oneAppModel/onepageitem_model_entity.dart';
import 'package:flutter_zlapp/Tool/date_util.dart';
import 'package:flutter_zlapp/Tool/colors.dart';
import 'package:flutter_zlapp/Page/Widget/loadingwWidget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_zlapp/Page/Home/appData/app.dart'; //获取页面数据 可以用多个页面来传值
import 'package:flutter_zlapp/Page/Home/toolTabar_list_event/toolTabar_list_event.dart';

class OnePage extends StatefulWidget {
  OnePage({Key key}) : super(key: key);
  @override
  _OnePageState createState() => _OnePageState();
}

class _OnePageState extends State<OnePage> with TickerProviderStateMixin{
//  //with是dart的关键字，意思是混入的意思，就是说可以将一个或者多个类的功能添加到自己的类无需继承这些类，避免多重继承导致的问题。可以在https://stackoverflow.com/questions/21682714/with-keyword-in-dart中找到答案
//  //为什么是SingleTickerProviderStateMixin呢，因为初始化animationController的时候需要一个TickerProvider类型的参数Vsync参数，所以我们混入了TickerProvider的子类SingleTickerProviderStateMixin
//  AnimationController animationController;//该对象管理着animation对象
//  Animation<double> animation;//该对象是当前动画的状态，例如动画是否开始，停止，前进，后退。但是绘制再屏幕上的内容不知道
  List<String> _oneList = [];
  List<OnePageItemDataContentList> _data = List();
  final RefreshController _refreshController = RefreshController(
      initialRefresh: false);
  bool _isShowBody = true; //隐藏子视图 默认隐藏

  Animation _animation;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    initAnimation();

    getIdOneList(false);
  }

  void initAnimation() {
    _animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 200));
    _animation = new Tween(begin: 0.0, end: 0.5).animate(_animationController);
  }
  //执行动画 并显示隐藏子视图
  void changeOpacity(bool expand) {
    setState(() {
      if (expand) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }
  void getOneList() {
    HttpUtil().baseUrl =  "http://v3.wufazhuce.com:8000/api";
    //static final String _baseUrl = "http://v3.wufazhuce.com:8000/api";
    HttpUtil().get('/onelist/idlist').then((data){
      print('data' + data.toString());
      OnePageListModelEntity listModel = OnePageListModelEntity.fromJson(data);
      _oneList.addAll(listModel.data);
    },onError: (error){

    });
  }

  void getIdOneList( bool isNext) {
    HttpUtil().baseUrl =  "http://v3.wufazhuce.com:8000/api";
    String url ;
    url = isNext ? '/onelist/5370/0': '/onelist/5371/0';
    _data.clear();
    HttpUtil().get(url).then((data){
      OnePageItemEntity  dataModel= OnePageItemEntity.fromJson(data);
      setState(() {
        _data.addAll(dataModel.data.contentList);
      });
    },onError: (error){

    });
  }

  @override
  void dispose() {
    _animationController?.dispose();
    _refreshController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    //Flutter-WillPopScope-双击返回与界面退出提示 返回拦截
    return WillPopScope(
      child:  Scaffold(
      appBar: AppBar(
      centerTitle: false,
      backgroundColor: Colors.white,
      /// 阴影
      elevation: 0.5,
      title: GestureDetector(
        onTap: () {
              setState(() {
                _isShowBody = !_isShowBody;
              });
              App.eventBus.fire(toolTabar_list_event(!_isShowBody)); //显示子视图 隐藏 Tabbar
              changeOpacity(!_isShowBody);
        },
        child: Row(
          children: <Widget>[
            Text(DateUtil.formatDate(DateTime.now(),format:'dd'),
                style: TextStyle(
                  color: Colors.black,
                  //fontWeight: FontWeight.bold,
                  fontSize: 40.0,
                  letterSpacing: -0.5,
                )),
            Padding(
              padding: EdgeInsets.only(left: 10,top: 15,right: 0,bottom: 0),
              child: Text(DateUtil.formatDate(DateTime.now(),format:'MM') + '.' + DateUtil.formatDate(DateTime.now(),format:'yyyy') ,
                  style: TextStyle(
                    color: Colors.black,
                    //fontWeight: FontWeight.bold,
                    fontSize: 12,
                    letterSpacing: 0.5,
                  )),
            ),
            Padding(
              child: RotationTransition(
                turns: _animation,
                child: Icon(
                  Icons.network_cell,
                  color: Colors.black,
                  size: 10.0,
                ),
              ),
              padding: EdgeInsets.fromLTRB(4.0, 16.0, 0, 0),
            ),

          ],
        ),
      ),
      actions: <Widget>[
        Padding(
          child: Text('上海 · 小雨   8℃',
              style: TextStyle(color: Colours.green_1, fontSize: 12.0)),
          padding: EdgeInsets.fromLTRB(0, 26.0, 15, 0),
        ),
      ],

    ),
    body: Stack(
    // Offstage是控制组件隐藏/可见的组件，如果感觉有些单调功能不全，我们可以使用Visibility，Visibility也是控制子组件隐藏/可见的组件。不同是的Visibility有隐藏状态是否留有空间、隐藏状态下是否可调用等功能。
      children: <Widget>[
        Visibility(
            visible:!_isShowBody,
            child:SmartRefresher(
              enablePullUp: false,
              enablePullDown: true,
              controller: _refreshController,
              child: itemListView(context),
              onRefresh: () async {
                getIdOneList(false);
                _refreshController.refreshCompleted();
              },),
             //	不可见时是否维持状态
             maintainState: true,
         ),
           Visibility(
             visible:!_isShowBody,
             child:Text('data'),
             //	不可见时是否维持状态
             maintainState: false,
           ),
        ],

    ), //叠加视图),
     ) );
  }

  Widget itemListView(BuildContext context) {
    return CustomScrollView (
      slivers: <Widget>[
          SliverList(
            delegate: new SliverChildBuilderDelegate((BuildContext context, int index) {
              //创建子widget
              return itemWidget(context, _data[index], index);
             },
              childCount: _data.length,
            ),
        ),

         SliverToBoxAdapter(
          child: Container(
            child: IconButton(
              onPressed: (){
                getIdOneList(true);
              },
              icon: Icon(
                Icons.face,
                color: Colors.blue,
              ),
              iconSize: 40,
            ),
             height: 100,
            color: Color(0xFFF4F4F4),
            ),
          ),
      ],
    );
  }

  Widget itemWidget(BuildContext context,OnePageItemDataContentList item,int index) {
    if(index == _data.length - 1) {
      return OnePageItem(item);
    }else {
      return Column (
        children: <Widget>[
          OnePageItem(item),
          Container(
          height: 5.0,
          color: Color(0xFFF4F4F4)),
        ],
      );
    }
  }
}

class OnePageItem extends StatelessWidget {
  OnePageItemDataContentList item;

  OnePageItem(this.item);
  @override
  Widget build(BuildContext context) {
    Widget _widget;
    int category = int.parse(item.category) ;
    String titeStr = '';
    if (category == 0) {
      titeStr = '图文';
    }else if (category == 1) {
      titeStr = '阅读';
    }else if (category == 2) {
      titeStr = '连载';
    }else if (category == 3) {
      titeStr = '问答';
    }else if (category == 4) {
      titeStr = '音乐';
    }
    switch (int.parse(item.category)) {
      case 0:
        _widget = Column(
          children: <Widget>[
            InkWell(
              child: CachedNetworkImage(
                height: 200.0,
                width: double.infinity,
                fit: BoxFit.cover,
                imageUrl: item.imgUrl,
                errorWidget: (context, url, error) => Container(
                  child: Column(
                    children: <Widget>[
                      Icon(
                        Icons.error,
                        size: 30.0,
                      ),
                      Text("图片加载失败"),
                    ],
                  ),
                  padding: EdgeInsets.all(10.0),
                ),
              ),
              onTap: () {

              },
            ),
            Container(
              padding: EdgeInsets.fromLTRB(16.0, 14.0, 16.0, 0),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Center(
                      child: Text(
                        "${item.title} | ${item.picInfo}",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                    padding: EdgeInsets.only(top: 12.0),
                  ),
                  Container(
                    child: Text(
                      item.forward,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 15.0,
                      ),
                    ),
                    width: double.infinity,
                    padding: EdgeInsets.only(top: 26.0, left: 12.0),
                  ),
                  Container(
                    child: Center(
                      child: Text(
                        "${item.wordsInfo}",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                    padding: EdgeInsets.only(top: 26.0, bottom: 24.0),
                  ),
                ],
              ),
            ),
            Flex(
              direction: Axis.horizontal,
              children: <Widget>[
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        child: Text(
                          "发现",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 12.0,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        padding: EdgeInsets.only(left: 46.0, top: 16.0),
                      ),
                      Container(
                        child: IconButton(
                          icon: Icon(
                            Icons.explore,
                            color: Colors.black,
                          ),
                          iconSize: 18.5,
                        ),
                        padding: EdgeInsets.only(
                          left: 6.0,
                        ),
                      ),
                    ],
                  ),
                  flex: 6,
                ),
                Expanded(
                  child: Container(
                    child: IconButton(
                      icon: Icon(Icons.colorize),
                      iconSize: 18.0,
                    ),
                    padding: EdgeInsets.only(left: 10.0),
                  ),
                  flex: 2,
                ),
                Expanded(
                  child: Container(
                    child: IconButton(
                      icon: Icon(Icons.bookmark_border),
                      iconSize: 18.0,
                    ),
                    padding: EdgeInsets.only(left: 10.0),
                  ),
                  flex: 2,
                ),
                Expanded(
                  child: Container(
                    child: IconButton(
                      icon: Icon(Icons.share),
                      iconSize: 18.0,
                    ),
                    padding: EdgeInsets.only(left: 10.0),
                  ),
                  flex: 2,
                ),
                Expanded(
                  child: Container(
                    child: Stack(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.favorite_border),
                          iconSize: 18.5,
                        ),
                        Positioned(
                            top: 10,
                            left: 35.0,
                            child: Container(
                              child: Text(
                                item.likeCount.toString(),
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 10.0,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )),
                      ],
                    ),
                    padding: EdgeInsets.only(right: 0.0),
                  ),
                  flex: 3,
                ),
              ],
            ),
          ],
        );
        break;
      default:
        _widget = InkWell(
          child: Container(
            padding: EdgeInsets.fromLTRB(16.0, 14.0, 16.0, 0),
            child: Column(
              children: <Widget>[
                Center(
                  child: Text(
                    '-' + titeStr + '-',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 12.0,
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    item.title,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22.0,
                    ),
                  ),
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 12.0),
                ),
                Container(
                  child: Text(
                    "文/作者",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 15.0,
                    ),
                  ),
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 6.0, bottom: 12.0),
                ),

                ///判断是否音乐类型
                int.parse(item.category) == 4
                    ? Stack(
                  children: <Widget>[
                    ClipOval(
                      child: CachedNetworkImage(
                        height: 200,
                        width: 200,
                        fit: BoxFit.cover,
                        imageUrl: item.imgUrl,
                        errorWidget: (context, url, error) => Container(
                          child: Column(
                            children: <Widget>[
                              Icon(
                                Icons.error,
                                size: 30.0,
                              ),
                              Text("图片加载失败"),
                            ],
                          ),
                          padding: EdgeInsets.all(10.0),
                        ),
                      ),
                    ),
                    Container(
                      child: IconButton(
                          icon: Icon(
                            Icons.play_circle_filled,
                            size: 80.0,
                            color: Colors.black54,
                          )),
                      padding: EdgeInsets.only(bottom: 45.0, right: 45.0),
                    ),
                  ],
                  alignment: Alignment.center,
                )
                    : CachedNetworkImage(
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  imageUrl: item.imgUrl,
                  errorWidget: (context, url, error) => Container(
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.error,
                          size: 30.0,
                        ),
                        Text("图片加载失败"),
                      ],
                    ),
                    padding: EdgeInsets.all(10.0),
                  ),
                ),
                Container(
                  child: Text(
                    item.forward,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 15.0,
                    ),
                  ),
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 10.0, bottom: 12.0),
                ),
                Flex(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: Text(
                          DateUtil.isToday(
                              DateUtil.getDateMsByTimeStr(item.postDate))
                              ? "今天"
                              : DateUtil.formatDateStr(item.postDate,
                              format: "MM月d日"),
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 13,
                          ),
                        ),
                        padding: EdgeInsets.only(left: 2.0),
                      ),
                      flex: 4,
                    ),
                    Expanded(
                      child: Stack(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.favorite_border),
                            iconSize: 18.5,
                          ),
                          Positioned(
                              top: 10,
                              left: 35.0,
                              child: Container(
                                child: Text(
                                  item.likeCount.toString(),
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 10.0,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                //decoration: BoxDecoration(color: Colors.blueAccent),
                                //padding: EdgeInsets.fromLTRB(5.0, 0, 5.0, 0),
                              )),
                        ],
                      ),
                      flex: 1,
                    ),
                    Expanded(
                      child: Container(
                        child: IconButton(
                          icon: Icon(Icons.share),
                          iconSize: 18.0,
                        ),
                        padding: EdgeInsets.only(left: 18.0),
                      ),
                      flex: 1,
                    ),
                  ],
                ),
              ],
            ),
          ),
          onTap: () {

          },
        );
        break;
    }

      return _widget;
    

  }








}

