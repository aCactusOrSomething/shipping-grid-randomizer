import 'dart:html';
import 'dart:math';

class RelationshipType {
  static final RelationshipType HEARTS = new RelationshipType("<3", 2);
  static final RelationshipType SPADES = new RelationshipType("<3<", 2);
  static final RelationshipType CLUBS = new RelationshipType("o8<", 3);
  static final RelationshipType DIAMONDS = new RelationshipType("<>", 2);


  String value;
  int numParties;

  RelationshipType(String value, int numParties) {
    this.value = value;
    this.numParties = numParties;
  }

  static List<Relationship> makeShips(List<String> names, RelationshipType type, int frequency){
    List<Relationship> ret = new List<Relationship>();
    double cutoff = frequency / 100;
    Random rand = new Random();
    for(String name in names) {
      if(rand.nextDouble() <= cutoff) { //% chance to make relation
        List<String> parties = new List<String>();
        parties.add(name);
        for(int i = 1; i <= type.numParties - 1; i++) {
          if(rand.nextDouble() <= cutoff) {
            parties.add(names[rand.nextInt(names.length)]);
          } else {
            i = type.numParties;
          }
        }
        Relationship relationship = new Relationship(type, parties);
        ret.add(relationship);
      }
    }
    return ret;
  }
}

class Relationship {
  RelationshipType type;
  List<String> parties;

  Relationship(RelationshipType type, List<String> parties) {
    this.parties = parties;
    this.type = type;
  }

  String toString() {
    String ret = parties[0];
    ret += " " + type.value + " " + parties[1];
    for(int i = 2; i < parties.length; i++) {
      ret += " & " + parties[i];
    }
    return ret;
  }
  TableRowElement toRow() {
    TableRowElement ret = new TableRowElement();
    ret.addCell().text = parties[0];
    ret.addCell().text = type.value;
    ret.addCell().text = parties[1];
    for(int i = 2; i < parties.length; i++) {
      ret.addCell().text = "&";
      ret.addCell().text = parties[i];
    }
    return ret;
  }
}