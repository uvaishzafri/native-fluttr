import 'package:native/model/chat_room.dart';
import 'package:native/model/custom_claims.dart';
import 'package:native/model/likes_model.dart';
import 'package:native/model/native_card/meta.dart';
import 'package:native/model/native_card/native_card.dart';
import 'package:native/model/native_card/native_type.dart';
import 'package:native/model/native_type.dart';
import 'package:native/model/user.dart';
import 'package:native/repo/model/message.dart';
import 'package:native/util/app_constants.dart';

// final List<Native> usersList = [
//   Native(
//     user: "Sarah Clay",
//     age: '31 yrs',
//     imageUrl: 'assets/home/ic_test.png',
//     type: NativeType.fields(),
//     energy: 33,
//     goodFits: [
//       NativeType.moon(),
//       NativeType.mist(),
//       NativeType.mineral(),
//     ],
//   ),
//   Native(
//     user: "Angelina",
//     age: '31 yrs',
//     imageUrl: 'assets/home/angelina.png',
//     type: NativeType.fields(),
//     energy: 33,
//     goodFits: [
//       NativeType.moon(),
//       NativeType.mist(),
//       NativeType.mineral(),
//     ],
//   ),
//   Native(
//     user: "Smith",
//     age: '31 yrs',
//     imageUrl: 'assets/home/ic_profile_pic2.png',
//     type: NativeType.fields(),
//     energy: 33,
//     goodFits: [
//       NativeType.moon(),
//       NativeType.mist(),
//       NativeType.mineral(),
//     ],
//   ),
//   Native(
//     user: "Christie",
//     age: '31 yrs',
//     imageUrl: 'assets/home/ic_profile_pic3.png',
//     type: NativeType.fields(),
//     energy: 33,
//     goodFits: [
//       NativeType.moon(),
//       NativeType.mist(),
//       NativeType.mineral(),
//     ],
//   ),
//   Native(
//     user: "Will",
//     age: '31 yrs',
//     imageUrl: 'assets/home/ic_profile_pic4.png',
//     type: NativeType.fields(),
//     energy: 33,
//     goodFits: [
//       NativeType.moon(),
//       NativeType.mist(),
//       NativeType.mineral(),
//     ],
//   ),
//   Native(
//     user: "Nick",
//     imageUrl: 'assets/home/ic_test.png',
//     age: '31 yrs',
//     type: NativeType.fields(),
//     energy: 33,
//     goodFits: [
//       NativeType.moon(),
//       NativeType.mist(),
//       NativeType.mineral(),
//     ],
//   ),
// ];

List<ChatRoom> dummyChatList = [
  ChatRoom(
      participants: {
        'CAFGy5wD0gOG2NXSp5goSVMOVQe2': [
          'test user',
          'https://picsum.photos/id/237/200/300'
        ],
        '5v4PoKCawiazfNwBWoUNWi2WFDo2': [
          'test user 2',
          'https://picsum.photos/id/230/200/300'
        ],
      },
      lastMessageTime: DateTime(2023, 10, 12),
      lastMessage: 'Hello',
      creationTime: DateTime(2023, 10, 11),
      creatorId: 'CAFGy5wD0gOG2NXSp5goSVMOVQe2',
      lastReadTime: {
        '5v4PoKCawiazfNwBWoUNWi2WFDo2': DateTime.now(),
        'CAFGy5wD0gOG2NXSp5goSVMOVQe2': DateTime.now(),
      },
      firestoreDocId: '1'),
  ChatRoom(
      participants: {
        'CAFGy5wD0gOG2NXSp5goSVMOVQe2': [
          'test user',
          'https://picsum.photos/id/237/200/300'
        ],
        '5v4PoKCawiazfNwBWoUNWi2WFDo2': [
          'test user 3',
          'https://picsum.photos/id/231/200/300'
        ],
      },
      creationTime: DateTime(2023, 10, 15),
      creatorId: 'CAFGy5wD0gOG2NXSp5goSVMOVQe2',
      lastReadTime: {
        '5v4PoKCawiazfNwBWoUNWi2WFDo2': DateTime.now(),
        'CAFGy5wD0gOG2NXSp5goSVMOVQe2': DateTime.now(),
      },
      firestoreDocId: '2'),
];

List<Message> dummyMessages = [
  Message(senderId: '5v4PoKCawiazfNwBWoUNWi2WFDo2', creationDate: DateTime(2023, 10, 15, 11), text: 'Cant wait to meet you'),
  Message(senderId: '5v4PoKCawiazfNwBWoUNWi2WFDo2', creationDate: DateTime(2023, 10, 15, 12), text: 'Hi'),
  Message(senderId: 'CAFGy5wD0gOG2NXSp5goSVMOVQe2', creationDate: DateTime(2023, 10, 15, 13, 30), text: 'Hell'),
  Message(senderId: 'CAFGy5wD0gOG2NXSp5goSVMOVQe2', creationDate: DateTime(2023, 10, 15, 14, 50, 20), text: '💬 '),
  Message(senderId: 'CAFGy5wD0gOG2NXSp5goSVMOVQe2', creationDate: DateTime(2023, 10, 15, 15, 10), text: 'Dinner'),
  Message(senderId: 'CAFGy5wD0gOG2NXSp5goSVMOVQe2', creationDate: DateTime(2023, 10, 15, 16, 50, 20), text: 'tonight?'),
];

