import 'package:flutter/material.dart';

class Search_Bar extends StatelessWidget {
  const Search_Bar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Container(
          margin: EdgeInsets.only(top: 10),

          child: TextField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 0),
              hintText: 'Search',
              prefixIcon: Icon(Icons.search),
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
            onSubmitted: (query) {
              print("Searching for: $query");
            },
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // You can add search results or suggestions here
          ],
        ),
      ),
    );
  }
}
