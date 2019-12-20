import 'dart:io';

class Visitor {
  final String id;
  final String mmyy;
  final String hostName;
  final String visitorName;
  final String wbsCode;
  final String title;
  final String company;
  final String homeCountry;
  final String project;
  final String purposeVisit;
  final String travelType;
  final String workstation;
  final String arrivalDatetime;
  final String arrivalFlight;
  final String departureDatetime;
  final String departureFlight;
  final String hotel;
  final String pickup;
  final String checkinDate;
  final String checkoutDate;
  final String hasAsset;
  final String visitorPicture;
  final List<Asset> asset;
  Visitor(
      {this.id,
      this.mmyy,
      this.hostName,
      this.visitorName,
      this.wbsCode,
      this.title,
      this.company,
      this.homeCountry,
      this.project,
      this.purposeVisit,
      this.travelType,
      this.workstation,
      this.arrivalDatetime,
      this.arrivalFlight,
      this.departureDatetime,
      this.departureFlight,
      this.hotel,
      this.pickup,
      this.checkinDate,
      this.checkoutDate,
      this.hasAsset,
      this.asset,
      this.visitorPicture});

  factory Visitor.fromJson(Map<String, dynamic> json) {
    return Visitor(
      id: json['visitor_id'],
      title: json['title'],
      hostName: json['host_name'],
      visitorName: json['visitor_name'],
      wbsCode: json['wbs_code'],
      company: json['company'],
      homeCountry: json['home_country'],
      project: json['project'],
      purposeVisit: json['purpose_visit'],
      travelType: json['travel_type'],
      workstation: json['workstation'],
      arrivalDatetime: json['arrival_datetime'],
      arrivalFlight: json['arrival_flight'],
      departureDatetime: json['departure_datetime'],
      departureFlight: json['departure_flight'],
      hotel: json['hotel'],
      pickup: json['pickup'],
      checkinDate: json['checkin_date'],
      checkoutDate: json['checkout_date'],
      hasAsset: json['has_asset'],
      asset: (json['asset'] as List)
          .map((data) => new Asset.fromJson(data))
          .toList(),
      visitorPicture: json['visitor_picture'],
    );
  }
}

class Asset {
  final String assetId;
  final String userId;
  final String userType;
  final String assetTag;

  final String assetImage;
  final String registrationDate;
  Asset(
      {this.assetId,
      this.assetTag,
      this.assetImage,
      this.registrationDate,
      this.userId,
      this.userType});
  factory Asset.fromJson(Map<String, dynamic> json) {
    return Asset(
        assetId: json['asset_id'],
        userId: json['user_id'],
        userType: json['user_type'],
        assetTag: json['asset_tag'],
        assetImage: json['asset_image'],
        registrationDate: json['registration_date']);
  }
}

class Account {
  final String userType;
  Account({
    this.userType,
  });
  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      userType: 'usertype',
    );
  }
}
