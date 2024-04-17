class CoursesModel {
  String? teacherId;
  String? teacherName;
  String? imageUrl;
  String? name;
  String? teacherImageUrl;
  String? id;

  CoursesModel(
      {this.teacherId,
        this.teacherName,
        this.imageUrl,
        this.name,
        this.teacherImageUrl,
        this.id});

  CoursesModel.fromJson(Map<String, dynamic> json) {
    teacherId = json['teacherId'];
    teacherName = json['teacherName'];
    imageUrl = json['imageUrl'];
    name = json['name'];
    teacherImageUrl = json['teacherImageUrl'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['teacherId'] = this.teacherId;
    data['teacherName'] = this.teacherName;
    data['imageUrl'] = this.imageUrl;
    data['name'] = this.name;
    data['teacherImageUrl'] = this.teacherImageUrl;
    data['id'] = this.id;
    return data;
  }
}
