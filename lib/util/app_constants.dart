import 'package:freezed_annotation/freezed_annotation.dart';

enum Gender {
  @JsonValue('MALE')
  male,
  @JsonValue('FEMALE')
  female,
  @JsonValue('OTHER')
  others
}

enum NotificationType {
  @JsonValue('LIKED')
  liked,
  @JsonValue('MATCHED')
  matched,
  @JsonValue('BLOCKED')
  blocked
}

List<String> problems = [
  'Nudity or sexual activity',
  'Hate speech or symbols',
  'Scam or Fraud',
  'Violence or dangerous organisation',
  'Bullying or harrasment',
  'Others',
];


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
