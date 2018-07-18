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


  //>deep breath. shogun made these, they look like fun.
  //todo these string values are placeholders. you need to get ALL of them to use emojis instead of unicode chars.
  static final RelationshipType DYNAMOTION_CLOWN = new RelationshipType("\u{1F389}", 2); //shogun: "X and Y are in clown. Z is simply the target and not a fixed variable"
  static final RelationshipType DYNAMOTION_B = new RelationshipType("\u{1F171}", 2);
  static final RelationshipType DYNAMOTION_FEAR = new RelationshipType("\u{1F631}", 2);
  static final RelationshipType DYNAMOTION_HORSE = new RelationshipType("\u{2658}", 2);

  static final RelationshipType DYNAMOTION_THUMBSUP = new RelationshipType("\u{1F44D}", 2);
  static final RelationshipType DYNAMOTION_CHICK = new RelationshipType("\u{1F426}", 2);
  static final RelationshipType DYNAMOTION_OKAY = new RelationshipType("\u{1F58F}", 2);
  static final RelationshipType DYNAMOTION_TYPOSITY = new RelationshipType("\u{1F5D1}", 2);

  static final RelationshipType DYNAMOTION_WEARY = new RelationshipType("\u{2639}", 2);
  static final RelationshipType DYNAMOTION_EGGPLANT = new RelationshipType("\u{2619}", 2);
  static final RelationshipType DYNAMOTION_POOP = new RelationshipType("\u{1F4A9}", 2);
  static final RelationshipType DYNAMOTION_100 = new RelationshipType("\u{1F4AF}", 2);

  static final RelationshipType DYNAMOTION_DAB = new RelationshipType("[Dab]", 2);
  //"The Ultimate Dynamotion is Dab. You can't get it. Ever. It's the Valhalla of friendships. It's the peak of alliance, concern, raw power and charisma." -shogun

  static final List<RelationshipType> HUMAN = [HEARTS];
  static final List<RelationshipType> EXTRA_QUADRANTS = [SPADES, CLUBS, DIAMONDS];
  static final List<RelationshipType> CHARMS = [CHARM_HEARTS, CHARM_STARS, CHARM_HORSESHOES, CHARM_CLOVERS, CHARM_DIAMONDS, CHARM_RAINBOWS, CHARM_POT_O_GOLD, CHARM_BALLOONS, CHARM_MOONS];
  static final List<RelationshipType> DYNAMOTIONS = [DYNAMOTION_CLOWN, DYNAMOTION_B, DYNAMOTION_FEAR, DYNAMOTION_HORSE,
  DYNAMOTION_THUMBSUP, DYNAMOTION_CHICK, DYNAMOTION_OKAY, DYNAMOTION_TYPOSITY,
  DYNAMOTION_WEARY, DYNAMOTION_EGGPLANT, DYNAMOTION_POOP, DYNAMOTION_100]; //no dab, it is not attainable.

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
            //fuck i need to nerf CLUBS. run the check twice, i suppose?
            //no, three times. a triangle has three sides.
            //future me is gonna look back at this and have no idea what i was thinking. sorry bud.
            if(rand.nextDouble() <= cutoff && rand.nextDouble() <= cutoff && rand.nextDouble() <= cutoff) {
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

  //fuck this is going to not work isnt it
  static List<Relationship> makeVacillations(List<String> names, List<Relationship> relationships, List<RelationshipType> types, int frequency) {
    List<Relationship> ret = new List<Relationship>();
    Random rand = new Random();
    double cutoff = frequency / 100;
    //get two parties
    for(int i = 0; i < names.length; i++) {
      for(int j = i; j < names.length; j++) {
        //check to see if they even WOULD vaccilate. check twice.
        if(rand.nextDouble() <= cutoff && rand.nextDouble() <= cutoff) {
          //get a list of all quadrants not used between them
          List<RelationshipType> legal = types;
          legal.remove(
              CLUBS); //i do not want to deal with clubs bullshit, sorry
          for (Relationship ship in relationships) {
            //ohoho i forgot about selfcest
            if (ship.parties.contains(names[i]) && ((ship.parties.contains(names[j]) && i != j) || i == j)) {
              legal.remove(ship.type);
            }
          }

          //must have two types to tango
          if (legal.length >= 2) {
            int firstNumber = rand.nextInt(legal.length);
            RelationshipType firstType = legal.removeAt(firstNumber);
            int secondNumber = rand.nextInt(legal.length);
            RelationshipType secondType = legal.removeAt(secondNumber);

            //finally, build the vacillation.
            Vacillation desc = new Vacillation([firstType, secondType], 2);
            Relationship vac = new Relationship(desc, [names[i], names[j]]);
            ret.add(vac);
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

class Vacillation extends RelationshipType {

  //why must inheritance be so funky
  Vacillation(List<RelationshipType> types, int numParties) : super("[${types[0].value} \u{1F300} ${types[1].value}]", numParties) {

  }
}
/*
    | |
   ||/
   \|
    |
  ----
  you're actually reading through my garbage code?
  sorry about the mess, most of this was written when i was still a beginner.
  (heck the original version of this note was, too. i went back and edited it when i needed to make changes.)

  i'm not sure who you are, but i know what people i shared this file with.
  since i have to say this to all of you, each for very different reasons, I
  might as well do it here.

  Thank you. Seriously. Y'all have been through a ton recently, and that never
  stopped any of you from being kind and supportive friends to each other.

  -A Cactus, or something

 */
