class HomeModelEntity {
	List<HomeModelBannerlist> bannerList;
	List<HomeModelSubnavlist> subNavList;
	List<HomeModelLocalnavlist> localNavList;
	HomeModelSalesbox salesBox;
	HomeModelConfig config;
	HomeModelGridnav gridNav;

	HomeModelEntity({this.bannerList, this.subNavList, this.localNavList, this.salesBox, this.config, this.gridNav});

	HomeModelEntity.fromJson(Map<String, dynamic> json) {
		if (json['bannerList'] != null) {
			bannerList = new List<HomeModelBannerlist>();(json['bannerList'] as List).forEach((v) { bannerList.add(new HomeModelBannerlist.fromJson(v)); });
		}
		if (json['subNavList'] != null) {
			subNavList = new List<HomeModelSubnavlist>();(json['subNavList'] as List).forEach((v) { subNavList.add(new HomeModelSubnavlist.fromJson(v)); });
		}
		if (json['localNavList'] != null) {
			localNavList = new List<HomeModelLocalnavlist>();(json['localNavList'] as List).forEach((v) { localNavList.add(new HomeModelLocalnavlist.fromJson(v)); });
		}
		salesBox = json['salesBox'] != null ? new HomeModelSalesbox.fromJson(json['salesBox']) : null;
		config = json['config'] != null ? new HomeModelConfig.fromJson(json['config']) : null;
		gridNav = json['gridNav'] != null ? new HomeModelGridnav.fromJson(json['gridNav']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.bannerList != null) {
      data['bannerList'] =  this.bannerList.map((v) => v.toJson()).toList();
    }
		if (this.subNavList != null) {
      data['subNavList'] =  this.subNavList.map((v) => v.toJson()).toList();
    }
		if (this.localNavList != null) {
      data['localNavList'] =  this.localNavList.map((v) => v.toJson()).toList();
    }
		if (this.salesBox != null) {
      data['salesBox'] = this.salesBox.toJson();
    }
		if (this.config != null) {
      data['config'] = this.config.toJson();
    }
		if (this.gridNav != null) {
      data['gridNav'] = this.gridNav.toJson();
    }
		return data;
	}
}

class HomeModelBannerlist {
	String icon;
	String url;

	HomeModelBannerlist({this.icon, this.url});

	HomeModelBannerlist.fromJson(Map<String, dynamic> json) {
		icon = json['icon'];
		url = json['url'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['icon'] = this.icon;
		data['url'] = this.url;
		return data;
	}
}

class HomeModelSubnavlist {
	String icon;
	String title;
	String url;
	bool hideAppBar;

	HomeModelSubnavlist({this.icon, this.title, this.url, this.hideAppBar});

	HomeModelSubnavlist.fromJson(Map<String, dynamic> json) {
		icon = json['icon'];
		title = json['title'];
		url = json['url'];
		hideAppBar = json['hideAppBar'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['icon'] = this.icon;
		data['title'] = this.title;
		data['url'] = this.url;
		data['hideAppBar'] = this.hideAppBar;
		return data;
	}
}

class HomeModelLocalnavlist {
	String statusBarColor;
	String icon;
	String title;
	String url;
	bool hideAppBar;

	HomeModelLocalnavlist({this.statusBarColor, this.icon, this.title, this.url, this.hideAppBar});

	HomeModelLocalnavlist.fromJson(Map<String, dynamic> json) {
		statusBarColor = json['statusBarColor'];
		icon = json['icon'];
		title = json['title'];
		url = json['url'];
		hideAppBar = json['hideAppBar'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['statusBarColor'] = this.statusBarColor;
		data['icon'] = this.icon;
		data['title'] = this.title;
		data['url'] = this.url;
		data['hideAppBar'] = this.hideAppBar;
		return data;
	}
}

class HomeModelSalesbox {
	HomeModelSalesboxBigcard2 bigCard2;
	HomeModelSalesboxSmallcard4 smallCard4;
	HomeModelSalesboxSmallcard3 smallCard3;
	HomeModelSalesboxBigcard1 bigCard1;
	HomeModelSalesboxSmallcard2 smallCard2;
	HomeModelSalesboxSmallcard1 smallCard1;
	String icon;
	String moreUrl;

