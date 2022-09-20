import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:module_five/Task2/Model/HotelModel.dart';
import 'package:module_five/Task2/UserServices/UserServices.dart';

class AddHotel extends StatefulWidget {
  const AddHotel({Key? key}) : super(key: key);

  @override
  State<AddHotel> createState() => _AddHotelState();
}

class _AddHotelState extends State<AddHotel> {
  var _ratingValue;
  TextEditingController _hName = TextEditingController();
  TextEditingController _hArea = TextEditingController();
  TextEditingController _hCity = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  var _userService = HotelUserServices();
  var mHotel = MyHotel();
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
                    initialRating: 0,
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
                        _ratingValue = value;
                      });
                    }),
                Text(_ratingValue.toString()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            mHotel.hotelName = _hName.text;
                            mHotel.hotelArea = _hArea.text;
                            mHotel.hotelCity = _hCity.text;
                            // _ratingValue == null
                            //    ? (0.0).toString()
                            //     : _ratingValue;
                            // _ratingValue ?? (0.0).toString();

                            // mHotel.hotelRating == null
                            //     ? (0.0)
                            //     : _ratingValue.toString();
                            if (_ratingValue == null) {
                              _ratingValue = (0.0).toString();
                            }
                            mHotel.hotelRating = _ratingValue.toString();

                            print(mHotel);
                            var result = await _userService.insertData(mHotel);
                            print(result);
                            print('Data Saved');
                            Navigator.pop(context, result);
                            //return result;
                          }
                        },
                        child: Text('Save')),
                    ElevatedButton(onPressed: () {}, child: Text('Clear')),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  addDataToHotel() async {}
}
