import 'package:flutter/material.dart';
import 'package:home_hub/components/search_component.dart';
import 'package:home_hub/models/category_model.dart';
import 'package:home_hub/providers/category_provider.dart';
import 'package:home_hub/screens/search_screen.dart';
import 'package:home_hub/utils/widgets.dart';
import 'package:provider/provider.dart';

import '../utils/colors.dart';

class SearchFragment extends StatefulWidget {
  const SearchFragment({Key? key}) : super(key: key);

  @override
  State<SearchFragment> createState() => _SearchFragmentState();
}

class _SearchFragmentState extends State<SearchFragment> {
  CategoryProvider? categoryProvider;

  void initState() {
    CategoryProvider provider = Provider.of(context, listen: false);
    provider.getCategoryData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    categoryProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        backgroundColor: transparent,
        title: Text(
          "Search",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchPage(
                                  categoryProvider: categoryProvider!,
                                )));
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      color: Colors.grey.shade200,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Search for services',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade500,
                            ),
                          ),
                          Icon(Icons.search, size: 20),
                        ],
                      ),
                    ),
                  ),
                  /*TextFormField(
                    keyboardType: TextInputType.name,
                    style: TextStyle(fontSize: 17),
                    decoration: commonInputDecoration(
                      hintText: "Search for services",
                      suffixIcon: Icon(Icons.search, size: 18),
                    ),
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),*/
                ),
              ),
            ),
            SearchComponent(
              categoryProvider: categoryProvider!,
            ),
          ],
        ),
      ),
    );
  }
}
