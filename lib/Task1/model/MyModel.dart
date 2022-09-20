class MyModel {
  int? id;
  String? name;
  String? description;
  String? date;
  String? time;
  String? priority;
  String? taskstatus;

  ModelUserMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id ?? null;
    mapping['taskname'] = name;
    mapping['description'] = description;
    mapping['date'] = date;
    mapping['time'] = time;
    mapping['priority'] = priority;
    mapping['taskstatus'] = taskstatus;
    return mapping;
  }
}
