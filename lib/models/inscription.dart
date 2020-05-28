class Inscription {

  var id;
  String firstName;
  String lastName;
  String phoneNumber;
  String email;
  String password;
  String comments;
  String userType;

  Inscription({
    this.id,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.email,
    this.password,
    this.comments,
    this.userType,
  });

  factory Inscription.fromJson(Map<String, dynamic> json) {
    return Inscription(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      password: json['password'],
      comments: json['comments'],
      userType: json['userType'],
    );
  }
}