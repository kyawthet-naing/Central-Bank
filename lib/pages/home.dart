import 'package:central_bank/pages/calculate.dart';
import 'package:central_bank/utils/api.dart';
import 'package:central_bank/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Central Bank'),
      ),
      body: DateFormat('EEEE').format(date) == 'Sunday' ||
              DateFormat('EEEE').format(date) == 'Saturday'
          ? Center(
              child: Text(
                  'Today is Weekend (${DateFormat('EEEE').format(date)}) .'))
          : FutureBuilder(
              future: API.getData(),
              builder: (context, snapshot) => snapshot.hasData
                  ? RefreshIndicator(
                      onRefresh: () async {
                        await API.getData();
                        setState(() {});
                        return Future.value(false);
                      },
                      child: Column(
                        children: [
                          SizedBox(
                            height: 40,
                            child: ListTile(
                              tileColor: Colors.blue.withOpacity(0.1),
                              title: Text('CURRENCY',style: TextStyle(fontSize: 18),),
                              trailing: Text('RATES',style: TextStyle(fontSize: 18),),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: Global.currenciesNickName.length,
                              itemBuilder: (context, index) => Column(
                                children: [
                                  ListTile(
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Calculate(
                                                  currenciesNickName:
                                                      Global.currenciesNickName[
                                                          index],
                                                  currentRates: Global
                                                          .dataList[index][
                                                      Global.currenciesNickName[
                                                          index]],
                                                ))),
                                    title: RichText(
                                      text: TextSpan(
                                          text:
                                              Global.currenciesNickName[index] +
                                                  '\n',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black),
                                          children: [
                                            TextSpan(
                                                text: Global
                                                    .currenciesName[index],
                                                style: buildTextStyle())
                                          ]),
                                    ),

                                    trailing: RichText(
                                      text: TextSpan(
                                          text: Global.dataList[index][Global
                                                  .currenciesNickName[index]] +
                                              ' ',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14),
                                          children: [
                                            TextSpan(
                                                text: '   MMK',
                                                style: buildTextStyle())
                                          ]),
                                    ),
                                    // trailing: Text(Global.dataList[index]
                                    //     [Global.currenciesNickName[index]]),
                                  ),
                                  Container(
                                    height: 0.5,
                                    width: MediaQuery.of(context).size.width,
                                    color: Colors.grey.withOpacity(0.3),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Center(child: CircularProgressIndicator()),
            ),
    );
  }

  TextStyle buildTextStyle() {
    return TextStyle(color: Colors.grey.shade600, fontSize: 11);
  }
}
