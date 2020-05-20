class PersonDetail {

  int id;
  int course_id;
  String name;
  String username;
  String email;
  String phone;
  String city;
  String country;
  String birthday;

  PersonDetail({this.id,this.name,this.username, this.email, this.phone, this.city, this.country, this.birthday, this.course_id});

  PersonDetail.initial()
      : id = 0,
        name = '',
        username = '',
        email = '',
        phone = '',
        city = '',
        country = '',
        birthday = '',
        course_id = 0;


  PersonDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    country = json['country'];
    city = json['city'];
    birthday = json['birthday'];
    course_id = json['course_id'];
    phone = json['phone'];
  }

}