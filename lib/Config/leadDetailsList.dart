// ignore_for_file: prefer_final_fields, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myknott/Config/api_service.dart';

import 'leadList.dart';

class LeadList extends StatefulWidget {
  const LeadList({Key key}) : super(key: key);
  @override
  State<LeadList> createState() => _LeadListState();
}

class _LeadListState extends State<LeadList> {
  List memberData = [];
  @override
  void initState() {
    callMemberapi();
    // this is called when the class is initialized or called for the first time
    super
        .initState(); //  this is the material super constructor for init state to link your instance initState to the global initState context
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lead\'s List"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
                future: callMemberapi(),
                builder: (context, snapshot) {
                  return ListView.builder(
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: memberData.length,
                    itemBuilder: ((context, index) {
                      LeadListModel member = memberData[index];
                      return Container(
                          decoration: BoxDecoration(border: Border.all()),
                          height: MediaQuery.of(context).size.height * 0.14,
                          padding: const EdgeInsets.all(15),
                          margin: const EdgeInsets.all(15),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    buildRowTwoWidget(
                                      " Name :" + member.name.toString(),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    buildRowTwoWidget(
                                      "Email : " + member.email.toString(),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    buildRowTwoWidget(
                                      "Number : " +
                                          member.phoneNumber.toString(),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ));
                    }),
                  );
                }),
          ],
        ),
      ),
    );
  }

  buildRowTwoWidget(
    String left,
  ) {
    return Row(
      children: [
        Expanded(child: Text(left, maxLines: 1)),
      ],
    );
  }

  callMemberapi() async {
    var data = {"notaryId": "62421089c913294914a8a35f"};

    print(data);
    var url = "https://notaryapi1.herokuapp.com/lead/getLeads";
    var response = await postApiCall.postrequest(data, url);
    var body = jsonDecode(response.toString());

    memberData = (body["leads"]).map((i) => LeadListModel.fromJson(i)).toList();

    print(body);
  }
}
