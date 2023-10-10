import 'package:flutter/material.dart';
import 'package:home_hub/providers/category_provider.dart';
import 'package:home_hub/screens/supplier_screen.dart';

class HomeWidget extends StatefulWidget {
  final CategoryProvider categoryProvider;

  HomeWidget({Key? key, required this.categoryProvider}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.categoryProvider.categoryList.isEmpty
        ? SizedBox(
            height: 60,
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.black),
              ),
            ),
          )
        : Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            //height: 500,
            child: GridView.count(
              scrollDirection: Axis.vertical,
              crossAxisCount: 2,
              physics: NeverScrollableScrollPhysics(),
              // to disable GridView's scrolling
              shrinkWrap: true,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              children: List.generate(
                widget.categoryProvider.categoryList.length,
                (index) => GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SupplierScreen(
                              categoryName: widget.categoryProvider
                                  .categoryList[index].categoryName)),
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: new BoxDecoration(
                            image: new DecorationImage(
                              fit: BoxFit.fill,
                              image: new NetworkImage(widget.categoryProvider
                                  .categoryList[index].categoryIcon),
                            ),
                          ),
                        ),
                        /*Icon(serviceProviders[index].serviceIcon,
                      size: 32,
                      color: appData.isDark
                          ? Colors.white
                          : serviceProviders[index].isSelected
                          ? blackColor
                          : blackColor,),*/
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget.categoryProvider.categoryList[index]
                              .categoryName,
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
