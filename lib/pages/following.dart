import 'package:crowdate/view/eventpreviewlist.dart';
import 'package:crowdate/viewmodel/eventlist.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Following extends StatefulWidget {
  const Following({Key? key}) : super(key: key);

  @override
  State<Following> createState() => _FollowingState();
}

class _FollowingState extends State<Following> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<EventListViewModel>(context, listen: false).fetchFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
                pinned: true,
                floating: true,
                leading: const BackButton(),
                expandedHeight: 200,
                flexibleSpace: LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  var top = constraints.biggest.height;
                  return FlexibleSpaceBar(
                    title: AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity: top > 71 && top < 91 ? 1.0 : 0.0,
                        child: const Text("Followed Events")),
                    background: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: CircleAvatar(
                              radius: 30,
                              child: ClipOval(
                                child: Image(image: NetworkImage(FirebaseAuth.instance.currentUser!.photoURL ?? "https://icon-library.com/images/anonymous-avatar-icon/anonymous-avatar-icon-25.jpg"),),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                              elevation: 4,
                              child: SizedBox(
                                width: 120,
                                height: 60,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text("Followed Events"),
                                    Consumer<EventListViewModel>(
                                      builder: (context, list, child) {
                                        return Text(
                                            list.eventsModel.length.toString());
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }))
          ];
        },
        body: Consumer<EventListViewModel>(
          builder: (context, list, child) {
            return EventPreviewList(eventsPreview: list, expandable: false);
          },
        ),
      ),
    );
  }
}
