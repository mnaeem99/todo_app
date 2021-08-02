class Todo {
  int _id;
  String _title;
  String _description;
  String _date;
  int _priority;
  Todo(this._title, this._priority, this._date, [this._description]);
  Todo.withId(this._id, this._title, this._priority, this._date,
      [this._description]);
  int get id => _id;
  String get title => _title;
  String get description => _description;
  // ignore: unnecessary_getters_setters
  String get date => _date;
  int get priority => _priority;
  set title(String newTitle) {
    if (newTitle.length <= 255) {
      _title = newTitle;
    }
  }

  set description(String newdescription) {
    if (newdescription.length <= 255) {
      _title = newdescription;
    }
  }

  // ignore: unnecessary_getters_setters
  set date(String newDate) {
    _date = newDate;
  }

  set priority(int newPriority) {
    if (newPriority > 0 && newPriority <= 3) {
      _priority = newPriority;
    }
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["title"] = _title;
    map["description"] = _description;
    map["priority"] = _priority;
    map["date"] = _date;
    if (_id != null) {
      map["id"] = _id;
    }
    return map;
  }

  Todo.fromObject(dynamic o) {
    this._id = o["id"];
    this._title = o["title"];
    this._description = o["description"];
    this._date = o["date"];
    this._priority = o["priority"];
  }
}
