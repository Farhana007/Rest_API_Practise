import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_api/models/model.dart';
import 'package:http/http.dart' as http;
import 'package:velocity_x/velocity_x.dart';

class ClassOneApi extends StatefulWidget {
  const ClassOneApi({super.key});

  @override
  State<ClassOneApi> createState() => _ClassOneApiState();
}

class _ClassOneApiState extends State<ClassOneApi> {
  //creating list to store datas from api
  List<UserModel> userlsit = [];

  // function to get data form api

  Future<List<UserModel>> getApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      userlsit.clear();
      for (Map i in data) {
        userlsit.add(UserModel.fromJson(i));
      }
      return userlsit;
    }
    return userlsit;
  }

  //icon var

  IconData _iconData = (Icons.favorite_border_outlined);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 216, 214),
      body: Center(
        child: Expanded(
            child: FutureBuilder(
                future: getApi(),
                builder: ((context, snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  } else {
                    return ListView.builder(
                        itemCount: userlsit.length,
                        itemBuilder: ((context, index) {
                          return Card(
                            child: ListTile(
                                title: Text(userlsit[index].name.toString()),
                                subtitle:
                                    Text(userlsit[index].email.toString()),
                                trailing: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _iconData = Icons.favorite;
                                      });
                                    },
                                    icon: Icon(
                                      _iconData,
                                    ))),
                          );
                        }));
                  }
                }))),
      ),
    );
  }
}
