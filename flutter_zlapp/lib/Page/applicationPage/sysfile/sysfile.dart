import 'package:flutter/material.dart';
class SysfileWidget extends StatefulWidget {
  @override
  _SysfileWidgetState createState() => _SysfileWidgetState();
}

class _SysfileWidgetState extends State<SysfileWidget> {
  
  @override 
  void initState() {
    super.initState();
    _getSysfileData();
  }
  //获取公司文档数据
  Future<void> _getSysfileData() async {
    /*公司文档数据*/
    // List<BannerModel> banner =
    //     await BannerApi.getInstance().getBannerModelData(context, false);
    // setState(() {
    //   bannerList = banner;
    // });
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
    
  }

}