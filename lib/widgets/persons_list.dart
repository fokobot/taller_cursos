import 'package:flutter/material.dart';
import 'package:taller_cursos/data/person.dart';

class PersonsList extends StatelessWidget {


  final List<Person> _items;
  PersonsList(this._items);

  @override
  Widget build(BuildContext context) {
    return _list(context);
  }

  Widget _list(BuildContext contex) {
    return ListView.builder(
      itemCount: this._items.length,
      itemBuilder: (context, posicion) {
        var element = this._items[posicion];
        return _item(context, element);
      },
    );
  }

  Widget _item(BuildContext context, Person element){
    return Card(
      child: InkWell(
        onTap: () {
          print("Detalle");
          //getDetail(context, element.id);
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