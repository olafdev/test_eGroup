import 'package:flutter/material.dart';
import 'package:testforegroup/screens/favorite_screen.dart';

// Imports

import 'package:testforegroup/screens/home_screen.dart';
import 'package:testforegroup/screens/details_screen.dart';

// Exports

export 'package:testforegroup/screens/home_screen.dart';
export 'package:testforegroup/screens/details_screen.dart';

// Routes

Map<String, WidgetBuilder> getAplicationRoutes() => <String, WidgetBuilder>{
      HomeScreen.routeName: (BuildContext context) => const HomeScreen(),
      DetailsScreen.routeName: (BuildContext context) => const DetailsScreen(),
      FavoriteScreen.routeName: (BuildContext context) => const FavoriteScreen(),
};
