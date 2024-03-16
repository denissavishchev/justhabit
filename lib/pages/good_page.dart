import 'package:flutter/material.dart';
import 'package:justhabit/constants.dart';
import 'package:justhabit/providers/good_provider.dart';
import 'package:justhabit/widgets/icon_svg_widget.dart';
import 'package:provider/provider.dart';
import '../widgets/good_tile_widget.dart';

class GoodPage extends StatelessWidget {
  const GoodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GoodProvider>(
        builder: (context, data, _){
          data.fetchUsers();
          return Scaffold(
            backgroundColor: kGrey,
            floatingActionButton: FloatingActionButton(
              backgroundColor: kGreen,
              foregroundColor: kBrown,
              onPressed: () => data.addHabit(context),
              child: const IconSvgWidget(icon: 'add', color: kBrown,),
            ),
            body: ListView.builder(
                padding: const EdgeInsets.only(bottom: 100),
                itemCount: data.dataList.length,
                itemBuilder: (context, index){
                  return GoodTileWidget(dataList: data.dataList, dataIndex: index,);
                }),
          );
        });
  }
}


