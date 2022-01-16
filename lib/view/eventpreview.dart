import 'package:crowdate/pages/details.dart';
import 'package:crowdate/util/firestoreutil.dart';
import 'package:crowdate/util/sqlutil.dart';
import 'package:crowdate/viewmodel/event.dart';
import 'package:flutter/material.dart';

class EventPreview extends StatelessWidget {
  final EventViewModel model;

  const EventPreview({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 4,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
                title: Text(model.name),
                subtitle: Text(model.genre + "/" + model.subGenre),
                trailing: Container(
                  alignment: Alignment.center,
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).colorScheme.primary),
                  child: Text(
                    model.daysUntil.toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white),
                  ),
                )),
            SizedBox(
                height: 200.0,
                child: Image(
                  image: NetworkImage(model.imageURL),
                  fit: BoxFit.cover,
                )),
            Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.centerLeft,
              child: Text(model.address),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    child: const Text('DETAILS'),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => EventDetails(
                                model: model,
                              )));
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    alignment: Alignment.centerRight,
                    icon: const Icon(
                      Icons.notification_add,
                      color: Colors.black54,
                    ),
                    onPressed: () async {
                      await FirestoreUtil.putFavorite(model.model);
                      await SQLUtil.putFavorite(model.model);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Event added to the following list!"),
                      ));
                    },
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
