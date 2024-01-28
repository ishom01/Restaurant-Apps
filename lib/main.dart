import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_app/common/styles.dart';
import 'package:resto_app/domain/entity/restaurant.dart';
import 'package:resto_app/presentation/bloc/restaurant_detail/restaurant_detail_bloc.dart';
import 'package:resto_app/presentation/bloc/restaurant_list/restaurant_list_bloc.dart';
import 'package:resto_app/presentation/bloc/restaurant_search/restaurant_search_bloc.dart';
import 'package:resto_app/presentation/pages/restaurant_detail_page.dart';
import 'package:resto_app/presentation/pages/restaurant_list_page.dart';
import 'package:resto_app/injection.dart' as di;
import 'package:resto_app/presentation/pages/restaurant_search_page.dart';


void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.locator<RestaurantListBloc>()),
        BlocProvider(create: (_) => di.locator<RestaurantDetailBloc>()),
        BlocProvider(create: (_) => di.locator<RestaurantSearchBloc>()),
      ],
      child: MaterialApp(
        title: 'Restaurant App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          textTheme: customTheme,
          useMaterial3: true,
        ),
        initialRoute: RestaurantListPage.routeName,
        routes: {
          RestaurantListPage.routeName: (context) => const RestaurantListPage(),
          RestaurantSearchPage.routeName: (context) => const RestaurantSearchPage(),
          RestaurantDetailPage.routeName: (context) {
            String restaurantId = ModalRoute.of(context)
                ?.settings.arguments as String? ?? "";
            return RestaurantDetailPage(id: restaurantId);
          },
        },
      )
    );
  }
}
