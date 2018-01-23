import 'dart:html';
import 'RelationshipType.dart';

List<String> names = new List<String>();
InputElement input;
InputElement addButton;
TableElement namesDisplay;
InputElement quadrantsButton;
List<ButtonElement> deleteButtons;
ButtonElement startButton;
TableElement shipsOutput;
TableElement shippingGrid;

List<Relationship> ships;
bool allowQuadrants = false;

void main() {
  input = querySelector("#namesInput");
  addButton = querySelector("#addButton");
  namesDisplay = querySelector("#names");
  quadrantsButton = querySelector("#allowQuadrants");
  startButton = querySelector("#startButton");
  shipsOutput = querySelector("#shipsOutput");
  shippingGrid = querySelector("#shippingGrid");

  deleteButtons = new List<ButtonElement>();

  //String ships = 'this is where i would put things if i could make them yet.';
  addButton.onClick.listen((e) => addNewPerson());
  //input.onChange.listen((e) => addNewPerson());
  quadrantsButton.onClick.listen((e) => toggleQuadrants());
  startButton.onClick.listen((e) => startShipping());

}

void addNewPerson() {

  if(input.value != "") {
    names.add(input.value);
    input.value = "";
    namesDisplay.children = new List<Element>();
    namesDisplayUpdate();
  }
}

void deletePerson(int id) {
  names.removeAt(id);
  namesDisplayUpdate();
  buildGrid();
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
    TableCellElement nameCell = row.addCell();
    nameCell.children.add(nameDisplay);
    TableCellElement deleteCell = row.addCell();
    deleteCell.children.add(deleteButton);
    row.id = "ignore";
    nameCell.id = "ignore";
    deleteCell.id = "ignore";
    buildGrid();
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
    TableRowElement row = ship.toRow();
    row.id = "ignore";
    for(TableCellElement cell in row.cells) {
      cell.id = "ignore";
    }
    shipsOutput.children.add(row);
  }
}

void toggleQuadrants() {
  if(allowQuadrants) {
    allowQuadrants = false;
  } else {
    allowQuadrants = true;
  }
}

void buildGrid() {
  shippingGrid.children = new List<Element>();
  if(names.length > 0) {
    TableRowElement firstRow = shippingGrid.addRow();
    firstRow.addCell(); //this cell is blank, as it is in the corner.
    for (int i = 0; i < names.length; i++) {
      String name = names[i];
      firstRow
          .insertCell(i + 1)
          .text = name;
      shippingGrid
          .insertRow(i + 1)
          .text = name;
    }
  }
}