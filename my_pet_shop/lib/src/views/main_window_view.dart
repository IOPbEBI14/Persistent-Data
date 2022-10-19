import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:my_pet_shop/src/domain/categories_provider.dart';
import '../settings/settings_view.dart';
import '../views/sub_categories_list.dart';
import 'bottom_sheet_category.dart';
import 'package:permission_handler/permission_handler.dart';

/// Displays a list of SampleItems.
class MainWindowView extends ConsumerWidget {
  const MainWindowView({Key? key}) : super(key: key);

  static const routeName = '/';

  Future<void> checkPermission() async {
    var result = await Permission.storage.request();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesList = ref.watch(myCategoriesListProvider);
    checkPermission();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Мой зоомагазин',
          textAlign: TextAlign.center,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to the settings page. If the user leaves and returns
              // to the app after it has been killed while running in the
              // background, the navigation stack is restored.
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => showMaterialModalBottomSheet(
          expand: true,
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return toggleBottomSheetCategory(context, ref);
          },
        ),
      ),

      body: // categoriesList.when
      GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 1,
        mainAxisSpacing: 0,
        childAspectRatio: 1.4,
        children: categoriesList
            .map((item) => GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      // padding: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(45)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 45,
                            foregroundImage: FileImage(
                              File(item.picture),
                              // cacheWidth: 615,
                              // cacheHeight: 461,
                              // fit: BoxFit.scaleDown,
                            ),
                          ),
                          Expanded(
                              child: Text(
                            item.name,
                          )),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    // Navigate to the details page. If the user leaves and returns to
                    // the app after it has been killed while running in the
                    // background, the navigation stack is restored.
                    Navigator.restorablePushNamed(
                      context,
                      SubcategoriesView.routeName,
                      arguments: item.toJson(),
                    );
                  },
                ))
            .toList(),
      ),
    );
  }
}
