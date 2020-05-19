class PersonDetail {

  int id;
  int course_id;
  String name;
  String username;
  String email;
  String phone;
  String city;
  String country;
  String birthdate;

  PersonDetail({this.id,this.name,this.username, this.email, this.phone, this.city, this.country, this.birthdate, this.course_id});

  PersonDetail.initial()
      : id = 0,
        name = '',
        username = '',
        email = '',
        phone = '',
        city = '',
        country = '',
        birthdate = '',
        course_id = 0;


  PersonDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    country = json['country'];
    city = json['city'];
    birthdate = json['birthdate'];
    course_id = json['course_id'];
    phone = json['phone'];
  }

}