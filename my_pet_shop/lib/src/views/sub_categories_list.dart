import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:my_pet_shop/src/domain/subcategories_provider.dart';
import 'package:my_pet_shop/src/models/category_item.dart';

import '../domain/categories_provider.dart';
import 'goods_list.dart';

/// Displays detailed information about a SampleItem.
class SubcategoriesView extends ConsumerWidget {
  CategoryItem category;
  final TextEditingController categoryNameController = TextEditingController();

  SubcategoriesView({Key? key, required this.category}) : super(key: key);

  static const routeName = '/subcategories_view';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subcategories = ref.watch(subcategoriesProvider(category));
    return Scaffold(
      appBar: AppBar(
        title: Text(category.name),
      ),
      body: subcategories.when(
          data: (subcats) => ListView.separated(
                itemCount: subcats.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(
                  height: 2,
                  thickness: 1,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                    // Navigate to the details page. If the user leaves and returns to
                    // the app after it has been killed while running in the
                    // background, the navigation stack is restored.
                    Navigator.restorablePushNamed(
                      context,
                      GoodsView.routeName,
                      arguments:subcats[index].subcategory,
                    );
                  },
                    child: SizedBox(
                      height: 40,
                      child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(45)),
                          child: Text(subcats[index].subcategory)),
                    ),
                  );
                },
              ),
          error: (err, stack) => Center(child: Text(err.toString())),
          loading: () => const Center(
                child: CircularProgressIndicator(),
              )),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => showMaterialModalBottomSheet(
          expand: true,
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return toggleBottomSheetSubcategory(context, ref);
          },
        ),
      ),
    );
  }

  Widget toggleBottomSheetSubcategory(BuildContext context, WidgetRef ref) {
    final catsList = ref.watch(myCategoriesListProvider);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Center(
          child: Container(
            padding: const EdgeInsets.fromLTRB(60, 10, 60, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: categoryNameController,
                  decoration: InputDecoration(
                    labelText: 'category name',
                    labelStyle: const TextStyle(color: Colors.purple),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(45),
                        borderSide: const BorderSide(color: Colors.purple)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(45),
                        borderSide: const BorderSide(color: Colors.purple)),
                  ),
                ),
                Container(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  alignment: Alignment.center,
                  child: ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(45),
                        )),
                      ),
                      child: const Text('          ADD          '),
                      onPressed: () {
                        try {
                          category.subcategories
                              .add(categoryNameController.text);
                          ref
                              .read<MyCategoriesList>(
                                  myCategoriesListProvider.notifier)
                              .updateSubcategory(category);
                          ref.refresh(subcategoriesProvider(category));
                          categoryNameController.clear();
                          Navigator.of(context).pop();
                        } catch (e) {
                          showMessage(context, e.toString());
                        }
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool showMessage(BuildContext context, String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(content: Text(message));
        });
    return true;
  }
}
