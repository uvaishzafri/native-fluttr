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
"Hindu": [],
  "Muslim": [],
  "Christian": [],
  "Sikh": [],
  "Buddhist": [],
  "Jain": [],
  "Others": [],
};

List<String> languages = [
  "Hindi",
  "English",
  "Marathi",
  "Telugu",
  "Tamil",
  "Bengali",
  "Gujarati",
  "Kannada",
  "Punjabi",
  "Urdu",
  "Odia",
  "Assamese",
  "Kashmiri",
  "Nepali",
  "Marwari",
  "Others",
];


List<String> locations = [
  'Bangalore',
  'Delhi',
  'Gurgaon',
  'Chennai',
  'Hyderabad',
  'Mumbai',
  'Pune',
  'Kolkata',
  'Ahmedabad'
];