	HomeModelSalesbox({this.bigCard2, this.smallCard4, this.smallCard3, this.bigCard1, this.smallCard2, this.smallCard1, this.icon, this.moreUrl});

	HomeModelSalesbox.fromJson(Map<String, dynamic> json) {
		bigCard2 = json['bigCard2'] != null ? new HomeModelSalesboxBigcard2.fromJson(json['bigCard2']) : null;
		smallCard4 = json['smallCard4'] != null ? new HomeModelSalesboxSmallcard4.fromJson(json['smallCard4']) : null;
		smallCard3 = json['smallCard3'] != null ? new HomeModelSalesboxSmallcard3.fromJson(json['smallCard3']) : null;
		bigCard1 = json['bigCard1'] != null ? new HomeModelSalesboxBigcard1.fromJson(json['bigCard1']) : null;
		smallCard2 = json['smallCard2'] != null ? new HomeModelSalesboxSmallcard2.fromJson(json['smallCard2']) : null;
		smallCard1 = json['smallCard1'] != null ? new HomeModelSalesboxSmallcard1.fromJson(json['smallCard1']) : null;
		icon = json['icon'];
		moreUrl = json['moreUrl'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.bigCard2 != null) {
      data['bigCard2'] = this.bigCard2.toJson();
    }
		if (this.smallCard4 != null) {
      data['smallCard4'] = this.smallCard4.toJson();
    }
		if (this.smallCard3 != null) {
      data['smallCard3'] = this.smallCard3.toJson();
    }
		if (this.bigCard1 != null) {
      data['bigCard1'] = this.bigCard1.toJson();
    }
		if (this.smallCard2 != null) {
      data['smallCard2'] = this.smallCard2.toJson();
    }
		if (this.smallCard1 != null) {
      data['smallCard1'] = this.smallCard1.toJson();
    }
		data['icon'] = this.icon;
		data['moreUrl'] = this.moreUrl;
		return data;
	}
}

class HomeModelSalesboxBigcard2 {
	String icon;
	String title;
	String url;

	HomeModelSalesboxBigcard2({this.icon, this.title, this.url});

	HomeModelSalesboxBigcard2.fromJson(Map<String, dynamic> json) {
		icon = json['icon'];
		title = json['title'];
		url = json['url'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['icon'] = this.icon;
		data['title'] = this.title;
		data['url'] = this.url;
		return data;
	}
}

class HomeModelSalesboxSmallcard4 {
	String icon;
	String title;
	String url;

	HomeModelSalesboxSmallcard4({this.icon, this.title, this.url});

	HomeModelSalesboxSmallcard4.fromJson(Map<String, dynamic> json) {
		icon = json['icon'];
		title = json['title'];
		url = json['url'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['icon'] = this.icon;
		data['title'] = this.title;
		data['url'] = this.url;
		return data;
	}
}

class HomeModelSalesboxSmallcard3 {
	String icon;
	String title;
	String url;

	HomeModelSalesboxSmallcard3({this.icon, this.title, this.url});

	HomeModelSalesboxSmallcard3.fromJson(Map<String, dynamic> json) {
		icon = json['icon'];
		title = json['title'];
		url = json['url'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['icon'] = this.icon;
		data['title'] = this.title;
		data['url'] = this.url;
		return data;
	}
}

class HomeModelSalesboxBigcard1 {
	String icon;
	String title;
	String url;

	HomeModelSalesboxBigcard1({this.icon, this.title, this.url});

	HomeModelSalesboxBigcard1.fromJson(Map<String, dynamic> json) {
		icon = json['icon'];
		title = json['title'];
		url = json['url'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['icon'] = this.icon;
		data['title'] = this.title;
		data['url'] = this.url;
		return data;
	}
}

class HomeModelSalesboxSmallcard2 {
	String icon;
	String title;
	String url;

	HomeModelSalesboxSmallcard2({this.icon, this.title, this.url});

	HomeModelSalesboxSmallcard2.fromJson(Map<String, dynamic> json) {
		icon = json['icon'];
		title = json['title'];
		url = json['url'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['icon'] = this.icon;
		data['title'] = this.title;
		data['url'] = this.url;
		return data;
	}
}

class HomeModelSalesboxSmallcard1 {
	String icon;
	String title;
	String url;

	HomeModelSalesboxSmallcard1({this.icon, this.title, this.url});

