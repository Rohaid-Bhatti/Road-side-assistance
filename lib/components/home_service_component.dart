import 'package:flutter/material.dart';
import 'package:home_hub/custom_widget/home_service_widget.dart';
import 'package:home_hub/providers/category_provider.dart';
import 'package:provider/provider.dart';

class HomeServiceComponent extends StatefulWidget {
  @override
  State<HomeServiceComponent> createState() => _HomeServiceComponentState();
}

class _HomeServiceComponentState extends State<HomeServiceComponent> {
  CategoryProvider? categoryProvider;
  @override
  void initState() {
    CategoryProvider provider = Provider.of(context, listen: false);
    provider.getCategoryData();
    super.initState();
  }


  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    categoryProvider = Provider.of(context);

    return HomeWidget(categoryProvider: categoryProvider!,);
  }
}
