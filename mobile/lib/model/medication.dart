class Medication {
  int _id;
  String _name;
  String _description;
  double _value;

  int get id => _id;
  String get name => _name;
  String get description => _description;
  double get value => _value;

  Medication(id, name, description, value) {
    this._id = id;
    this._name = name;
    this._description = description;
    this._value = value;
  }

  Medication.fromJson(object) {
    this._id = object['id'];
    this._name = object['name'];
    this._description = object['description'];
    this._value = double.parse(object['value'].toString());
  }

  Map<String, dynamic> toMap({bool withId = false}) {
    final Map<String, dynamic> map = new Map<String, dynamic>();
    if(withId) map['id'] = this._id;
    map['name'] = this._name;
    map['description'] = this._description;
    map['value'] = this._value.toString();

    return map;
  }
}