	HomeModelSalesboxSmallcard1.fromJson(Map<String, dynamic> json) {
		icon = json['icon'];
		title = json['title'];
		url = json['url'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['icon'] = this.icon;
		data['title'] = this.title;
		data['url'] = this.url;
		return data;
	}
}

class HomeModelConfig {
	String searchUrl;

	HomeModelConfig({this.searchUrl});

	HomeModelConfig.fromJson(Map<String, dynamic> json) {
		searchUrl = json['searchUrl'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['searchUrl'] = this.searchUrl;
		return data;
	}
}

class HomeModelGridnav {
	HomeModelGridnavFlight flight;
	HomeModelGridnavHotel hotel;
	HomeModelGridnavTravel travel;

	HomeModelGridnav({this.flight, this.hotel, this.travel});

	HomeModelGridnav.fromJson(Map<String, dynamic> json) {
		flight = json['flight'] != null ? new HomeModelGridnavFlight.fromJson(json['flight']) : null;
		hotel = json['hotel'] != null ? new HomeModelGridnavHotel.fromJson(json['hotel']) : null;
		travel = json['travel'] != null ? new HomeModelGridnavTravel.fromJson(json['travel']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.flight != null) {
      data['flight'] = this.flight.toJson();
    }
		if (this.hotel != null) {
      data['hotel'] = this.hotel.toJson();
    }
		if (this.travel != null) {
      data['travel'] = this.travel.toJson();
    }
		return data;
	}
}

class HomeModelGridnavFlight {
	HomeModelGridnavFlightItem2 item2;
	HomeModelGridnavFlightItem1 item1;
	String endColor;
	HomeModelGridnavFlightMainitem mainItem;
	HomeModelGridnavFlightItem4 item4;
	HomeModelGridnavFlightItem3 item3;
	String startColor;

	HomeModelGridnavFlight({this.item2, this.item1, this.endColor, this.mainItem, this.item4, this.item3, this.startColor});

	HomeModelGridnavFlight.fromJson(Map<String, dynamic> json) {
		item2 = json['item2'] != null ? new HomeModelGridnavFlightItem2.fromJson(json['item2']) : null;
		item1 = json['item1'] != null ? new HomeModelGridnavFlightItem1.fromJson(json['item1']) : null;
		endColor = json['endColor'];
		mainItem = json['mainItem'] != null ? new HomeModelGridnavFlightMainitem.fromJson(json['mainItem']) : null;
		item4 = json['item4'] != null ? new HomeModelGridnavFlightItem4.fromJson(json['item4']) : null;
		item3 = json['item3'] != null ? new HomeModelGridnavFlightItem3.fromJson(json['item3']) : null;
		startColor = json['startColor'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.item2 != null) {
      data['item2'] = this.item2.toJson();
    }
		if (this.item1 != null) {
      data['item1'] = this.item1.toJson();
    }
		data['endColor'] = this.endColor;
		if (this.mainItem != null) {
      data['mainItem'] = this.mainItem.toJson();
    }
		if (this.item4 != null) {
      data['item4'] = this.item4.toJson();
    }
		if (this.item3 != null) {
      data['item3'] = this.item3.toJson();
    }
		data['startColor'] = this.startColor;
		return data;
	}
}

class HomeModelGridnavFlightItem2 {
	String title;
	String url;

	HomeModelGridnavFlightItem2({this.title, this.url});

	HomeModelGridnavFlightItem2.fromJson(Map<String, dynamic> json) {
		title = json['title'];
		url = json['url'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['title'] = this.title;
		data['url'] = this.url;
		return data;
	}
}

class HomeModelGridnavFlightItem1 {
	String title;
	String url;
	bool hideAppBar;

	HomeModelGridnavFlightItem1({this.title, this.url, this.hideAppBar});

	HomeModelGridnavFlightItem1.fromJson(Map<String, dynamic> json) {
		title = json['title'];
		url = json['url'];
		hideAppBar = json['hideAppBar'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['title'] = this.title;
		data['url'] = this.url;
		data['hideAppBar'] = this.hideAppBar;
		return data;
	}
}

class HomeModelGridnavFlightMainitem {
	String icon;
	String title;
	String url;

	HomeModelGridnavFlightMainitem({this.icon, this.title, this.url});

