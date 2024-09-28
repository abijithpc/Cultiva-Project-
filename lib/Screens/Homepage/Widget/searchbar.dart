import 'package:flutter/material.dart';

class Searchbar extends StatelessWidget {
  final TextEditingController searchController;

  const Searchbar({
    super.key,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextFormField(
        controller: searchController,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          hintText: 'Search Plant',
          hintStyle: TextStyle(color: Colors.white),
          filled: true,
          fillColor: Colors.white.withOpacity(0.3),
        ),
      ),
    );
  }
}
