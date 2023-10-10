import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:home_hub/components/customer_review_component.dart';
import 'package:home_hub/components/home_service_component.dart';
import 'package:home_hub/components/popular_service_component.dart';
import 'package:home_hub/custom_widget/drawer_side.dart';
import 'package:home_hub/providers/category_provider.dart';
import 'package:home_hub/providers/user_provider.dart';
import 'package:home_hub/screens/search_screen.dart';
import 'package:home_hub/services/firestore_services.dart';
import 'package:home_hub/services/notification_services.dart';
import 'package:home_hub/utils/widgets.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../custom_widget/space.dart';
import '../main.dart';
import '../models/customer_review_model.dart';
import '../screens/all_categories_screen.dart';
import '../utils/colors.dart';

class HomeFragment extends StatefulWidget {
  const HomeFragment({Key? key}) : super(key: key);

  @override
  State<HomeFragment> createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  String seacrhQuery = "";
  NotificationServices notificationServices = NotificationServices();

  CategoryProvider? categoryProvider;
  double aspectRatio = 0.0;
  final List bannerList = [];
  final FirebaseService _service = FirebaseService();

  //my code for banner from here
  @override
  void initState() {
    super.initState();
    getBanners();
    WidgetsBinding.instance.addPostFrameCallback((_) => _animateSlider());
    WidgetsBinding.instance.addPostFrameCallback((_) => _animateSlider1());
    CategoryProvider provider = Provider.of(context, listen: false);
    provider.getCategoryData();
    provider.getPCategoryData();

    notificationServices.requestNotificationPermission();
    notificationServices.isTokenRefresh();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    notificationServices.forgroundMessage();
    notificationServices.getDeviceToken().then((value) {
      if (kDebugMode) {
        print('device token');
        print(value);
      }
    });
  }

  getBanners() {
    return _service.homeBanner.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          bannerList.add(doc['image']);
        });
      });
    });
  }

  final PageController offerPagesController = PageController();

  void _animateSlider() {
    Future.delayed(Duration(seconds: 3)).then((_) {
      int nextPage = offerPagesController.page!.round() + 1;

      if (nextPage == bannerList.length) {
        nextPage = 0;
      }

      offerPagesController
          .animateToPage(nextPage, duration: Duration(seconds: 1), curve: Curves.linear)
          .then((_) => _animateSlider());
    });
  }
  //to here

  //mycode for review from here
  final PageController reviewPagesController = PageController();

  void _animateSlider1() {
    Future.delayed(Duration(seconds: 3)).then((_) {
      int nextPage1 = reviewPagesController.page!.round() + 1;

      if (nextPage1 == customerReviews.length) {
        nextPage1 = 0;
      }

      reviewPagesController
          .animateToPage(nextPage1,
              duration: Duration(seconds: 1), curve: Curves.linear)
          .then((_) => _animateSlider1());
    });
  }

  //to here

  // final offerPagesController =
  //     PageController(viewportFraction: 0.93, keepPage: true, initialPage: 0);
  //final reviewPagesController = PageController(viewportFraction: 0.93, keepPage: true, initialPage: 1);

  @override
  void dispose() {
    offerPagesController.dispose();
    reviewPagesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    categoryProvider = Provider.of(context);
    UserProvider userProvider = Provider.of(context);
    userProvider.getUserData();

    aspectRatio = MediaQuery.of(context).size.aspectRatio;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: transparent,
        iconTheme: IconThemeData(size: 30),
        actions: [
          /*IconButton(
            icon: Icon(Icons.notifications, size: 22),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationScreen()),
              );
            },
          ),*/
          Observer(
            builder: (context) {
              return Padding(
                padding: EdgeInsets.all(10.0),
                child: Switch(
                  value: appData.isDark,
                  onChanged: (value) {
                    setState(() {
                      appData.toggle();
                    });
                  },
                ),
              );
            },
          ),
        ],
      ),
      drawer: DrawerSide(
        userProvider: userProvider,
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
                ),
              ),
            ),
            Space(16),
            bannerList.isEmpty
                ? SizedBox(
                    height: 170,
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.black),
                      ),
                    ),
                  )
                : SizedBox(
                    height: 170,
                    child: PageView.builder(
                      controller: offerPagesController,
                      itemCount: bannerList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            /*Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ServiceProvidersScreen(index: index)),
                            );*/
                          },
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(bannerList[index],
                                  fit: BoxFit.cover),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
            SmoothPageIndicator(
              controller: offerPagesController,
              //count: 3,
              count: bannerList.length,
              effect: ExpandingDotsEffect(
                dotHeight: 7,
                dotWidth: 8,
                activeDotColor: appData.isDark ? Colors.white : Colors.black,
                expansionFactor: 2.2,
              ),
            ),

            //my code here
            Space(25),
            Text(
              'Services',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
            ),
            Space(8),
            HomeServiceComponent(),

            Space(8),
            homeTitleWidget(
              titleText: "Popular Services",
              onAllTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AllCategoriesScreen(categoryProvider: categoryProvider!,),
                  ),
                );
              },
            ),
            PopularServiceComponent(pCategoryProvider: categoryProvider!,),
            Space(32),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "What our customers say",
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                ),
              ),
            ),
            Space(16),
            SizedBox(
              height: 117,
              child: PageView.builder(
                itemCount: customerReviews.length,
                controller: reviewPagesController,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return CustomerReviewComponent(
                      customerReviewModel: customerReviews[index]);
                },
              ),
            ),
            Space(16),
            SmoothPageIndicator(
              controller: reviewPagesController,
              count: customerReviews.length,
              effect: ScaleEffect(
                dotHeight: 7,
                dotWidth: 7,
                activeDotColor: appData.isDark ? Colors.white : activeDotColor,
                dotColor: Colors.grey.withOpacity(0.2),
              ),
            ),
            Space(16),
          ],
        ),
      ),
    );
  }
}