	HomeModelGridnavFlightMainitem.fromJson(Map<String, dynamic> json) {
		icon = json['icon'];
		title = json['title'];
		url = json['url'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['icon'] = this.icon;
		data['title'] = this.title;
		data['url'] = this.url;
		return data;
	}
}

class HomeModelGridnavFlightItem4 {
	String title;
	String url;
	bool hideAppBar;

	HomeModelGridnavFlightItem4({this.title, this.url, this.hideAppBar});

	HomeModelGridnavFlightItem4.fromJson(Map<String, dynamic> json) {
		title = json['title'];
		url = json['url'];
		hideAppBar = json['hideAppBar'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['title'] = this.title;
		data['url'] = this.url;
		data['hideAppBar'] = this.hideAppBar;
		return data;
	}
}

class HomeModelGridnavFlightItem3 {
	String title;
	String url;
	bool hideAppBar;

	HomeModelGridnavFlightItem3({this.title, this.url, this.hideAppBar});

	HomeModelGridnavFlightItem3.fromJson(Map<String, dynamic> json) {
		title = json['title'];
		url = json['url'];
		hideAppBar = json['hideAppBar'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['title'] = this.title;
		data['url'] = this.url;
		data['hideAppBar'] = this.hideAppBar;
		return data;
	}
}

class HomeModelGridnavHotel {
	HomeModelGridnavHotelItem2 item2;
	HomeModelGridnavHotelItem1 item1;
	String endColor;
	HomeModelGridnavHotelMainitem mainItem;
	HomeModelGridnavHotelItem4 item4;
	HomeModelGridnavHotelItem3 item3;
	String startColor;

	HomeModelGridnavHotel({this.item2, this.item1, this.endColor, this.mainItem, this.item4, this.item3, this.startColor});

	HomeModelGridnavHotel.fromJson(Map<String, dynamic> json) {
		item2 = json['item2'] != null ? new HomeModelGridnavHotelItem2.fromJson(json['item2']) : null;
		item1 = json['item1'] != null ? new HomeModelGridnavHotelItem1.fromJson(json['item1']) : null;
		endColor = json['endColor'];
		mainItem = json['mainItem'] != null ? new HomeModelGridnavHotelMainitem.fromJson(json['mainItem']) : null;
		item4 = json['item4'] != null ? new HomeModelGridnavHotelItem4.fromJson(json['item4']) : null;
		item3 = json['item3'] != null ? new HomeModelGridnavHotelItem3.fromJson(json['item3']) : null;
		startColor = json['startColor'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.item2 != null) {
      data['item2'] = this.item2.toJson();
    }
		if (this.item1 != null) {
      data['item1'] = this.item1.toJson();
    }
		data['endColor'] = this.endColor;
		if (this.mainItem != null) {
      data['mainItem'] = this.mainItem.toJson();
    }
		if (this.item4 != null) {
      data['item4'] = this.item4.toJson();
    }
		if (this.item3 != null) {
      data['item3'] = this.item3.toJson();
    }
		data['startColor'] = this.startColor;
		return data;
	}
}

class HomeModelGridnavHotelItem2 {
	String title;
	String url;

	HomeModelGridnavHotelItem2({this.title, this.url});

	HomeModelGridnavHotelItem2.fromJson(Map<String, dynamic> json) {
		title = json['title'];
		url = json['url'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['title'] = this.title;
		data['url'] = this.url;
		return data;
	}
}

class HomeModelGridnavHotelItem1 {
	String statusBarColor;
	String title;
	String url;

	HomeModelGridnavHotelItem1({this.statusBarColor, this.title, this.url});

	HomeModelGridnavHotelItem1.fromJson(Map<String, dynamic> json) {
		statusBarColor = json['statusBarColor'];
		title = json['title'];
		url = json['url'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['statusBarColor'] = this.statusBarColor;
		data['title'] = this.title;
		data['url'] = this.url;
		return data;
	}
}

class HomeModelGridnavHotelMainitem {
	String statusBarColor;
	String icon;
	String title;
	String url;

	HomeModelGridnavHotelMainitem({this.statusBarColor, this.icon, this.title, this.url});

	HomeModelGridnavHotelMainitem.fromJson(Map<String, dynamic> json) {
		statusBarColor = json['statusBarColor'];
		icon = json['icon'];
		title = json['title'];
		url = json['url'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['statusBarColor'] = this.statusBarColor;
		data['icon'] = this.icon;
		data['title'] = this.title;
		data['url'] = this.url;
		return data;
	}
}

class HomeModelGridnavHotelItem4 {
	String title;
	String url;
	bool hideAppBar;

