import 'dart:convert';
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
          if(dataList[dataIndex]['date'].toString().split(' ')[0] != DateTime.now().toString().split(' ')[0]){
            data.progressActionsMap.clear();
            data.getProgressActions();
          }
          return GestureDetector(
            onLongPress: () => data.delete(dataList[dataIndex]['id']),
            child: Container(
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
                        const SizedBox(height: 4,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if(dataList[dataIndex]['comment'] != ''){
                                    data.showPopDialog(
                                        context, 'Comment', dataList[dataIndex]['comment']);
                                    }
                                  },
                                 child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 2),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                                    border: Border.all(width: 1, color:
                                    dataList[dataIndex]['comment'] != ''
                                        ? kGreen.withOpacity(0.6)
                                        : Colors.transparent,),
                                  ),
                                  width: 24,
                                  height: 20,
                                  child: Icon(Icons.comment_outlined, size: 18,
                                    color: dataList[dataIndex]['comment'] != ''
                                        ? kBrown : Colors.transparent,),
                                ),
                              ),
                              Text(dataList[dataIndex]['name'], style: kGreenStyle,),
                              Column(
                                children: [
                                  Text('Days:', style: kGreenStyleTiny,),
                                  Text('${data.progressDay.indexWhere((i) => i ==
                                      DateTime.now().toString().split(' ')[0])}'
                                      '/${dataList[dataIndex]['days']}',
                                    style: kGreenStyleTiny,),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 240,
                          height: 48,
                          child: Wrap(
                            runAlignment: WrapAlignment.center,
                            runSpacing: 4,
                            children: List.generate(dataList[dataIndex]['days'], (index){
                              data.progressDays = jsonDecode(dataList[dataIndex]['progressDays']);
                              return Container(
                                margin: const EdgeInsets.only(right: 4),
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                    color: data.progressDays.values.elementAt(index) == '0'
                                        ?  Colors.transparent
                                        : data.progressDays.values.elementAt(index) == '1'
                                        ? kGreen
                                        : data.progressDays.values.elementAt(index) == '2'
                                        ? kGreen.withOpacity(0.6)
                                        : data.progressDays.values.elementAt(index) == '3'
                                        ? kGreen.withOpacity(0.2)
                                        : Colors.red,
                                    borderRadius: const BorderRadius.all(Radius.circular(3)),
                                    border: Border.all(width: 1, color: kGreen)
                                ),
                              );
                            }),
                          ),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      data.updateProgressState(context,
                          dataList[dataIndex]['name'],
                          dataList[dataIndex]['comment'],
                          dataList[dataIndex]['days'],
                          dataList[dataIndex]['actions'],
                          dataList[dataIndex]['id']);
                    },
                    child: Container(
                      width: 80,
                      decoration: const BoxDecoration(
                          color: kBrown,
                          border: Border(left: BorderSide(width: 1, color: kYellow))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(dataList[dataIndex]['actions'], (index) {
                            data.progressActions = jsonDecode(dataList[dataIndex]['progressActions']);
                            return Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 1),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(8)),
                                border: Border.all(width: 1, color: kGreen)
                              ),
                                child: Icon(Icons.check_box,
                                  color: data.progressActions.values.elementAt(index) == 'false'
                                      ? kGrey : kGreen,));
                          }),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}