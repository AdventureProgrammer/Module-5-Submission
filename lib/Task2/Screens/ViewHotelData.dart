import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:module_five/Task2/Model/HotelModel.dart';

class ViewHotelData extends StatefulWidget {
  final MyHotel myHotel;
  const ViewHotelData({Key? key, required this.myHotel}) : super(key: key);

  @override
  State<ViewHotelData> createState() => _ViewHotelDataState();
}

class _ViewHotelDataState extends State<ViewHotelData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Details of Hotels'),
        ),
        body: Container(
          child: Column(
            children: [
              Text(widget.myHotel.hotelName ?? ''),
              Text(widget.myHotel.hotelArea ?? ''),
              Text(widget.myHotel.hotelCity ?? ''),
              Text(widget.myHotel.hotelRating ?? ''),
            ],
          ),
        ));
  }
}