	HomeModelGridnavHotelItem4({this.title, this.url, this.hideAppBar});

	HomeModelGridnavHotelItem4.fromJson(Map<String, dynamic> json) {
		title = json['title'];
		url = json['url'];
		hideAppBar = json['hideAppBar'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['title'] = this.title;
		data['url'] = this.url;
		data['hideAppBar'] = this.hideAppBar;
		return data;
	}
}

class HomeModelGridnavHotelItem3 {
	String title;
	String url;
	bool hideAppBar;

	HomeModelGridnavHotelItem3({this.title, this.url, this.hideAppBar});

	HomeModelGridnavHotelItem3.fromJson(Map<String, dynamic> json) {
		title = json['title'];
		url = json['url'];
		hideAppBar = json['hideAppBar'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['title'] = this.title;
		data['url'] = this.url;
		data['hideAppBar'] = this.hideAppBar;
		return data;
	}
}

class HomeModelGridnavTravel {
	HomeModelGridnavTravelItem2 item2;
	HomeModelGridnavTravelItem1 item1;
	String endColor;
	HomeModelGridnavTravelMainitem mainItem;
	HomeModelGridnavTravelItem4 item4;
	HomeModelGridnavTravelItem3 item3;
	String startColor;

	HomeModelGridnavTravel({this.item2, this.item1, this.endColor, this.mainItem, this.item4, this.item3, this.startColor});

	HomeModelGridnavTravel.fromJson(Map<String, dynamic> json) {
		item2 = json['item2'] != null ? new HomeModelGridnavTravelItem2.fromJson(json['item2']) : null;
		item1 = json['item1'] != null ? new HomeModelGridnavTravelItem1.fromJson(json['item1']) : null;
		endColor = json['endColor'];
		mainItem = json['mainItem'] != null ? new HomeModelGridnavTravelMainitem.fromJson(json['mainItem']) : null;
		item4 = json['item4'] != null ? new HomeModelGridnavTravelItem4.fromJson(json['item4']) : null;
		item3 = json['item3'] != null ? new HomeModelGridnavTravelItem3.fromJson(json['item3']) : null;
		startColor = json['startColor'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.item2 != null) {
      data['item2'] = this.item2.toJson();
    }
		if (this.item1 != null) {
      data['item1'] = this.item1.toJson();
    }
		data['endColor'] = this.endColor;
		if (this.mainItem != null) {
      data['mainItem'] = this.mainItem.toJson();
    }
		if (this.item4 != null) {
      data['item4'] = this.item4.toJson();
    }
		if (this.item3 != null) {
      data['item3'] = this.item3.toJson();
    }
		data['startColor'] = this.startColor;
		return data;
	}
}

class HomeModelGridnavTravelItem2 {
	String statusBarColor;
	String title;
	String url;
	bool hideAppBar;

	HomeModelGridnavTravelItem2({this.statusBarColor, this.title, this.url, this.hideAppBar});

	HomeModelGridnavTravelItem2.fromJson(Map<String, dynamic> json) {
		statusBarColor = json['statusBarColor'];
		title = json['title'];
		url = json['url'];
		hideAppBar = json['hideAppBar'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['statusBarColor'] = this.statusBarColor;
		data['title'] = this.title;
		data['url'] = this.url;
		data['hideAppBar'] = this.hideAppBar;
		return data;
	}
}

class HomeModelGridnavTravelItem1 {
	String statusBarColor;
	String title;
	String url;
	bool hideAppBar;

	HomeModelGridnavTravelItem1({this.statusBarColor, this.title, this.url, this.hideAppBar});

	HomeModelGridnavTravelItem1.fromJson(Map<String, dynamic> json) {
		statusBarColor = json['statusBarColor'];
		title = json['title'];
		url = json['url'];
		hideAppBar = json['hideAppBar'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['statusBarColor'] = this.statusBarColor;
		data['title'] = this.title;
		data['url'] = this.url;
		data['hideAppBar'] = this.hideAppBar;
		return data;
	}
}

class HomeModelGridnavTravelMainitem {
	String statusBarColor;
	String icon;
	String title;
	String url;
	bool hideAppBar;

