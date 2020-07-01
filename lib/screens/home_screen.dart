import 'package:flutter/material.dart';
import 'package:weights/size_config.dart';
import 'package:weights/services/networking.dart';
import 'package:weights/components/rounded_button.dart';
import 'dart:convert';
import 'dart:async';

enum SingingCharacter { daily, weekly, monthly }

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String radioValue = 'daily';

  NetworkHandler _networkHandler = NetworkHandler();

  Map<String, dynamic> properties = {};
  Map<String, dynamic> data = {};

  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getMetadata('21');
    setTimer();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  void setTimer() {
    const oneSec = const Duration(seconds: 10);

    new Timer.periodic(oneSec, (Timer t) {
      print('text value - $textController.text.isNotEmpty');

      print('timer executed...');
      getMetadata(textController.text);
    });
  }

  void getMetadata(String value) async {
    try {
      var response = await _networkHandler.getUserInfo(value);

      var responseData = jsonDecode(response);
      properties = responseData;

      setState(() {
        data = properties['data'];
      });
      print('response - $responseData');
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    Color textBoxColor = Color(0XFFaacfcf);
    Color backgroundColor = Color(0XFF00909e);

    print('$radioValue' + '_set_wt_count');
    print('$radioValue' + '_set_wt_sum');
    return Scaffold(
      appBar: AppBar(
        title: Text('Weights'),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Container(
            color: backgroundColor,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'Online Monitoring',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: SizeConfig.blockSizeHorizontal * 8,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          'Daily weight SUM',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: SizeConfig.blockSizeHorizontal * 4,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      Container(
                        height: 80,
                        width: SizeConfig.blockSizeHorizontal * 40,
                        decoration: BoxDecoration(
                            color: textBoxColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: Center(
                          child: Text(
                            data.isNotEmpty
                                ? data['daily_act_wt_sum'].toString() + '  kg'
                                : '',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: SizeConfig.blockSizeHorizontal * 4,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 10),
                              child: Text(
                                'Weekly weight SUM',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize:
                                        SizeConfig.blockSizeHorizontal * 4,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                            Container(
                              height: 80,
                              width: SizeConfig.blockSizeHorizontal * 40,
                              decoration: BoxDecoration(
                                  color: textBoxColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              child: Center(
                                child: Text(
                                  data.isNotEmpty
                                      ? data['weekly_act_wt_sum'].toString() +
                                          '  kg'
                                      : '',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize:
                                          SizeConfig.blockSizeHorizontal * 4,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 10),
                              child: Text(
                                'Monthly weight SUM',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize:
                                        SizeConfig.blockSizeHorizontal * 4,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                            Container(
                              height: 80,
                              width: SizeConfig.blockSizeHorizontal * 40,
                              decoration: BoxDecoration(
                                  color: textBoxColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              child: Center(
                                child: Text(
                                  data.isNotEmpty
                                      ? data['monthly_act_wt_sum'].toString() +
                                          '  kg'
                                      : '',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize:
                                          SizeConfig.blockSizeHorizontal * 4,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Select period',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: SizeConfig.blockSizeHorizontal * 4,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                Radio(
                                  value: 'daily',
                                  groupValue: radioValue,
                                  onChanged: (String value) {
                                    setState(() {
                                      radioValue = value;
                                    });
                                  },
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Daily'),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                Radio(
                                  value: 'weekly',
                                  groupValue: radioValue,
                                  onChanged: (String value) {
                                    setState(() {
                                      radioValue = value;
                                    });
                                  },
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Weekly'),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                Radio(
                                  value: 'monthly',
                                  groupValue: radioValue,
                                  onChanged: (String value) {
                                    setState(() {
                                      radioValue = value;
                                    });
                                  },
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Monthly'),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Column(
                        children: [
                          Container(
                            height: 60,
                            width: SizeConfig.blockSizeHorizontal * 60,
                            child: TextFormField(
                              controller: textController,
                              decoration: InputDecoration(
                                hintText: 'Select Slab',
                                alignLabelWithHint: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 10),
                              child: Text(
                                'Selected Slab entries',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize:
                                        SizeConfig.blockSizeHorizontal * 4,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                            Container(
                              height: 80,
                              width: SizeConfig.blockSizeHorizontal * 40,
                              decoration: BoxDecoration(
                                  color: textBoxColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              child: Center(
                                child: Text(
                                  data.isNotEmpty
                                      ? data['$radioValue' + '_set_wt_count']
                                          .toString()
                                      : '',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize:
                                          SizeConfig.blockSizeHorizontal * 4,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 10),
                              child: Text(
                                'Selected Slab SUM',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize:
                                        SizeConfig.blockSizeHorizontal * 4,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                            Container(
                              height: 80,
                              width: SizeConfig.blockSizeHorizontal * 40,
                              decoration: BoxDecoration(
                                  color: textBoxColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              child: Center(
                                child: Text(
                                  data.isNotEmpty
                                      ? data['$radioValue' + '_set_wt_sum']
                                          .toString()
                                      : '',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize:
                                          SizeConfig.blockSizeHorizontal * 4,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: RoundedButton(
                      title: 'submit',
                      onPressAction: () {
                        getMetadata(textController.text);
                      },
                      backgroundColor: Colors.black54,
                      textColor: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
