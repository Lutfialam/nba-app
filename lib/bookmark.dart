import 'package:flutter/material.dart';
import 'package:nba/model/team.dart';
import 'package:nba/teamDetail.dart';
import 'package:nba/utils/shared_pref.dart';

class BookMark extends StatefulWidget {
  BookMark({Key? key}) : super(key: key);

  @override
  State<BookMark> createState() => _BookMarkState();
}

class _BookMarkState extends State<BookMark> {
  String search = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder<List<String>>(
              future: SharedPref().getBookMarkList(),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!.length > 0) {
                  return Container(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            contentPadding:
                                EdgeInsets.only(left: 15, right: 15),
                            hintText: 'Search bookmark',
                            fillColor: Color(0xffE8E6E6),
                            filled: true,
                            suffixIcon: Icon(
                              Icons.search,
                              color: Color(0xff726767),
                            ),
                          ),
                          style: TextStyle(
                            color: Color(0xff726767),
                            fontSize: 20,
                          ),
                          onChanged: (value) => setState(() => search = value),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 15),
                          child: Column(
                            children: snapshot.data!.map((teamId) {
                              return FutureBuilder<TeamModel>(
                                future:
                                    TeamModel.getTeamById(int.parse(teamId)),
                                builder: (context, snapshot) {
                                  TeamModel team =
                                      snapshot.data ?? new TeamModel();
                                  if (search == '' ||
                                      team.name
                                          .toLowerCase()
                                          .contains(search.toLowerCase())) {
                                    return InkWell(
                                      onTap: () async {
                                        var nav =
                                            await Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                TeamDetail(team: team),
                                          ),
                                        );

                                        if (nav == null || nav == true) {
                                          setState(() {});
                                        }
                                      },
                                      child: Container(
                                        margin:
                                            EdgeInsets.only(top: 5, bottom: 5),
                                        padding: EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(20),
                                          ),
                                          color: Color(0xff6C63FF),
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              margin:
                                                  EdgeInsets.only(right: 20),
                                              child: CircleAvatar(
                                                radius: 35,
                                                backgroundImage: team.logo,
                                              ),
                                            ),
                                            Container(
                                              width: size.width * 0.6,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    team.name,
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        fontSize: 30,
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    team.abbreviation,
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  } else {
                                    return Container();
                                  }
                                },
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (snapshot.hasData && snapshot.data!.length <= 0) {
                  return Container(
                    height: size.height * 0.90,
                    width: size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          width: 308,
                          height: 316,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/bookmark_not_found.png'),
                            ),
                          ),
                        ),
                        Container(
                          width: 299,
                          child: Text(
                            'looks like you never tagged some teams before. try to bookmark some team and you will see the team you bookmarked here',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xff726767),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),
      ),
    );
  }
}
