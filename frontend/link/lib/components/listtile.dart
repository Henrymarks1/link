import 'package:flutter/material.dart';

import 'customsearch.dart';
import 'package:uuid/uuid.dart';

// ignore: must_be_immutable
class UserTile extends StatelessWidget {
  String name;
  String userPath;
  bool online;
  bool user;

  UserTile({this.name, this.userPath, this.online, this.user});
  @override
  Widget build(BuildContext context) {
    var uuid = Uuid();

    return ListTile(
        leading: InkWell(
          onTap: () {
            return user == true
                ? showDialog<void>(
                    context: context,
                    barrierDismissible: false, // user must tap button!
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Status'),
                        content: SingleChildScrollView(
                          child: ListBody(children: <Widget>[
                            Text('Change status to offline.'),
                          ]),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Approve'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  )
                : null;
          },
          child: Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.asset(
                  userPath ?? 'image/asset/null.png',
                ),
              ),
              ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Container(
                    height: 17,
                    width: 17,
                    color:
                        online == true ? Colors.green[800] : Colors.grey[500],
                  )),
            ],
          ),
        ),
        title: Text(name),
        subtitle: Text(online == true ? "Online" : "Offline"),
        trailing: Container(
            width: MediaQuery.of(context).size.width * .3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.group_add,
                    size: 35,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: AddressSearch(uuid.v4()),
                    );
                  },
                  icon: Icon(
                    Icons.search,
                    size: 35,
                  ),
                ),
              ],
            )));
  }
}
