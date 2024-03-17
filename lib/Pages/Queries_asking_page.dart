import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:technical_hub_challenge_box/Complaint/Complaint_Services.dart';

class comment extends StatefulWidget {
  const comment({super.key});

  @override
  State<comment> createState() => _commentState();
}

class _commentState extends State<comment> {
  TextEditingController _messageController = TextEditingController();
  final chatservicres _chatService = chatservicres();
  String _selectedItem = 'Choose one';

  void sendMessage() async {
    if (_messageController.text.isNotEmpty && _selectedItem != "Choose one") {
      await _chatService.sendMessege(
          _messageController.text, _selectedItem.trim().toLowerCase());
      _messageController.clear();
    } else {
      print(
          "=====================Error Choose any type=================================");
    }
  }

  @override
  Widget build(BuildContext context) {
    var hi = MediaQuery.of(context).size.height;
    var wi = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                Color.fromRGBO(11, 72, 73, 1),
                Color.fromRGBO(6, 37, 37, 1)
              ])),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  SizedBox(
                    height: hi / 3.2,
                  ),
                  Container(
                    width: wi / 1.1,
                    height: hi / 18,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.green)),
                    child: DropdownButton<String>(
                      alignment: Alignment.center,
                      borderRadius: BorderRadius.circular(20),
                      dropdownColor: Color.fromRGBO(11, 72, 73, 1),
                      iconEnabledColor: Colors.white,
                      underline: Container(
                        height: 0.003,
                        color: Colors.green,
                      ),
                      padding: EdgeInsets.only(left: 15, right: 10),
                      style: TextStyle(color: Colors.white),
                      value: _selectedItem,
                      onChanged: (value) {
                        setState(() {
                          _selectedItem = value!;
                        });
                      },
                      items: <String>[
                        'Choose one',
                        'Management',
                        'Infrastructure',
                        'Operation',
                        'Coding'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                            value: value,
                            child: SizedBox(
                              width: wi / 1.3,
                              height: 40,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                      color: Color.fromRGBO(136, 213, 155, 1)),
                                ),
                              ),
                            ));
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    height: hi / 25,
                  ),
                  Container(
                      height: hi / 4,
                      width: wi / 1.1,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.green)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: TextFormField(
                          controller: _messageController,
                          maxLines: null,
                          textAlign: TextAlign.start,
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.only(left: 20, top: 20, right: 8),
                              hintText: "Type Here....",
                              hintStyle: TextStyle(
                                color: Colors.white,
                              ),
                              border: InputBorder.none),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )),
                  SizedBox(
                    height: hi / 15,
                  ),
                  ElevatedButton(
                      onPressed: sendMessage,
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green)),
                      child: Text('Sumbit'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
