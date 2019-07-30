// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staff_infro_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

staffInfroModel _$staffInfroModelFromJson(Map<String, dynamic> json) {
  return staffInfroModel(
      json['used'] == null
          ? null
          : Used.fromJson(json['used'] as Map<String, dynamic>),
      json['self'] == null
          ? null
          : Self.fromJson(json['self'] as Map<String, dynamic>),
      json['url'] as String);
}

Map<String, dynamic> _$staffInfroModelToJson(staffInfroModel instance) =>
    <String, dynamic>{
      'used': instance.used,
      'self': instance.self,
      'url': instance.url
    };

Used _$UsedFromJson(Map<String, dynamic> json) {
  return Used(json['status'] as int);
}

Map<String, dynamic> _$UsedToJson(Used instance) =>
    <String, dynamic>{'status': instance.status};

Self _$SelfFromJson(Map<String, dynamic> json) {
  return Self(
      json['staff'] == null
          ? null
          : Staff.fromJson(json['staff'] as Map<String, dynamic>),
      json['role'] as List,
      json['limit_version'] as int,
      (json['role_menu'] as List)?.map((e) => e as String)?.toList());
}

Map<String, dynamic> _$SelfToJson(Self instance) => <String, dynamic>{
      'staff': instance.staff,
      'role': instance.role,
      'limit_version': instance.limitVersion,
      'role_menu': instance.roleMenu
    };

Staff _$StaffFromJson(Map<String, dynamic> json) {
  return Staff(
      json['uid'] as int,
      json['staff_id'] as int,
      json['full_name'] as String,
      json['username'] as String,
      json['birth_day'] as int,
      json['mobile'] as String,
      json['entry_time'] as String,
      json['avatar'] as String,
      json['big_img'] as String,
      json['part_name'] as String,
      json['team_name'] as String,
      json['job_name'] as String,
      json['partner_name'] as String,
      json['label_name'] as String,
      json['part_full'] as String,
      json['team_id'] as int,
      json['sex'] as int,
      json['partner_syndic'] as String,
      json['state'] as int,
      json['com_id'] as int,
      json['com_uid'] as int,
      json['work_type'] as bool,
      json['network_manager'] as bool,
      json['push_is_silence'] as bool,
      json['entry_time_stamp'] as int,
      (json['groupShield'] as List)?.map((e) => e as int)?.toList());
}

Map<String, dynamic> _$StaffToJson(Staff instance) => <String, dynamic>{
      'uid': instance.uid,
      'staff_id': instance.staffId,
      'full_name': instance.fullName,
      'username': instance.username,
      'birth_day': instance.birthDay,
      'mobile': instance.mobile,
      'entry_time': instance.entryTime,
      'avatar': instance.avatar,
      'big_img': instance.bigImg,
      'part_name': instance.partName,
      'team_name': instance.teamName,
      'job_name': instance.jobName,
      'partner_name': instance.partnerName,
      'label_name': instance.labelName,
      'part_full': instance.partFull,
      'team_id': instance.teamId,
      'sex': instance.sex,
      'partner_syndic': instance.partnerSyndic,
      'state': instance.state,
      'com_id': instance.comId,
      'com_uid': instance.comUid,
      'work_type': instance.workType,
      'network_manager': instance.networkManager,
      'push_is_silence': instance.pushIsSilence,
      'entry_time_stamp': instance.entryTimeStamp,
      'groupShield': instance.groupShield
    };
