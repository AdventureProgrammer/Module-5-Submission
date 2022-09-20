class MyHotel {
  int? id;
  String? hotelName;
  String? hotelArea;
  String? hotelCity;
  String? hotelRating;

  MyHotelMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id ?? null;
    mapping['hName'] = hotelName;
    mapping['hArea'] = hotelArea;
    mapping['hCity'] = hotelCity;
    mapping['hRating'] = hotelRating;
    return mapping;
  }
}
