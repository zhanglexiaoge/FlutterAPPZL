class DetailModelEntity {
	int code;
	int httpCode;
	DetailModelData data;
	String message;

	DetailModelEntity({this.code, this.httpCode, this.data, this.message});

	DetailModelEntity.fromJson(Map<String, dynamic> json) {
		code = json['code'];
		httpCode = json['http_code'];
		data = json['data'] != null ? new DetailModelData.fromJson(json['data']) : null;
		message = json['message'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['code'] = this.code;
		data['http_code'] = this.httpCode;
		if (this.data != null) {
      data['data'] = this.data.toJson();
    }
		data['message'] = this.message;
		return data;
	}
}

class DetailModelData {
	List<DetailModelDataBanner> banner;
	List<DetailModelDataList> xList;

	DetailModelData({this.banner, this.xList});

	DetailModelData.fromJson(Map<String, dynamic> json) {
		if (json['banner'] != null) {
			banner = new List<DetailModelDataBanner>();(json['banner'] as List).forEach((v) { banner.add(new DetailModelDataBanner.fromJson(v)); });
		}
		if (json['list'] != null) {
			xList = new List<DetailModelDataList>();(json['list'] as List).forEach((v) { xList.add(new DetailModelDataList.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.banner != null) {
      data['banner'] =  this.banner.map((v) => v.toJson()).toList();
    }
		if (this.xList != null) {
      data['list'] =  this.xList.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class DetailModelDataBanner {
	int id;
	String redirectUrl;

	DetailModelDataBanner({this.id, this.redirectUrl});

	DetailModelDataBanner.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		redirectUrl = json['redirect_url'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = this.id;
		data['redirect_url'] = this.redirectUrl;
		return data;
	}
}

class DetailModelDataList {
	String name;
	String description;
	int id;
	String directory;
	int isInSticker;
	String url;

	DetailModelDataList({this.name, this.description, this.id, this.directory, this.isInSticker, this.url});

	DetailModelDataList.fromJson(Map<String, dynamic> json) {
		name = json['name'];
		description = json['description'];
		id = json['id'];
		directory = json['directory'];
		isInSticker = json['is_in_sticker'];
		url = json['url'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['name'] = this.name;
		data['description'] = this.description;
		data['id'] = this.id;
		data['directory'] = this.directory;
		data['is_in_sticker'] = this.isInSticker;
		data['url'] = this.url;
		return data;
	}
}
