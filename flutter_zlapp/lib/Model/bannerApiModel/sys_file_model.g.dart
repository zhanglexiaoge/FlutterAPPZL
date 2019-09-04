// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sys_file_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

sysFileModel _$sysFileModelFromJson(Map<String, dynamic> json) {
  return sysFileModel(
      json['current_page'] as int,
      (json['data'] as List)
          ?.map((e) =>
              e == null ? null : Data.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['first_page_url'] as String,
      json['from'] as int,
      json['last_page'] as int,
      json['last_page_url'] as String,
      json['next_page_url'] as String,
      json['path'] as String,
      json['per_page'] as int,
      json['to'] as int,
      json['total'] as int);
}

Map<String, dynamic> _$sysFileModelToJson(sysFileModel instance) =>
    <String, dynamic>{
      'current_page': instance.currentPage,
      'data': instance.data,
      'first_page_url': instance.firstPageUrl,
      'from': instance.from,
      'last_page': instance.lastPage,
      'last_page_url': instance.lastPageUrl,
      'next_page_url': instance.nextPageUrl,
      'path': instance.path,
      'per_page': instance.perPage,
      'to': instance.to,
      'total': instance.total
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
      json['id'] as int,
      json['title'] as String,
      json['create_id'] as int,
      json['pv'] as int,
      json['state'] as int,
      json['thumb_pic'] as String,
      json['create_time'] as int,
      json['update_time'] as int,
      json['creator'] == null
          ? null
          : Creator.fromJson(json['creator'] as Map<String, dynamic>),
      json['state_tag'] as String,
      json['last_time'] as String,
      json['content'] as String);
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'create_id': instance.createId,
      'pv': instance.pv,
      'state': instance.state,
      'thumb_pic': instance.thumbPic,
      'create_time': instance.createTime,
      'update_time': instance.updateTime,
      'creator': instance.creator,
      'state_tag': instance.stateTag,
      'last_time': instance.lastTime,
      'content': instance.content
    };

Creator _$CreatorFromJson(Map<String, dynamic> json) {
  return Creator(json['uid'] as int, json['full_name'] as String);
}

Map<String, dynamic> _$CreatorToJson(Creator instance) =>
    <String, dynamic>{'uid': instance.uid, 'full_name': instance.fullName};
