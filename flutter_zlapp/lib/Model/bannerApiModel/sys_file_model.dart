import 'package:json_annotation/json_annotation.dart'; 
  
part 'sys_file_model.g.dart';


@JsonSerializable()
  class sysFileModel extends Object {

  @JsonKey(name: 'current_page')
  int currentPage;

  @JsonKey(name: 'data')
  List<Data> data;

  @JsonKey(name: 'first_page_url')
  String firstPageUrl;

  @JsonKey(name: 'from')
  int from;

  @JsonKey(name: 'last_page')
  int lastPage;

  @JsonKey(name: 'last_page_url')
  String lastPageUrl;

  @JsonKey(name: 'next_page_url')
  String nextPageUrl;

  @JsonKey(name: 'path')
  String path;

  @JsonKey(name: 'per_page')
  int perPage;

  @JsonKey(name: 'to')
  int to;

  @JsonKey(name: 'total')
  int total;

  sysFileModel(this.currentPage,this.data,this.firstPageUrl,this.from,this.lastPage,this.lastPageUrl,this.nextPageUrl,this.path,this.perPage,this.to,this.total,);

  factory sysFileModel.fromJson(Map<String, dynamic> srcJson) => _$sysFileModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$sysFileModelToJson(this);

}

  
@JsonSerializable()
  class Data extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'create_id')
  int createId;

  @JsonKey(name: 'pv')
  int pv;

  @JsonKey(name: 'state')
  int state;

  @JsonKey(name: 'thumb_pic')
  String thumbPic;

  @JsonKey(name: 'create_time')
  int createTime;

  @JsonKey(name: 'update_time')
  int updateTime;

  @JsonKey(name: 'creator')
  Creator creator;

  @JsonKey(name: 'state_tag')
  String stateTag;

  @JsonKey(name: 'last_time')
  String lastTime;

  @JsonKey(name: 'content')
  String content;

  Data(this.id,this.title,this.createId,this.pv,this.state,this.thumbPic,this.createTime,this.updateTime,this.creator,this.stateTag,this.lastTime,this.content,);

  factory Data.fromJson(Map<String, dynamic> srcJson) => _$DataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataToJson(this);

}

  
@JsonSerializable()
  class Creator extends Object {

  @JsonKey(name: 'uid')
  int uid;

  @JsonKey(name: 'full_name')
  String fullName;

  Creator(this.uid,this.fullName,);

  factory Creator.fromJson(Map<String, dynamic> srcJson) => _$CreatorFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CreatorToJson(this);

}

  
