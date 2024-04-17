class UserModel {
  String? firstName;
  String? lastName;
  String? userName;
  String? image;
  String? email;
  String? accountType;
  String? uid;
  List<CourseModel?>? courses;

  UserModel(
      {this.firstName, this.lastName, this.userName, this.email, this.accountType, this.uid, this.image, this.courses});

  UserModel.fromJson(Map<String, dynamic>? json) {
    lastName = json != null ? json['lastName'] : null;
    firstName = json != null ? json['firstName'] : null;
    userName = json != null ? json['userName'] : null;
    email = json != null ? json['email'] : null;
    accountType = json != null ? json['accountType'] : null;
    image = json != null ? json['image'] : null;
    uid = json != null ? json['uid'] : null;
    if (json != null && json['courses'] != null) {
      courses = <CourseModel>[];
      json['courses'].forEach((v) {
        courses!.add(CourseModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lastName'] = lastName;
    data['firstName'] = firstName;
    data['userName'] = userName;
    data['email'] = email;
    data['accountType'] = accountType;
    data['image'] = image;
    data['uid'] = uid;
    if (courses != null) {
      data['courses'] = courses!.map((v) => v?.toJson()).toList();
    }
    return data;
  }
}

class CourseModel {
  String? id;
  String? imageUrl;
  String? name;
  String? teacherName;

  CourseModel({this.id, this.imageUrl, this.name, this.teacherName});

  CourseModel.fromJson(Map<String, dynamic>? json) {
    id = json != null ? json['id'] : null;
    imageUrl = json != null ? json['imageUrl'] : null;
    name = json != null ? json['name'] : null;
    teacherName = json != null ? json['teacherName'] : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['imageUrl'] = this.imageUrl;
    data['name'] = this.name;
    data['teacherName'] = this.teacherName;
    return data;
  }
}
