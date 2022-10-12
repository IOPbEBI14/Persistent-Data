import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_pet_shop/src/models/category_item.dart';
import 'package:my_pet_shop/src/views/goods_list.dart';
import 'package:my_pet_shop/src/views/theme.dart';

import 'models/sub_category_item.dart';
import 'views/sub_categories_list.dart';
import 'views/main_window_view.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The AnimatedBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return MaterialApp(
      // Providing a restorationScopeId allows the Navigator built by the
      // MaterialApp to restore the navigation stack when a user leaves and
      // returns to the app after it has been killed while running in the
      // background.
      restorationScopeId: 'app',

      // Define a light and dark color theme. Then, read the user's
      // preferred ThemeMode (light, dark, or system default) from the
      // SettingsController to display the correct theme.
      theme: themeLight,
      darkTheme: ThemeData.dark(),

      // Define a function to handle named routes in order to support
      // Flutter web url navigation and deep linking.
      onGenerateRoute: (RouteSettings routeSettings) {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) {
            switch (routeSettings.name) {
              case SubcategoriesView.routeName:
                {
                  CategoryItem item = CategoryItem.fromJson(
                      jsonDecode(routeSettings.arguments.toString()));
                  return SubcategoriesView(
                    category: item,
                  );
                }
              case GoodsView.routeName:
                {
                  SubCategoryItem item =
                      SubCategoryItem(routeSettings.arguments.toString());
                  return GoodsView(
                    subCategory: item,
                  );
                }
              case MainWindowView.routeName:
              default:
                return const MainWindowView();
            }
          },
        );
      },
    );
  }
}
