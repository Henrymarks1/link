import 'package:flutter/material.dart';

import 'getfriends.dart';

class FriendSearch extends SearchDelegate {
  FriendSearch() {
    user = new Friend();
  }

  Friend user;
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Clear',
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
        future: query == "" ? null : user.fetchSuggestions(query),
        builder: (context, snapshot) => query == ''
            ? Container(
                padding: EdgeInsets.all(16.0),
                child: Text('Search a friend'),
              )
            : snapshot.hasData
                ? ListView.builder(
                    itemBuilder: (context, index) => ListTile(
                      title: Text((snapshot.data[index]).name),
                      onTap: () {
                        // String data = (snapshot.data[index]).description;
                        close(context, snapshot.data[index]);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => CreateHang(
                        //             address: data,
                        //           )),
                        // );
                      },
                    ),
                    itemCount: snapshot.data.length,
                  )
                : Container(child: Text('Loading...')));
  }
}
