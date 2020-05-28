class Service {

  var id;
  String libelle;

  Service({this.id ,this.libelle});

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      libelle: json['libelle'],
    );
  }
}