class Banner {
  String status;
  String message;
  String response;

  static List<BannerSliderItem> bannersliderLIst;

  Banner.getuserid(dynamic obj) {
    bannersliderLIst = obj
        .map<BannerSliderItem>((json) => new BannerSliderItem.fromJson(json))
        .toList();
  }
}

class BannerSliderItem {
  final String bannersliderid;
  final String bannerslidername;
  final String bannerslidernamealignment;
  final String bannersliderimage;
  final String bannerslidershowbutton;
  final String bannersliderbuttonalignment;
  final String bannersliderbuttontext;
  final String bannersliderorder;
  final String bannersliderstatus;

  BannerSliderItem({
    this.bannersliderid,
    this.bannerslidershowbutton,
    this.bannerslidernamealignment,
    this.bannersliderimage,
    this.bannersliderbuttonalignment,
    this.bannersliderbuttontext,
    this.bannerslidername,
    this.bannersliderorder,
    this.bannersliderstatus,
  });

  factory BannerSliderItem.fromJson(Map<String, dynamic> jsonMap) {
    return BannerSliderItem(
        bannersliderid: jsonMap['banner_slider_id'],
        bannerslidername: jsonMap['banner_slider_name'],
        bannerslidernamealignment: jsonMap['banner_slider_name_alignment'],
        bannersliderimage: jsonMap['banner_slider_image'],
        bannerslidershowbutton: jsonMap['banner_slider_show_button'],
        bannersliderbuttonalignment: jsonMap['banner_slider_button_alignment'],
        bannersliderbuttontext: jsonMap['banner_slider_button_text'],
        bannersliderorder: jsonMap['banner_slider_order'],
        bannersliderstatus: jsonMap['banner_slider_status']);
  }
}
