import 'package:flutter/material.dart';
import 'package:taller_cursos/data/person.dart';

class PersonsList extends StatelessWidget {


  final List<Person> items;
  final Function onTap;

  PersonsList({Key key, this.items, this.onTap});

  @override
  Widget build(BuildContext context) {
    return _list(context);
  }

  Widget _list(BuildContext contex) {
    return ListView.builder(
      itemCount: this.items.length,
      itemBuilder: (context, posicion) {
        var element = this.items[posicion];
        return _item(context, element);
      },
    );
  }

  Widget _item(BuildContext context, Person element){
    return Card(
      child: InkWell(
        onTap: () {
          this.onTap(element);
        },
        child: Container(
          child: ListTile(
            title: Text(element.name),
            subtitle: Text("Email: ${element.email}\n"),
          ),
        ),
      ),
    );
  }
  
}