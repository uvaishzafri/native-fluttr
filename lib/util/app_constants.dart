import 'package:freezed_annotation/freezed_annotation.dart';

enum Gender {
  @JsonValue('MALE')
  male,
  @JsonValue('FEMALE')
  female,
  @JsonValue('OTHER')
  others
}

final Map<String, List<String>> religions = {
  'Christian': [
    'Catholic',
    'Russian',
    'Syriac',
  ],
  'Hindu': [
    'Bengali',
    'Brahmin',
    'Marwadi'
  ],
  'Buddhist': [
    'Bengali',
    'Brahmin',
    'Marwadi'
  ],
  'Muslim': [
    'Bengali',
    'Brahmin',
    'Marwadi'
  ],
  'Jain': [
    'Bengali',
    'Brahmin',
    'Marwadi'
  ],
};

List<String> locations = [
  'Bengaluru',
  'Mumbai',
  'Delhi',
  'Chennai',
  'Pune'
];
