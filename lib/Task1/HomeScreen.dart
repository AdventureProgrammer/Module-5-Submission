import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:module_five/Task1/model/MyModel.dart';
import 'package:module_five/Task1/screens/AddTask.dart';
import 'package:module_five/Task1/screens/UpdateTask.dart';
import 'package:module_five/Task1/userservices/UserServices.dart';

class DisplayData extends StatefulWidget {
  const DisplayData({Key? key}) : super(key: key);

  @override
  State<DisplayData> createState() => _DisplayDataState();
}

class _DisplayDataState extends State<DisplayData> {
  var _userService = UserServices();
  List<MyModel> modelList = [];
  List taskItems = [];
  List filteredItems = [];
  bool isSearching = false;
  var colorP = Color;
  Color? cp;
  Color? showColorAsPerPriority(List<MyModel> modelList, int index) {
    if (modelList[index].taskstatus!.contains('pending')) {
      if (modelList[index].priority!.contains('low')) {
        //print('======${modelList[index].priority}');

        cp = Colors.green;
      } else if (modelList[index].priority!.contains('average')) {
        cp = Colors.blue;
      } else if (modelList[index].priority!.contains('high')) {
        cp = Colors.red;
      }
    } else if (modelList[index].taskstatus!.contains('completed')) {
      cp = Colors.grey;
    }

    return cp;
  }
  // showColorAsPerPriority(List<MyModel> modelList, int index) {
  //   setState(() {
  //     if (modelList[index].priority == 'low') {
  //       cp = Colors.green;
  //     }
  //   });
  // }

  getAllLists() async {
    var models = await _userService.readDataTasks();
    modelList = <MyModel>[];
    models.forEach((mymodel) {
      setState(() {
        var _m = MyModel();
        _m.id = mymodel['id'];
        _m.name = mymodel['taskname'];
        _m.description = mymodel['description'];
        _m.date = mymodel['date'];
        _m.time = mymodel['time'];
        _m.priority = mymodel['priority'];
        _m.taskstatus = mymodel['taskstatus'];
        modelList.add(_m);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllLists();
    //setState(() {
    //  Text(modelList.isEmpty ? 'No Records' : 'Records Present');
    //2w1 });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: !isSearching
            ? Text('All Tasks')
            : TextField(
                onChanged: (value) {},
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    hintText: "Search Task Here",
                    hintStyle: TextStyle(color: Colors.white)),
              ),
        actions: <Widget>[
          isSearching
              ? IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    setState(() {
                      this.isSearching = false;
                      filteredItems = taskItems;
                    });
                  },
                )
              : IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      this.isSearching = true;
                    });
                  },
                )
        ],
      ),

      //Text('Home Screen'),

      body: ListView.builder(
        itemCount: modelList.length,
        itemBuilder: (context, index) {
          return Card(
            color: showColorAsPerPriority(modelList, index),

            // modelList[index].priority == 'low'
            //     ? Colors.green
            //     : modelList[index].priority == 'average'
            //         ? Colors.blue
            //         : modelList[index].priority == 'high'
            //             ? Colors.red
            //             : cp != null
            //                 ? Colors.grey
            //                 : Colors.blue,

            //selectColor(modelList, index, modelList[index].priority!),
            // selectColor(modelList, index, modelList[index].priority!),
            //modelList[index].priority == 'low' ? Colors.green : Colors.red,
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: ListTile(
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(modelList.length == 0
                        ? 'No Records'
                        : 'Records Present'),
                    Text(modelList[index].name ?? ''),
                    Text(modelList[index].description ?? ''),
                    Text(modelList[index].date ?? ''),
                    Text(modelList[index].time ?? ''),
                    Text(modelList[index].priority ?? ''),
                    Text(modelList[index].taskstatus ?? ''),
                  ],
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UpdateTask(
                              myModel: modelList[index],
                            ),
                          ),
                        ).then(
                          (value) => {
                            if (value != null)
                              {
                                getAllLists(),
                              }
                          },
                        );
                      },
                      child: Text(
                        'Edit',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        _deleteUser(context, modelList[index].id);
                      },
                      child: Text(
                        'Delete',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                onLongPress: () =>
                    _contextMenu(context, index, modelList, modelList[index]),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTask(),
            ),
          ).then((value) => {
                if (value != null)
                  {
                    getAllLists(),
                    showSnackbar('Data Added Success'),
                  }
              });
        },
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Icon(Icons.add),
              Text('Task'),
            ],
          ),
        ),
      ),
    );
  }

  showSnackbar(String s) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(s),
      ),
    );
  }

  _deleteUser(BuildContext context, taskId) {
    return showDialog(
      context: context,
      builder: (param) {
        return AlertDialog(
          title: Text(
            'Are you sure want to Delete',
          ),
          actions: [
            TextButton(
              onPressed: () {},
              child: Text('cancel'),
            ),
            TextButton(
              onPressed: () async {
                var res = await _userService.deleteDataOfUser(taskId);
                if (res != null) {
                  getAllLists();

                  showSnackbar('Data Deleted');
                }

                Navigator.pop(context);
              },
              child: Text(
                'Delete',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  _contextMenu(
    BuildContext context,
    int index,
    List<MyModel> modelList,
    MyModel modelList2,
  ) async {
    final result = await showMenu(
      context: context,
      position: RelativeRect.fromRect(
        Rect.fromLTWH(1, 1, 1, 1),
        Rect.fromLTWH(1, 1, 1, 1),
      ),
      items: [
        const PopupMenuItem(
          child: Text('Complete Task'),
          value: 'complete',
        ),
      ],
    ).then(
      (value) => {
        if (value == 'complete')
          {
            print('=====Task Complete====='),
            setState(
              () {
                // cp = Colors.grey;
              },
            )
          },
      },
    );
  }
}
