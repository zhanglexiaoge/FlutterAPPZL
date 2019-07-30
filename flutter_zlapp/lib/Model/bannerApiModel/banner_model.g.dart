// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BannerModel _$BannerModelFromJson(Map<String, dynamic> json) {
  return BannerModel(json['index'] as int, json['terminal'] as String,
      json['redirect_url'] as String, json['big_img'] as String);
}

Map<String, dynamic> _$BannerModelToJson(BannerModel instance) =>
    <String, dynamic>{
      'index': instance.index,
      'terminal': instance.terminal,
      'redirect_url': instance.redirectUrl,
      'big_img': instance.bigImg
    };
