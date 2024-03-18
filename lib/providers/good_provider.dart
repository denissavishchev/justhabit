import 'dart:convert';
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
  Days selectedDays = Days.fifteen;
  Done selectedActions = Done.one;
  int totalDays = 15;
  int totalActions = 1;
  List<String> progressDay = [];
  Map<String, String> progressDaysMap = {};
  Map<String, String> progressActionsMap = {};
  Map<String, dynamic> progressActions = {};
  Map<String, dynamic> progressDays = {};

  List<Map<String, dynamic>> dataList = [];
  final nameController = TextEditingController();
  final commentController = TextEditingController();

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


  void updateProgressState(context, String name, String comment, int days, int actions, int userId) async{
      switch(actions){
        case 3:
          if(progressActions.values.elementAt(0) == 'true' &&
              progressActions.values.elementAt(1) == 'true'){
            progressActions.update('2', (value) => 'true');
            progressDays.update(DateTime.now().toString().split(' ')[0], (value) => '1');
          }else if(progressActions.values.elementAt(0) == 'true'){
            progressActions.update('1', (value) => 'true');
            progressDays.update(DateTime.now().toString().split(' ')[0], (value) => '2');
          }else if(progressActions.values.elementAt(0) == 'false'){
            progressActions.update('0', (value) => 'true');
            progressDays.update(DateTime.now().toString().split(' ')[0], (value) => '3');
          }
          break;
        case 2:
          if(progressActions.values.elementAt(0) == 'true'){
            progressActions.update('1', (value) => 'true');
            progressDays.update(DateTime.now().toString().split(' ')[0], (value) => '1');
          }else if(progressActions.values.elementAt(0) == 'false'){
            progressActions.update('0', (value) => 'true');
            progressDays.update(DateTime.now().toString().split(' ')[0], (value) => '2');
          }
          break;
        case 1:
          progressActions.update('0', (value) => 'true');
          progressDays.update(DateTime.now().toString().split(' ')[0], (value) => '1');
    }

    Map<String, dynamic> data = {
      'name' : name,
      'comment' : comment,
      'days' : days,
      'actions' : actions,
      'color' : '',
      'icon' : '',
      'unit' : '',
      'progressDays' : json.encode(progressDays),
      'progressActions' : json.encode(progressActions),
      'date' : DateTime.now().toString(),
    };
    await DatabaseHelper.updateData(userId, data);
  }

  void getProgressDays(){
    final date = DateTime.now();
    for(int i = 0; i <= (DateTime(date.year, date.month, date.day + totalDays))
        .difference(DateTime.now()).inDays; i++){
      progressDay.add(DateTime.now().add(Duration(days: i)).toString().split(' ')[0]);
    }
    for(var value in progressDay){
      progressDaysMap.addAll({value.toString(): '0'});
    }
  }

  getProgressActions(){
    for (int i = 0; i < totalActions; i++){
      progressActionsMap.addAll({i.toString() : 'false'});
    }
  }

  void saveData() async{
    getProgressDays();
    getProgressActions();
    await DatabaseHelper.insertUser(
      nameController.text,
      commentController.text,
      totalDays,
      totalActions,
      json.encode(progressDaysMap),
      json.encode(progressActionsMap)

    );
    fetchUsers();
    nameController.clear();
    commentController.clear();
    totalDays = 15;
    totalActions = 1;
    selectedDays = Days.fifteen;
    selectedActions = Done.one;
    progressDay.clear();
    progressDaysMap.clear();
    progressActions.clear();
    progressActionsMap.clear();
    notifyListeners();
  }

  void fetchUsers()async {
    List<Map<String, dynamic>> userList = await DatabaseHelper.getData();
    dataList = userList;
    notifyListeners();
  }

  void delete(int docId) async{
    await DatabaseHelper.deleteData(docId);
    List<Map<String, dynamic>> updatedData = await DatabaseHelper.getData();
    dataList = updatedData;
    notifyListeners();
  }

  void selectDay(int days){
    switch(days){
      case 15:
        selectedDays = Days.fifteen;
        totalDays = 15;
        break;
      case 30:
        selectedDays = Days.thirty;
        totalDays = 30;
        break;
      case 45:
        selectedDays = Days.fortyFive;
        totalDays = 45;
        break;
      case 60:
        selectedDays = Days.sixty;
        totalDays = 60;
        break;
    }
    notifyListeners();
  }

  void selectAction(int action){
    switch(action){
      case 1:
        selectedActions = Done.one;
        totalActions = 1;
        break;
      case 2:
        selectedActions = Done.two;
        totalActions = 2;
        break;
      case 3:
        selectedActions = Done.three;
        totalActions = 3;
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
                  height: 80,
                  controller: commentController,
                  hintText: 'Comment',
                ),
                const DaysButtonWidget(),
                const ActionsButtonWidget(),
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
                    child: Center(child: Text('Start',
                      style: kGreenStyle,)),
                  ),
                )
              ],
            ),
          );
        });
  }

  void showPopDialog(context, String title, String content){
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Ok'))
            ],
          );
        });
  }
}



