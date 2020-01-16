import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_zlapp/Tool/colors.dart';
import 'package:flutter_zlapp/Page/Widget/cachedImage.dart';
import 'package:provider/provider.dart';
import 'package:flutter_zlapp/Model/DeatilPage/detail_model_entity.dart';
import 'package:flutter_zlapp/Model/provider/faceManageModel.dart';
import 'package:reorderables/reorderables.dart';
import 'package:flutter_zlapp/Eventbus/eventbus_list.dart';

class FaceSequenceSet extends StatefulWidget {
  @override
  _FaceSequenceSetState createState() => _FaceSequenceSetState();
}

class _FaceSequenceSetState extends State<FaceSequenceSet> {
  List<Widget> _listItem = new List();
  List  <DetailModelDataList> listData = [];
  List<DetailModelDataList> copylistData = new List();


  @override
  void initState() {
    super.initState();
    //通过addPostFrameCallback可以做一些安全的操作，在有些时候是很有用的，它会在当前Frame绘制完后进行回调，并只会回调一次，如果要再次监听需要再设置。 比如本地数据加载后,网络数据更新
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      Provider.of<FaceManageModel>(context)
          .listface.forEach((data) {
        listData.add(data);
        _listItem.add(setItem(data));
        copylistData.add(data);
      });
      setState(() {});
    });
  }

  Future<void> faceSequenceSort() async {
     if(copylistData == listData) {
       //不需要更新数据
       Navigator.pop(context);
     }else {
       List<DetailModelDataList> tempList = new List();
       List<String > idList = new List();
       for (int i = 0; i < listData.length; i++) {
         DetailModelDataList model = listData[i];
         model.directory = (i + 1).toString();
         tempList.add(model);
         idList.add(model.id.toString());
       }
       FaceManageModel facemodel = Provider.of<FaceManageModel>(context);
       print('temp >>>> ' +tempList.toString());
       facemodel.listface = tempList;
       facemodel.update();
       EventBusUtil().getEventBus().fire(EventbusFaceReorder(idList));
       Navigator.pop(context);
     }

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
                    faceSequenceSort();
                  },
                  child: Text("完成"),
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
    return ReorderableColumn(
      header: _headerView(context),
      children: _listItem,
      crossAxisAlignment: CrossAxisAlignment.start,
      onReorder: (oldIndex, newIndex) {
        _updateItems(oldIndex, newIndex,context);
      },
      onNoReorder: (int index) {},
    );
  }

  Widget _headerView(BuildContext context) {
    return new Container(
      height: 40,
      color: Colours.color_f9f9,
      padding: EdgeInsets.fromLTRB(10, 14, 0, 0),
      child: Text(
        '长按可对聊天面板中的表情排序',
        textAlign: TextAlign.left,
        style: TextStyle(color: Colours.color_9999, fontSize: 12),
      ),
    );
  }
  void _updateItems(int oldIndex, int newIndex,BuildContext context) {

    setState(() {
      Widget row = _listItem.removeAt(oldIndex);
      _listItem.insert(newIndex, row);
      var temp = listData.removeAt(oldIndex);
      listData.insert(newIndex, temp);
    });
  }

  Widget setItem(DetailModelDataList model) {
    return new Container(
      color: Colours.color_ffff,
      key: Key(model.id.toString()),
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
                        child: _imageViewWidget(model.url),
                      ),
                      new Container(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Text(model.name,
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
                  child: Icon(
                    Icons.dehaze,
                    color: Colours.color_9999,
                  ),
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
    );
  }

  Widget _imageViewWidget(String url) {
    return CachedImage(
      imageUrl: url ?? "",
      fit: BoxFit.fill,
      width: 40,
      height: 40,
    );
  }

}
