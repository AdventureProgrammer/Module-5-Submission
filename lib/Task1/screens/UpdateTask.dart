import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:module_five/Task1/model/MyModel.dart';
import 'package:module_five/Task1/userservices/UserServices.dart';

class UpdateTask extends StatefulWidget {
  final MyModel myModel;
  //List<MyModel> myList = <MyModel>[];

  UpdateTask({
    Key? key,
    required this.myModel,
  }) : super(key: key);

  @override
  State<UpdateTask> createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {
  var _userService = UserServices();
  var _myModel = MyModel();
  GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _priorityController = TextEditingController();
  TextEditingController _taskStatusController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController.text = widget.myModel.name ?? '';
    _descriptionController.text = widget.myModel.description ?? '';
    _dateController.text = widget.myModel.date ?? '';
    _timeController.text = widget.myModel.time ?? '';
    _priorityController.text = widget.myModel.priority ?? '';
    _taskStatusController.text = widget.myModel.taskstatus ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Data To Table'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Enter Name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter name';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Enter Description',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Description';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _dateController,
                  decoration: InputDecoration(
                    labelText: 'Select Date',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter date';
                    } else {
                      return null;
                    }
                  },
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(
                            2000), //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2101));

                    if (pickedDate != null) {
                      print(
                          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate =
                          DateFormat('dd-MMM-yyyy').format(pickedDate);
                      print(
                          formattedDate); //formatted date output using intl package =>  2021-03-16
                      //you can implement different kind of Date Format here according to your requirement

                      setState(() {
                        _dateController.text =
                            formattedDate; //set output date to TextField value.
                      });
                    } else {
                      print("Date is not selected");
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _timeController,
                  decoration: InputDecoration(
                    labelText: 'Select Time',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Select Time';
                    } else {
                      return null;
                    }
                  },
                  onTap: () {
                    _show(_timeController);
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _priorityController,
                  decoration: InputDecoration(
                    hintText: 'Enter Priority - low/average/high',
                    labelText: 'Enter Priority',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Priority(low/average/high)';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _taskStatusController,
                  decoration: InputDecoration(
                    hintText: 'Enter Task Status - completed/pending',
                    labelText: 'Enter TaskStatus',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter TaskStatus(completed/pending)';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 34,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _myModel.id = widget.myModel.id!;
                            _myModel.name = _nameController.text;

                            _myModel.description = _descriptionController.text;
                            _myModel.date = _dateController.text;
                            _myModel.time = _timeController.text;
                            _myModel.priority = _priorityController.text;
                            _myModel.taskstatus = _taskStatusController.text;
                            var resultUpdate =
                                await _userService.updateDataOfUser(_myModel);
                            //print(result + '=====Data Inserted=====');
                            // print('Data Inserted');
                            print(_myModel.name);
                            print(_myModel.description);
                            // return result;
                            Navigator.pop(context, resultUpdate);
                          }
                        },
                        child: Text('Update')),
                    ElevatedButton(onPressed: () {}, child: Text('Clear'))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _show(TextEditingController txt) async {
    final TimeOfDay? result = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, child) {
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                  // Using 12-Hour format
                  alwaysUse24HourFormat: true),
              // If you want 24-Hour format, just
              //change alwaysUse24HourFormat to true
              child: child!);
        });
    if (result != null) {
      setState(() {
        txt.text = result.format(context);
      });
    }
  }
}
