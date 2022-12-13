import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Contact_screen extends StatefulWidget {
  const Contact_screen({super.key});
  @override
  State<Contact_screen> createState() => _Contact_screenState();
}

class _Contact_screenState extends State<Contact_screen> {
  List<dynamic> users = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              final name = user['name']['first'];
              final email = user['email'];
              final imageUrl = user['picture']['thumbnail'];
              return ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(imageUrl),
                ),
                title: Text(name.toString()),
                subtitle: Text(email),
              );
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: fetchUsers,
          child: const Icon(Icons.refresh),
        ));
  }

//clase del boton llamado a la api
  void fetchUsers() async {
    print("holi soy el boton");
    const url = 'https://randomuser.me/api/?results=50';
    final uri = Uri.parse(url);
    final reponse = await http.get(uri);
    final body = reponse.body;
    final json = jsonDecode(body);
    setState(() {
      users = json['results'];
    });
    print("Completado");
  }
}
