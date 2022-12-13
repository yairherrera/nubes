import 'package:flutter/material.dart';

class contact_home_screen extends StatefulWidget {
  const contact_home_screen({super.key});

  @override
  State<contact_home_screen> createState() => _contact_home_screenState();
}

class _contact_home_screenState extends State<contact_home_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
      onPressed: fetchUsers,
    ));
  }

//clase del boton
  void fetchUsers() {
    print("holi soy el boton");
  }
}
