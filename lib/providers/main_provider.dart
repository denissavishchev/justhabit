import 'package:flutter/material.dart';
import 'package:justhabit/constants.dart';
import 'package:justhabit/pages/bad_page.dart';
import '../databasehelper.dart';
import '../pages/good_page.dart';

class MainProvider with ChangeNotifier {

  PageController mainPageController = PageController(initialPage: 0);
  int activePage = 0;

  List<Map<String, dynamic>> dataList = [];
  final nameController = TextEditingController();
  final commentController = TextEditingController();
  final daysController = TextEditingController();
  final actionController = TextEditingController();
  final colorController = TextEditingController();
  final iconController = TextEditingController();

  final List pages = [
    const GoodPage(),
    const BadPage(),
    Container(color: Colors.green,),
  ];

  final List icon = [
    'brain',
    'pipe',
    'todolist',
  ];

  final List names = [
    'Good',
    'Bad',
    'Periodic',
  ];

  void changePage(int index) {
    activePage = index;
    notifyListeners();
  }

  void saveData() async{
    await DatabaseHelper.insertUser(
      nameController.text,
      commentController.text,
      int.parse(daysController.text),
      int.parse(actionController.text),
      colorController.text,
      iconController.text
    );
    fetchUsers();
    nameController.clear();
    commentController.clear();
    daysController.clear();
    actionController.clear();
    colorController.clear();
    iconController.clear();
  }

  void fetchUsers()async {
    List<Map<String, dynamic>> userList = await DatabaseHelper.getData();
    dataList = userList;
    notifyListeners();
  }

  Future addHabit(context) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        enableDrag: false,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.8,
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: const BoxDecoration(
                color: kGrey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                )
            ),
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(hintText: 'Name'),
                ),
                TextFormField(
                  controller: commentController,
                  decoration: const InputDecoration(hintText: 'Comment'),
                ),
                TextFormField(
                  controller: daysController,
                  decoration: const InputDecoration(hintText: 'Days'),
                ),
                TextFormField(
                  controller: actionController,
                  decoration: const InputDecoration(hintText: 'Action'),
                ),
                TextFormField(
                  controller: colorController,
                  decoration: const InputDecoration(hintText: 'Color'),
                ),
                TextFormField(
                  controller: iconController,
                  decoration: const InputDecoration(hintText: 'Icon'),
                ),
                IconButton(
                  onPressed: (){
                    saveData();
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.add),
                )
              ],
            ),
          );
        });
  }


}