import 'package:flutter/material.dart';
import 'package:justhabit/constants.dart';
import 'package:justhabit/providers/main_provider.dart';
import 'package:justhabit/widgets/icon_svg_widget.dart';
import 'package:provider/provider.dart';

import '../widgets/good_tile_widget.dart';

class GoodPage extends StatelessWidget {
  const GoodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
        builder: (context, data, _){
          data.fetchUsers();
          return Scaffold(
            backgroundColor: kGrey,
            floatingActionButton: FloatingActionButton(
              backgroundColor: kGreen,
              foregroundColor: kOrange,
              onPressed: () => data.addHabit(context),
              child: IconSvgWidget(icon: 'add', color: kOrange.withOpacity(0.6),),
            ),
            body: ListView.builder(
                padding: const EdgeInsets.only(bottom: 12),
                itemCount: data.dataList.length,
                itemBuilder: (context, index){
                  return GoodTileWidget(dataList: data.dataList, dataIndex: index,);
                }),
          );
        });
  }
}


