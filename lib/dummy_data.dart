import 'package:native/feature/fav_card/models/fan_model.dart';
import 'package:native/feature/fav_card/models/fav_card_data.dart';
import 'package:native/feature/fav_card/models/item_detail_model.dart';
import 'package:native/feature/fav_card/sub_pages/fav_card_tutorial/models/fav_card_tutorial_item_model.dart';
import 'package:native/feature/fav_card/sub_pages/fav_card_tutorial/models/fav_card_tutorial_model.dart';
import 'package:native/model/chat_room.dart';
import 'package:native/model/custom_claims.dart';
import 'package:native/model/native_card/meta.dart';
import 'package:native/model/native_card/native_card.dart';
import 'package:native/model/native_type.dart';
import 'package:native/model/user.dart';
import 'package:native/repo/model/message.dart';
import 'package:native/util/app_constants.dart';

import 'feature/fav_card/models/fav_card_items/fav_card_items.dart';

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
        'CAFGy5wD0gOG2NXSp5goSVMOVQe2': ['test user', 'https://picsum.photos/id/237/200/300'],
        '5v4PoKCawiazfNwBWoUNWi2WFDo2': ['test user 2', 'https://picsum.photos/id/230/200/300'],
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
        'CAFGy5wD0gOG2NXSp5goSVMOVQe2': ['test user', 'https://picsum.photos/id/237/200/300'],
        '5v4PoKCawiazfNwBWoUNWi2WFDo2': ['test user 3', 'https://picsum.photos/id/231/200/300'],
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

// LikesModel likes = LikesModel(fromYou: [
//   UserLikes(userId: '1', likedDate: DateTime(2023, 10, 14),
//   UserLikes(userId: '2', likedDate: DateTime(2023, 10, 14),
//   UserLikes(userId: '3', likedDate: DateTime(2023, 10, 14),
// ], fromOthers: [
//   UserLikes(userId: '1', likedDate: DateTime(2023, 10, 14),
//   UserLikes(userId: '2', likedDate: DateTime(2023, 10, 14),
//   UserLikes(userId: '3', likedDate: DateTime(2023, 10, 14),
// ]);

