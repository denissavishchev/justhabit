import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:justhabit/providers/good_provider.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class GoodTileWidget extends StatelessWidget {
  const GoodTileWidget({
    super.key, required this.dataList, required this.dataIndex,
  });

  final List<Map<String, dynamic>> dataList;
  final int dataIndex;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<GoodProvider>(
        builder: (context, data, _){
          return Container(
            width: size.width,
            height: 100,
            margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
                color: kWhite,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                boxShadow: [
                  BoxShadow(
                      color: kBlack.withOpacity(0.2),
                      spreadRadius: 3,
                      blurRadius: 3,
                      offset: const Offset(2, 3)
                  )
                ]
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const SizedBox(height: 12,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(dataList[dataIndex]['comment']),
                          Text(dataList[dataIndex]['name']),
                          Text('Days: 15/${dataList[dataIndex]['days']}')
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(15, (index){
                          return Container(
                            margin: EdgeInsets.only(right: 2),
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                                color: kGreen,
                                borderRadius: BorderRadius.all(Radius.circular(3))
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 4,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(15, (index){
                          return Container(
                            margin: EdgeInsets.only(right: 2),
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                                color: kGreen,
                                borderRadius: BorderRadius.all(Radius.circular(3))
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 4,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(15, (index){
                          return Container(
                            margin: const EdgeInsets.only(right: 2),
                            width: 12,
                            height: 12,
                            decoration: const BoxDecoration(
                                color: kGreen,
                                borderRadius: BorderRadius.all(Radius.circular(3))
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 4,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(15, (index){
                          return Container(
                            margin: const EdgeInsets.only(right: 2),
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              // color: kGreen,
                                borderRadius: BorderRadius.all(Radius.circular(3)),
                                border: Border.all(width: 1, color: kGreen)
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 4,),
                    ],
                  ),
                ),
                Container(
                  width: 80,
                  decoration: const BoxDecoration(
                      color: kBrown,
                      border: Border(left: BorderSide(width: 1, color: kYellow))
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.check_box, color: kGrey,),
                        Divider(),
                        Icon(Icons.check_box, color: kGreen,),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}