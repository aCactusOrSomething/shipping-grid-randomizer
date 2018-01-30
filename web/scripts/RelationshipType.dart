import 'dart:html';
import 'dart:math';

class RelationshipType {
  static final RelationshipType HEARTS = new RelationshipType("\u{2661}", 2);
  static final RelationshipType SPADES = new RelationshipType("\u{2660}", 2);
  static final RelationshipType CLUBS = new RelationshipType("\u{2663}", 3);
  static final RelationshipType DIAMONDS = new RelationshipType("\u{2662}", 2);

  static final RelationshipType CHARM_HEARTS = new RelationshipType("\u{2764}", 2);
  static final RelationshipType CHARM_STARS = new RelationshipType("\u{2729}", 2);
  static final RelationshipType CHARM_HORSESHOES = new RelationshipType("\u{260B}", 2);
  static final RelationshipType CHARM_CLOVERS = new RelationshipType("\u{2724}", 2);
  static final RelationshipType CHARM_DIAMONDS = new RelationshipType("\u{27E1}", 2);
  static final RelationshipType CHARM_RAINBOWS = new RelationshipType("\u{22D2}", 2);
  static final RelationshipType CHARM_POT_O_GOLD = new RelationshipType("\u{228D}", 2);
  static final RelationshipType CHARM_BALLOONS = new RelationshipType("\u{26B2}", 2);
  static final RelationshipType CHARM_MOONS = new RelationshipType("\u{263E}", 2);


  String value;
  int numParties;

  RelationshipType(String value, int numParties) {
    this.value = value;
    this.numParties = numParties;
  }

  //okay, time to rework this.
  static List<Relationship> makeShips(List<String> names, RelationshipType type, int frequency){
    List<Relationship> ret = new List<Relationship>();
    double cutoff = frequency / 100;
    Random rand = new Random();
    int maxShips = 0;
    for(int i = 0; i < type.numParties; i++ ) {
      maxShips += names.length - i;
    }
    for(int i = 0; i < names.length; i++) {
      for(int j = i; j < names.length; j++) {
        //todo: only reason this is OK now is because the maximum parties in a ship is 3, for clubs. generalize this to work with any length.
        if(type.numParties > 2) {
          for(int k = j; k < names.length; k++) {
            List<String> parties = new List<String>();
            parties.add(names[i]);
            parties.add(names[j]);
            parties.add(names[k]);
            if(rand.nextDouble() <= cutoff) {
              ret.add(new Relationship(type, parties));
            }
          }
        } else {
          List<String> parties = new List<String>();
          parties.add(names[i]);
          parties.add(names[j]);
          if(rand.nextDouble() <= cutoff) {
            ret.add(new Relationship(type, parties));
          }
        }
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