final usersList2 = [
  NativeCard.fromJson({
    "birthday": {"month": 10, "year": 2000, "day": 14},
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
        {"ja": "霧", "en": "Mist"},
        {"ja": "太陽", "en": "Sun"},
        {"ja": "鉱物", "en": "Mineral"}
      ],
      "energyScore": 22,
      "color": {
        "hex": "#F2C9D3",
        "hsv": {"s": 16.94214876033058, "v": 94.90196078431372, "h": 345.3658536585366},
        "rgb": {"b": 211, "r": 242, "g": 201},
      },
      "parameter": {"active": 0.7, "independence": 0.1, "finance": 0, "fun": 0.2, "knowledge": 0},
      "type": {"ja": "草花", "en": "Flower"},
      "slogan": "Healing Classy Free person"
    },
    "ideasPlan": {
      "descriptions": [
        "Luxurious international travel dates to experience gorgeous arts.",
        "Experience of traditional culture that values ​​forms and rules."
      ]
    },
    "favCardInterests": [
      {
        "id": "1",
        "likes": 200,
        "comment": "I like this card",
        "name": "Ed Sheeran",
        "categories": ["travel", "music"],
        "imageAddress": 'https://i.scdn.co/image/ab6761610000f1789e690225ad4445530612ccc9'
      },
      {
        "id": "1",
        "likes": 200,
        "comment": "Very driven and enthusiastic artist!!",
        "name": "Taylor Swift",
        "categories": ["travel", "music"],
        "imageAddress": 'https://i.scdn.co/image/ab6761610000f1785a00969a4698c3132a15fbb0',
      },
      {
        "id": "1",
        "likes": 200,
        "comment": "OMG!!!! Such a great artist !!!! ❤️❤️❤️",
        "name": "The Weeknd",
        "categories": ["top", "music"],
        "imageAddress": 'https://i.scdn.co/image/ab6761610000f178b5f9e28219c169fd4b9e8379',
      }
    ],
    "favCardTrends": {"love": 75, "travel": 80}
  }),
  NativeCard.fromJson({
    "birthday": {"month": 10, "year": 2000, "day": 14},
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
        {"ja": "霧", "en": "Mist"},
        {"ja": "太陽", "en": "Sun"},
        {"ja": "鉱物", "en": "Mineral"}
      ],
      "energyScore": 22,
      "color": {
        "hex": "#F2C9D3",
        "hsv": {"s": 16.94214876033058, "v": 94.90196078431372, "h": 345.3658536585366},
        "rgb": {"b": 211, "r": 242, "g": 201}
      },
      "parameter": {"active": 0.7, "independence": 0.1, "finance": 0, "fun": 0.2, "knowledge": 0},
      "type": {"ja": "草花", "en": "Flower"},
      "slogan": "Healing Classy Free person"
    },
    "ideasPlan": {
      "descriptions": [
        "Luxurious international travel dates to experience gorgeous arts.",
        "Experience of traditional culture that values ​​forms and rules."
      ]
    }
  }),
  NativeCard.fromJson({
    "birthday": {"month": 10, "year": 2000, "day": 14},
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
        {"ja": "霧", "en": "Mist"},
        {"ja": "太陽", "en": "Sun"},
        {"ja": "鉱物", "en": "Mineral"}
      ],
      "energyScore": 22,
      "color": {
        "hex": "#F2C9D3",
        "hsv": {"s": 16.94214876033058, "v": 94.90196078431372, "h": 345.3658536585366},
        "rgb": {"b": 211, "r": 242, "g": 201}
      },
      "parameter": {"active": 0.7, "independence": 0.1, "finance": 0, "fun": 0.2, "knowledge": 0},
      "type": {"ja": "草花", "en": "Flower"},
      "slogan": "Healing Classy Free person"
    },
    "ideasPlan": {
      "descriptions": [
        "Luxurious international travel dates to experience gorgeous arts.",
        "Experience of traditional culture that values ​​forms and rules."
      ]
    }
  }),
  NativeCard.fromJson({
    "birthday": {"month": 10, "year": 2000, "day": 14},
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
        {"ja": "霧", "en": "Mist"},
        {"ja": "太陽", "en": "Sun"},
        {"ja": "鉱物", "en": "Mineral"}
      ],
      "energyScore": 22,
      "color": {
        "hex": "#F2C9D3",
        "hsv": {"s": 16.94214876033058, "v": 94.90196078431372, "h": 345.3658536585366},
        "rgb": {"b": 211, "r": 242, "g": 201}
      },
      "parameter": {"active": 0.7, "independence": 0.1, "finance": 0, "fun": 0.2, "knowledge": 0},
      "type": {"ja": "草花", "en": "Flower"},
      "slogan": "Healing Classy Free person"
    },
    "ideasPlan": {
      "descriptions": [
        "Luxurious international travel dates to experience gorgeous arts.",
        "Experience of traditional culture that values ​​forms and rules."
      ]
    }
  }),
  NativeCard.fromJson({
    "birthday": {"month": 10, "year": 2000, "day": 14},
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
        {"ja": "霧", "en": "Mist"},
        {"ja": "太陽", "en": "Sun"},
        {"ja": "鉱物", "en": "Mineral"}
      ],
      "energyScore": 22,
      "color": {
        "hex": "#F2C9D3",
        "hsv": {"s": 16.94214876033058, "v": 94.90196078431372, "h": 345.3658536585366},
        "rgb": {"b": 211, "r": 242, "g": 201}
      },
      "parameter": {"active": 0.7, "independence": 0.1, "finance": 0, "fun": 0.2, "knowledge": 0},
      "type": {"ja": "草花", "en": "Flower"},
      "slogan": "Healing Classy Free person"
    },
    "ideasPlan": {
      "descriptions": [
        "Luxurious international travel dates to experience gorgeous arts.",
        "Experience of traditional culture that values ​​forms and rules."
      ]
    }
  }),
  NativeCard.fromJson({
    "birthday": {"month": 10, "year": 2000, "day": 14},
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
        {"ja": "霧", "en": "Mist"},
        {"ja": "太陽", "en": "Sun"},
        {"ja": "鉱物", "en": "Mineral"}
      ],
      "energyScore": 22,
      "color": {
        "hex": "#F2C9D3",
        "hsv": {"s": 16.94214876033058, "v": 94.90196078431372, "h": 345.3658536585366},
        "rgb": {"b": 211, "r": 242, "g": 201}
      },
      "parameter": {"active": 0.7, "independence": 0.1, "finance": 0, "fun": 0.2, "knowledge": 0},
      "type": {"ja": "草花", "en": "Flower"},
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
      matchTypes: [
        NativeTypeEnum.mineral,
        NativeTypeEnum.mist,
        NativeTypeEnum.moon,
      ],
      energyScore: 33,
    ),
    customClaims: CustomClaims(
      gender: Gender.male,
      birthday: '2001-10-12',
      religion: ['Hindu'],
      community: ['Marwadi'],
      location: 'Pune',
      about: 'about me',
    ),
  ),
  User(
    uid: '2',
    displayName: 'Sarah clay',
    photoURL: 'https://picsum.photos/id/232/200/300',
    email: 'testuser@gmail.com',
    emailVerified: true,
    phoneNumber: '+919999898989',
    phoneNumberVerified: true,
    native: Meta(
      type: NativeTypeEnum.fields,
      matchTypes: [
        NativeTypeEnum.mineral,
        NativeTypeEnum.mist,
        NativeTypeEnum.moon,
      ],
      energyScore: 33,
    ),
    customClaims: CustomClaims(
      gender: Gender.male,
      birthday: '2005-10-12',
      religion: ['Hindu'],
      community: ['Marwadi'],
      location: 'Pune',
      about: 'about me',
    ),
  ),
  User(
    uid: '3',
    displayName: 'Sarah clay',
    photoURL: 'https://picsum.photos/id/233/200/300',
    email: 'testuser@gmail.com',
    emailVerified: true,
    phoneNumber: '+919999898989',
    phoneNumberVerified: true,
    native: Meta(
      type: NativeTypeEnum.fields,
      matchTypes: [
        NativeTypeEnum.mineral,
        NativeTypeEnum.mist,
        NativeTypeEnum.moon,
      ],
      energyScore: 33,
    ),
    customClaims: CustomClaims(
      gender: Gender.male,
      birthday: '2002-10-12',
      religion: ['Hindu'],
      community: ['Marwadi'],
      location: 'Pune',
      about: 'about me',
    ),
  ),
  User(
    uid: '4',
    displayName: 'Sarah clay',
    photoURL: 'https://picsum.photos/id/234/200/300',
    email: 'testuser@gmail.com',
    emailVerified: true,
    phoneNumber: '+919999898989',
    phoneNumberVerified: true,
    native: Meta(
      type: NativeTypeEnum.fields,
      matchTypes: [
        NativeTypeEnum.mineral,
        NativeTypeEnum.mist,
        NativeTypeEnum.moon,
      ],
      energyScore: 33,
    ),
    customClaims: CustomClaims(
      gender: Gender.male,
      birthday: '2003-10-12',
      religion: ['Hindu'],
      community: ['Marwadi'],
      location: 'Pune',
      about: 'about me',
    ),
  ),
  User(
    uid: '5',
    displayName: 'Sarah clay',
    photoURL: 'https://picsum.photos/id/235/200/300',
    email: 'testuser@gmail.com',
    emailVerified: true,
    phoneNumber: '+919999898989',
    phoneNumberVerified: true,
    native: Meta(
      type: NativeTypeEnum.fields,
      matchTypes: [
        NativeTypeEnum.mineral,
        NativeTypeEnum.mist,
        NativeTypeEnum.moon,
      ],
      energyScore: 33,
    ),
    customClaims: CustomClaims(
      gender: Gender.male,
      birthday: '2004-10-12',
      religion: ['Hindu'],
      community: ['Marwadi'],
      location: 'Pune',
      about: 'about me',
    ),
  ),
  User(
    uid: '6',
    displayName: 'Sarah clay',
    photoURL: 'https://picsum.photos/id/231/200/300',
    email: 'testuser@gmail.com',
    emailVerified: true,
    phoneNumber: '+919999898989',
    phoneNumberVerified: true,
    native: Meta(
      type: NativeTypeEnum.fields,
      matchTypes: [
        NativeTypeEnum.mineral,
        NativeTypeEnum.mist,
        NativeTypeEnum.moon,
      ],
      energyScore: 33,
    ),
    customClaims: CustomClaims(
      gender: Gender.male,
      birthday: '2005-10-12',
      religion: ['Hindu'],
      community: ['Marwadi'],
      location: 'Pune',
      about: 'about me',
    ),
  ),
];

