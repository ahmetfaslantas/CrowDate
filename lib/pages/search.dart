import 'package:crowdate/view/eventpreviewlist.dart';
import 'package:crowdate/viewmodel/eventlist.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _searchController = TextEditingController();
  String localeName = "en";
  List<String> selectedGenrelist = [];

  Map<String, String> genres = {
    "Music": "KnvZfZ7vAkJ",
    "Comedy": "KnvZfZ7vAkA",
    "Action/Adventure": "KnvZfZ7vAke",
    "eSports": "KnvZfZ7vAJF",
    "Drama": "KnvZfZ7vAk6",
    "Basketball": "KnvZfZ7vAde"
  };

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<EventListViewModel>(context, listen: false).fetchEvents(
          keyword: _searchController.text,
          genreList: selectedGenrelist,
          locale: localeName);
    });

    _searchController.addListener(() {
      Provider.of<EventListViewModel>(context, listen: false).fetchEvents(
          keyword: _searchController.text,
          genreList: selectedGenrelist,
          locale: localeName);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Provider.of<EventListViewModel>(context, listen: false)
            .fetchEvents(refresh: true, primary: true);
        return Future.value(true);
      },
      child: Scaffold(
          appBar: AppBar(
            title: Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: _searchController.clear,
                          ),
                          IconButton(
                            icon: const Icon(Icons.menu),
                            onPressed: () async {
                              await showFilterDialog();
                              Provider.of<EventListViewModel>(context,
                                      listen: false)
                                  .fetchEvents(
                                      keyword: _searchController.text,
                                      locale: localeName,
                                      genreList: selectedGenrelist);
                            },
                          ),
                        ],
                      ),
                      hintText: 'Search...',
                      border: InputBorder.none),
                ),
              ),
            ),
          ),
          body: Consumer<EventListViewModel>(
            builder: (context, list, child) {
              return EventPreviewList(eventsPreview: list);
            },
          )),
    );
  }

  Future showFilterDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Search Filters",
                        style: TextStyle(color: Colors.black54, fontSize: 20),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Country",
                            style: TextStyle(color: Colors.black54),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: DropdownButton<String>(
                            isExpanded: true,
                            borderRadius: BorderRadius.circular(4),
                            hint: const Text("Select Country"),
                            value: localeName,
                            onChanged: (String? data) {
                              setState(() {
                                localeName = data!;
                              });
                            },
                            items: const [
                              DropdownMenuItem(value: "en", child: Text("USA")),
                              DropdownMenuItem(
                                  value: "ca", child: Text("Canada")),
                              DropdownMenuItem(value: "gb", child: Text("UK")),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      height: 8,
                      color: Colors.black,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Categories",
                            style: TextStyle(color: Colors.black54),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Wrap(
                          spacing: 8,
                          children: genres.entries
                              .map((entry) => FilterChip(
                                  selected:
                                      selectedGenrelist.contains(entry.value),
                                  label: Text(entry.key),
                                  onSelected: (bool value) {
                                    value
                                        ? selectedGenrelist.add(entry.value)
                                        : selectedGenrelist.remove(entry.value);
                                    setState(() {});
                                  }))
                              .toList()),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          child: const Text("Cancel"),
                          onPressed: () {
                            selectedGenrelist = [];
                            localeName = "en";
                            Navigator.pop(context);
                          },
                        ),
                        TextButton(
                          child: const Text("Apply"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          });
        });
  }
}
