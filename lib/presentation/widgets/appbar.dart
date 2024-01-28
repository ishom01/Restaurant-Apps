import 'package:flutter/material.dart';
import 'package:resto_app/common/styles.dart';
import 'package:resto_app/domain/entity/restaurant.dart';
import 'package:resto_app/presentation/pages/restaurant_search_page.dart';

class MainAppbar extends StatelessWidget implements PreferredSizeWidget{

  const MainAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColor.blue,
      padding: const EdgeInsets.only(left: 16),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Expanded(
            child: Text(
              "Restaurant App",
              style: Theme.of(context).textTheme.titleLarge
                  ?.copyWith(color: Colors.white),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, RestaurantSearchPage.routeName);
            },
            icon: const Icon(Icons.search, color: Colors.white)
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 56);
}

class SearchAppbar extends StatelessWidget implements PreferredSizeWidget{

  const SearchAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColor.blue,
      padding: const EdgeInsets.only(),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back, color: Colors.white)
          ),
          Expanded(
            child: Text(
              "Search Restaurant",
              style: Theme.of(context).textTheme.titleLarge
                  ?.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 56);
}

class DetailAppBar extends StatelessWidget{

  final Restaurant? restaurant;
  final double position;
  final double triggerPosition;

  const DetailAppBar({
    super.key,
    required this.position,
    required this.triggerPosition,
    this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    var isTrigger = position > triggerPosition;
    var navBarHeight = MediaQuery.of(context).viewPadding.top;

    return Container(
      transform: Matrix4.translationValues(0, position, 0),
      child: AnimatedContainer(
        height: 56 + navBarHeight,
        width: double.infinity,
        padding: EdgeInsets.only(left: 16, right: 16, top: navBarHeight),
        color: isTrigger ? CustomColor.blue : Colors.transparent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.decelerate,
        child: Row(
          children: [
            Flexible(
              child: SizedBox(
                height: 28,
                width: 28,
                child: IconButton.filled(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white)
                  ),
                  padding: EdgeInsets.zero,
                  icon: const Center(
                    child: Icon(
                        Icons.keyboard_arrow_left,
                        color: CustomColor.blue,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Visibility(
                  visible: isTrigger,
                  child: Text(
                    restaurant?.name ?? "",
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme
                        .titleLarge?.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
