class Kyc {
  int? id;
  int? acorideUserId;
  String? profileImage;
  String? kycDocumentType;
  String? kycDocumentImage;
  String? kycDocumentNumber;

  Kyc(
      {this.id,
        this.acorideUserId,
        this.profileImage,
        this.kycDocumentType,
        this.kycDocumentImage,
        this.kycDocumentNumber});

  Kyc.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    acorideUserId = json['acoride_user_id'];
    profileImage = json['profile_image'];
    kycDocumentType = json['kyc_document_type'];
    kycDocumentImage = json['kyc_document_image'];
    kycDocumentNumber = json['kyc_document_number'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['acoride_user_id'] = acorideUserId;
    data['profile_image'] = profileImage;
    data['kyc_document_type'] = kycDocumentType;
    data['kyc_document_image'] = kycDocumentImage;
    data['kyc_document_number'] = kycDocumentNumber;
    return data;
  }
}