import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:module_five/Task2/Model/HotelModel.dart';
import 'package:module_five/Task2/Screens/AddHotel.dart';
import 'package:module_five/Task2/Screens/UpdateHotelData.dart';
import 'package:module_five/Task2/Screens/ViewHotelData.dart';
import 'package:module_five/Task2/UserServices/UserServices.dart';

class HotelHomePage extends StatefulWidget {
  const HotelHomePage({Key? key}) : super(key: key);

  @override
  State<HotelHomePage> createState() => _HotelHomePageState();
}

class _HotelHomePageState extends State<HotelHomePage> {
  late List<MyHotel> myHotelList = [];
  var _userService = HotelUserServices();
  getAllHotelsList() async {
    var hotelData = await _userService.readData();
    myHotelList = [];
    hotelData.forEach((myHotelData) {
      setState(() {
        var _hotel = MyHotel();
        _hotel.id = myHotelData['id'];
        _hotel.hotelName = myHotelData['hName'];
        _hotel.hotelArea = myHotelData['hArea'];
        _hotel.hotelCity = myHotelData['hCity'];
        _hotel.hotelRating = myHotelData['hRating'];
        myHotelList.add(_hotel);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllHotelsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hotel List'),
      ),
      body: ListView.builder(
          itemCount: myHotelList.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(myHotelList[index].hotelName ?? ''),
                    Text(myHotelList[index].hotelArea ?? ''),
                    Text(myHotelList[index].hotelCity ?? ''),
                    Text(
                        'Rating=${myHotelList[index].hotelRating ?? (0.0).toString()}'),
                    //Text(myHotelList[index].hotelRating ?? 0.0 )
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
                              builder: (context) => ViewHotelData(
                                myHotel: myHotelList[index],
                              ),
                            ),
                          );
                        },
                        child: Text('View')),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpdateHotelData(
                                myHotel: myHotelList[index],
                              ),
                            ),
                          ).then((value) => {
                                if (value != null) {getAllHotelsList()}
                              });
                        },
                        child: Text('Update')),
                    TextButton(
                      onPressed: () {
                        //Navigator.pop(context);
                        _deleteHotelDataById(context, myHotelList[index].id);
                      },
                      child: Text(
                        'Delete',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddHotel(),
            ),
          ).then((value) => {
                if (value != null)
                  {
                    getAllHotelsList(),
                  }
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  _deleteHotelDataById(BuildContext context, hotelId) {
    return showDialog(
        context: context,
        builder: (param) {
          return AlertDialog(
            title: Text('Are you sure want to delete?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel',
                ),
              ),
              TextButton(
                onPressed: () {
                  var res = _userService.deleteData(hotelId);
                  if (res != null) {
                    getAllHotelsList();
                    showSnackBar('Hotel Deleted');
                  }
                  Navigator.pop(context);
                },
                child: Text(
                  'Delete',
                ),
              ),
            ],
          );
        });
  }

  showSnackBar(String s) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(s),
      ),
    );
  }
}
