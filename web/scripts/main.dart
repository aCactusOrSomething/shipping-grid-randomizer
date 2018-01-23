import 'dart:html';
import 'RelationshipType.dart';

List<String> names = new List<String>();
InputElement input;
ButtonElement addButton;
TableElement namesDisplay;
DivElement quadrantsDisplay;
ButtonElement quadrantsButton;
List<ButtonElement> deleteButtons;
ButtonElement startButton;
DivElement shipsOutput;

List<Relationship> ships;
bool allowQuadrants = false;

void main() {
  input = querySelector("#namesInput");
  addButton = querySelector("#addButton");
  namesDisplay = querySelector("#names");
  quadrantsDisplay = querySelector("#quadrantText");
  quadrantsButton = querySelector("#allowQuadrants");
  startButton = querySelector("#startButton");
  shipsOutput = querySelector("#shipsOutput");
  deleteButtons = new List<ButtonElement>();

  String ships = 'this is where i would put things if i could make them yet.';
  addButton.onClick.listen((e) => addNewPerson());
  input.onChange.listen((e) => addNewPerson());
  quadrantsButton.onClick.listen((e) => toggleQuadrants());
  startButton.onClick.listen((e) => startShipping());

}

void addNewPerson() {
  names.add(input.value);
  input.value = "";
  namesDisplay.children = new List<Element>();
  namesDisplayUpdate();
}

void deletePerson(int id) {
  names.removeAt(id);
  namesDisplayUpdate();
}

void namesDisplayUpdate() {
  namesDisplay.children = new List<Element>();
  deleteButtons = new List<ButtonElement>();
  for (String name in names) {
    var nameDisplay = new DivElement();

    //"delete" buttons for each name
    ButtonElement deleteButton = new ButtonElement();
    deleteButton.text = "delete";
    deleteButtons.add(deleteButton);
    
    //why aren't you working, why the fuck aren't you working.
    nameDisplay.text = name;
    
    TableRowElement row = namesDisplay.addRow();
    row.addCell().children.add(nameDisplay);
    row.addCell().children.add(deleteButton);
  }
  for(int i = 0; i < deleteButtons.length; i++) {
    deleteButtons[i].onClick.listen((e) => deletePerson(i));
  }
}

void startShipping() {
  ships = RelationshipType.makeShips(names, RelationshipType.HEARTS);
  if(allowQuadrants) {
    ships.addAll(RelationshipType.makeShips(names, RelationshipType.SPADES));
    ships.addAll(RelationshipType.makeShips(names, RelationshipType.DIAMONDS));
    ships.addAll(RelationshipType.makeShips(names, RelationshipType.CLUBS));
  }
  shipsOutput.children = new List<Element>();
  for(Relationship ship in ships) {
    ParagraphElement display = new ParagraphElement();
    display.text = ship.toString();
    shipsOutput.children.add(display);
  }
}

void toggleQuadrants() {
  if(allowQuadrants) {
    allowQuadrants = false;
    quadrantsDisplay.text = "Quadrants are not allowed.";
  } else {
    allowQuadrants = true;
    quadrantsDisplay.text = "Quadrants are allowed.";
  }
}