import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _searchController = new TextEditingController();
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
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: _searchController.clear,
                      ),
                      IconButton(
                        icon: Icon(Icons.menu),
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
              child: Container(
                height: 500,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ListTile(
                        title: Text(
                          "Categories",
                          style: TextStyle(color: Colors.black54, fontSize: 20),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Wrap(
                            spacing: 8,
                            children: [
                              FilterChip(
                                  label: Text("Sports"),
                                  onSelected: (bool value) {}),
                              FilterChip(
                                  label: Text("Comedy"),
                                  onSelected: (bool value) {}),
                              FilterChip(
                                  label: Text("Community"),
                                  onSelected: (bool value) {}),
                              FilterChip(
                                  label: Text("Food and Drinks"),
                                  onSelected: (bool value) {}),
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        height: 8,
                        color: Colors.black,
                      ),
                      DropdownButton<String>(
                        borderRadius: BorderRadius.circular(4),
                        isExpanded: true,
                        hint: Text("Select Country"),
                        value: dropdownValue,
                        onChanged: (String? data) {
                          setState(() {
                            dropdownValue = data!;
                          });
                        },
                        items: [
                          DropdownMenuItem(value: "USA", child: Text("USA")),
                          DropdownMenuItem(
                              value: "Canada", child: Text("Canada")),
                          DropdownMenuItem(value: "UK", child: Text("UK")),
                        ],
                      ),
                      Expanded(child: Container()),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          child: Text("Apply"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
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
