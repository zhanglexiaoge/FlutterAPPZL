import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_zlapp/Tool/date_util.dart';
import 'package:flutter_zlapp/Tool/HTTP/HttpUtil.dart';
import 'package:flutter_zlapp/Page/Home/oneAppModel/one_page_tool_bar_list_item_entity.dart';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_zlapp/Tool/Utils.dart';
import 'package:flutter_zlapp/Tool/colors.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
class OnePageListView extends StatefulWidget {
  @override
  _OnePageListViewState createState() => _OnePageListViewState();
}

class _OnePageListViewState extends State<OnePageListView> {
  final RefreshController _refreshController = RefreshController(
      initialRefresh: false);
  String _nowMonth;
  String _nowDate;

  List<OnePageToolBarListItemEntity> _data = List();
  @override
  void initState() {
    super.initState();
    _nowMonth = DateUtil.formatDate(DateTime.now(), format: DataFormats.y_mo);
    _nowDate = DateUtil.formatDate(DateTime.now(), format: DataFormats.zh_y_mo);
    getListViewList(false);
  }
  @override
  void dispose() {
   _refreshController.dispose();
    super.dispose();
  }

  void getListViewList( bool isheader) {
   String url =  "/feeds/list/" + "$_nowMonth" + "?channel=cool&version=4.6.3&platform=android";
   HttpUtil().get(url).then((data){
     OnePageToolBarListItemEntity onePageToolBarListItemEntity =
     OnePageToolBarListItemEntity.fromJson(data);
     if (onePageToolBarListItemEntity != null &&
         onePageToolBarListItemEntity.data != null &&
         _data != null) {
       if (onePageToolBarListItemEntity.data.length > 0) {
         if(isheader) {
           List<OnePageToolBarListItemEntity> _tempdata = List();
           _tempdata.add(onePageToolBarListItemEntity);
           _data.forEach((dataModel){
             _tempdata.add(dataModel);
           });
           setState(() {
             _data = _tempdata;
           });
         }else {
           setState(() {
             _data.add(onePageToolBarListItemEntity);
           });
         }
       }
     }
   },onError: (error) {

   });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      //Stack 叠加视图,底部有一个日期选择器
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
        SmartRefresher(
          enablePullUp: true,
          enablePullDown: true,
          controller: _refreshController,
          child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return onePageToolBarListItem(_data[index].data);
              },
              separatorBuilder:(context, index) {
                return Divider(
                  height: 0,
                  color: Colors.white,
                );
              },
              itemCount:_data.length),
          onRefresh: () async {
            String _nowMonthNow =
                DateUtil.formatDate(DateTime.now(), format: DataFormats.y_mo);
            if(_nowMonth != _nowMonthNow) {
              String _nowMonthTemp = DateUtil.getNextMonth(_nowMonth);
              setState(() {
                _nowMonth = _nowMonthTemp;
                _nowDate =
                "${_nowMonth.split('-')[0]}年${_nowMonth.split('-')[1]}月";
              });
              getListViewList(true);
            }
            _refreshController.refreshCompleted();
          },
          onLoading: () async {
            _nowMonth = DateUtil.getLastMonth(_nowMonth);
            setState(() {
              _nowDate =
              "${_nowMonth.split('-')[0]}年${_nowMonth.split('-')[1]}月";
            });
            getListViewList(false);
            _refreshController.loadComplete();
          },
         ),
          InkWell(
            child: Container(
              color: Colors.white,
              height: 48.0,
              width: double.maxFinite,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "$_nowDate",
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black54,
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.black54,
                      size: 18.0,
                    ),
                  ],
                ),
                padding: EdgeInsets.only(bottom: 8.0),
              ),
            ),
            onTap: () {
              _showDatePicker();
            },
          ),

        ],

      ),

    );
  }

  void _showDatePicker() {
    DatePicker.showDatePicker(
      context,
      pickerTheme: DateTimePickerTheme(
        showTitle: true,
        confirm: Text('确定', style: TextStyle(color: Colors.red)),
        cancel: Text('退出', style: TextStyle(color: Colors.cyan)),
      ),
      minDateTime: DateTime.parse('2012-10-01'),
      maxDateTime: DateTime.parse(DateUtil.formatDate(DateTime.now(), format: DataFormats.y_mo_d)),
      initialDateTime:DateTime.parse(_nowMonth + '-01'),
      dateFormat: 'yyyy-MMMM',
      locale: DateTimePickerLocale.zh_cn,
      onClose: () => print("----- onClose -----"),
      onCancel: () => print('onCancel'),
      onChange: (dateTime, List<int> index) {

      },
      onConfirm: (dateTime, List<int> index) {
        setState(() {
          _data.clear();
          _nowMonth = DateUtil.formatDate(dateTime, format: DataFormats.y_mo);
          _nowDate = DateUtil.formatDate(dateTime, format: DataFormats.zh_y_mo);
          getListViewList(false);
        });
      },
    );

  }

}

class onePageToolBarListItem extends StatelessWidget {
  List<OnePageToolBarListItemData> _data;

  onePageToolBarListItem(this._data);
  double itemWidth = (Utils.width - 45) / 2;
  Widget getItemWidget(OnePageToolBarListItemData item, BuildContext context) {
     return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0),
        border: Border.all(
          color: Colors.black38,
          width: 0.5,
        ),
      ),
      child: InkWell(
        child: Column (
          children: <Widget>[
            CachedNetworkImage(
              height: itemWidth - 40,
              width:itemWidth,
              fit: BoxFit.cover,
              imageUrl: item.cover,
            ),
            Container(
              child: Text(
                item.date,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black54,
                ),
              ),
              alignment: Alignment.center,
              width: itemWidth,
              height: 40.0,
            ),
          ],

        ),
      ),
     );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 25,bottom: 15),
          height: 55,
          child: new Row(
            children: <Widget>[
              new Expanded(
                flex:1,
                child: Container(
                  margin:EdgeInsets.only(right: 15,left: 15) ,
                  height: 0.5,
                  color: Colours.color_dddd,
                ),
              ),
              Text(DateUtil.formatDateStr(_data[0].date, format: "MM月"),textAlign:TextAlign.center,softWrap:true,overflow: TextOverflow.ellipsis,maxLines: 1, style: TextStyle(fontSize: 12,color:  Colours.color_dddd)),
              new Expanded(
                flex:1,
                child: Container(
                  margin: EdgeInsets.only(left: 15,right: 15),
                  height: 0.5,
                  color:  Colours.color_dddd,
                ),
              ),
            ],
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          itemCount: _data.length,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 15),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            return getItemWidget(_data[index], context);
          },
        ),
      ],
    );
  }
}