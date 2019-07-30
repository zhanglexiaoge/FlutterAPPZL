import 'package:json_annotation/json_annotation.dart'; 
  
part 'staff_infro_model.g.dart';


@JsonSerializable()
  class staffInfroModel extends Object {

  @JsonKey(name: 'used')
  Used used;

  @JsonKey(name: 'self')
  Self self;

  @JsonKey(name: 'url')
  String url;

  staffInfroModel(this.used,this.self,this.url,);

  factory staffInfroModel.fromJson(Map<String, dynamic> srcJson) => _$staffInfroModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$staffInfroModelToJson(this);

}

  
@JsonSerializable()
  class Used extends Object {

  @JsonKey(name: 'status')
  int status;

  Used(this.status,);

  factory Used.fromJson(Map<String, dynamic> srcJson) => _$UsedFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UsedToJson(this);

}

  
@JsonSerializable()
  class Self extends Object {

  @JsonKey(name: 'staff')
  Staff staff;

  @JsonKey(name: 'role')
  List<dynamic> role;

  @JsonKey(name: 'limit_version')
  int limitVersion;

  @JsonKey(name: 'role_menu')
  List<String> roleMenu;

  Self(this.staff,this.role,this.limitVersion,this.roleMenu,);

  factory Self.fromJson(Map<String, dynamic> srcJson) => _$SelfFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SelfToJson(this);

}

  
@JsonSerializable()
  class Staff extends Object {

  @JsonKey(name: 'uid')
  int uid;

  @JsonKey(name: 'staff_id')
  int staffId;

  @JsonKey(name: 'full_name')
  String fullName;

  @JsonKey(name: 'username')
  String username;

  @JsonKey(name: 'birth_day')
  int birthDay;

  @JsonKey(name: 'mobile')
  String mobile;

  @JsonKey(name: 'entry_time')
  String entryTime;

  @JsonKey(name: 'avatar')
  String avatar;

  @JsonKey(name: 'big_img')
  String bigImg;

  @JsonKey(name: 'part_name')
  String partName;

  @JsonKey(name: 'team_name')
  String teamName;

  @JsonKey(name: 'job_name')
  String jobName;

  @JsonKey(name: 'partner_name')
  String partnerName;

  @JsonKey(name: 'label_name')
  String labelName;

  @JsonKey(name: 'part_full')
  String partFull;

  @JsonKey(name: 'team_id')
  int teamId;

  @JsonKey(name: 'sex')
  int sex;

  @JsonKey(name: 'partner_syndic')
  String partnerSyndic;

  @JsonKey(name: 'state')
  int state;

  @JsonKey(name: 'com_id')
  int comId;

  @JsonKey(name: 'com_uid')
  int comUid;

  @JsonKey(name: 'work_type')
  bool workType;

  @JsonKey(name: 'network_manager')
  bool networkManager;

  @JsonKey(name: 'push_is_silence')
  bool pushIsSilence;

  @JsonKey(name: 'entry_time_stamp')
  int entryTimeStamp;

  @JsonKey(name: 'groupShield')
  List<int> groupShield;

  Staff(this.uid,this.staffId,this.fullName,this.username,this.birthDay,this.mobile,this.entryTime,this.avatar,this.bigImg,this.partName,this.teamName,this.jobName,this.partnerName,this.labelName,this.partFull,this.teamId,this.sex,this.partnerSyndic,this.state,this.comId,this.comUid,this.workType,this.networkManager,this.pushIsSilence,this.entryTimeStamp,this.groupShield,);

  factory Staff.fromJson(Map<String, dynamic> srcJson) => _$StaffFromJson(srcJson);

  Map<String, dynamic> toJson() => _$StaffToJson(this);

}

  