final itemDetail = ItemDetailModel(fans: fansList, isAlreadyLiked: false);
final fansList = [
  FanModel(
    comment: "I love this artist.  ❤️❤️❤️❤️",
    user: User(
      uid: '1',
      displayName: 'Sarah clay',
      photoURL: 'https://picsum.photos/id/231/200/300',
      email: 'testuser@gmail.com',
      emailVerified: true,
      phoneNumber: '+919999898989',
      phoneNumberVerified: true,
      native: Meta(
        type: NativeTypeEnum.fields,
        matchTypes: [
          NativeTypeEnum.mineral,
          NativeTypeEnum.mist,
          NativeTypeEnum.moon,
        ],
        energyScore: 33,
      ),
      customClaims: CustomClaims(
        gender: Gender.male,
        birthday: '2001-10-12',
        religion: ['Hindu'],
        community: ['Marwadi'],
        location: 'Pune',
        about: 'about me',
      ),
    ),
  ),
  FanModel(
    comment: "I love this artist.  ❤️❤️❤️❤️",
    user: User(
      uid: '2',
      displayName: 'Sarah clay',
      photoURL: 'https://picsum.photos/id/232/200/300',
      email: 'testuser@gmail.com',
      emailVerified: true,
      phoneNumber: '+919999898989',
      phoneNumberVerified: true,
      native: Meta(
        type: NativeTypeEnum.fields,
        matchTypes: [
          NativeTypeEnum.mineral,
          NativeTypeEnum.mist,
          NativeTypeEnum.moon,
        ],
        energyScore: 33,
      ),
      customClaims: CustomClaims(
        gender: Gender.male,
        birthday: '2005-10-12',
        religion: ['Hindu'],
        community: ['Marwadi'],
        location: 'Pune',
        about: 'about me',
      ),
    ),
  ),
  FanModel(
    comment: "I love this artist.  ❤️❤️❤️❤️",
    user: User(
      uid: '3',
      displayName: 'Sarah clay',
      photoURL: 'https://picsum.photos/id/233/200/300',
      email: 'testuser@gmail.com',
      emailVerified: true,
      phoneNumber: '+919999898989',
      phoneNumberVerified: true,
      native: Meta(
        type: NativeTypeEnum.fields,
        matchTypes: [
          NativeTypeEnum.mineral,
          NativeTypeEnum.mist,
          NativeTypeEnum.moon,
        ],
        energyScore: 33,
      ),
      customClaims: CustomClaims(
        gender: Gender.male,
        birthday: '2002-10-12',
        religion: ['Hindu'],
        community: ['Marwadi'],
        location: 'Pune',
        about: 'about me',
      ),
    ),
  ),
  FanModel(
    comment: "I love this artist.  ❤️❤️❤️❤️",
    user: User(
      uid: '4',
      displayName: 'Sarah clay',
      photoURL: 'https://picsum.photos/id/234/200/300',
      email: 'testuser@gmail.com',
      emailVerified: true,
      phoneNumber: '+919999898989',
      phoneNumberVerified: true,
      native: Meta(
        type: NativeTypeEnum.fields,
        matchTypes: [
          NativeTypeEnum.mineral,
          NativeTypeEnum.mist,
          NativeTypeEnum.moon,
        ],
        energyScore: 33,
      ),
      customClaims: CustomClaims(
        gender: Gender.male,
        birthday: '2003-10-12',
        religion: ['Hindu'],
        community: ['Marwadi'],
        location: 'Pune',
        about: 'about me',
      ),
    ),
  ),
  FanModel(
    comment: "I love this artist.  ❤️❤️❤️❤️",
    user: User(
      uid: '5',
      displayName: 'Sarah clay',
      photoURL: 'https://picsum.photos/id/235/200/300',
      email: 'testuser@gmail.com',
      emailVerified: true,
      phoneNumber: '+919999898989',
      phoneNumberVerified: true,
      native: Meta(
        type: NativeTypeEnum.fields,
        matchTypes: [
          NativeTypeEnum.mineral,
          NativeTypeEnum.mist,
          NativeTypeEnum.moon,
        ],
        energyScore: 33,
      ),
      customClaims: CustomClaims(
        gender: Gender.male,
        birthday: '2004-10-12',
        religion: ['Hindu'],
        community: ['Marwadi'],
        location: 'Pune',
        about: 'about me',
      ),
    ),
  ),
  FanModel(
    comment: "I love this artist.  ❤️❤️❤️❤️",
    user: User(
      uid: '6',
      displayName: 'Sarah clay',
      photoURL: 'https://picsum.photos/id/231/200/300',
      email: 'testuser@gmail.com',
      emailVerified: true,
      phoneNumber: '+919999898989',
      phoneNumberVerified: true,
      native: Meta(
        type: NativeTypeEnum.fields,
        matchTypes: [
          NativeTypeEnum.mineral,
          NativeTypeEnum.mist,
          NativeTypeEnum.moon,
        ],
        energyScore: 33,
      ),
      customClaims: CustomClaims(
        gender: Gender.male,
        birthday: '2005-10-12',
        religion: ['Hindu'],
        community: ['Marwadi'],
        location: 'Pune',
        about: 'about me',
      ),
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

FavCardDataModel favCardDataModel = FavCardDataModel(items: dummyFavCardItems, hasCompletedFavCardOnBoarding: false, noOfLikedFavCards: 4);

FavCardTutorialModel tutorialModel =
    FavCardTutorialModel(title: "This is a sample tutorial and the data can change anytime as you wish", steps: [
  FavCardTutorialItemModel(
      title: "Lorem Ipsum",
      stepIconImageAddress: "https://i.scdn.co/image/ab6761610000f1784293385d324db8558179afd9",
      stepIconImageWidth: 65,
      stepIconImageHeight: 65,
      stepContentImageAddress: "https://i.scdn.co/image/ab6761610000f1784293385d324db8558179afd9",
      stepContentImageWidth: 200,
      stepContentImageHeight: 200),
  FavCardTutorialItemModel(
      title: "Lorem Ipsum",
      stepIconImageAddress: "https://i.scdn.co/image/ab6761610000f1784293385d324db8558179afd9",
      stepIconImageWidth: 15,
      stepIconImageHeight: 15,
      stepContentImageAddress: "https://i.scdn.co/image/ab6761610000f1784293385d324db8558179afd9",
      stepContentImageWidth: 400,
      stepContentImageHeight: 400),
  FavCardTutorialItemModel(
      title: "Lorem Ipsum",
      stepIconImageAddress: "https://i.scdn.co/image/ab6761610000f1784293385d324db8558179afd9",
      stepIconImageWidth: 35,
      stepIconImageHeight: 35,
      stepContentImageAddress: "https://i.scdn.co/image/ab6761610000f1784293385d324db8558179afd9",
      stepContentImageWidth: 600,
      stepContentImageHeight: 600)
]);

List<FavCardItemModel> dummyFavCardItems = [
  const FavCardItemModel(
      id: "3",
      likes: 200,
      comment: "I like this card",
      name: "Drake",
      categories: ["top", "music", "travel", "food", "love"],
      imageAddress: 'https://i.scdn'
          '.co/image/ab6761610000f1784293385d324db8558179afd9'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "OMG!!!! Such a great artist !!!! ❤️❤️❤️",
      name: "Bad Bunny",
      categories: ["travel", "music"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f1788ee9a6f54dcbd4bc95126b14'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "Very driven and enthusiastic artist!!",
      name: "Taylor Swift",
      categories: ["travel", "music"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f1785a00969a4698c3132a15fbb0'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "OMG!!!! Such a great artist !!!! ❤️❤️❤️",
      name: "The Weeknd",
      categories: ["top", "music"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f178b5f9e28219c169fd4b9e8379'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "I like this card",
      name: "Ed Sheeran",
      categories: ["travel", "music"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f1789e690225ad4445530612ccc9'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "OP, GOAT,  OG!!!  ",
      name: "Ariana Grande",
      categories: ["travel", "music"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f178cdce7620dc940db079bf4952'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "Very driven and enthusiastic artist!!",
      name: "Justin Bieber",
      categories: ["travel", "music"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f1788ae7f2aaa9817a704a87ea36'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "I love the songs 😄😅😂 ",
      name: "Eminem",
      categories: ["travel", "anime"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f178a00b11c129b27a88fc72f36b'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "OMG!!!! Such a great artist !!!! ❤️❤️❤️",
      name: "BTS",
      categories: ["travel", "music"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f1785704a64f34fe29ff73ab56bb'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "I love the songs 😄😅😂 ",
      name: "Post Malone",
      categories: ["bike", "anime"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f178b894ef9fa437b0389c5567cc'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "wow 😄😅😂 ",
      name: "Kanye West",
      categories: ["anime", "music"],
      imageAddress: 'https://i.scdn.co/image/bd1c6fdf3705cf9b7d0c8ac8e7bbed98e31a1559'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "OMG!!!! Such a great artist !!!! ❤️❤️❤️",
      name: "Drake",
      categories: ["top", "music"],
      imageAddress: 'https://i.scdn'
          '.co/image/ab6761610000f1784293385d324db8558179afd9'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "I like this card",
      name: "Bad Bunny",
      categories: ["travel", "music"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f1788ee9a6f54dcbd4bc95126b14'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "OMG!!!! Such a great artist !!!! ❤️❤️❤️",
      name: "Taylor Swift",
      categories: ["travel", "music"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f1785a00969a4698c3132a15fbb0'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "Very driven and enthusiastic artist!!",
      name: "The Weeknd",
      categories: ["top", "music"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f178b5f9e28219c169fd4b9e8379'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "wow 😄😅😂 ",
      name: "Ed Sheeran",
      categories: ["travel", "music"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f1789e690225ad4445530612ccc9'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "OP, GOAT,  OG!!!  ",
      name: "Ariana Grande",
      categories: ["travel", "music"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f178cdce7620dc940db079bf4952'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "I love the songs 😄😅😂 ",
      name: "Justin Bieber",
      categories: ["travel", "music"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f1788ae7f2aaa9817a704a87ea36'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "OMG!!!! Such a great artist !!!! ❤️❤️❤️",
      name: "Eminem",
      categories: ["travel", "anime"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f178a00b11c129b27a88fc72f36b'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "I like this card",
      name: "BTS",
      categories: ["travel", "music"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f1785704a64f34fe29ff73ab56bb'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "Very driven and enthusiastic artist!!",
      name: "Post Malone",
      categories: ["bike", "anime"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f178b894ef9fa437b0389c5567cc'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "OP, GOAT,  OG!!!  ",
      name: "Kanye West",
      categories: ["anime", "music"],
      imageAddress: 'https://i.scdn.co/image/bd1c6fdf3705cf9b7d0c8ac8e7bbed98e31a1559'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "OP, GOAT,  OG!!!  ",
      name: "Drake",
      categories: ["top", "music"],
      imageAddress: 'https://i.scdn'
          '.co/image/ab6761610000f1784293385d324db8558179afd9'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "OMG!!!! Such a great artist !!!! ❤️❤️❤️",
      name: "Bad Bunny",
      categories: ["travel", "music"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f1788ee9a6f54dcbd4bc95126b14'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "I like this card",
      name: "Taylor Swift",
      categories: ["travel", "music"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f1785a00969a4698c3132a15fbb0'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "I like this card",
      name: "The Weeknd",
      categories: ["top", "music"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f178b5f9e28219c169fd4b9e8379'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "OMG!!!! Such a great artist !!!! ❤️❤️❤️",
      name: "Ed Sheeran",
      categories: ["travel", "music"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f1789e690225ad4445530612ccc9'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "wow 😄😅😂 ",
      name: "Ariana Grande",
      categories: ["travel", "music"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f178cdce7620dc940db079bf4952'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "Very driven and enthusiastic artist!!",
      name: "Justin Bieber",
      categories: ["travel", "music"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f1788ae7f2aaa9817a704a87ea36'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "I love the songs 😄😅😂 ",
      name: "Eminem",
      categories: ["travel", "anime"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f178a00b11c129b27a88fc72f36b'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "OMG!!!! Such a great artist !!!! ❤️❤️❤️",
      name: "BTS",
      categories: ["travel", "music"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f1785704a64f34fe29ff73ab56bb'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "wow 😄😅😂 ",
      name: "Post Malone",
      categories: ["bike", "anime"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f178b894ef9fa437b0389c5567cc'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "OP, GOAT,  OG!!!  ",
      name: "Kanye West",
      categories: ["anime", "music"],
      imageAddress: 'https://i.scdn.co/image/bd1c6fdf3705cf9b7d0c8ac8e7bbed98e31a1559'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "I love the songs 😄😅😂 ",
      name: "Drake",
      categories: ["top", "music"],
      imageAddress: 'https://i.scdn'
          '.co/image/ab6761610000f1784293385d324db8558179afd9'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "I like this card",
      name: "Bad Bunny",
      categories: ["travel", "music"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f1788ee9a6f54dcbd4bc95126b14'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "OMG!!!! Such a great artist !!!! ❤️❤️❤️",
      name: "Taylor Swift",
      categories: ["travel", "music"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f1785a00969a4698c3132a15fbb0'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "Very driven and enthusiastic artist!!",
      name: "The Weeknd",
      categories: ["top", "music"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f178b5f9e28219c169fd4b9e8379'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "OP, GOAT,  OG!!!  ",
      name: "Ed Sheeran",
      categories: ["travel", "music"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f1789e690225ad4445530612ccc9'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "OP, GOAT,  OG!!!  ",
      name: "Ariana Grande",
      categories: ["travel", "music"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f178cdce7620dc940db079bf4952'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "wow 😄😅😂 ",
      name: "Justin Bieber",
      categories: ["travel", "music"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f1788ae7f2aaa9817a704a87ea36'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "OMG!!!! Such a great artist !!!! ❤️❤️❤️",
      name: "Eminem",
      categories: ["travel", "anime"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f178a00b11c129b27a88fc72f36b'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "I love the songs 😄😅😂 ",
      name: "BTS",
      categories: ["travel", "music"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f1785704a64f34fe29ff73ab56bb'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "I like this card",
      name: "Post Malone",
      categories: ["bike", "anime"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f178b894ef9fa437b0389c5567cc'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "wow 😄😅😂 ",
      name: "Kanye West",
      categories: ["anime", "music"],
      imageAddress: 'https://i.scdn.co/image/bd1c6fdf3705cf9b7d0c8ac8e7bbed98e31a1559'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "OP, GOAT,  OG!!!  ",
      name: "Drake",
      categories: ["top", "music"],
      imageAddress: 'https://i.scdn'
          '.co/image/ab6761610000f1784293385d324db8558179afd9'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "Very driven and enthusiastic artist!!",
      name: "Bad Bunny",
      categories: ["travel", "music"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f1788ee9a6f54dcbd4bc95126b14'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "OMG!!!! Such a great artist !!!! ❤️❤️❤️",
      name: "Taylor Swift",
      categories: ["travel", "music"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f1785a00969a4698c3132a15fbb0'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "OP, GOAT,  OG!!!  ",
      name: "The Weeknd",
      categories: ["top", "music"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f178b5f9e28219c169fd4b9e8379'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "wow 😄😅😂 ",
      name: "Ed Sheeran",
      categories: ["travel", "music"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f1789e690225ad4445530612ccc9'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "OP, GOAT,  OG!!!  ",
      name: "Ariana Grande",
      categories: ["travel", "music"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f178cdce7620dc940db079bf4952'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "I like this card",
      name: "Justin Bieber",
      categories: ["travel", "music"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f1788ae7f2aaa9817a704a87ea36'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "I love the songs 😄😅😂 ",
      name: "Eminem",
      categories: ["travel", "anime"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f178a00b11c129b27a88fc72f36b'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "Very driven and enthusiastic artist!!",
      name: "BTS",
      categories: ["travel", "music"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f1785704a64f34fe29ff73ab56bb'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "OMG!!!! Such a great artist !!!! ❤️❤️❤️",
      name: "Post Malone",
      categories: ["bike", "anime"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f178b894ef9fa437b0389c5567cc'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "OP, GOAT,  OG!!!  ",
      name: "Kanye West",
      categories: ["anime", "music"],
      imageAddress: 'https://i.scdn.co/image/bd1c6fdf3705cf9b7d0c8ac8e7bbed98e31a1559'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "OP, GOAT,  OG!!!  ",
      name: "Drake",
      categories: ["top", "music"],
      imageAddress: 'https://i.scdn'
          '.co/image/ab6761610000f1784293385d324db8558179afd9'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "wow 😄😅😂 ",
      name: "Bad Bunny",
      categories: ["travel", "music"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f1788ee9a6f54dcbd4bc95126b14'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "I like this card",
      name: "Taylor Swift",
      categories: ["travel", "music"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f1785a00969a4698c3132a15fbb0'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "I love the songs 😄😅😂 ",
      name: "The Weeknd",
      categories: ["top", "music"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f178b5f9e28219c169fd4b9e8379'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "OMG!!!! Such a great artist !!!! ❤️❤️❤️",
      name: "Ed Sheeran",
      categories: ["travel", "music"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f1789e690225ad4445530612ccc9'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "I love the songs 😄😅😂 ",
      name: "Ariana Grande",
      categories: ["travel", "music"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f178cdce7620dc940db079bf4952'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "Very driven and enthusiastic artist!!",
      name: "Justin Bieber",
      categories: ["travel", "music"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f1788ae7f2aaa9817a704a87ea36'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "I like this card",
      name: "Eminem",
      categories: ["travel", "anime"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f178a00b11c129b27a88fc72f36b'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "OP, GOAT,  OG!!!  ",
      name: "BTS",
      categories: ["travel", "music"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f1785704a64f34fe29ff73ab56bb'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "OMG!!!! Such a great artist !!!! ❤️❤️❤️",
      name: "Post Malone",
      categories: ["bike", "anime"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f178b894ef9fa437b0389c5567cc'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "OP, GOAT,  OG!!!  ",
      name: "Kanye West",
      categories: ["anime", "music"],
      imageAddress: 'https://i.scdn.co/image/bd1c6fdf3705cf9b7d0c8ac8e7bbed98e31a1559'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "OP, GOAT,  OG!!!  ",
      name: "Drake",
      categories: ["top", "music"],
      imageAddress: 'https://i.scdn'
          '.co/image/ab6761610000f1784293385d324db8558179afd9'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "I like this card",
      name: "Bad Bunny",
      categories: ["travel", "music"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f1788ee9a6f54dcbd4bc95126b14'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "OP, GOAT,  OG!!!  ",
      name: "Taylor Swift",
      categories: ["travel", "music"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f1785a00969a4698c3132a15fbb0'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "Very driven and enthusiastic artist!!",
      name: "The Weeknd",
      categories: ["top", "music"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f178b5f9e28219c169fd4b9e8379'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "wow 😄😅😂 ",
      name: "Ed Sheeran",
      categories: ["travel", "music"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f1789e690225ad4445530612ccc9'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "OMG!!!! Such a great artist !!!! ❤️❤️❤️",
      name: "Ariana Grande",
      categories: ["travel", "music"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f178cdce7620dc940db079bf4952'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "I love the songs 😄😅😂 ",
      name: "Justin Bieber",
      categories: ["travel", "music"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f1788ae7f2aaa9817a704a87ea36'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "I like this card",
      name: "Eminem",
      categories: ["travel", "anime"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f178a00b11c129b27a88fc72f36b'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "OP, GOAT,  OG!!!  ",
      name: "BTS",
      categories: ["travel", "music"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f1785704a64f34fe29ff73ab56bb'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "OP, GOAT,  OG!!!  ",
      name: "Post Malone",
      categories: ["bike", "anime"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f178b894ef9fa437b0389c5567cc'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "Very driven and enthusiastic artist!!",
      name: "Kanye West",
      categories: ["anime", "music"],
      imageAddress: 'https://i.scdn.co/image/bd1c6fdf3705cf9b7d0c8ac8e7bbed98e31a1559'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "OMG!!!! Such a great artist !!!! ❤️❤️❤️",
      name: "Drake",
      categories: ["top", "music"],
      imageAddress: 'https://i.scdn'
          '.co/image/ab6761610000f1784293385d324db8558179afd9'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "OP, GOAT,  OG!!!  ",
      name: "Bad Bunny",
      categories: ["travel", "music"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f1788ee9a6f54dcbd4bc95126b14'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "I like this card",
      name: "Taylor Swift",
      categories: ["travel", "music"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f1785a00969a4698c3132a15fbb0'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "OP, GOAT,  OG!!!  ",
      name: "The Weeknd",
      categories: ["top", "music"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f178b5f9e28219c169fd4b9e8379'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "wow 😄😅😂 ",
      name: "Ed Sheeran",
      categories: ["travel", "music"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f1789e690225ad4445530612ccc9'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "I love the songs 😄😅😂 ",
      name: "Ariana Grande",
      categories: ["travel", "music"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f178cdce7620dc940db079bf4952'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "OP, GOAT,  OG!!!  ",
      name: "Justin Bieber",
      categories: ["travel", "music"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f1788ae7f2aaa9817a704a87ea36'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "OMG!!!! Such a great artist !!!! ❤️❤️❤️",
      name: "Eminem",
      categories: ["travel", "anime"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f178a00b11c129b27a88fc72f36b'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "Very driven and enthusiastic artist!!",
      name: "BTS",
      categories: ["travel", "music"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f1785704a64f34fe29ff73ab56bb'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "OP, GOAT,  OG!!!  ",
      name: "Post Malone",
      categories: ["bike", "anime"],
      imageAddress: 'https://i.scdn.co/image/ab6761610000f178b894ef9fa437b0389c5567cc'),
  const FavCardItemModel(
      id: "1",
      likes: 200,
      comment: "I like this card",
      name: "Kanye West",
      categories: ["anime", "music"],
      imageAddress: 'https://i.scdn.co/image/bd1c6fdf3705cf9b7d0c8ac8e7bbed98e31a1559'),
];
