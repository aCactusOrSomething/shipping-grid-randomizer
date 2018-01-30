import 'dart:html';
import 'RelationshipType.dart';

List<String> names = new List<String>();

InputElement addButton;
TableElement namesDisplay;
InputElement quadrantsButton;
InputElement charmsButton;
InputElement heartButton;
InputElement frequencySlider;
DivElement frequencyDisplay;
List<ButtonElement> deleteButtons;
List<InputElement> nameInputs;
ButtonElement startButton;
TableElement shipsOutput;
TableElement shippingGrid;

List<Relationship> ships;
bool allowQuadrants = false;
bool allowCharms = false;
bool allowHeart = true;
int frequency = 10;

void main() {

  addButton = querySelector("#addButton");
  namesDisplay = querySelector("#names");
  heartButton = querySelector("#allowHeart");
  quadrantsButton = querySelector("#allowQuadrants");
  charmsButton = querySelector("#allowCharms");
  frequencySlider = querySelector("#frequencySlider");
  frequencyDisplay = querySelector("#frequencyDisplay");
  startButton = querySelector("#startButton");
  shipsOutput = querySelector("#shipsOutput");
  shippingGrid = querySelector("#shippingGrid");

  deleteButtons = new List<ButtonElement>();
  nameInputs = new List<InputElement>();
  ships = new List<Relationship>();

  addButton.onClick.listen((e) => addNewPerson());

  heartButton.onClick.listen((e) => toggleHeart());
  quadrantsButton.onClick.listen((e) => toggleQuadrants());
  charmsButton.onClick.listen((e) => toggleCharms());

  startButton.onClick.listen((e) => startShipping());
  frequencySlider.onInput.listen((e) => updateFrequency());

}

void addNewPerson() {
  names.add("");
  namesDisplay.children = new List<Element>();
  namesDisplayUpdate();
}

void deletePerson(int id) {
  names.removeAt(id);
  namesDisplayUpdate();
  buildGrid();
}

void updateName(int nameID) {
  names[nameID] = nameInputs[nameID].value;
  buildGrid();
}

void namesDisplayUpdate() {
  namesDisplay.children = new List<Element>();
  deleteButtons = new List<ButtonElement>();
  nameInputs = new List<InputElement>();
  for (String name in names) {
    var nameDisplay = new InputElement();

    //"delete" buttons for each name
    ButtonElement deleteButton = new ButtonElement();
    deleteButton.text = "delete";
    deleteButtons.add(deleteButton);

    nameDisplay.value = name;
    nameInputs.add(nameDisplay);

    
    TableRowElement row = namesDisplay.addRow();
    TableCellElement nameCell = row.addCell();
    nameCell.children.add(nameDisplay);
    TableCellElement deleteCell = row.addCell();
    deleteCell.children.add(deleteButton);
    row.id = "noBorders";
    nameCell.id = "noBorders";
    deleteCell.id = "noBorders";
    buildGrid();
  }

  for(int i = 0; i < deleteButtons.length; i++) {
    deleteButtons[i].onClick.listen((e) => deletePerson(i));
    nameInputs[i].onInput.listen((e) => updateName(i));
  }
}

void startShipping() {
  //this first part is to ensure that there are no duplicate names. those screw shit up, severely.
  bool duplicate = false;
  bool blankName = false;
  for(int i = 0; i < names.length; i++) {
    for(int j = 0; j < names.length; j++) {
      if (names[i] == names[j] && i != j) {
        duplicate = true;
        break;
      }
    }
    if(names[i] == "") {
      blankName = true;
      i = names.length;
      break;
    }
  }

  if(!duplicate && !blankName && names.length != 0) {
    ships = new List<Relationship>();
    if (allowHeart) {
      ships.addAll(
          RelationshipType.makeShips(
              names, RelationshipType.HEARTS, frequency));
    }
    if (allowQuadrants) {
      ships.addAll(RelationshipType.makeShips(
          names, RelationshipType.SPADES, frequency));
      ships.addAll(RelationshipType.makeShips(
          names, RelationshipType.DIAMONDS, frequency));
      ships.addAll(
          RelationshipType.makeShips(names, RelationshipType.CLUBS, frequency));
    }
    if (allowCharms) {
      ships.addAll(RelationshipType.makeShips(
          names, RelationshipType.CHARM_BALLOONS, frequency));
      ships.addAll(RelationshipType.makeShips(
          names, RelationshipType.CHARM_CLOVERS, frequency));
      ships.addAll(RelationshipType.makeShips(
          names, RelationshipType.CHARM_DIAMONDS, frequency));
      ships.addAll(RelationshipType.makeShips(
          names, RelationshipType.CHARM_HEARTS, frequency));
      ships.addAll(RelationshipType.makeShips(
          names, RelationshipType.CHARM_HORSESHOES, frequency));
      ships.addAll(RelationshipType.makeShips(
          names, RelationshipType.CHARM_MOONS, frequency));
      ships.addAll(RelationshipType.makeShips(
          names, RelationshipType.CHARM_POT_O_GOLD, frequency));
      ships.addAll(RelationshipType.makeShips(
          names, RelationshipType.CHARM_RAINBOWS, frequency));
      ships.addAll(RelationshipType.makeShips(
          names, RelationshipType.CHARM_STARS, frequency));
    }
    shipsOutput.children = new List<Element>();
    for (Relationship ship in ships) {
      TableRowElement row = ship.toRow();
      row.id = "noBorders";
      for (TableCellElement cell in row.cells) {
        cell.id = "noBorders";
      }
      shipsOutput.children.add(row);
    }
    buildGrid();
    fillGrid();
  } else if(names.length == 0) {
    window.alert("Cannot make ships: you have not listed any names.");
  } else if(duplicate) {
    window.alert("Cannot make ships: you have duplicate names in your list.");
  } else if(blankName) {
    window.alert("Cannot make ships: you have empty names in your list.");
  }
}

void toggleHeart() {
  if(allowHeart) {
    allowHeart = false;
  } else {
    allowHeart = true;
  }
}

void toggleQuadrants() {
  if(allowQuadrants) {
    allowQuadrants = false;
  } else {
    allowQuadrants = true;
  }
}

void toggleCharms() {
  if(allowCharms) {
    allowCharms = false;
  } else {
    allowCharms = true;
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

        shippingGrid.rows[i + 1].insertCell(j).text = " ";
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
      print("does " + firstName + " equal " + names[j - 1]);
      if(firstName == names[j - 1]) {
        print("yes");
        for(int k = 1; k < shippingGrid.rows.length; k++) {
          for(int l = 1; l < ship.parties.length; l++) {
            print("does " + ship.parties[l] + " equal " + names[k - 1] + " which should be at (" + k.toString() + ", " + 0.toString() + ")");
            if(ship.parties[l] == names[k - 1]) {
              print("yes");
              shippingGrid.rows[k].cells[j - 1].appendText(ship.type.value);
              //fuck, this means it prints it double for selfcest ships. gotta fix that.
              if(names[j - 1] != names[k - 1]) {
                shippingGrid.rows[j].cells[k - 1].appendText(ship.type.value);
              }
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
