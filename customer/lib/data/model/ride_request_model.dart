import 'package:acoride/data/model/UserModel.dart';
import 'package:acoride/data/model/category_model.dart';
import 'package:acoride/data/model/trip_request_amount.dart';

class RideRequestModel {
  int? id;
  String? rideId;
  int? driverId;
  int? passengerId;
  String? passengerPickupAddress;
  double? passengerPickupLatitude;
  double? passengerPickupLongitude;
  String? passengerDestinationAddress;
  double? passengerDestinationLatitude;
  double? passengerDestinationLongitude;
  double? driverStartRideLatitude;
  double? driverStartRideLongitude;
  String? rideType;
  String? scheduleDateTime;
  String? scheduleStartRide;
  String? driverAcceptStatus;
  String? driverAcceptDatetime;
  String? driverStartRide;
  String? driverStartrideTime;
  String? completedStatus;
  String? completedStatusTime;
  String? km;
  String? kmInTime;
  String? paymentType;
  String? paymentCardNumber;
  String? estimatedPrice;
  String? amountPaid;
  String? cancelledBy;
  String? duration;
  String? onGoing;
  String? baseFareFee;
  String? distanceCovered;
  String? estimatedDistanceCovered;
  String? deletedAt;
  String? createdAt;
  UserModel? user;
  UserModel? deliveryUser;
  CategoryModel? categoryModel;
  TripAmountRequest? tripAmountRequest;

  RideRequestModel(
      {this.id,
        this.rideId,
        this.driverId,
        this.passengerId,
        this.passengerPickupAddress,
        this.passengerPickupLatitude,
        this.passengerPickupLongitude,
        this.passengerDestinationAddress,
        this.passengerDestinationLatitude,
        this.passengerDestinationLongitude,
        this.rideType,
        this.scheduleDateTime,
        this.scheduleStartRide,
        this.driverAcceptStatus,
        this.driverAcceptDatetime,
        this.driverStartRide,
        this.driverStartrideTime,
        this.completedStatus,
        this.completedStatusTime,
        this.km,
        this.kmInTime,
        this.paymentType,
        this.paymentCardNumber,
        this.estimatedPrice,
        this.amountPaid,
        this.cancelledBy,
        this.onGoing,
        this.baseFareFee,
        this.distanceCovered,
        this.deletedAt,
        this.duration,
        this.createdAt,
        this.estimatedDistanceCovered,
        this.user,
        this.deliveryUser,
        this.categoryModel,
        this.driverStartRideLatitude,
        this.driverStartRideLongitude,
      });

  RideRequestModel.fromMap(json) {
    id = json['id'];
    rideId = json['ride_id'];
    driverId = json['driver_id'];
    passengerId = json['passenger_id'];
    passengerPickupAddress = json['passenger_pickup_address'];
    passengerPickupLatitude = json['passenger_pickup_latitude'];
    passengerPickupLongitude = json['passenger_pickup_longitude'];
    passengerDestinationAddress = json['passenger_destination_address'];
    passengerDestinationLatitude = json['passenger_destination_latitude'];
    passengerDestinationLongitude = json['passenger_destination_longitude'];
    rideType = json['ride_type'];
    scheduleDateTime = json['schedule_date_time'];
    scheduleStartRide = json['schedule_start_ride'];
    driverAcceptStatus = json['driver_accept_status'];
    driverAcceptDatetime = json['driver_accept_datetime'];
    driverStartRide = json['driver_start_ride'];
    driverStartrideTime = json['driver_startride_time'];
    completedStatus = json['completed_status'];
    completedStatusTime = json['completed_status_time'];
    km = json['km'];
    duration = json['duration'];
    kmInTime = json['km_in_time'];
    paymentType = json['payment_type'];
    paymentCardNumber = json['payment_card_number'];
    estimatedPrice = json['estimated_price'];
    amountPaid = json['amount_paid'];
    cancelledBy = json['cancelled_by'];
    onGoing = json['on_going'];
    baseFareFee = json['base_fare_fee'];
    distanceCovered = json['distance_covered'];
    estimatedDistanceCovered = json['estimated_distance_covered'];
    deletedAt = json['deleted_at'];
    driverStartRideLatitude = json['driver_start_ride_latitude'];
    driverStartRideLongitude = json['driver_start_ride_longitude'];
    createdAt = json['created_at'];
    user = json['user'] != null ? UserModel.fromMap(json['user']) : null;
    deliveryUser = json['delivery_user'] != null ? UserModel.fromMap(json['delivery_user']) : null;
    categoryModel = json['category'] != null ? CategoryModel.fromJson(json['category']) : null;
    tripAmountRequest = json['trip_amount'] != null ? TripAmountRequest.fromMap(json['trip_amount']) : null;
  }

  Map<String?, dynamic> toMap() {
    final Map<String?, dynamic> data = Map<String?, dynamic>();
    data['id'] = id;
    data['ride_id'] = rideId;
    data['driver_id'] = driverId;
    data['passenger_id'] = passengerId;
    data['passenger_pickup_address'] = passengerPickupAddress;
    data['passenger_pickup_latitude'] = passengerPickupLatitude;
    data['passenger_pickup_longitude'] = passengerPickupLongitude;
    data['passenger_destination_address'] = passengerDestinationAddress;
    data['passenger_destination_latitude'] = passengerDestinationLatitude;
    data['passenger_destination_longitude'] =
        passengerDestinationLongitude;
    data['ride_type'] = rideType;
    data['schedule_date_time'] = scheduleDateTime;
    data['schedule_start_ride'] = scheduleStartRide;
    data['driver_accept_status'] = driverAcceptStatus;
    data['driver_accept_datetime'] = driverAcceptDatetime;
    data['driver_start_ride'] = driverStartRide;
    data['driver_startride_time'] = driverStartrideTime;
    data['completed_status'] = completedStatus;
    data['completed_status_time'] = completedStatusTime;
    data['km'] = km;
    data['km_in_time'] = kmInTime;
    data['payment_type'] = paymentType;
    data['payment_card_number'] = paymentCardNumber;
    data['estimated_price'] = estimatedPrice;
    data['amount_paid'] = amountPaid;
    data['cancelled_by'] = cancelledBy;
    data['duration'] = duration;
    data['on_going'] = onGoing;
    data['base_fare_fee'] = baseFareFee;
    data['distance_covered'] = distanceCovered;
    data['estimated_distance_covered'] = estimatedDistanceCovered;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    if (user != null) {
      data['user'] = user!.toMap();
    }
    if (deliveryUser != null) {
      data['delivery_user'] = deliveryUser!.toMap();
    }
    if (categoryModel != null) {
      data['category'] = categoryModel!.toJson();
    }
    if (tripAmountRequest != null) {
      data['trip_amount'] = tripAmountRequest!.toMap();
    }
    return data;
  }
}
