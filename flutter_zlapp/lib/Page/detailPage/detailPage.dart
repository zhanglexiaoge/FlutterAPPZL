import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_zlapp/Model/DeatilPage/detailjson.dart';
import 'package:flutter_zlapp/Model/DeatilPage/detail_model_entity.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_zlapp/Page/Widget/cachedImage.dart';
import 'package:flutter_zlapp/Tool/colors.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_zlapp/Tool/application/application.dart';
import 'package:flutter_zlapp/Router/routes.dart';
import 'package:flutter_zlapp/Model/provider/faceManageModel.dart';
import 'package:provider/provider.dart';
class DetailPage extends StatefulWidget {
  final String message;
  final Color color;
  final String result;
  DetailPage({Key key, this.message, this.color,this.result}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  RefreshController _refreshController =
  RefreshController(initialRefresh: false);
  List<DetailModelDataBanner> banner = new List();
  List<DetailModelDataList> xList = new List();

  /*加载表情数据*/
  Future<void> loadfaceGroupList() async {
    await Future.delayed(Duration(milliseconds: 500));//等待500毫秒
    DetailModelEntity detailModel = DetailModelEntity.fromJson(DeatilJson().deatilListBanner);
    if(banner.length == 0) {
      banner.addAll(detailModel.data.banner);
    }
    xList.addAll(detailModel.data.xList);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('message >>>> ' + widget.message);
    print('color >>>> ' + widget.color.toString());
    print('result >>>> ' + widget.result);
    loadfaceGroupList();
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('表情商店'),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context,widget.result);
            }),
        actions: <Widget>[
          CupertinoButton(
            child: Icon(
              Icons.settings,
              color: Colours.color_3333,
            ),
            onPressed: () {
              List<DetailModelDataList> tempList = new List();
              xList.forEach((model) {
                if(model.isInSticker ==1) {
                  tempList.add(model);
                }
              });
              //FaceManageModel
              FaceManageModel facemodel = Provider.of<FaceManageModel>(context);
              facemodel.listface = tempList;
              //表情管理页面
              TransitionType transitionType = TransitionType.native;
              Application.router.navigateTo(context, Routes.facemanage,transition:transitionType);
            },
          )
        ],
      ),
      body: bodyView(context),
    );
  }

  Widget bodyView(BuildContext context) {
   return Column(
     children: <Widget>[
       Container(
         child: _bannerWidget(context),
         height: 160,
       ),
       Expanded(
           child: SmartRefresher(
             enablePullDown: true,
             enablePullUp: false,
             onRefresh: () async {
               //monitor fetch data from network
               xList.clear();
               loadfaceGroupList();
               _refreshController.refreshCompleted();
             },
             controller: _refreshController,
             child: ListView.builder(
               itemBuilder: _item,
               itemCount: xList.length,
             ),
           )
       ),

     ],
   );
}

  /*banner轮播图*/
  Widget  _bannerWidget(BuildContext context) {
    if (banner.length > 0) {
      return Container(
        height: 160.0,
        child: Swiper(
          itemBuilder: (BuildContext context, int index){
            return CachedImage(
              imageUrl: banner[index].redirectUrl,
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
          itemCount: banner.length,
          autoplay: true,
        ) ,
      );
    }else {
      return Container(
        height: 160.0,
      );
    }
  }

  Widget _item(BuildContext context, int index) {
    return new InkWell(

      onTap: () {

      },
      child: new Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: new Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Expanded(
                    child: new Row(
                      children: <Widget>[
                        FaceImageWidget(xList[index].url),
                        FaceNameWidget(xList[index].name,
                            '来源: ' + xList[index].description),
                      ],
                    ),
                  ),
                  new Container(
                    width: 75,
                    height: 30,
                    child: _Downloadbuttonprogress(
                        context, index, xList[index]),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
              height: 0.5,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget _Downloadbuttonprogress(
      BuildContext context, int index, DetailModelDataList dataModel) {
    return FlatButton(
      onPressed: () {
        Future.delayed(Duration(milliseconds: 500));//等待500毫秒
        dataModel.isInSticker = 1;
        setState(() {});
      },
      child: Text((dataModel.isInSticker == 1) ? '已下载' : '下载',
          style: TextStyle(fontSize: 14, color: (dataModel.isInSticker == 1) ? Colours.color_9999
              : Colours.color_76fc)),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          side: BorderSide(
              color: (dataModel.isInSticker == 1)
                  ? Colours.color_dddd
                  : Colours.color_76fc,
              style: BorderStyle.solid,
              width: 0.5)),
      splashColor: Colours.color_alpha,
      color: Colours.color_ffff,
    );
  }
}

/*表情图片*/
class FaceImageWidget extends StatelessWidget {
  final String avatar;
  FaceImageWidget(this.avatar);
  @override
  Widget build(BuildContext context) {
    return CachedImage(
      imageUrl: avatar ?? "",
      fit: BoxFit.fill,
      width: 60,
      height: 60,
    );

  }
}

/*表情名字 来源*/
class FaceNameWidget extends StatelessWidget {
  final String facename;
  final String facesoucre;

  FaceNameWidget(this.facename, this.facesoucre);

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.only(left: 10),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Text(facename,
                textAlign: TextAlign.left,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(fontSize: 15, color: Colours.gray_33)),
          ),
          Text(facesoucre,
              textAlign: TextAlign.left,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(fontSize: 12, color: Colours.gray_99)),
        ],
      ),
    );
  }
}
