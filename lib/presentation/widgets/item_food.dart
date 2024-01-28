import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:resto_app/domain/entity/food.dart';

class ListItemFood extends StatelessWidget {

  final List<Food> foods;

  const ListItemFood({super.key, required this.foods});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return StaggeredGrid.count(
      crossAxisCount: _calculateAxisCount(screenSize),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: foods.map((value) => ItemFood(food: value)).toList(),
    );
  }

  int _calculateAxisCount(Size screenSize) {
    int count = (screenSize.width / 480).ceil();
    return count > 1 ? count : 1;
  }
}

class ItemFood extends StatelessWidget {

  final Food food;

  const ItemFood({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    return Container(
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
      padding: const EdgeInsets.all(16),
      child: Text(
        food.name ?? "",
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.displayLarge,
      ),
    );
  }
}