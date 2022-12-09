class AppSettings {
  int? id;
  String? androidAppVersion;
  String? iosAppVersion;
  bool? isUpdate;
  bool? forceUpdate;
  int? dailyCommission;

  AppSettings(
      {this.id,
        this.androidAppVersion,
        this.iosAppVersion,
        this.isUpdate,
        this.forceUpdate,
        this.dailyCommission});

  AppSettings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    androidAppVersion = json['android_app_version'];
    iosAppVersion = json['ios_app_version'];
    isUpdate = json['is_update'];
    forceUpdate = json['force_update'];
    dailyCommission = json['daily_commission'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['android_app_version'] = this.androidAppVersion;
    data['ios_app_version'] = this.iosAppVersion;
    data['is_update'] = this.isUpdate;
    data['force_update'] = this.forceUpdate;
    data['daily_commission'] = this.dailyCommission;
    return data;
  }
}
