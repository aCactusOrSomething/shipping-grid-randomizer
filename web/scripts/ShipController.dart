import 'dart:html';
import 'RelationshipType.dart';

List<String> names = new List<String>();

InputElement addButton;
TableElement namesDisplay;
InputElement quadrantsButton;
InputElement charmsButton;
InputElement heartButton;
InputElement frequencySlider;
InputElement advancedOptions;
DivElement frequencyDisplay;
List<ButtonElement> deleteButtons;
List<InputElement> nameInputs;
UListElement advancedOptionsList;
ButtonElement startButton;
TableElement shipsOutput;
TableElement shippingGrid;


List<Relationship> ships;
bool allowQuadrants = false;
bool allowCharms = false;
bool allowHeart = true;
bool allowDynamotions = false;
bool allowVacillation = true;
bool advancedOptionsOn = false;
int frequency = 10;

void main() {

  addButton = querySelector("#addButton");
  namesDisplay = querySelector("#names");
  heartButton = querySelector("#allowHeart");
  quadrantsButton = querySelector("#allowQuadrants");
  charmsButton = querySelector("#allowCharms");
  //frequencySlider = querySelector("#frequencySlider");
  //frequencyDisplay = querySelector("#frequencyDisplay");
  startButton = querySelector("#startButton");
  shipsOutput = querySelector("#shipsOutput");
  shippingGrid = querySelector("#shippingGrid");
  advancedOptions = querySelector("#advancedOptions");
  advancedOptionsList = querySelector("#advancedOptionsList");

  deleteButtons = new List<ButtonElement>();
  nameInputs = new List<InputElement>();
  ships = new List<Relationship>();

  addButton.onClick.listen((e) => addNewPerson());

  heartButton.onClick.listen((e) => toggleHeart());
  quadrantsButton.onClick.listen((e) => toggleQuadrants());
  charmsButton.onClick.listen((e) => toggleCharms());

  startButton.onClick.listen((e) => startShipping());
  //frequencySlider.onInput.listen((e) => updateFrequency());

  advancedOptions.onClick.listen((e) => toggleAdvancedOptions());

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
    for(RelationshipType type in getAllowedRelationshipTypes()) {
      ships.addAll(RelationshipType.makeShips(names, type, frequency));
    }

    //vacillation is singled out this way, because otherwise i would have a recursive nightmare.
    if(allowVacillation) {
      ships.addAll(RelationshipType.makeVacillations(
          names, ships, getAllowedRelationshipTypes(), frequency));
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

void toggleDynamotions() {
  if(allowDynamotions == true) {
    allowDynamotions = false;
  } else {
    allowDynamotions = true;
  }
}

void toggleVacillation() {
  if(allowVacillation == true) {
    allowVacillation = false;
  } else {
    allowVacillation = true;
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

      if(firstName == names[j - 1]) {

        for(int k = 1; k < shippingGrid.rows.length; k++) {
          for(int l = 1; l < ship.parties.length; l++) {
            if(ship.parties[l] == names[k - 1]) {
              //shippingGrid.rows[k].cells[j - 1].appendText(ship.type.value);
              shippingGrid.rows[k].cells[j - 1].children.addAll(ship.type.getImage());
              //fuck, this means it prints it double for selfcest ships. gotta fix that.
              if(names[j - 1] != names[k - 1]) {
                //shippingGrid.rows[j].cells[k - 1].appendText(ship.type.value);
                shippingGrid.rows[j].cells[k - 1].children.addAll(ship.type.getImage());
              }
            }
          }
        }
      }
    }
  }
}

void updateFrequency() {
  frequency = frequencySlider.valueAsNumber;
  frequencyDisplay.text = frequency.toString();
}

void toggleAdvancedOptions() {
  //looks like im going to have to build these buttons from scratch.
  if(advancedOptionsOn == false) {
    advancedOptionsList.children = new List<Element>();
    advancedOptionsOn = true;
    advancedOptionsList.children.add(getDynamoCheckbox());
    advancedOptionsList.children.add(getVacillationCheckbox());
    advancedOptionsList.children.add(getFrequencySlider());

  } else {
    advancedOptionsList.children = new List<Element>();
    advancedOptionsOn = false;
  }
}

LIElement getDynamoCheckbox() {
  InputElement dynamoCheckbox = new InputElement();
  LIElement item = new LIElement();
  dynamoCheckbox.type = "checkbox";
  dynamoCheckbox.checked = allowDynamotions;
  item.children.add(dynamoCheckbox);
  item.appendText("Shitsphere"); //apparently they are called this. i want it to at least DISPLAY shitsphere so im consistent with how its displayed on the main page.
  dynamoCheckbox.onClick.listen((e) => toggleDynamotions());
  return item;
}

LIElement getFrequencySlider() {
  DivElement top = new DivElement();
  top.text = "ship frequency:";
  InputElement slider = new InputElement();
  slider.type = "range";
  slider.min = "0";
  slider.max = "100";
  slider.value = frequency.toString();
  DivElement display = new DivElement();
  display.text = frequency.toString();

  slider.onInput.listen((e) => updateFrequency());
  frequencySlider = slider;
  frequencyDisplay = display;

  LIElement ret = new LIElement();
  ret.append(top);
  ret.append(slider);
  ret.append(display);
  return ret;
}

LIElement getVacillationCheckbox() {
  InputElement vacillationCheckbox = new InputElement();
  LIElement item = new LIElement();
  vacillationCheckbox.type = "checkbox";
  vacillationCheckbox.checked = allowVacillation;
  item.children.add(vacillationCheckbox);
  item.appendText("Vacillation");
  vacillationCheckbox.onClick.listen((e) => toggleVacillation());
  return item;
}

List<RelationshipType> getAllowedRelationshipTypes() {
  List<RelationshipType> ret = new List<RelationshipType>();
  if(allowHeart) {
    ret.add(RelationshipType.HEARTS);
  }
  if(allowQuadrants) {
    ret.addAll(RelationshipType.EXTRA_QUADRANTS);
  }
  if(allowCharms) {
    ret.addAll(RelationshipType.CHARMS);
  }
  if(allowDynamotions) {
    ret.addAll(RelationshipType.DYNAMOTIONS);
  }
  return ret;
}

/*TODO LIST BEFORE V1:
-nerf clubs [completed]
-add Advanced Settings option so im not clogging the whole page with esoteric diagrams [completed]
-overcoat relationships [50%]
-vacillations somehow [completed]
*/

/*todo list before V2:
-integrate doll parts
-use images of some sort
 */