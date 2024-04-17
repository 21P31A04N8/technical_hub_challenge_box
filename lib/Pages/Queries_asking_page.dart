import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:technical_hub_challenge_box/Complaint/Complaint_Services.dart';
import 'package:lottie/lottie.dart';

class comment extends StatefulWidget {
  const comment({super.key});

  @override
  State<comment> createState() => _commentState();
}

class _commentState extends State<comment> with SingleTickerProviderStateMixin {
  bool isload = false;
  bool islottie = true;
  bool isAccepted = false;
  AnimationController? arr;
  TextEditingController _messageController = TextEditingController();
  final chatservicres _chatService = chatservicres();
  String _selectedItem = 'Choose one';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    arr = AnimationController(vsync: this, duration: Duration(seconds: 3));
  }

  void sendMessage() async {
    if (_messageController.text.isNotEmpty && _selectedItem != "Choose one") {
      await _chatService.sendMessege(
          _messageController.text, _selectedItem.trim().toLowerCase());
      _messageController.clear();
      _selectedItem = 'Choose one';
    } else {
      print(
          "=====================Error Choose any type=================================");
    }
  }

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
                      itemHeight: 60,

                      // icon: Icon(Icons.arrow_downward),
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
                  GestureDetector(
                    onTap: (_messageController.text.isNotEmpty &&
                            _selectedItem != "Choose one")
                        ? () {
                            //isAccepted = false;
                            isload = true;
                            islottie = false;
                            setState(() {
                              sendMessage();
                              arr!
                                  .forward()
                                  .then((value) => Navigator.pop(context));
                            });

                            // if (sendMessage()) {
                            //   Navigator.pop(context);
                            // }
                          }
                        : null,
                    child: Container(
                      width: 120, // Adjust width according to your needs
                      height: 50, // Adjust height according to your needs
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            25), // Rounded corners for the button
                        color: Colors.green, // Button color
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Visibility(
                              visible: isload,
                              child: Lottie.asset(
                                controller: arr,
                                'lib/Assets/Animation1.json',
                                // Path to your Lottie animation file
                                width: 50, // Adjust width of the animation
                                height: 50, // Adjust height of the animation
                                fit: BoxFit.cover,
                                repeat: islottie ? true : false,
                              ),
                            ),
                            //  Adjust spacing between the animation and text
                            Visibility(
                              visible: !isload,
                              child: Text(
                                'Submit',
                                style: TextStyle(
                                  color: Colors.white, // Text color
                                  fontSize: 16, // Text size
                                  fontWeight: FontWeight.bold, // Text weight
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
