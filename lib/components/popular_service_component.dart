import 'package:flutter/material.dart';
import 'package:home_hub/providers/category_provider.dart';
import 'package:home_hub/screens/supplier_screen.dart';
import 'package:home_hub/utils/images.dart';

class PopularServiceComponent extends StatefulWidget {
  final CategoryProvider pCategoryProvider;

  PopularServiceComponent({Key? key, required this.pCategoryProvider})
      : super(key: key);

  @override
  _PopularServiceComponentState createState() =>
      _PopularServiceComponentState();
}

class _PopularServiceComponentState extends State<PopularServiceComponent> {
  //List<String> servicesList = [plumber, electrician, painter1, carpenter];

  @override
  void initState() {
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return widget.pCategoryProvider.categoryList.isEmpty
        ? SizedBox(
            height: 125,
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.black),
              ),
            ),
          )
        : SizedBox(
            height: 125,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 8),
              scrollDirection: Axis.horizontal,
              children: List.generate(
                widget.pCategoryProvider.pCategoryList.length,
                (index) => GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SupplierScreen(
                              categoryName: widget
                                  .pCategoryProvider
                                  .pCategoryList[index]
                                  .categoryName) /*ServiceProvidersScreen(index: index)*/),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: SizedBox(
                      width: 110,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                            widget.pCategoryProvider.pCategoryList[index]
                                .categoryImage,
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
