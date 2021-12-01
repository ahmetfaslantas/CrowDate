import 'package:crowdate/model/event.dart';
import 'package:crowdate/view/eventpreview.dart';
import 'package:crowdate/viewmodel/event.dart';
import 'package:flutter/material.dart';

class Following extends StatelessWidget {
  const Following({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
              pinned: true,
              floating: true,
              leading: const BackButton(),
              expandedHeight: 200,
              flexibleSpace: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
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
                              child: Image.asset("assets/icon/Icon-512.png"),
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
                                children: const [
                                  Text("Followed Events"),
                                  Text("3")
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              })),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => EventPreview(
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
                              "https://s1.ticketm.net/dam/a/bc3/48a3747f-f6e1-403f-bca8-658c20b98bc3_1544981_TABLET_LANDSCAPE_16_9.jpg"))),
              childCount: 3,
            ),
          )
        ],
      ),
    );
  }
}
