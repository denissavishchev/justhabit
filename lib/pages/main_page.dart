import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:justhabit/constants.dart';
import 'package:justhabit/widgets/icon_svg_widget.dart';
import 'package:provider/provider.dart';
import '../providers/good_provider.dart';
import '../widgets/bottom_bar_widget.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Consumer<GoodProvider>
          (builder: (context, data, _){
          return SafeArea(
            child: Column(
              children: [
                Container(
                  height: size.height * 0.08,
                  width: size.width,
                  color: kGreen,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: 60,),
                      Text('Just habit', style: kBrownStyleBig,),
                      const IconSvgWidget(icon: 'gear', color: kWhite, padding: 12,)
                    ],
                  ),
                ),
                Expanded(
                  child: PageView.builder(
                      controller: data.mainPageController,
                      onPageChanged: (int index) => data.changePage(index),
                      itemCount: data.pages.length,
                      itemBuilder: (context, index) {
                        return data.pages[index % data.pages.length];
                      }),
                ),
                SizedBox(
                  height: size.height * 0.1,
                    child: const BottomNavBarWidget()),
              ],
            ),
          );
        })
    );
  }
}


