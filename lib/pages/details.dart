import 'package:crowdate/viewmodel/event.dart';
import 'package:flutter/material.dart';

class EventDetails extends StatelessWidget {
  const EventDetails({Key? key, required this.model}) : super(key: key);

  final EventViewModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(model.name),
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                child: Image(
                  image: NetworkImage(model.imageURL),
                  fit: BoxFit.cover,
                )),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8.0),
              child: Text(
                model.name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Icon(
                              Icons.my_location,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          Text(
                            model.address,
                            style:
                                TextStyle(fontSize: 18, color: Colors.black54),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Icon(
                              Icons.calendar_view_month,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          Text(
                            model.date,
                            style:
                                TextStyle(fontSize: 18, color: Colors.black54),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Icon(
                              Icons.money,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          Text(
                            model.minPrice.toString() +
                                "-" +
                                model.maxPrice.toString() +
                                " " +
                                model.currency,
                            style:
                                TextStyle(fontSize: 18, color: Colors.black54),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Icon(
                              Icons.theaters,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          Text(
                            model.genre,
                            style:
                                TextStyle(fontSize: 18, color: Colors.black54),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Event Details Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce congue pretium nisi a dignissim. Duis bibendum iaculis porttitor. Aenean sagittis eros est, non feugiat lorem tincidunt eu.",
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.notifications_off),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Event Unfollowed")));
        },
      ),
    );
  }
}