LikesModel likes = LikesModel(fromYou: [
  UserLikes(userId: 'Sarah Clay', likedDate: DateTime(2023, 10, 14)),
  UserLikes(userId: 'Angelina', likedDate: DateTime(2023, 10, 14)),
  UserLikes(userId: 'Smith', likedDate: DateTime(2023, 10, 14)),
], fromOthers: [
  UserLikes(userId: 'Sarah Clay', likedDate: DateTime(2023, 10, 14)),
  UserLikes(userId: 'Angelina', likedDate: DateTime(2023, 10, 14)),
  UserLikes(userId: 'Smith', likedDate: DateTime(2023, 10, 14)),
]);

final usersList2 = [
  NativeCard.fromJson({
    "birthday": {
      "month": 10,
      "year": 2000,
      "day": 14
    },
    "love": {
      "hashTags": "#Comfortable #Conservative #Kind",
      "descriptions": [
        "First impressions convey kindness. Revealing gentle vibe",
        "People prefer free relationship not bound and shilly-shally.",
        "Serious and nervous. Cannot approach from you. Going out lasts longer."
      ]
    },
    "gender": "MALE",
    "partner": {
      "descriptions": [
        "Tends to be stressed out by caring outside. Calm together.",
        "Honest person make active attack without hurting your high pride."
      ]
    },
    "personality": {
      "sameKindCelebrity": "Alia Bhatt, Salman Khan, CarryMinati, Manushi Chhillar",
      "hashTags": "#Humble #Restrained #Indecisive #Indecisive #Mild-mannered",
      "descriptions": [
        "Shy, not a risk taker, glue person, weave relationships",
        "Seeker pursues a theme through steady effort and perseverance.",
        "Lively, full of action, and thinks that it is important to act first."
      ]
    },
    "advice": {
      "descriptions": [
        "Swayed by indecision because of kindness. Follow your will!",
        "Be honest without being passive for fear that pride will be hurt."
      ]
    },
    "meta": {
      "matchTypes": [
        {
          "ja": "霧",
          "en": "Mist"
        },
        {
          "ja": "太陽",
          "en": "Sun"
        },
        {
          "ja": "鉱物",
          "en": "Mineral"
        }
      ],
      "energyScore": 22,
      "color": {
        "hex": "#F2C9D3",
        "hsv": {
          "s": 16.94214876033058,
          "v": 94.90196078431372,
          "h": 345.3658536585366
        },
        "rgb": {
          "b": 211,
          "r": 242,
          "g": 201
        }
      },
      "parameter": {
        "active": 0.7,
        "independence": 0.1,
        "finance": 0,
        "fun": 0.2,
        "knowledge": 0
      },
      "type": {
        "ja": "草花",
        "en": "Flower"
      },
      "slogan": "Healing Classy Free person"
    },
    "ideasPlan": {
      "descriptions": [
        "Luxurious international travel dates to experience gorgeous arts.",
        "Experience of traditional culture that values ​​forms and rules."
      ]
    }
  }),
];

final usersList = [
  User(
    uid: '1',
    displayName: 'Sarah clay',
    photoURL: 'https://picsum.photos/id/231/200/300',
    email: 'testuser@gmail.com',
    emailVerified: true,
    phoneNumber: '+919999898989',
    phoneNumberVerified: true,
    native: Meta(
      type: NativeTypeEnum.fields,
      // type: NativeType(
      //   en: 'Mist',
      //   ja: '1234',
      // ),
      matchTypes: [
        NativeTypeEnum.mineral,
        NativeTypeEnum.mist,
        NativeTypeEnum.moon,
        // NativeType(
        //   en: 'Mist',
        //   ja: '1234',
        // ),
        // NativeType(
        //   en: 'Moon',
        //   ja: '1235',
        // ),
        // NativeType(
        //   en: 'Light',
        //   ja: '1236',
        // ),
      ],
      energyScore: 33,
    ),
    customClaims: CustomClaims(
      gender: Gender.male,
      birthday: '12-10-2001',
      religion: 'Hindu',
      community: 'Marwadi',
      location: 'Pune',
      about: 'about me',
    ),
  ),
];

//     user: "Sarah Clay",
//     age: '31 yrs',
//     imageUrl: 'assets/home/ic_test.png',
//     type: NativeType.fields(),
//     energy: 33,
//     goodFits: [
//       NativeType.moon(),
//       NativeType.mist(),
//       NativeType.mineral(),
//     ],

