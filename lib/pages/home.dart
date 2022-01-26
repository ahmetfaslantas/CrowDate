import 'dart:async';

import 'package:crowdate/pages/following.dart';
import 'package:crowdate/pages/login.dart';
import 'package:crowdate/pages/search.dart';
import 'package:crowdate/view/eventpreviewlist.dart';
import 'package:crowdate/viewmodel/eventlist.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:connectivity_plus/connectivity_plus.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Connectivity _connectivity = Connectivity();
  ConnectivityResult _connectionStatus = ConnectivityResult.wifi;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    _connectivity.checkConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((event) {
      setState(() {
        _connectionStatus = event;
      });

      if (_connectionStatus != ConnectivityResult.none) {
        Provider.of<EventListViewModel>(context, listen: false).fetchEvents();
      }
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Recent Events"),
          actions: [
            _connectionStatus != ConnectivityResult.none ? IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                Provider.of<EventListViewModel>(context, listen: false).clear();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Search()));
              },
            ) : Container()
          ],
        ),
        drawer: _connectionStatus != ConnectivityResult.none ? Drawer(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              UserAccountsDrawerHeader(
                  accountName: Text(
                      FirebaseAuth.instance.currentUser!.displayName ??
                          "Anonymous"),
                  accountEmail: Text(FirebaseAuth.instance.currentUser!.email ??
                      "No Email Provided"),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(FirebaseAuth
                            .instance.currentUser!.photoURL ??
                        "https://icon-library.com/images/anonymous-avatar-icon/anonymous-avatar-icon-25.jpg"),
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
                  FirebaseAuth.instance.signOut().then((value) => {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Login())),
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Logged out!"),
                        ))
                      });
                },
              )
            ],
          ),
        ) : null,
        body: _connectionStatus == ConnectivityResult.none
            ? Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.wifi_off_outlined, size: 50,),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("No Internet Connection!", style: TextStyle(color: Colors.black54, fontSize: 25),),
                )
              ],
            ))
            : Consumer<EventListViewModel>(
                builder: (context, list, child) {
                  return EventPreviewList(
                      eventsPreview: list, expandable: true);
                },
              ));
  }
}
