import 'package:flutter/material.dart';
import 'package:flutter_zlapp/APi/bannerApi.dart';
import 'package:flutter_zlapp/Model/bannerApiModel/sys_file_model.dart';
class SysfileWidget extends StatefulWidget {
  @override
  _SysfileWidgetState createState() => _SysfileWidgetState();
}

class _SysfileWidgetState extends State<SysfileWidget> {
  var page = 1;
  List list = new List(); //列表要展示的数据
  bool showMore = false; //是否上拉加载
  ScrollController _scrollController = ScrollController();
  @override 
  void initState() {
    super.initState();
    //监听scroll滑动 是否是上拉加载
    _scrollController.addListener(() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      print('上拉加载');
      setState(() {
        page++;
        showMore = true;
      });
      _getSysfileData();
    }
  });

    _getSysfileData();
  }
  //获取公司文档数据
  Future<Null> _getSysfileData() async {
    sysFileModel model =  await BannerApi.getInstance().getsysfile(context, false,this.page);
    if (this.page == 0) {
      this.list.clear();
      this.list.addAll(model.data);
    }else {
      this.list.addAll(model.data);
    }
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
         itemBuilder: (BuildContext context, int index) {
                return Text(index.toString());
              },
         itemCount: list.length,
       ),
       onRefresh: _getSysfileData,
     );

    // return RefreshIndicator(
    //    onRefresh: _onRefresh,
    //    child: ListView.builder(
    //      itemCount: list.length,
    //      itemBuilder:  return  _renderRow(context, index),
    //    )
    // );
  }

  //  Widget _renderRow(BuildContext context, int index) {
  //   return ListTile(
  //     title: Text(list[index]),
  //   );
  // }
  
  // //下拉刷新
  // Future _onRefresh() async {
  //  sysFileModel model =  await BannerApi.getInstance().getsysfile(context, false,this.page);
  //   return model.data;
  // }  this.page = 1;

  // //上拉加载
  // Future _getMoreRefresh() async {
  //   this.page ++;
    
  //   sysFileModel model =  await BannerApi.getInstance().getsysfile(context, false,this.page);
  //   if (this.page <= model.lastPage ) {
  //      this.list.addAll(model.data);
  //   }
  //   // else {
      
  //   // }
  //   return this.list;
  // }

  @override
  void dispose() {
  _scrollController.dispose();//监听器不用了要横着放
  super.dispose();
 }


  // Widget getLoadingWidget(
  //     {String text: '加载中...', Color bgColor: const Color(0x4b000000)}) {
  //   return Material(
  //       /// 透明
  //       type: MaterialType.transparency,
  //       /// 保证控件居中显示
  //       child: Center(
  //           child: Container(
  //               width: 60.0,
  //               height: 60.0,
  //               decoration: ShapeDecoration(
  //                   color: bgColor,
  //                   shape: RoundedRectangleBorder(
  //                       borderRadius: BorderRadius.all(Radius.circular(10.0)))),
  //               child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: <Widget>[
  //                     Center(
  //                       child: Text('', style: TextStyle(fontSize: 12.0)),
  //                     ),
  //                     Padding(
  //                         padding: EdgeInsets.only(top: 20.0),
  //                         child: Text(text, style: TextStyle(fontSize: 12.0)))
  //                   ])))      
  //             );
  // }



}