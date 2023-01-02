import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_pet_shop/src/models/sub_category_item.dart';

import '../domain/goods_provider.dart';

/// Displays detailed information about a SampleItem.
class SingleGoodView extends ConsumerWidget {
  SubCategoryItem subCategory;
  String backgroundPicture;

  SingleGoodView({Key? key, required this.subCategory, required this.backgroundPicture}) : super(key: key);

  static const routeName = '/single_good_view';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goodsList = ref.watch(goodsProvider(subCategory));
    return Scaffold(
      appBar: AppBar(
        title: Text(subCategory.subcategory),
      ),
      body: Container(
        child: goodsList.when(
            data: (goods) => ListView.builder(
              itemCount: goods.length,
              // separatorBuilder: (BuildContext context, int index) =>
              // const Divider(
              //   height: 2,
              //   thickness: 1,
              // ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    // Navigate to the details page. If the user leaves and returns to
                    // the app after it has been killed while running in the
                    // background, the navigation stack is restored.
                    await HapticFeedback.mediumImpact();
                    // Navigator.restorablePushNamed(
                    //   context,
                    //   SingleGoodView.routeName,
                    //   arguments:goods[index].name,
                    // );
                  },
                  child: Card(
                      // padding: const EdgeInsets.all(10),
                      // decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(45)),
                      child: Row(
                        children: [
                          Image.asset('assets/images/flutter_logo.png'),
                          Column(
                            children: [
                              Text(goods[index].description,),
                              Text('Стоимость товара'),
                              Text('Рейтинг товара'),
                            ],
                          ),
                        ],
                      )),
                );
              },
            ),
            error: (err, stack) => Center(child: Text(err.toString())),
            loading: () => const Center(
                  child: CircularProgressIndicator(),
                )),
      ),
    );
  }
}
