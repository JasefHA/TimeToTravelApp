import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('la flaca'),
            accountEmail: Text('laflaca@test.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                  child: Image.asset(
                'assets/pexels-zeyneb-alishova-12507501.jpg',
                width: 90,
                height: 90,
                fit: BoxFit.cover,
              )),
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/judeus-samson-tI6m-AXpAsg-unsplash.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Favoritos'),
            onTap: null,
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text('Amigos'),
            onTap: null,
          ),
          ListTile(
            leading: Icon(Icons.share),
            title: Text('Compartir'),
            onTap: null,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Configuración'),
            onTap: null,
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notificaciones'),
            onTap: null,
            trailing: ClipOval(
              child: Container(
                color: Colors.red,
                width: 20,
                height: 20,
                child: Center(
                  child: Text(
                    '8',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Salir'),
            onTap: null,
          ),
        ],
      ),
    );
  }
}
