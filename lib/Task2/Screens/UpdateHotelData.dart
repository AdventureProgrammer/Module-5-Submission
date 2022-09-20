import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:module_five/Task2/Model/HotelModel.dart';
import 'package:module_five/Task2/UserServices/UserServices.dart';

class UpdateHotelData extends StatefulWidget {
  final MyHotel myHotel;
  const UpdateHotelData({Key? key, required this.myHotel}) : super(key: key);

  @override
  State<UpdateHotelData> createState() => _UpdateHotelDataState();
}

class _UpdateHotelDataState extends State<UpdateHotelData> {
  var _ratingValue;
  var _myRatingValue;
  TextEditingController _hName = TextEditingController();
  TextEditingController _hArea = TextEditingController();
  TextEditingController _hCity = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  var _userService = HotelUserServices();
  var mHotel = MyHotel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _hName.text = widget.myHotel.hotelName ?? '';
    _hArea.text = widget.myHotel.hotelArea ?? '';
    _hCity.text = widget.myHotel.hotelCity ?? '';
    _ratingValue = widget.myHotel.hotelRating ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Data'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              children: [
                SizedBox(
                  height: 28,
                ),
                TextFormField(
                  controller: _hName,
                  decoration: InputDecoration(labelText: 'Enter Hotel Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Fill Field';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 28,
                ),
                TextFormField(
                  controller: _hArea,
                  decoration: InputDecoration(labelText: 'Enter Hotel Area'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Fill Field';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 28,
                ),
                TextFormField(
                  controller: _hCity,
                  decoration: InputDecoration(labelText: 'Enter Hotel City'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Fill Field';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 28,
                ),
                Text('Please Rate Hotel'),
                SizedBox(
                  height: 28,
                ),
                RatingBar(
                    initialRating: _rating(_ratingValue)!,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    ratingWidget: RatingWidget(
                        full: const Icon(
                          Icons.star,
                          color: Colors.orange,
                        ),
                        half: const Icon(
                          Icons.star_half,
                          color: Colors.orange,
                        ),
                        empty: const Icon(
                          Icons.star_outline,
                          color: Colors.orange,
                        )),
                    onRatingUpdate: (value) {
                      setState(() {
                        _myRatingValue = value;
                      });
                    }),
                Text('Old Rating = ${_ratingValue.toString()}'),
                Text('New Rating = ${_myRatingValue.toString()}'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            mHotel.id = widget.myHotel.id;
                            mHotel.hotelName = _hName.text;
                            mHotel.hotelArea = _hArea.text;
                            mHotel.hotelCity = _hCity.text;
                            if (_ratingValue == 0.0 || _ratingValue == null)
                              _ratingValue = (0.0).toString();

                            if (_myRatingValue == null) _myRatingValue = 0.0;
                            mHotel.hotelRating = _myRatingValue.toString();

                            print(mHotel);
                            var result = await _userService.updateData(mHotel);
                            print(result);
                            print('Data Updated');
                            Navigator.pop(context, result);
                            //return result;
                          }
                        },
                        child: Text('Save')),
                    ElevatedButton(
                        onPressed: () {
                          _hName.clear();
                          _hArea.clear();
                          _hCity.clear();
                        },
                        child: Text('Clear')),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double? _rating(ratingValue) {
    //if (ratingValue) {
    //var currentRating = _ratingValue.
    var _ratingDoubleValue = double.parse(ratingValue);

    return _ratingDoubleValue.toDouble();
    // }
  }
}
