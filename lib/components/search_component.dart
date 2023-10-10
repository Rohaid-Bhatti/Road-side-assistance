import 'package:flutter/material.dart';
import 'package:home_hub/custom_widget/space.dart';
import 'package:home_hub/providers/category_provider.dart';
import 'package:home_hub/screens/supplier_screen.dart';
import 'package:home_hub/utils/colors.dart';

class SearchComponent extends StatefulWidget {
  final CategoryProvider categoryProvider;

  SearchComponent({Key? key, required this.categoryProvider}) : super(key: key);

  @override
  State<SearchComponent> createState() => _SearchComponentState();
}

class _SearchComponentState extends State<SearchComponent> {
  @override
  Widget build(BuildContext context) {
    return widget.categoryProvider.categoryList.isEmpty
        ? Container(
            height: 100,
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.black),
              ),
            ),
          )
        : ListView.builder(
            shrinkWrap: true,
            primary: false,
            padding: EdgeInsets.all(8),
            physics: NeverScrollableScrollPhysics(),
            itemCount: widget.categoryProvider.categoryList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SupplierScreen(
                            categoryName: widget
                                .categoryProvider
                                .categoryList[index]
                                .categoryName)
                            /*ServiceProvidersScreen(index: index)*/),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.all(4),
                  child: Card(
                    color: transparent,
                    elevation: 0,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                              widget.categoryProvider.categoryList[index]
                                  .categoryImage,
                              width: 90,
                              height: 90,
                              fit: BoxFit.cover),
                        ),
                        Space(16),
                        Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.categoryProvider.categoryList[index]
                                    .categoryName,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              Space(4),
                              Text(
                                widget.categoryProvider.categoryList[index]
                                    .categoryDes,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.w300, fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
  }
}
