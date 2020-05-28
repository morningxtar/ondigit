class Place {

  var id;
  String serviceType;
  String computerNumber;
  String dateReservation;
  String timeReservation;
  String userEmail;
  var access;

  Place({
    this.id,
    this.serviceType,
    this.computerNumber,
    this.dateReservation,
    this.timeReservation,
    this.userEmail,
    this.access,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      id: json['id'],
      serviceType: json['serviceType'],
      computerNumber: json['computerNumber'],
      dateReservation: json['dateReservation'],
      timeReservation: json['timeReservation'],
      userEmail: json['userEmail'],
      access: json['access'],
    );
  }
}