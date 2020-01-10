class LoginModelEntity {
	String hcAccessToken;

	LoginModelEntity({this.hcAccessToken});

	LoginModelEntity.fromJson(Map<String, dynamic> json) {
		hcAccessToken = json['HC_ACCESS_TOKEN'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['HC_ACCESS_TOKEN'] = this.hcAccessToken;
		return data;
	}
}
