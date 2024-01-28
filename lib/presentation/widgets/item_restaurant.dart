import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:resto_app/domain/entity/restaurant.dart';
import 'package:resto_app/presentation/pages/restaurant_detail_page.dart';

class ListItemRestaurant extends StatelessWidget {

  final List<Restaurant> restaurants;

  const ListItemRestaurant({super.key, required this.restaurants});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return StaggeredGrid.count(
      crossAxisCount: _calculateAxisCount(screenSize),
      crossAxisSpacing: 16,
      children: restaurants.map((value) => GestureDetector(
        onTap: () {
          Navigator.pushNamed(
              context, RestaurantDetailPage.routeName, arguments: value.id);
        },
        child: ItemRestaurant(restaurant: value),
      )).toList(),
    );
  }

  int _calculateAxisCount(Size screenSize) {
    int count = (screenSize.width / 480).ceil();
    return count > 1 ? count : 1;
  }
}

class ItemRestaurant extends StatelessWidget {

  final Restaurant restaurant;

  const ItemRestaurant({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Container(
            height: 104,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ]
            ),
            padding: const EdgeInsets.only(top: 16, bottom: 16, right: 16, left: 118),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurant.name ?? "",
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  restaurant.city ?? "",
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Flexible(
                        child: Text(
                          restaurant.rating?.toString() ?? "",
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.displaySmall,
                        )
                    ),
                    const Flexible(
                      child: SizedBox(width: 4),
                    ),
                    Flexible(
                        child: Image.asset("assets/images/star.png", width: 14, height: 14)
                    )
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              child: Image.network(restaurant.smallImageUrl, fit: BoxFit.fitHeight, height: 120, width: 90),
            ),
          ),
        ],
      ),
    );
  }
}