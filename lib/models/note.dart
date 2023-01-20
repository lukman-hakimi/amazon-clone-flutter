class Note {
  late String id;
  late String title;
  late String date;
  late String desc;

  Note.fromJson(Map<String, dynamic> json){
    id = json["id"];
    title = json["title"];
    date = json["date"];
    desc = json["desc"];
  }
}