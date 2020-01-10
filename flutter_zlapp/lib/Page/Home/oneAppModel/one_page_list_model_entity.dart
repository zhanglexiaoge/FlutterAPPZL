class OnePageListModelEntity {
	int res;
	List<String> data;

	OnePageListModelEntity({this.res, this.data});

	OnePageListModelEntity.fromJson(Map<String, dynamic> json) {
		res = json['res'];
		data = json['data']?.cast<String>();
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['res'] = this.res;
		data['data'] = this.data;
		return data;
	}
}
