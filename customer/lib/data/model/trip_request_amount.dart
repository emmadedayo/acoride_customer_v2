class TripAmountRequest {
  int? id;
  String? rideId;
  String? basePrice;
  String? timePrice;
  String? bookingFee;
  String? distanceFee;
  String? total;

  TripAmountRequest(
      {this.id,
        this.rideId,
        this.basePrice,
        this.timePrice,
        this.bookingFee,
        this.distanceFee,
        this.total
      });

  TripAmountRequest.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    rideId = json['ride_id'];
    basePrice = json['base_price'];
    timePrice = json['time_price'];
    bookingFee = json['booking_fee'];
    distanceFee = json['distance_fee'];
    total = json['total'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['ride_id'] = rideId;
    data['base_price'] = basePrice;
    data['time_price'] = timePrice;
    data['booking_fee'] = bookingFee;
    data['distance_fee'] = distanceFee;
    data['total'] = total;
    return data;
  }
}
