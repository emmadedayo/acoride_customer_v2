class UserBank {
  int? id;
  int? userId;
  String? bankCode;
  String? bankName;
  String? accountNumber;
  String? accountName;
  String? isActive;
  String? recipientCode;

  UserBank(
      {this.id,
        this.userId,
        this.bankCode,
        this.bankName,
        this.accountNumber,
        this.accountName,
        this.isActive,
        this.recipientCode});

  UserBank.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    bankCode = json['bank_code'];
    bankName = json['bank_name'];
    accountNumber = json['account_number'];
    accountName = json['account_name'];
    isActive = json['is_active'];
    recipientCode = json['recipient_code'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['user_id'] = userId;
    data['bank_code'] = bankCode;
    data['bank_name'] = bankName;
    data['account_number'] = accountNumber;
    data['account_name'] = accountName;
    data['is_active'] = isActive;
    data['recipient_code'] = recipientCode;
    return data;
  }
}