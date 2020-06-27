class User {
  String _name;
  String _user;
  String _token;
  String _pswd;
  int _id;

  get name => _name;
  get user => _user;
  get token => _token;
  get pswd => _pswd;
  get id => _id;

  set name(value) => _name = value;

  set pswd(value) => this._pswd = value;

  User({name, user, token, pswd, id}) {
    this._name = name;
    this._user = user;
    this._token = token;
    this._pswd = pswd;
    this._id = id;
  }

  User.fromJson(Map<String, dynamic> object) {
    this._user = object['user'];
    this._name = object['name'];
    this._token = object['authToken'];
    this._id = object['id'];
    this._pswd = '';
  }

  toMap() {
    final object = {
      'user': this._user,
      'pswd': this._pswd,
    };

    return object;
  }
}