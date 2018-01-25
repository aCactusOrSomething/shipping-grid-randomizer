import 'dart:html';
import 'RelationshipType.dart';

List<String> names = new List<String>();
InputElement input;
InputElement addButton;
TableElement namesDisplay;
InputElement quadrantsButton;
InputElement frequencySlider;
DivElement frequencyDisplay;
List<ButtonElement> deleteButtons;
ButtonElement startButton;
TableElement shipsOutput;
TableElement shippingGrid;

List<Relationship> ships;
bool allowQuadrants = false;
int frequency = 80;

void main() {
  input = querySelector("#namesInput");
  addButton = querySelector("#addButton");
  namesDisplay = querySelector("#names");
  quadrantsButton = querySelector("#allowQuadrants");
  frequencySlider = querySelector("#frequencySlider");
  frequencyDisplay = querySelector("#frequencyDisplay");
  startButton = querySelector("#startButton");
  shipsOutput = querySelector("#shipsOutput");
  shippingGrid = querySelector("#shippingGrid");

  deleteButtons = new List<ButtonElement>();
  ships = new List<Relationship>();

  //String ships = 'this is where i would put things if i could make them yet.';
  addButton.onClick.listen((e) => addNewPerson());
  //input.onChange.listen((e) => addNewPerson());
  quadrantsButton.onClick.listen((e) => toggleQuadrants());
  startButton.onClick.listen((e) => startShipping());
  frequencySlider.onInput.listen((e) => updateFrequency());
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
  //todo set this back to hearts
  ships = RelationshipType.makeShips(names, RelationshipType.HEARTS, frequency);
  if(allowQuadrants) {
    ships.addAll(RelationshipType.makeShips(names, RelationshipType.SPADES, frequency));
    ships.addAll(RelationshipType.makeShips(names, RelationshipType.DIAMONDS, frequency));
    ships.addAll(RelationshipType.makeShips(names, RelationshipType.CLUBS, frequency));
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
  buildGrid();
  fillGrid();
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
      for (int j = 0; j < names.length; j++) {
        shippingGrid.rows[i + 1].insertCell(j);
      }
    }
  }
}

void fillGrid() {
  TableRowElement firstRow = shippingGrid.rows[0];
  for(int i = 0; i < ships.length; i++) {
    Relationship ship = ships[i];
    String firstName = ship.parties[0];
    for(int j = 1; j < firstRow.cells.length; j++) {
      TableCellElement cell = firstRow.cells[j];
      print("does " + firstName + " equal " + cell.text);
      if(firstName == cell.text) {
        print("yes");
        for(int k = 1; k < shippingGrid.rows.length; k++) {
          for(int l = 1; l < ship.parties.length; l++) {
            print("does " + ship.parties[l] + " equal " + shippingGrid.rows[k].text + " which should be at (" + k.toString() + ", " + 0.toString() + ")");
            if(ship.parties[l] == shippingGrid.rows[k].text.substring(0, ship.parties[l].length)) {
              print("yes");
              shippingGrid.rows[k].cells[j - 1].appendText(ship.type.value);
              shippingGrid.rows[j].cells[k - 1].appendText(ship.type.value);
            }
          }
        }
      }
    }
    print("next ship");
  }
}

void updateFrequency() {
  frequency = frequencySlider.valueAsNumber;
  frequencyDisplay.text = frequency.toString();
}