import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _searchController = TextEditingController();
  String dropdownValue = "USA";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        onPressed: showFilterDialog,
                      ),
                    ],
                  ),
                  hintText: 'Search...',
                  border: InputBorder.none),
            ),
          ),
        ),
      ),
      body: Container(// TODO: Replace with search content.

          ),
    );
  }

  void showFilterDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              child: SizedBox(
                height: 300,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
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
                          Expanded(child: Container()),
                          SizedBox(
                            width: 200,
                            child: DropdownButton<String>(
                              isExpanded: true,
                              borderRadius: BorderRadius.circular(4),
                              hint: const Text("Select Country"),
                              value: dropdownValue,
                              onChanged: (String? data) {
                                setState(() {
                                  dropdownValue = data!;
                                });
                              },
                              items: const [
                                DropdownMenuItem(
                                    value: "USA", child: Text("USA")),
                                DropdownMenuItem(
                                    value: "Canada", child: Text("Canada")),
                                DropdownMenuItem(
                                    value: "UK", child: Text("UK")),
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
                          children: [
                            FilterChip(
                                label: const Text("Sports"),
                                onSelected: (bool value) {}),
                            FilterChip(
                                label: const Text("Comedy"),
                                onSelected: (bool value) {}),
                            FilterChip(
                                selected: true,
                                label: const Text("Community"),
                                onSelected: (bool value) {}),
                            FilterChip(
                                label: const Text("Food and Drinks"),
                                onSelected: (bool value) {}),
                          ],
                        ),
                      ),
                      Expanded(child: Container()),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            child: const Text("Cancel"),
                            onPressed: () {
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
              ),
            );
          });
        });
  }
}
