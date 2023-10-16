import 'package:native/model/chat_room.dart';
import 'package:native/model/native.dart';
import 'package:native/repo/model/message.dart';

final List<Native> usersList = [
  // NativeCard(
  //   birthday: Birthday(year: '2001', month: 'jan', day: '10'),
  //   meta: Meta(

  //   )
  // )
  Native(
    user: "Sarah Clay",
    age: '31 yrs',
    imageUrl: 'assets/home/ic_test.png',
    type: NativeType.fields(),
    energy: 33,
    goodFits: [
      NativeType.moon(),
      NativeType.mist(),
      NativeType.mineral(),
    ],
  ),
  Native(
    user: "Angelina",
    age: '31 yrs',
    imageUrl: 'assets/home/angelina.png',
    type: NativeType.fields(),
    energy: 33,
    goodFits: [
      NativeType.moon(),
      NativeType.mist(),
      NativeType.mineral(),
    ],
  ),
  Native(
    user: "Smith",
    age: '31 yrs',
    imageUrl: 'assets/home/ic_profile_pic2.png',
    type: NativeType.fields(),
    energy: 33,
    goodFits: [
      NativeType.moon(),
      NativeType.mist(),
      NativeType.mineral(),
    ],
  ),
  Native(
    user: "Christie",
    age: '31 yrs',
    imageUrl: 'assets/home/ic_profile_pic3.png',
    type: NativeType.fields(),
    energy: 33,
    goodFits: [
      NativeType.moon(),
      NativeType.mist(),
      NativeType.mineral(),
    ],
  ),
  Native(
    user: "Will",
    age: '31 yrs',
    imageUrl: 'assets/home/ic_profile_pic4.png',
    type: NativeType.fields(),
    energy: 33,
    goodFits: [
      NativeType.moon(),
      NativeType.mist(),
      NativeType.mineral(),
    ],
  ),
  Native(
    user: "Nick",
    imageUrl: 'assets/home/ic_test.png',
    age: '31 yrs',
    type: NativeType.fields(),
    energy: 33,
    goodFits: [
      NativeType.moon(),
      NativeType.mist(),
      NativeType.mineral(),
    ],
  ),
];

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
  Message(senderId: '5v4PoKCawiazfNwBWoUNWi2WFDo2', creationDate: DateTime(2023, 10, 15, 11), text: 'Hello'),
  Message(senderId: '5v4PoKCawiazfNwBWoUNWi2WFDo2', creationDate: DateTime(2023, 10, 15, 12), text: 'Hi'),
  Message(senderId: 'CAFGy5wD0gOG2NXSp5goSVMOVQe2', creationDate: DateTime(2023, 10, 15, 13, 30), text: 'Hell'),
  Message(senderId: 'CAFGy5wD0gOG2NXSp5goSVMOVQe2', creationDate: DateTime(2023, 10, 15, 16, 50, 20), text: '💬'),
  Message(senderId: 'CAFGy5wD0gOG2NXSp5goSVMOVQe2', creationDate: DateTime(2023, 10, 15, 14, 10), text: 'Dinner'),
  Message(senderId: 'CAFGy5wD0gOG2NXSp5goSVMOVQe2', creationDate: DateTime(2023, 10, 15, 15, 50, 20), text: 'tonight?'),
];
