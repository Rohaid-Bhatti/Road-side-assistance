import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:home_hub/const/firebase_const.dart';
import 'package:home_hub/providers/category_provider.dart';
import 'package:home_hub/screens/supplier_screen.dart';
import 'package:home_hub/utils/widgets.dart';

class SearchPage extends StatefulWidget {
  final CategoryProvider categoryProvider;

  SearchPage({Key? key, required this.categoryProvider}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  late Query _searchQuery;

  @override
  void initState() {
    super.initState();
    _searchQuery = firestore.collection(category);
  }

  void _performSearch(String searchQuery) {
    setState(() {
      _searchQuery = firestore
          .collection(category)
          .where('categoryName', isGreaterThanOrEqualTo: searchQuery)
          .where('categoryName', isLessThan: searchQuery + 'z')
          .orderBy('categoryName')
          .limit(10);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: TextFormField(
          controller: _searchController,
          onChanged: _performSearch,
          keyboardType: TextInputType.name,
          style: TextStyle(fontSize: 17),
          decoration: commonInputDecoration(
            hintText: "Search for services",
            suffixIcon: IconButton(
              icon: Icon(Icons.search, size: 18),
              onPressed: () {
                _searchController.clear();
                _performSearch('');
              },
            ),
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _searchQuery.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot document = snapshot.data!.docs[index];
                Map<String, dynamic> data =
                document.data() as Map<String, dynamic>;
                return Card(
                  elevation: 2,
                  margin: EdgeInsets.only(left: 16, right: 16, top: 6, bottom: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SupplierScreen(
                            categoryName: data['categoryName'],
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                      child: ListTile(
                        minLeadingWidth: 0,
                        leading: Icon(Icons.arrow_forward_ios, size: 14,),
                        title: Text(data['categoryName']),
                        subtitle: Text(data['categoryDes']),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}