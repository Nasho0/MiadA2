import 'package:flutter/material.dart'; //main import
import 'dart:math'; // import math library to get random numbers

//main function
void main(){
  runApp(myApp());
}

//class myAssign2 that main call it
class myApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'choose Item',
      theme: ThemeData(
      primarySwatch:Colors.pink,
      primaryColor: Color.fromARGB(244, 188, 19, 188),
      primaryColorDark: Color.fromARGB(222, 61, 15, 63),
      canvasColor: Color.fromARGB(244, 244, 163, 163),
    //  fontFamily: 'Raleway',
       ),
       home: HomePage(), //go to home_page class
    );

  }
}
//create statefulwidget with state
class HomePage extends StatefulWidget{
  @override
  HomePageState createState() => HomePageState();
}

//state that extends from Home_Page
class HomePageState extends State<HomePage>{
//create list of Items
//object with hard coded list of items
  List<Item> Items =[
    Item(name:'Rose',imagePath:'flowers/rose.png'),
    Item(name:'Tulip',imagePath:'flowers/Tulip.png'),
    Item(name:'Daisy',imagePath:'flowers/Daisy.png'),
    Item(name:'Lily',imagePath:'flowers/Lily.png'),
    Item(name:'Orchid',imagePath:'flowers/Orchid.png'),
    Item(name:'SunItem',imagePath:'flowers/Sunflower.png'),
    Item(name:'Lavender',imagePath:'flowers/Lavender.png'),
    Item(name:'Sakura',imagePath:'flowers/Sakura.png'),
  ];

//constrain 
  String? selectedChoice;
  String? displayedImage;
  bool isListVisible = false;

//function for displaying choices
  void displayChoice() {
    //check inside the list
  Item ? chosenItem = findItem(selectedChoice);

 //test the selection
 //if the Item in the list then display the image 
  if (chosenItem!= null) {
    setState(() {
      displayedImage = chosenItem.imagePath;
    }
  );
  } 
  //if the Item NOT in the list then display a msg
  else
   {
    showDialog(
      context:context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Invalid Item name'),
          content: Text('Try again, the entered Item is not in the list.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
//compare the input with fowers list
  Item? findItem(String? name) {
  if (name == null) return null;
  //compare with each element inside the list
  for (var Item in Items) {
    if (Item.name.toLowerCase() == name.toLowerCase()) {
      return Item;
    }
  }
  
  return null;
}
//feelingLucky function that connected with "Im feeling Lucky" button
  void feelingLucky() {
    Random random = Random();
    int index = random.nextInt(Items.length);

    setState(() {
      displayedImage = Items[index].imagePath;
    }
    );
  }
//text constrain 
  TextEditingController _textFieldController = TextEditingController();

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }
//widget that contain all user Interface
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text('Language of Flowers'), 

      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              TextField(
                controller: _textFieldController,
                onChanged: (value) {
                  setState(() {
                    selectedChoice = value;
                  }
                  );
                },
// textbox widget to type in the choice of the item
              decoration: InputDecoration(
              labelText: 'Enter Flower name...',
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isListVisible = !isListVisible;
                  }
                  );
                },  
//If an exist Item name entered in the textbox,
// and the button "display choice" is pressed, 
//show an image of the Item    
                child: Container(
                  height: 200.0,
                  child: ListView.builder(
                    itemCount: Items.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(Items[index].name),
                        onTap: () {
                          setState(() {
                            selectedChoice = Items[index].name;
                            isListVisible = false;
                          }
                          );
                          _textFieldController.text = selectedChoice!;
                        },
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 1.0),
              ElevatedButton(
                onPressed: () {
                  displayChoice();
                },
//elevated button for"Display Choice"
                child: Text('Display Choice'),
              ),
              SizedBox(height: 8.0),
              ElevatedButton(
                onPressed: () {
                  feelingLucky();
                },
//elevated button for "Im feeling Lucky"
                child: Text("I'm feeling Lucky"),
              ),
              SizedBox(height: 8.0),
              displayedImage != null
                  ? Image.asset(
                      displayedImage!,
                      width: 300.0,
                      height: 300.0,
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}

// Item class that contain name & imagePath for each Item in the list
class Item {
  final String name;
  final String imagePath;

 Item({required this.name, required this.imagePath});
}
//Miad binti wan mahri 
//2016152
