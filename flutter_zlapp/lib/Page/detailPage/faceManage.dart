import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_zlapp/Tool/colors.dart';
import 'package:flutter_zlapp/Page/Widget/cachedImage.dart';
import 'package:provider/provider.dart';
import 'package:flutter_zlapp/Model/DeatilPage/detail_model_entity.dart';
import 'package:flutter_zlapp/Model/provider/faceManageModel.dart';

class FaceManageSet extends StatefulWidget {
  @override
  _FaceManageSetState createState() => _FaceManageSetState();
}

class _FaceManageSetState extends State<FaceManageSet> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: AppBar(
            backgroundColor: Colours.color_ffff,
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios,color:Colours.color_3333,),
                onPressed: () {
                  Navigator.pop(context);
                }),
              actions: <Widget>[
                MaterialButton(
                  onPressed: () {

                  },
                  child: Text("排序"),
                  highlightColor: Colours.color_ffff,
                  splashColor: Colours.color_ffff,
                  minWidth: 40)
            ],
            elevation: 1,
            centerTitle: true,
            title: Text('我的表情',
                style: TextStyle(fontSize: 18, color: Colours.color_1111)),
          ),
          preferredSize: Size.fromHeight(44)),
      body: bodyView(context),
    );
  }
  Widget bodyView(BuildContext context) {
    FaceManageModel _provider = Provider.of<FaceManageModel>(context);
    return new Container(
      color: Colours.color_f9f9,
      child:CustomScrollView(
          slivers: <Widget>[
            //相当于表头
            SliverToBoxAdapter(
              child: Container(
                height: 40,
                color: Colours.color_f9f9,
                padding: EdgeInsets.fromLTRB(10, 14, 0, 0),
                child: Text(
                  '聊天面板中的表情',
                  style: TextStyle(color: Colours.color_9999, fontSize: 12),
                ),
              ),
            ),
            // 当列表项高度固定时，使用 SliverFixedExtendList 比 SliverList 具有更高的性能
            SliverList(
              delegate: SliverChildBuilderDelegate((context,index){
                DetailModelDataList model = _provider.listface[index];
                return InkWell(
                  child: new Container(
                    color: Colours.color_ffff,
                    child: new Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                          child: new Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: new Row(
                                  children: <Widget>[
                                    new Container(
                                      child: imageViewWidget(model.url),
                                    ),
                                    new Container(
                                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      child: Text( model.name,
                                          textAlign: TextAlign.left,
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontSize: 15, color: Colours.color_3333)),
                                    ),
                                  ],
                                ),
                              ),
                              new Container(
                                width: 60,
                                height: 30,
                                child: removeButton(model, context),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          height: 0.5,
                          color: Colours.color_dddd,
                        ),
                      ],
                    ),
                  ),
                );
              },
              childCount:_provider.listface.length, ),
            ),
          ],
        ),

    );
  }

  Widget imageViewWidget(String url) {
    return CachedImage(
      imageUrl: url ?? "",
      fit: BoxFit.fill,
      width: 40,
      height: 40,
    );
  }
  /*移除button */
  Widget removeButton(DetailModelDataList dataModel, BuildContext context) {
    return FlatButton(
      onPressed: () {
        removefaceModel(dataModel);
      },
      child: Text('移除', style: TextStyle(color: Colours.color_3333, fontSize: 14)),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          side: BorderSide(
              color: Colours.color_dddd,
              style: BorderStyle.solid,
              width: 0.5)),
      splashColor: Colours.color_alpha,
      color: Colours.color_f5f5,
    );
  }

  /*加载表情数据*/
  Future<void> removefaceModel(DetailModelDataList dataModel) async {
    await Future.delayed(Duration(milliseconds: 500));//等待500毫秒
    Provider.of<FaceManageModel>(context).listface.remove(dataModel);
    //全局监听 相当于通知
    //EventBusUtil().getEventBus().fire(UpdateMoveFace(dataModel.id));
    //和原生交互
//    ChannelUtil.communicateFunction(Channel.removeEmotions, {
//      "sticker_group_id": dataModel.id,
//    });
    //更新状态 数据
    Provider.of<FaceManageModel>(context).update();
  }


}