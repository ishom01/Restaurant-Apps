import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_app/common/data_state.dart';
import 'package:resto_app/common/styles.dart';
import 'package:resto_app/domain/entity/restaurant.dart';
import 'package:resto_app/presentation/bloc/restaurant_list/restaurant_list_event.dart';
import 'package:resto_app/presentation/widgets/error.dart';
import 'package:resto_app/presentation/widgets/loading.dart';

import '../bloc/restaurant_list/restaurant_list_bloc.dart';
import '../widgets/appbar.dart';
import '../widgets/item_restaurant.dart';

class RestaurantListPage extends StatefulWidget {

  static const String routeName = "/";

  const RestaurantListPage({super.key});

  @override
  State<StatefulWidget> createState() => _RestaurantListPageState();
}

class _RestaurantListPageState extends State<RestaurantListPage> {

  @override
  void initState() {
    super.initState();
    context.read<RestaurantListBloc>().add(RestaurantListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: const MainAppbar(),
          backgroundColor: CustomColor.lightBlue,
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello, Ishom!",
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      Text(
                        "Where do you want to eat?",
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Container(height: 16, width: 6, color: CustomColor.orange),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                            "Top Popular Restaurant",
                            style: Theme.of(context).textTheme.displayMedium,
                            overflow: TextOverflow.ellipsis
                        ),
                      ),
                    ],
                  ),
                ),
                BlocBuilder<RestaurantListBloc, UiState<List<Restaurant>>>(
                    builder: (context, state) {
                      if (state.isLoading) {
                        return const CustomLoading();
                      } else if (state.isError) {
                        return CustomError(state.message ?? "");
                      } else {
                        return ListItemRestaurant(restaurants: state.data ?? []);
                      }
                    }
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        )
    );
  }
}