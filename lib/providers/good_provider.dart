import 'package:flutter/material.dart';
import 'package:justhabit/constants.dart';
import 'package:justhabit/pages/bad_page.dart';
import 'package:justhabit/widgets/actions_button_widget.dart';
import '../databasehelper.dart';
import '../pages/good_page.dart';
import '../widgets/days_button_widget.dart';
import '../widgets/text_field_widget.dart';

class GoodProvider with ChangeNotifier {

  PageController mainPageController = PageController(initialPage: 0);
  int activePage = 0;
  Days selectedDays = Days.one;
  Done selectedActions = Done.one;

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

  void selectDay(int days){
    switch(days){
      case 30:
        selectedDays = Days.one;
        break;
      case 60:
        selectedDays = Days.two;
        break;
    }
    notifyListeners();
  }

  void selectAction(int action){
    switch(action){
      case 1:
        selectedActions = Done.one;
        break;
      case 2:
        selectedActions = Done.two;
        break;
      case 3:
        selectedActions = Done.three;
        break;
    }
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextFieldWidget(
                  controller: nameController,
                  hintText: 'Name',
                ),
                TextFieldWidget(
                  height: 90,
                  controller: commentController,
                  hintText: 'Comment',
                ),
                const DaysButtonWidget(),
                const ActionsButtonWidget(),
                TextFormField(
                  controller: colorController,
                  decoration: const InputDecoration(hintText: 'Color'),
                ),
                TextFormField(
                  controller: iconController,
                  decoration: const InputDecoration(hintText: 'Icon'),
                ),
                GestureDetector(
                  onTap: (){
                    saveData();
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: 100,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: kGreen),
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                        gradient: LinearGradient(
                            colors: [
                              kGreen.withOpacity(0.2),
                              kYellow.withOpacity(0.1)
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            stops: const [0, 1]
                        )
                    ),
                    child: Center(child: Text('Begin',
                      style: kOrangeStyle.copyWith(
                          color: kOrange.withOpacity(0.5)),)),
                  ),
                )
              ],
            ),
          );
        });
  }
}


