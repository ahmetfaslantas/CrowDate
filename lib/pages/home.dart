import 'package:crowdate/model/event.dart';
import 'package:crowdate/view/eventpreview.dart';
import 'package:crowdate/viewmodel/event.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recent Events"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      body: Center(),
      drawer: Drawer(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            UserAccountsDrawerHeader(
                accountName: Text("Name"), // TODO: Replace with user name.
                accountEmail: Text("Email"), // TODO: Replace with user email.
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage("assets/icon/Icon-512.png"), // TODO: Replace with network image.
                )),
            Expanded(child: Container()),
            Divider(
              color: Colors.black54,
              height: 1,
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.logout),
                  Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text("Logout"),
                  )
                ],
              ),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Logged out!"),));
              },
            )
          ],
        ),
      ),
    );
  }
}
