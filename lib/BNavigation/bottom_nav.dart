import 'package:flutter/material.dart';

class BNavigator extends StatefulWidget {
  final Function currentIndex;
  const BNavigator({Key? key, required this.currentIndex}) : super(key: key);

  @override
  State<BNavigator> createState() => _BNavigatorState();
}

class _BNavigatorState extends State<BNavigator> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: index,
      onTap: (int i) {
        setState(() {
          index = i;
          widget.currentIndex(i);
        });
      },
      //para añadir mas secciones en el navbar
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.brown,
      iconSize: 25.0,
      selectedFontSize: 18.0,
      unselectedFontSize: 12.0,
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.currency_bitcoin),
            label: 'Coins',
            backgroundColor: Colors.blueGrey),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_outline),
          label: 'Following',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.supervised_user_circle_sharp),
          label: 'User',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.precision_manufacturing_outlined),
          label: 'Correción',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Contactos',
        )
      ],
    );
  }
}
