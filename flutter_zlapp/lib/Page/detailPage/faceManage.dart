import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_zlapp/Tool/colors.dart';
import 'package:flutter_zlapp/Page/Widget/cachedImage.dart';
import 'package:provider/provider.dart';
import 'package:flutter_zlapp/Model/DeatilPage/detail_model_entity.dart';
import 'package:flutter_zlapp/Model/provider/faceManageModel.dart';
import 'package:flutter_zlapp/Eventbus/eventbus_list.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_zlapp/Tool/application/application.dart';
import 'package:flutter_zlapp/Router/routes.dart';

class FaceManageSet extends StatefulWidget {
  @override
  _FaceManageSetState createState() => _FaceManageSetState();
}

class _FaceManageSetState extends State<FaceManageSet> {
  @override
  void initState() {
    super.initState();
   //通过addPostFrameCallback可以做一些安全的操作，在有些时候是很有用的，它会在当前Frame绘制完后进行回调，并只会回调一次，如果要再次监听需要再设置。 比如本地数据加载后,网络数据更新
//    WidgetsBinding.instance.addPostFrameCallback((_) {
//
//    });
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
                    //表情排序界面
                    TransitionType transitionType = TransitionType.native;
                    Application.router.navigateTo(context, Routes.facesequence,transition:transitionType);
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
    return Consumer(builder: (context, FaceManageModel _provider, _) => new Container(
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

    ),);
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
    EventBusUtil().getEventBus().fire(EventbusremoveFace(dataModel.id.toString()));
    //EventBusUtil().getEventBus().fire(UpdateMoveFace(dataModel.id));
    //和原生交互
//    ChannelUtil.communicateFunction(Channel.removeEmotions, {
//      "sticker_group_id": dataModel.id,
//    });
    //更新状态 数据
    Provider.of<FaceManageModel>(context).update();
  }


}


//StatefulWidget 的生命周期比较复杂，依次为：
//
//createState
//initState
//didChangeDependencies
//build
//addPostFrameCallback
//didUpdateWidget
//deactivate
//dispose

//#### createState

//createState 是 StatefulWidget 里创建 State 的方法，当要创建新的 StatefulWidget 的时候，会立即执行 createState，而且只执行一次，createState 必须要实现：
//
//
//class MyScreen extends StatefulWidget {
//  @override
//  _MyScreenState createState() => _MyScreenState();
//}

//### initState
//initState 是 StatefulWidget 创建完后调用的第一个方法，而且只执行一次，类似于 Android 的 onCreate、iOS 的 viewDidLoad()，所以在这里 View 并没有渲染，
//但是这时 StatefulWidget 已经被加载到渲染树里了，这时 StatefulWidget 的 mount 的值会变为 true，直到 dispose 调用的时候才会变为 false。可以在 initState 里做一些初始化的操作。

//@override
//void initState() {
//  super.initState();
//  ...
//}


//####addPostFrameCallback
//
//addPostFrameCallback 是 StatefulWidge 渲染结束的回调，只会被调用一次，之后 StatefulWidget 需要刷新 UI 也不会被调用，addPostFrameCallback 的使用方法是在 initState 里添加回调：
//import 'package:flutter/scheduler.dart';
//@override
//void initState() {
//  super.initState();
//  SchedulerBinding.instance.addPostFrameCallback((_) => {});
//}

//deactivate
//
//当要将 State 对象从渲染树中移除的时候，就会调用 deactivate 生命周期，这标志着 StatefulWidget 将要销毁，但是有时候 State 不会被销毁，而是重新插入到渲染树种。
//
//dispose
//
//当 View 不需要再显示，从渲染树中移除的时候，State 就会永久的从渲染树中移除，就会调用 dispose 生命周期，这时候就可以在 dispose 里做一些取消监听、动画的操作，和 initState 是相反的。