	HomeModelGridnavTravelMainitem({this.statusBarColor, this.icon, this.title, this.url, this.hideAppBar});

	HomeModelGridnavTravelMainitem.fromJson(Map<String, dynamic> json) {
		statusBarColor = json['statusBarColor'];
		icon = json['icon'];
		title = json['title'];
		url = json['url'];
		hideAppBar = json['hideAppBar'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['statusBarColor'] = this.statusBarColor;
		data['icon'] = this.icon;
		data['title'] = this.title;
		data['url'] = this.url;
		data['hideAppBar'] = this.hideAppBar;
		return data;
	}
}

class HomeModelGridnavTravelItem4 {
	String title;
	String url;
	bool hideAppBar;

	HomeModelGridnavTravelItem4({this.title, this.url, this.hideAppBar});

	HomeModelGridnavTravelItem4.fromJson(Map<String, dynamic> json) {
		title = json['title'];
		url = json['url'];
		hideAppBar = json['hideAppBar'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['title'] = this.title;
		data['url'] = this.url;
		data['hideAppBar'] = this.hideAppBar;
		return data;
	}
}

class HomeModelGridnavTravelItem3 {
	String title;
	String url;
	bool hideAppBar;

	HomeModelGridnavTravelItem3({this.title, this.url, this.hideAppBar});

