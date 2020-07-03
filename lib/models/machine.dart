class Machine {

  var id;
  String libelle;

  Machine({this.id ,this.libelle});

  factory Machine.fromJson(Map<String, dynamic> json) {
    return Machine(
      id: json['id'],
      libelle: json['libelle'],
    );
  }
}