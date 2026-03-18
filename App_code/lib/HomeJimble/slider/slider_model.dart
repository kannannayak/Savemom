class BannerViewModel {
  bool? status;
  String? message;
  List<Datum>? data;

  BannerViewModel({
    this.status,
    this.message,
    this.data,
  });

  factory BannerViewModel.fromJson(Map<String, dynamic> json) =>
      BannerViewModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
  };

  @override
  String toString() {
    return 'BannerViewModel(status: $status, message: $message, data: $data)';
  }
}

class Datum {
  int? bId;
  String? location;
  String? bannerImg;
  String? sendTo;

  Datum({
    this.bId,
    this.location,
    this.bannerImg,
    this.sendTo,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    bId: json["b_id"],
    location: json["location"],
    bannerImg: json["banner_img"],
    sendTo: json["send_to"],
  );

  Map<String, dynamic> toJson() => {
    "b_id": bId,
    "location": location,
    "banner_img": bannerImg,
    "send_to": sendTo,
  };

  @override
  String toString() {
    return 'Datum(bId: $bId, location: $location, bannerImg: $bannerImg, sendTo: $sendTo)';
  }
}
