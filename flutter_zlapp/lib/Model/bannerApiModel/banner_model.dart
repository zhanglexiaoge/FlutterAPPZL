import 'package:json_annotation/json_annotation.dart'; 
  
part 'banner_model.g.dart';

//https://caijinglong.github.io/json2dart/index_ch.html   json_serializable库 在线生成model
//https://www.jianshu.com/p/4210536124b1
//flutter packages pub run build_runner build

List<BannerModel> getBannerModelList(List<dynamic> list){
    List<BannerModel> result = [];
    list.forEach((item){
      result.add(BannerModel.fromJson(item));
    });
    return result;
  }
@JsonSerializable()
  class BannerModel extends Object {

  @JsonKey(name: 'index')
  int index;

  @JsonKey(name: 'terminal')
  String terminal;

  @JsonKey(name: 'redirect_url')
  String redirectUrl;

  @JsonKey(name: 'big_img')
  String bigImg;

  BannerModel(this.index,this.terminal,this.redirectUrl,this.bigImg,);

  factory BannerModel.fromJson(Map<String, dynamic> srcJson) => _$BannerModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BannerModelToJson(this);

}

  
