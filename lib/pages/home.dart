import 'package:crowdate/model/event.dart';
import 'package:crowdate/pages/following.dart';
import 'package:crowdate/pages/login.dart';
import 'package:crowdate/pages/search.dart';
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
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Search()));
            },
          )
        ],
      ),
      drawer: Drawer(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            UserAccountsDrawerHeader(
                accountName: Text("Name"), // TODO: Replace with user name.
                accountEmail: Text("Email"), // TODO: Replace with user email.
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage(
                      "assets/icon/Icon-512.png"), // TODO: Replace with network image.
                )),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.notifications, color: Colors.black54),
                  Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text("Followed Events"),
                  )
                ],
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Following()));
              },
            ),
            Expanded(child: Container()),
            Divider(
              color: Colors.black54,
              height: 1,
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.logout, color: Colors.black54),
                  Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text("Logout"),
                  )
                ],
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Login()));
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Logged out!"),
                ));
              },
            )
          ],
        ),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return EventPreview(
              model: EventViewModel(
                  model: EventModel(
                      address: "1414 Kelly Drive West Virginia",
                      currency: "USD",
                      id: "asd",
                      date: "2021-12-12",
                      genre: "Pop",
                      subGenre: "HipHop",
                      maxPrice: 12,
                      minPrice: 12,
                      name: "Concert",
                      imageURL:
                          "https://s1.ticketm.net/dam/a/bc3/48a3747f-f6e1-403f-bca8-658c20b98bc3_1544981_TABLET_LANDSCAPE_16_9.jpg")));
        },
        itemCount: 5,
      ),
    );
  }
}
