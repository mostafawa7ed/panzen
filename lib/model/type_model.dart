class TypeModel {
  String? id;
  String? name;

  TypeModel({
    this.id,
    this.name,
  });

  TypeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

// Factory method to create User object from a map
  factory TypeModel.fromMap(Map<String, dynamic> map) {
    return TypeModel(
      id: map['id'].toString(),
      name: map['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;

    return data;
  }
}
