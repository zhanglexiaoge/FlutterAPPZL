import 'package:flutter/material.dart';
import 'package:flutter_zlapp/APi/bannerApi.dart';
import 'package:flutter_zlapp/Model/bannerApiModel/sys_file_model.dart';
import 'package:flutter_zlapp/Tool/date_util.dart';
import 'package:flutter_zlapp/Page/applicationPage/sysfile/updateView.dart';
enum LoadingStatus {
  //正在加载中
  Loading_loading,
  //加载完成
  Loading_complete,
  //空闲状态
  Loading_idel,
}



class SysfileWidget extends StatefulWidget {
  @override
  _SysfileWidgetState createState() => _SysfileWidgetState();
}

class _SysfileWidgetState extends State<SysfileWidget> {
  var page = 1;
  List list = new List(); //列表要展示的数据
  ScrollController _scrollController = ScrollController();
  var countPage = 1;
  String loadText = "加载中...";
  LoadingStatus loadingStatu = LoadingStatus.Loading_idel;
  @override 
  void initState() {
    super.initState();
    _getSysfileData();
    //监听scroll滑动 是否是上拉加载
    _scrollController.addListener(() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
        print('上拉加载');
        setState(() {
          page++;
        });
      _getSysfileData();
    }
   });
  }
  //上拉加载 获取公司文档数据
  Future<Null> _getSysfileData() async {
    if (page > countPage ) {
        setState(() {
        loadingStatu = LoadingStatus.Loading_complete;
      });  
    } else {
       if (loadingStatu ==LoadingStatus.Loading_idel && this.page > 1) {
        //设置加载状态
        setState(() {
          loadingStatu = LoadingStatus.Loading_loading;
        });
     }
   }  
    sysFileModel model =  await BannerApi.getInstance().getsysfile(context, false,this.page);
    setState(() {
       if (this.page == 1) {
           this.list.clear();
           this.list.addAll(model.data);
           countPage = model.lastPage;
           loadingStatu = LoadingStatus.Loading_idel;
       }else {
           this.list.addAll(model.data); 
           countPage = model.lastPage;
           loadingStatu = LoadingStatus.Loading_idel;
       }
    });
  }
  
  Future<Null> _pullToRefresh() async {
  //下拉刷新做处理
    setState(() {
      page = 1;
    });
    _getSysfileData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('公司文档'),
      ),
      body: bodyView(),
    );
  }
  Widget bodyView() {
     return RefreshIndicator(
       child: ListView.builder(
         itemBuilder: _item,
         itemCount: list.length ,
         controller: _scrollController,
       ),
       onRefresh: _pullToRefresh,
     );
  }
Widget _item(BuildContext context, int index) {
   print(list[index]);
   return new Container(
     padding: EdgeInsets.all(10),
     child: new Column(
       children: <Widget>[
        Container(
          //softWrap: false 不换行 maxLines: 10, //最大行数
           child: Text(list[index].title,textAlign:TextAlign.left,maxLines: 1,style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold,color: Colors.black )),
           alignment: Alignment.topLeft,
         ),
        Container (
          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
          height: 60,
          child: Row (
            children: <Widget>[
              new Expanded(
                child: Text(list[index].content,textAlign:TextAlign.left,softWrap:true,overflow: TextOverflow.ellipsis,maxLines: 3, style: TextStyle(fontSize: 13.0,color: Colors.black)),
              ),
              FadeInImage.assetNetwork(
                 placeholder: 'assets/images/babner_default@2x.png',
                 image: "${list[index].thumbPic}",
                 fit:BoxFit.fill,
                 height: 60,
                 width: 60
              ),
            ],
          ),
        ),
        Container (
          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: Row (
            children: <Widget>[
              UpdateView(iconPath:'assets/images/doc_icon_time@2x.png',title: DateUtil.formatTimelineToStr(list[index].updateTime)),
               Container(
                 height: 14.0,
                 width: 15.0,
               ),
              UpdateView(iconPath:'assets/images/doc_icon_read@2x.png',title:(list[index].pv.toString() + "浏览")) ,
            ],
          ),
        ),
       Container(
        height: 10,
        margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
        color: Colors.cyan,
       ),
       ],
     ),
   );
}
  @override
  void dispose() {
  _scrollController.dispose();//监听器不用了要横着放
  super.dispose();
  }
}