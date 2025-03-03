class School{
  final int id;
  final String name;

  School(this.id, this.name);

  factory School.fromMap(Map<String, dynamic> map){
    return School(
        int.parse(map[idKey].toString()), map[nameKey].toString());
  }

  static const idKey = 'id';
  static const nameKey = 'name';
}