import 'package:flutter/material.dart';
import 'package:home_hub/main.dart';
import 'package:home_hub/providers/category_provider.dart';
import 'package:home_hub/screens/supplier_screen.dart';

import '../custom_widget/space.dart';
import '../utils/colors.dart';
import '../utils/images.dart';

class AllCategoriesScreen extends StatefulWidget {
  final CategoryProvider categoryProvider;

  AllCategoriesScreen({Key? key, required this.categoryProvider}) : super(key: key);

  @override
  State<AllCategoriesScreen> createState() => _AllCategoriesScreenState();
}

class _AllCategoriesScreenState extends State<AllCategoriesScreen> {
  String image = "";
  String title = "";
  Color _textColor = transparent;
  Color _iconColor = whiteColor;

  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(
        () {
          setState(
            () {
              _textColor = _isSliverAppBarExpanded
                  ? appData.isDark
                      ? whiteColor
                      : blackColor
                  : transparent;
              _iconColor = _isSliverAppBarExpanded
                  ? appData.isDark
                      ? whiteColor
                      : blackColor
                  : whiteColor;
            },
          );
        },
      );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  bool get _isSliverAppBarExpanded {
    return _scrollController.hasClients && _scrollController.offset > (200);
  }

  /*String _setImage(int index) {
    String image;
    if (widget.list == serviceProviders) {
      image = widget.list[index].serviceImage;
    } else {
      image = widget.list[index].imagePath!;
    }
    return image;
  }

  String _setTitle(int index) {
    String title;
    if (widget.list == serviceProviders) {
      title = widget.list[index].serviceName;
    } else {
      title = widget.list[index].title!;
    }
    return title;
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: appData.isDark ? customAppbarColorDark : customAppbarColor,
            expandedHeight: MediaQuery.of(context).size.height * 0.35,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: _iconColor),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            flexibleSpace: FlexibleSpaceBar(background: Image.asset(room, fit: BoxFit.cover)),
            centerTitle: true,
            title: Text(
              "All Categories",
              textAlign: TextAlign.center,
              style: TextStyle(color: _textColor, fontWeight: FontWeight.w900, fontSize: 20),
            ),
          ),
          SliverToBoxAdapter(child: Container(padding: EdgeInsets.only(top: 10))),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: widget.categoryProvider.categoryList.length,
              (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: GestureDetector(
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
                    child: Card(
                      color: transparent,
                      elevation: 0,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(widget.categoryProvider.categoryList[index].categoryImage, width: 90, height: 90, fit: BoxFit.cover),
                          ),
                          Space(16),
                          Text(
                            widget.categoryProvider.categoryList[index].categoryName,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Container(padding: EdgeInsets.only(top: 10)),
          ),
        ],
      ),
    );
  }
}
