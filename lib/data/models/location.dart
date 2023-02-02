import 'dart:typed_data';

class Location {
  Location({
    required this.latitude,
    required this.longitude,
  });
  final double latitude;
  final double longitude;

  static final empty = Location(latitude: 0, longitude: 0);

  get geoHash => encode(latitude, longitude);

  static const String _baseSequence = '0123456789bcdefghjkmnpqrstuvwxyz';

  /// Creates a Map of available characters for a geohash
  final _base32Map = <String, int>{
    for (var value in _baseSequence.split(''))
      value: _baseSequence.indexOf(value),
  };

  /// Creates a reversed Map of available characters for a geohash

  final _base32MapR = <int, String>{
    for (var value in _baseSequence.split(''))
      _baseSequence.indexOf(value): value,
  };

  List<int> _doubleToBits({
    required double value,
    double lower = -90.0,
    double middle = 0.0,
    double upper = 90.0,
    int length = 15,
  }) {
    final ret = <int>[];

    for (var i = 0; i < length; i++) {
      if (value >= middle) {
        lower = middle;
        ret.add(1);
      } else {
        upper = middle;
        ret.add(0);
      }
      middle = (upper + lower) / 2;
    }

    return ret;
  }

  /// Converts a List<int> bits into a String geohash
  String _bitsToGeoHash(List<int> bitValue) {
    final geoHashList = <String>[];

    var remainingBits = List<int>.from(bitValue);
    var subBits = <int>[];
    String subBitsAsString;
    for (var i = 0; i < bitValue.length / 5; i++) {
      subBits = remainingBits.sublist(0, 5);
      remainingBits = remainingBits.sublist(5);

      subBitsAsString = '';
      for (final value in subBits) {
        subBitsAsString += value.toString();
      }

      final value =
          int.parse(int.parse(subBitsAsString, radix: 2).toRadixString(10));
      geoHashList.add(_base32MapR[value]!);
    }

    return geoHashList.join('');
  }

  /// Converts a String geohash into List<int> bits
  List<int> _geoHashToBits(String geohash) {
    final bitList = <int>[];

    for (final letter in geohash.split('')) {
      if (_base32Map[letter] == null) {
        continue;
      }

      final buffer = Uint8List(5).buffer;
      final bufferData = ByteData.view(buffer);

      bufferData.setUint32(0, _base32Map[letter]!);
      for (final letter in bufferData
          .getUint32(0)
          .toRadixString(2)
          .padLeft(5, '0')
          .split('')) {
        bitList.add(int.parse(letter));
      }
    }

    return bitList;
  }

  String encode(double longitude, double latitude, {int precision = 12}) {
    var originalPrecision = precision + 0;
    if (longitude < -180.0 || longitude > 180.0) {
      throw RangeError.range(longitude, -180, 180, 'Longitude');
    }
    if (latitude < -90.0 || latitude > 90.0) {
      throw RangeError.range(latitude, -90, 90, 'Latitude');
    }

    if (precision % 2 == 1) {
      precision = precision + 1;
    }
    if (precision != 1) {
      precision ~/= 2;
    }

    final longitudeBits = _doubleToBits(
      value: longitude,
      lower: -180.0,
      upper: 180.0,
      length: precision * 5,
    );
    final latitudeBits = _doubleToBits(
      value: latitude,
      lower: -90.0,
      upper: 90.0,
      length: precision * 5,
    );

    final ret = <int>[];
    for (var i = 0; i < longitudeBits.length; i++) {
      ret.add(longitudeBits[i]);
      ret.add(latitudeBits[i]);
    }
    final geohashString = _bitsToGeoHash(ret);

    if (originalPrecision == 1) {
      return geohashString.substring(0, 1);
    }
    if (originalPrecision % 2 == 1) {
      return geohashString.substring(0, geohashString.length - 1);
    }
    return geohashString;
  }
}