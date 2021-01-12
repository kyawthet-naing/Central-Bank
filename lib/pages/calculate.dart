import 'package:flutter/material.dart';

class Calculate extends StatefulWidget {
  final String currentRates, currenciesNickName;

  const Calculate({this.currentRates, this.currenciesNickName});

  @override
  _CalculateState createState() => _CalculateState();
}

class _CalculateState extends State<Calculate> {
  String currencies1 = '1.0';
  String currencies2 = '';
  double currentRateNumber = 0.0;
  bool checkClick = false;

  /*
   mmk   =>   true
   other =>   false
   */

  @override
  void initState() {
    currencies2 = widget.currentRates;
    List<String> splitList = currencies2.split('');
    splitList.remove(',');
    currentRateNumber = double.parse(splitList.join());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Central Bank'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 80,
            child: FlatButton(
              onPressed: () {
                setState(() {
                  currencies1 = '1.0';
                  currencies2 = widget.currentRates;
                  checkClick = false;
                });
              },
              child: Row(
                children: [
                  Text(
                    widget.currenciesNickName,
                    style: TextStyle(fontSize: 20),
                  ),
                  Expanded(
                    child: Text(
                      currencies1,
                      // maxLines: 1,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontSize: 20,
                          color: !checkClick ? Colors.blue : Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
          buildDivider(context),
          SizedBox(
            height: 80,
            child: FlatButton(
              onPressed: () {
                setState(() {
                  currencies1 = '1.0';
                  currencies2 = widget.currentRates;
                  checkClick = true;
                });
              },
              child: Row(
                children: [
                  Text(
                    'MMK',
                    style: TextStyle(fontSize: 20),
                  ),
                  Expanded(
                    child: Text(
                      currencies2,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontSize: 20,
                          color: checkClick ? Colors.blue : Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
          buildDivider(context),
          Spacer(),
          _buildKeypad(context)
        ],
      ),
    );
  }

  Container _buildKeypad(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.2),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10), topLeft: Radius.circular(10))),
      height: MediaQuery.of(context).size.height / 2,
      child: Column(
        children: [
          buildButtonRow(
              num1: '1',
              num1onPressed: () => _buildNumber(num: '1'),
              num2: '2',
              num2onPressed: () => _buildNumber(num: '2'),
              num3: '3',
              num3onPressed: () => _buildNumber(num: '3')),
          buildButtonRow(
            num1: '4',
            num1onPressed: () => _buildNumber(num: '4'),
            num2: '5',
            num2onPressed: () => _buildNumber(num: '5'),
            num3: '6',
            num3onPressed: () => _buildNumber(num: '6'),
          ),
          buildButtonRow(
            num1: '7',
            num1onPressed: () => _buildNumber(num: '7'),
            num2: '8',
            num2onPressed: () => _buildNumber(num: '8'),
            num3: '9',
            num3onPressed: () => _buildNumber(num: '9'),
          ),
          Expanded(
            child: Row(
              children: [
                buildTextButton(
                    num: '.',
                    onPressed: () {
                      if (!checkClick) {
                        setState(() {
                          List dot = currencies1.split('');
                          currencies1 = currencies1 == '1.0'
                              ? '0.'
                              : _getDot(dot, currencies1);

                          double rate =
                              double.parse(currencies1) * currentRateNumber;
                          currencies2 = rate.toStringAsFixed(2).toString();
                        });
                      } else {
                        setState(() {
                          List dot = currencies2.split('');
                          currencies2 = currencies2 == widget.currentRates
                              ? '0.'
                              : _getDot(dot, currencies2);
                          var rate =
                              double.parse(currencies2) / currentRateNumber;
                          currencies1 = rate.toStringAsFixed(2).toString();
                        });
                      }
                    }),
                buildTextButton(
                    num: '0', onPressed: () => _buildNumber(num: '0')),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(2),
                    height: double.infinity,
                    child: FlatButton(
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Icon(
                        Icons.backspace,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        if (!checkClick) {
                          List numDelC1 = currencies1.split('');
                          if (numDelC1.length > 1 && numDelC1.join() != '1.0') {
                            numDelC1.removeAt(numDelC1.length - 1);
                          } else {
                            setState(() {
                              currencies1 = '1.0';
                              currencies2 = widget.currentRates;
                            });
                            return;
                          }
                          String deletedNumber = numDelC1.join();
                          setState(() {
                            currencies1 = deletedNumber;
                            double toDouble =
                                double.parse(deletedNumber) * currentRateNumber;
                            currencies2 =
                                toDouble.toStringAsFixed(2).toString();
                          });
                        } else {
                          setState(() {
                            List numDelC2 = currencies2.split('');
                            if (numDelC2.length > 1 &&
                                numDelC2.join() != widget.currentRates) {
                              numDelC2.removeAt(numDelC2.length - 1);
                            } else {
                              setState(() {
                                currencies1 = '1.0';
                                currencies2 = widget.currentRates;
                              });
                              return;
                            }
                            String deletedNumber = numDelC2.join();
                            setState(() {
                              currencies2 = deletedNumber;
                              double toDouble = double.parse(deletedNumber) /
                                  currentRateNumber;
                              currencies1 =
                                  toDouble.toStringAsFixed(2).toString();
                            });
                          });
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Container buildDivider(BuildContext context) {
    return Container(
      height: 0.5,
      width: MediaQuery.of(context).size.width,
      color: Colors.grey.withOpacity(0.3),
    );
  }

  Expanded buildButtonRow(
      {@required String num1,
      @required num1onPressed,
      @required String num2,
      @required num2onPressed,
      @required String num3,
      @required num3onPressed}) {
    return Expanded(
      child: Row(
        children: [
          buildTextButton(num: num1, onPressed: num1onPressed),
          buildTextButton(num: num2, onPressed: num2onPressed),
          buildTextButton(num: num3, onPressed: num3onPressed),
        ],
      ),
    );
  }

  Expanded buildTextButton({@required String num, Function onPressed}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(2),
        height: double.infinity,
        child: FlatButton(
          color: Colors.blue,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Text(
            num,
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }

  void _buildNumber({@required String num}) {
    if (!checkClick) {
      setState(() {
        currencies1 = currencies1 == '1.0' ? num : currencies1 + num;
        double rate = double.parse(currencies1) * currentRateNumber;
        currencies2 = rate.toStringAsFixed(2).toString();
      });
    } else {
      setState(() {
        currencies2 =
            currencies2 == widget.currentRates ? num : currencies2 + num;
        var rate = double.parse(currencies2) / currentRateNumber;
        currencies1 = rate.toStringAsFixed(2).toString();
      });
    }
  }

  String _getDot(List list, String curr) {
    if (list.contains('.')) {
      return curr;
    }
    return curr + '.';
  }
}
