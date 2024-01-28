import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_app/common/data_state.dart';
import 'package:resto_app/common/styles.dart';
import 'package:resto_app/domain/entity/restaurant.dart';
import 'package:resto_app/presentation/bloc/restaurant_list/restaurant_list_event.dart';
import 'package:resto_app/presentation/bloc/restaurant_search/restaurant_search_bloc.dart';
import 'package:resto_app/presentation/bloc/restaurant_search/restaurant_search_event.dart';
import 'package:resto_app/presentation/widgets/error.dart';
import 'package:resto_app/presentation/widgets/loading.dart';

import '../bloc/restaurant_list/restaurant_list_bloc.dart';
import '../widgets/appbar.dart';
import '../widgets/item_restaurant.dart';

class RestaurantSearchPage extends StatefulWidget {

  static const String routeName = "/search";

  const RestaurantSearchPage({super.key});

  @override
  State<StatefulWidget> createState() => _RestaurantSearchPageState();
}

class _RestaurantSearchPageState extends State<RestaurantSearchPage> {

  @override
  void initState() {
    super.initState();
    context.read<RestaurantSearchBloc>().add(RestaurantSearchEvent(''));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: const SearchAppbar(),
          backgroundColor: CustomColor.lightBlue,
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: TextField(
                    onSubmitted: (query) {
                      context.read<RestaurantSearchBloc>()
                          .add(RestaurantSearchEvent(query));
                    },
                    decoration: const InputDecoration(
                      hintText: 'Search title',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(8)
                    ),
                    textInputAction: TextInputAction.search,
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
                            "Daftar Restaurant",
                            style: Theme.of(context).textTheme.displayMedium,
                            overflow: TextOverflow.ellipsis
                        ),
                      ),
                    ],
                  ),
                ),
                BlocBuilder<RestaurantSearchBloc, UiState<List<Restaurant>>>(
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