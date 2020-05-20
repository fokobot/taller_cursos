import 'package:flutter/material.dart';
import 'package:taller_cursos/data/person_detail.dart';

class ProfilePage extends StatelessWidget {
  
  final PersonDetail _personDetail;

  ProfilePage(this._personDetail);
      
  TextStyle _style() {
    return TextStyle(fontWeight: FontWeight.bold);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Name"),
            SizedBox(
              height: 4,
            ),
            Text(
              this._personDetail.name,
              style: _style(),
            ),
            SizedBox(
              height: 16,
            ),
            Text("Username", style: _style()),
            SizedBox(
              height: 4,
            ),
            Text(
              this._personDetail.username,
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "Phone",
              style: _style(),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              this._personDetail.phone,
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "Email",
              style: _style(),
            ),
            SizedBox(
              height: 4,
            ),
            Text(this._personDetail.email),
            SizedBox(
              height: 16,
            ),
            Text(
              "City",
              style: _style(),
            ),
            SizedBox(
              height: 4,
            ),
            Text(this._personDetail.city),
            SizedBox(
              height: 16,
            ),
            Text(
              "Country",
              style: _style(),
            ),
            SizedBox(
              height: 4,
            ),
            Text(this._personDetail.country),
            SizedBox(
              height: 16,
            ),
            Text(
              "Birthday",
              style: _style(),
            ),
            SizedBox(
              height: 4,
            ),
            Text(this._personDetail.birthday),
            SizedBox(
              height: 16,
            ),
            Divider(
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}

final String url =
    "https://ohsobserver.com/wp-content/uploads/2017/09/DrHendrickson-800x1200.jpg";

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => Size(double.infinity, 320);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyClipper(),
      child: Container(
        padding: EdgeInsets.only(top: 4),
        decoration: BoxDecoration(color: Colors.redAccent, boxShadow: [
          BoxShadow(color: Colors.red, blurRadius: 20, offset: Offset(0, 0))
        ]),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover, image: NetworkImage(url))),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Milan Short",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path p = Path();

    p.lineTo(0, size.height - 70);
    p.lineTo(size.width, size.height);

    p.lineTo(size.width, 0);

    p.close();

    return p;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
