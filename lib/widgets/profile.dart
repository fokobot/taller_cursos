import 'package:taller_cursos/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Consumer<UserModel>(
              builder: (context, user, child){
                return Text(
                  "Bienvenido, ${user.username}."
                );
              },
            ),
          ),
          Spacer(),
          Row(children: <Widget>[
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(30.0),
                  color: Color(0xff01A0C7),
                  child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    //padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Cerrar Sesión",
                      style: TextStyle(
                        fontFamily: 'Montserrat', 
                        fontSize: 20.0,
                        color: Colors.white
                      ),
                    ),
                    onPressed: () => Provider.of<UserModel>(context, listen: false).signOut(),
                  ),
                ),
              ),
            )]
          ),
        ],
      )
    );
  }
}