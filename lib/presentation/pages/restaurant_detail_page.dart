import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_app/common/data_state.dart';
import 'package:resto_app/common/styles.dart';
import 'package:resto_app/domain/entity/restaurant.dart';
import 'package:resto_app/presentation/bloc/restaurant_detail/restaurant_detail_bloc.dart';
import 'package:resto_app/presentation/bloc/restaurant_detail/restaurant_detail_event.dart';

import '../widgets/appbar.dart';
import '../widgets/error.dart';
import '../widgets/item_food.dart';
import '../widgets/loading.dart';

class RestaurantDetailPage extends StatefulWidget {

  static const String routeName = "/detail";

  final String id;

  const RestaurantDetailPage({super.key, required this.id});

  @override
  State<StatefulWidget> createState() => _RestaurantDetailScreen();
}

class _RestaurantDetailScreen extends State<RestaurantDetailPage> {

  var _currentPosition = 0.0;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<RestaurantDetailBloc>().add(RestaurantDetailEvent(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      setState(() {
        _currentPosition = _scrollController.position.pixels;
      });
    });
    return _renderMobilePage();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _renderMobilePage() {
    return Scaffold(
      backgroundColor: CustomColor.lightBlue,
      body: BlocBuilder<RestaurantDetailBloc, UiState<Restaurant>>(
        builder: (context, state) {
          if (state.isLoading) {
            return const SafeArea(child: Center(child: CustomLoading()));
          } else if (state.isError) {
            return SafeArea(child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomError(state.message ?? ""),
            ));
          } else {
            return SingleChildScrollView(
              controller: _scrollController,
              child: _renderDetail(state.data!),
            );
          }
        },
      ),
    );
  }

  Widget _renderDetail(Restaurant restaurant) {
    Size screenSize = MediaQuery.of(context).size;
    var imageHeight = screenSize.height * 2 / 5;
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(132)
          ),
          child: Image.network(
              restaurant.largeImageUrl ?? "",
              fit: BoxFit.cover,
              width: double.infinity,
              height: imageHeight
          ),
        ),
        Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                  left: 24,
                  right: 24,
                  top: imageHeight - 72
              ),
              padding: const EdgeInsets.all(16),
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
                ],
              ),
              child: Column(
                children: [
                  Text(
                    restaurant.name ?? "",
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme
                        .displayLarge?.copyWith(fontSize: 24),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Flexible(
                          child: Icon(
                              Icons.location_pin,
                              size: 16,
                              color: Colors.red
                          )
                      ),
                      Text(
                        restaurant.city?.toString() ?? "",
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      const Flexible(
                        child: SizedBox(width: 8),
                      ),
                      Flexible(
                        child: Container(
                            width: 4,
                            height: 16,
                            color: Colors.grey.withOpacity(0.5)
                        ),
                      ),
                      const Flexible(
                        child: SizedBox(width: 8),
                      ),
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
                        child: Image.asset(
                            "assets/images/star.png",
                            width: 14,
                            height: 14
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 24,
                  horizontal: 24
              ),
              child: Row(
                children: [
                  Container(height: 16, width: 6, color: CustomColor.orange),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                        "Description",
                        style: Theme.of(context).textTheme.titleLarge,
                        overflow: TextOverflow.ellipsis
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                restaurant.description ?? "",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 24,
                  horizontal: 24
              ),
              child: Row(
                children: [
                  Container(height: 16, width: 6, color: CustomColor.orange),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                        "Foods",
                        style: Theme.of(context).textTheme.titleLarge,
                        overflow: TextOverflow.ellipsis
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ListItemFood(
                  foods: restaurant.menus?.foods ?? []
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 24,
                horizontal: 24,
              ),
              child: Row(
                children: [
                  Container(
                      height: 16,
                      width: 6,
                      color: CustomColor.orange
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                        "Drinks",
                        style: Theme.of(context).textTheme.titleLarge,
                        overflow: TextOverflow.ellipsis
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ListItemFood(
                foods: restaurant.menus?.drinks ?? [],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
        DetailAppBar(
          restaurant: restaurant,
          position: _currentPosition,
          triggerPosition: imageHeight - 72,
        ),
      ],
    );
  }
}