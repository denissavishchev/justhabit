import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:justhabit/constants.dart';
import 'package:provider/provider.dart';
import '../providers/good_provider.dart';
import 'icon_svg_widget.dart';


class BottomNavBarWidget extends StatelessWidget {
  const BottomNavBarWidget({super.key,});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<GoodProvider>(builder: (context, data, _){
      return Container(
        width: size.width,
        color: kGreen,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            data.pages.length, (index) =>
              GestureDetector(
                onTap: (){
                  data.mainPageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeIn);
                },
                child: Container(
                    width: size.width / 3,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 40,
                          child: IconSvgWidget(
                            icon: data.icon[index],
                            padding: 0,
                            color: data.activePage == index
                                ? kOrange.withOpacity(0.6) : kWhite,),
                        ),
                        Text(data.names[index],
                          style: data.activePage == index
                              ? kOrangeStyleSmall.copyWith(color: kOrange.withOpacity(0.8))
                              : kWhiteStyleSmall,)
                      ],
                    )
                ),
              ),
          ),
        ),
      );
    }
    );
  }
}
