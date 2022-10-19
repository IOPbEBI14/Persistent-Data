import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/categories_provider.dart';
import '../domain/picture_loader.dart';
import '../models/category_item.dart';

final TextEditingController categoryNameController = TextEditingController();
final TextEditingController pictureUrlController = TextEditingController();

Widget toggleBottomSheetCategory(BuildContext context, WidgetRef ref) {
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
              TextFormField(
                controller: pictureUrlController,
                decoration: InputDecoration(
                  labelText: 'picture url',
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
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                alignment: Alignment.center,
                child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(45),
                      )),
                    ),
                    child: const Text('          ADD          '),
                    onPressed: () async {
                      if (catsList.length != 8) {
                        String pictureName = '';
                        final String url = pictureUrlController.text;
                        PictureLoader loader = PictureLoader();
                        try {
                          await loader
                              .loadPicture(url)
                              .then((fileName) => pictureName = fileName);
                          ref
                              .read<MyCategoriesList>(
                                  myCategoriesListProvider.notifier)
                              .addCategoryInList(CategoryItem(
                                  id: catsList.length - 1,
                                  name: categoryNameController.text,
                                  picture: pictureName,
                                  subcategories: ['Food', 'Toilet']));
                          categoryNameController.clear();
                          pictureUrlController.clear();
                          Navigator.of(context).pop();
                        } catch (e) {
                          showMessage(context, e.toString());
                        }
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
