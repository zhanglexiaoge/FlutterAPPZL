import 'package:flutter/material.dart';
import 'package:flutter_zlapp/APi/bannerApi.dart';
import 'package:flutter_zlapp/Model/bannerApiModel/sys_file_model.dart';

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
      //   if (page > countPage ) {
      //     setState(() {
      //      showMore = false;
      //     });
      //     return;
      //  }else {
      //    _getSysfileData();
      //  } 
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
           child: Text(list[index].title,style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold,color: Colors.black)),
         ),
        Container (
          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: Row (
            children: <Widget>[
              Text(list[index].content,style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold,color: Colors.black)),
              Image.asset(list[index].thumbPic,height: 40,width: 40),
            ],
          ),
        ),
        Container (
          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: Row (
            children: <Widget>[
              Text(list[index].updateTime.toString(),style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold,color: Colors.black)),
              Text(list[index].pv.toString(),style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold,color: Colors.black)),
            ],
          ),
        ),
       ],
     ),
   );
}


  /**
   * 加载更多时显示的组件,给用户提示
   */
  Widget _getMoreWidget() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              '加载中...',
              style: TextStyle(fontSize: 16.0),
            ),
            CircularProgressIndicator(
              strokeWidth: 1.0,
            )
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
  _scrollController.dispose();//监听器不用了要横着放
  super.dispose();
  }
}