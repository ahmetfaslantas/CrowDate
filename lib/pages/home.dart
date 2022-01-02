import 'package:crowdate/pages/following.dart';
import 'package:crowdate/pages/login.dart';
import 'package:crowdate/pages/search.dart';
import 'package:crowdate/view/eventpreviewlist.dart';
import 'package:crowdate/viewmodel/eventlist.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<EventListViewModel>(context, listen: false).fetchEvents();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Recent Events"),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                Provider.of<EventListViewModel>(context, listen: false).clear();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Search()));
              },
            )
          ],
        ),
        drawer: Drawer(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const UserAccountsDrawerHeader(
                  accountName: Text("Name"), // TODO: Replace with user name.
                  accountEmail: Text("Email"), // TODO: Replace with user email.
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: AssetImage(
                        "assets/icon/Icon-512.png"), // TODO: Replace with network image.
                  )),
              ListTile(
                title: Row(
                  children: const [
                    Icon(Icons.notifications, color: Colors.black54),
                    Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Text("Followed Events"),
                    )
                  ],
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const Following()));
                },
              ),
              Expanded(child: Container()),
              const Divider(
                color: Colors.black54,
                height: 1,
              ),
              ListTile(
                title: Row(
                  children: const [
                    Icon(Icons.logout, color: Colors.black54),
                    Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Text("Logout"),
                    )
                  ],
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Login()));
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Logged out!"),
                  ));
                },
              )
            ],
          ),
        ),
        body: Consumer<EventListViewModel>(
          builder: (context, list, child) {
            return EventPreviewList(eventsPreview: list);
          },
        ));
  }
}
