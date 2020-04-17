import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:gmaildeleteundo/fab_button.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.white.withOpacity(0.9)));
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: GmailHomePage(),
  ));
}

class GmailHomePage extends StatefulWidget {
  @override
  _GmailHomePageState createState() => _GmailHomePageState();
}

class _GmailHomePageState extends State<GmailHomePage> {
  final items = List<String>.generate(20, (i) => "Instagram ${i + 1}");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.white,
        child: CustomPaint(
          child: Container(
            height: double.infinity,
            width: double.infinity,
          ),
          foregroundPainter: FloatingPainter(),
        ),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            brightness: Brightness.light,
            backgroundColor: Colors.transparent,
            elevation: 0,
            floating: true,
            title: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[300],
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: Offset(0, 0),
                    )
                  ]),
              child: Row(
                children: <Widget>[
                  Material(
                    type: MaterialType.transparency,
                    child: IconButton(
                      splashColor: Colors.grey,
                      icon: Icon(
                        Icons.menu,
                        color: Colors.grey[800],
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.go,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 15),
                        hintText: 'Search mail',
                        hintStyle: TextStyle(
                          fontSize: 17.5,
                          color: Colors.grey[700],
                          fontFamily: "Roboto",
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                        padding:
                        EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        child: CircleAvatar(
                          maxRadius: 16,
                          backgroundImage: AssetImage("images/me.jpg"),
                        )),
                  )
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final item = items[index];
              return Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Dismissible(
                    background: stackBehindDismiss(),
                    key: Key(item),
                    onDismissed: (direction) {
                      var item = items.elementAt(index);
                      setState(() {
                        items.removeAt(index);
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text("1 mail deleted"),
                          action: SnackBarAction(
                            label: 'UNDO',
                            textColor: Colors.white,
                            onPressed: () {
                              setState(() {
                                items.insert(index, item);
                              });
                            },
                          ),
                        ));
                      });
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(
                          "I",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        backgroundColor: Colors.green.withOpacity(0.8),
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "${items[index]}",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Roboto",
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: Text(
                              "15 Apr",
                              style:
                              TextStyle(fontSize: 13, fontFamily: "Roboto"),
                            ),
                          )
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Hello everyone, this is Sandip Pramanik...",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey[800],
                                fontWeight: FontWeight.w600),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Follow me for some more awesome UI",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.w600,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Icon(
                                Icons.star_border,
                                size: 20,
                                color: Colors.grey[700],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }, childCount: items.length),
          )
        ],
      ),
    );
  }

  Widget stackBehindDismiss() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20),
      color: Colors.red[600],
      child: Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
  }
}