	HomeModelGridnavTravelItem3.fromJson(Map<String, dynamic> json) {
		title = json['title'];
		url = json['url'];
		hideAppBar = json['hideAppBar'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['title'] = this.title;
		data['url'] = this.url;
		data['hideAppBar'] = this.hideAppBar;
		return data;
	}
}
//首页数据格式
//{
//"config": {
//"searchUrl": "https://m.ctrip.com/restapi/h5api/searchapp/search?source=mobileweb&action=autocomplete&contentType=json&keyword=1"
//},
//"bannerList": [
//{
//"icon": "https://www.devio.org/io/flutter_app/img/banner/100h10000000q7ght9352.jpg",
//"url": "https://gs.ctrip.com/html5/you/travels/1422/3771516.html?from=https%3A%2F%2Fm.ctrip.com%2Fhtml5%2F"
//},
//{
//"icon": "https://dimg04.c-ctrip.com/images/300h0u000000j05rnD96B_C_500_280.jpg",
//"url": "https://m.ctrip.com/webapp/vacations/tour/detail?productid=3168213&departcityid=2&salecityid=2&from=https%3A%2F%2Fm.ctrip.com%2Fhtml5%2F"
//},
//{
//"icon": "http://pages.ctrip.com/hotel/201811/jdsc_640es_tab1.jpg",
//"url": "https://m.ctrip.com/events/jiudianshangchenghuodong.html?disable_webview_cache_key=1"
//},
//{
//"icon": "https://dimg03.c-ctrip.com/images/fd/tg/g1/M03/7E/19/CghzfVWw6OaACaJXABqNWv6ecpw824_C_500_280_Q90.jpg",
//"url": "https://m.ctrip.com/webapp/vacations/tour/detail?productid=53720&departcityid=2&salecityid=2&from=https%3A%2F%2Fm.ctrip.com%2Fhtml5%2F"
//}
//],
//"localNavList": [
//{
//"icon": "https://www.devio.org/io/flutter_app/img/ln_ticket.png",
//"title": "攻略·景点",
//"url": "https://m.ctrip.com/webapp/you/place/2.html?ishideheader=true&secondwakeup=true&dpclickjump=true&allianceid=66672&sid=1693366&from=https%3A%2F%2Fm.ctrip.com%2Fhtml5%2F",
//"statusBarColor": "1070b8",
//"hideAppBar": true
//},
//{
//"icon": "https://www.devio.org/io/flutter_app/img/ln_weekend.png",
//"title": "周边游",
//"url": "https://m.ctrip.com/webapp/vacations/tour/around?&from=https%3A%2F%2Fm.ctrip.com%2Fhtml5%2F",
//"statusBarColor": "52149f",
//"hideAppBar": true
//},
//{
//"icon": "https://www.devio.org/io/flutter_app/img/ln_food.png",
//"title": "美食林",
//"url": "https://m.ctrip.com/webapp/you/foods/address.html?new=1&ishideheader=true",
//"statusBarColor": "19A0F0",
//"hideAppBar": true
//},
//{
//"icon": "https://www.devio.org/io/flutter_app/img/ln_oneday.png",
//"title": "一日游",
//"url": "https://dp.ctrip.com/webapp/activity/daytour",
//"hideAppBar": true
//},
//{
//"icon": "https://www.devio.org/io/flutter_app/img/ln_guide.png",
//"title": "当地攻略",
//"url": "https://m.ctrip.com/webapp/you/",
//"statusBarColor": "19A0F0",
//"hideAppBar": true
//}
//],
//"gridNav": {
//"hotel": {
//"startColor": "fa5956",
//"endColor": "fa9b4d",
//"mainItem": {
//"title": "酒店",
//"icon": "https://pic.c-ctrip.com/platform/h5/home/grid-nav-items-hotel.png",
//"url": "https://m.ctrip.com/webapp/hotel/",
//"statusBarColor": "4289ff"
//},
//"item1": {
//"title": "海外酒店",
//"url": "https://m.ctrip.com/webapp/hotel/oversea/?otype=1",
//"statusBarColor": "4289ff"
//},
//"item2": {
//"title": "特价酒店",
//"url": "https://m.ctrip.com/webapp/hotel/hotsale"
//},
//"item3": {
//"title": "团购",
//"url": "https://m.ctrip.com/webapp/tuan/?secondwakeup=true&dpclickjump=true",
//"hideAppBar": true
//},
//"item4": {
//"title": "民宿 客栈",
//"url": "https://m.ctrip.com/webapp/inn/index",
//"hideAppBar": true
//}
//},
//"flight": {
//"startColor": "4b8fed",
//"endColor": "53bced",
//"mainItem": {
//"title": "机票",
//"icon": "https://pic.c-ctrip.com/platform/h5/home/grid-nav-items-flight.png",
//"url": "https://m.ctrip.com/html5/flight/swift/index"
//},
//"item1": {
//"title": "火车票",
//"url": "https://m.ctrip.com/webapp/train/?secondwakeup=true&dpclickjump=true&from=https%3A%2F%2Fm.ctrip.com%2Fhtml5%2F#/index?VNK=4e431539",
//"hideAppBar": true
//},
//"item2": {
//"title": "特价机票",
//"url": "https://m.ctrip.com/html5/flight/swift/index"
//},
//"item3": {
//"title": "汽车票·船票",
//"url": "https://m.ctrip.com/html5/Trains/bus/",
//"hideAppBar": true
//},
//"item4": {
//"title": "专车·租车",
//"url": "https://m.ctrip.com/webapp/car/index?s=ctrip&from=https%3A%2F%2Fm.ctrip.com%2Fhtml5%2F",
//"hideAppBar": true
//}
//},
//"travel": {
//"startColor": "34c2aa",
//"endColor": "6cd557",
//"mainItem": {
//"title": "旅游",
//"icon": "https://pic.c-ctrip.com/platform/h5/home/grid-nav-items-travel.png",
//"url": "https://m.ctrip.com/webapp/vacations/tour/vacations",
//"hideAppBar": true,
//"statusBarColor": "19A0F0"
//},
//"item1": {
//"title": "门票",
//"url": "https://m.ctrip.com/webapp/ticket/ticket",
//"statusBarColor": "19A0F0",
//"hideAppBar": true
//},
//"item2": {
//"title": "目的地攻略",
//"url": "https://m.ctrip.com/html5/you/",
//"statusBarColor": "19A0F0",
//"hideAppBar": true
//},
//"item3": {
//"title": "邮轮旅行",
//"url": "https://m.ctrip.com/webapp/cruise/index",
//"hideAppBar": true
//},
//"item4": {
//"title": "定制旅行",
//"url": "https://m.ctrip.com/webapp/dingzhi",
//"hideAppBar": true
//}
//}
//},
//"subNavList": [
//{
//"icon": "https://www.devio.org/io/flutter_app/img/sub_nav_wifi.png",
//"title": "WiFi电话卡",
//"url": "https://m.ctrip.com/webapp/activity/wifi",
//"hideAppBar": true
//},
//{
//"icon": "https://www.devio.org/io/flutter_app/img/sub_nav_visa.png",
//"title": "保险·签证",
//"url": "https://m.ctrip.com/webapp/tourvisa/entry",
//"hideAppBar": true
//},
//{
//"icon": "https://www.devio.org/io/flutter_app/img/sub_nav_exchange.png",
//"title": "外币兑换",
//"url": "https://dp.ctrip.com/webapp/forex/index?bid=2&1=1",
//"hideAppBar": true
//},
//{
//"icon": "https://www.devio.org/io/flutter_app/img/sub_nav_shopping.png",
//"title": "购物",
//"url": "https://m.ctrip.com/webapp/gshop/?ctm_ref=M_ps_2home_sl&bid=2&cid=3&pid=1",
//"hideAppBar": true
//},
//{
//"icon": "https://www.devio.org/io/flutter_app/img/sub_nav_guide.png",
//"title": "当地向导",
//"url": "https://m.ctrip.com/webapp/vacations/pguider/homepage?secondwakeup=true&dpclickjump=true&from=https%3A%2F%2Fm.ctrip.com%2Fhtml5%2F",
//"hideAppBar": true
//},
//{
//"icon": "https://www.devio.org/io/flutter_app/img/sub_nav_freetravel.png",
//"title": "自由行",
//"url": "https://dp.ctrip.com/webapp/vacations/idiytour/diyindex?navBarStyle=white",
//"hideAppBar": true
//},
//{
//"icon": "https://www.devio.org/io/flutter_app/img/sub_nav_play.png",
//"title": "境外玩乐",
//"url": "https://dp.ctrip.com/webapp/activity/overseasindex",
//"hideAppBar": true
//},
//{
//"icon": "https://www.devio.org/io/flutter_app/img/sub_nav_lipin.png",
//"title": "礼品卡",
//"url": "https://dp.ctrip.com/webapp/lipin/money",
//"hideAppBar": true
//},
//{
//"icon": "https://www.devio.org/io/flutter_app/img/sub_nav_credit.png",
//"title": "信用卡",
//"url": "https://dp.ctrip.com/webapp/cc/index?bid=8&cid=1&pid=4"
//},
//{
//"icon": "https://www.devio.org/io/flutter_app/img/sub_nav_more.png",
//"title": "更多",
//"url": "https://dp.ctrip.com/webapp/more/",
//"hideAppBar": true
//}
//],
//"salesBox": {
//"icon": "https://www.devio.org/io/flutter_app/img/sales_box_huodong.png",
//"moreUrl": "https://contents.ctrip.com/activitysetupapp/mkt/index/moreact",
//"bigCard1": {
//"icon": "https://dimg04.c-ctrip.com/images/700t0y000000m71h523FE_375_260_342.png",
//"url": "https://contents.ctrip.com/buildingblocksweb/special/membershipcard/index.html?sceneid=1&productid=14912&ishidenavbar=yes&pushcode=act_svip_hm31",
//"title": "活动"
//},
//"bigCard2": {
//"icon": "https://dimg04.c-ctrip.com/images/700a10000000portu2BAD_375_260_342.jpg",
//"url": "https://m.ctrip.com/webapp/you/livestream/plan/crhHotelList.html?liveAwaken=true&isHideHeader=true&isHideNavBar=YES&mktcrhcode=hotevent",
//"title": "活动"
//},
//"smallCard1": {
//"icon": "https://dimg04.c-ctrip.com/images/700b0z000000neoth8688_375_160_345.jpg",
//"url": "https://contents.ctrip.com/activitysetupapp/mkt/index/nbaafs?pushcode=IP_nbaafs004",
//"title": "活动"
//},
//"smallCard2": {
//"icon": "https://dimg04.c-ctrip.com/images/700w0z000000mogkyEF78_375_160_345.jpg",
//"url": "https://smarket.ctrip.com/webapp/promocode/add?source=5",
//"title": "活动"
//},
//"smallCard3": {
//"icon": "https://dimg04.c-ctrip.com/images/700a0t000000im512AB2C_375_160_345.jpg",
//"url": "https://smarket.ctrip.com/webapp/promocode/add?source=5",
//"title": "活动"
//},
//"smallCard4": {
//"icon": "https://dimg04.c-ctrip.com/images/700d0s000000htvwo16C4_375_160_345.jpg",
//"url": "https://smarket.ctrip.com/webapp/promocode/add?source=5",
//"title": "活动"
//}
//}
//}
