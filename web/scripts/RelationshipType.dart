import 'dart:html';
import 'dart:math';

class RelationshipType {
  static final int SIZE = 20;


  static final RelationshipType HEARTS = new RelationshipType("\u{2661}", "http://www.farragofiction.com/DollSim/images/Charms/Hearts.png", 2);

  static final RelationshipType SPADES = new RelationshipType("\u{2660}", "http://www.farragofiction.com/DollSim/images/Charms/Spades.png", 2);
  static final RelationshipType CLUBS = new RelationshipType("\u{2663}", "http://www.farragofiction.com/DollSim/images/Charms/Clubs.png", 3);
  static final RelationshipType DIAMONDS = new RelationshipType("\u{2662}", "http://www.farragofiction.com/DollSim/images/Charms/Diamonds.png", 2);

  static final RelationshipType CHARM_HEARTS = new RelationshipType("\u{2764}", "http://www.farragofiction.com/DollSim/images/Charms/CharmHearts.png", 2);
  static final RelationshipType CHARM_STARS = new RelationshipType("\u{2729}", "http://www.farragofiction.com/DollSim/images/Charms/CharmStars.png", 2);
  static final RelationshipType CHARM_HORSESHOES = new RelationshipType("\u{260B}", "http://www.farragofiction.com/DollSim/images/Charms/CharmHorseshoes.png", 2);
  static final RelationshipType CHARM_CLOVERS = new RelationshipType("\u{2724}", "http://www.farragofiction.com/DollSim/images/Charms/CharmClovers.png", 2);
  static final RelationshipType CHARM_DIAMONDS = new RelationshipType("\u{27E1}", "http://www.farragofiction.com/DollSim/images/Charms/CharmDiamonds.png", 2);
  static final RelationshipType CHARM_RAINBOWS = new RelationshipType("\u{22D2}", "http://www.farragofiction.com/DollSim/images/Charms/CharmRainbows.png", 2);
  static final RelationshipType CHARM_POT_O_GOLD = new RelationshipType("\u{228D}", "http://www.farragofiction.com/DollSim/images/Charms/CharmPotsOfGold.png", 2);
  static final RelationshipType CHARM_BALLOONS = new RelationshipType("\u{26B2}", "http://www.farragofiction.com/DollSim/images/Charms/CharmBalloons.png", 2);
  static final RelationshipType CHARM_MOONS = new RelationshipType("\u{263E}", "http://www.farragofiction.com/DollSim/images/Charms/CharmMoons.png", 2);

  //http://www.farragofiction.com/DollSim/images/Charms/

  //>deep breath. shogun made these, they look like fun.
  //todo these string values are placeholders. you need to get ALL of them to use emojis instead of unicode chars.
  static final RelationshipType DYNAMOTION_CLOWN = new RelationshipType("\u{1F389}", "http://www.farragofiction.com/DollSim/images/Charms/Clown.png", 2); //shogun: "X and Y are in clown. Z is simply the target and not a fixed variable"
  static final RelationshipType DYNAMOTION_B = new RelationshipType("\u{1F171}", "http://www.farragofiction.com/DollSim/images/Charms/b.png", 2);
  static final RelationshipType DYNAMOTION_FEAR = new RelationshipType("\u{1F631}", "http://www.farragofiction.com/DollSim/images/Charms/Fear.png", 2);
  static final RelationshipType DYNAMOTION_HORSE = new RelationshipType("\u{2658}", "http://www.farragofiction.com/DollSim/images/Charms/Horse.png", 2);

  static final RelationshipType DYNAMOTION_THUMBSUP = new RelationshipType("\u{1F44D}", "http://www.farragofiction.com/DollSim/images/Charms/Thumb.png", 2);
  static final RelationshipType DYNAMOTION_CHICK = new RelationshipType("\u{1F426}", "http://www.farragofiction.com/DollSim/images/Charms/hatched_chick.png", 2);
  static final RelationshipType DYNAMOTION_OKAY = new RelationshipType("\u{1F58F}", "http://www.farragofiction.com/DollSim/images/Charms/Okay.png", 2);
  static final RelationshipType DYNAMOTION_TYPOSITY = new RelationshipType("\u{1F5D1}", "http://www.farragofiction.com/DollSim/images/Charms/Tpyosity.png", 2);

  static final RelationshipType DYNAMOTION_WEARY = new RelationshipType("\u{2639}", "http://www.farragofiction.com/DollSim/images/Charms/Smile.png", 2);
  static final RelationshipType DYNAMOTION_EGGPLANT = new RelationshipType("\u{2619}", "http://www.farragofiction.com/DollSim/images/Charms/Auberiginastycitiy.png", 2);
  static final RelationshipType DYNAMOTION_POOP = new RelationshipType("\u{1F4A9}", "http://www.farragofiction.com/DollSim/images/Charms/Patristewartus.png", 2);
  static final RelationshipType DYNAMOTION_100 = new RelationshipType("\u{1F4AF}", "http://www.farragofiction.com/DollSim/images/Charms/100.png", 2);

  static final RelationshipType DYNAMOTION_DAB = new RelationshipType("[Dab]", "http://www.farragofiction.com/DollSim/images/Charms/Dab.png", 2);
  //"The Ultimate Dynamotion is Dab. You can't get it. Ever. It's the Valhalla of friendships. It's the peak of alliance, concern, raw power and charisma." -shogun



  //TODO PUT LAMIA ROMANCE HERE
  static final LamiaCard CARD_HEART = new LamiaCard("\u{2661}", "http://www.farragofiction.com/DollSim/images/Charms/Hearts.png", 2);
  static final LamiaCard CARD_SPADES = new LamiaCard("\u{2660}", "http://www.farragofiction.com/DollSim/images/Charms/Spades.png", 2);
  static final LamiaCard CARD_CLUBS = new LamiaCard("\u{2663}", "http://www.farragofiction.com/DollSim/images/Charms/Clubs.png", 2);//manic made lamia clubs 2 party and this is why i love her so much
  static final LamiaCard CARD_DIAMONDS = new LamiaCard("\u{2662}", "http://www.farragofiction.com/DollSim/images/Charms/Diamonds.png", 2);
  static final LamiaCard JOKER = new LamiaCard("\u{1F389}", "http://www.farragofiction.com/DollSim/images/Charms/Clown.png", 2); //honk!

  static final List<RelationshipType> HUMAN = [HEARTS];
  static final List<RelationshipType> EXTRA_QUADRANTS = [SPADES, CLUBS, DIAMONDS];
  static final List<RelationshipType> CHARMS = [CHARM_HEARTS, CHARM_STARS, CHARM_HORSESHOES, CHARM_CLOVERS, CHARM_DIAMONDS, CHARM_RAINBOWS, CHARM_POT_O_GOLD, CHARM_BALLOONS, CHARM_MOONS];
  static final List<LamiaCard> CARDS = [CARD_HEART, CARD_SPADES, CARD_DIAMONDS, CARD_CLUBS];
  static final List<RelationshipType> DYNAMOTIONS = [DYNAMOTION_CLOWN, DYNAMOTION_B, DYNAMOTION_FEAR, DYNAMOTION_HORSE,
  DYNAMOTION_THUMBSUP, DYNAMOTION_CHICK, DYNAMOTION_OKAY, DYNAMOTION_TYPOSITY,
  DYNAMOTION_WEARY, DYNAMOTION_EGGPLANT, DYNAMOTION_POOP, DYNAMOTION_100]; //no dab, it is not attainable.

  String value;
  int numParties;
  String imageSrc;

  RelationshipType(String value, String imageSrc, int numParties,) {
    this.value = value;
    this.numParties = numParties;
    this.imageSrc = imageSrc;
  }

  //okay, time to rework this.
  static List<Relationship> makeShips(List<String> names, RelationshipType type, int frequency){
    List<Relationship> ret = new List<Relationship>();
    double cutoff = frequency / 100;
    Random rand = new Random();
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

 List<HtmlElement> getImage() {
    ImageElement ret = new ImageElement();
    ret.src = imageSrc;
    ret.width = SIZE;
    ret.height = SIZE;
    return [ret];
 }
}

class Relationship {
  RelationshipType type;
  List<String> parties;

  Relationship(RelationshipType type, List<String> parties) {
    this.parties = parties;
    this.type = type;
  }

  @override
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
    ret.addCell().children.addAll(type.getImage());
    ret.addCell().text = parties[1];
    for(int i = 2; i < parties.length; i++) {
      ret.addCell().text = "&";
      ret.addCell().text = parties[i];
    }
    return ret;
  }
}

class Vacillation extends RelationshipType {
  List<RelationshipType> types;
  //why must inheritance be so funky
  Vacillation(List<RelationshipType> types, int numParties) : super(
      "[${types[0].value} \u{1F300} ${types[1].value}]",
      "http://www.farragofiction.com/DollSim/images/Charms/Vacillation.png",
      numParties) {
    this.types = types;
  }

  @override
  List<HtmlElement> getImage() {
    int size = RelationshipType.SIZE;
    List<HtmlElement> ret = [];
    ret.addAll(types[0].getImage());
    ImageElement mid = new ImageElement();
    ret.add(mid);
    ret.addAll(types[1].getImage());

    mid.src = imageSrc;
    mid.width = size;
    mid.height = size;
    return ret;
  }
}

class LamiaCard extends RelationshipType {
  /*lamia cards function the same as normal relationship types, but have an additional intensity value.
  the intensity can go from 1 to 13. (1 is considered stronger than 13, but comparing values is not within the scope)
  */

  LamiaCard(String value, String imageSrc, int numParties, ): super(value, imageSrc, numParties);

  @override
  List<HtmlElement> getImage() {
    ImageElement retType = new ImageElement();
    retType.src = imageSrc;
    retType.width = RelationshipType.SIZE;
    retType.height = RelationshipType.SIZE;

    SpanElement retIntensity = new SpanElement();
    retIntensity.appendText(getRandomIntensity());
    return [retType, retIntensity];
  }

  //god this is lazy
  static String getRandomIntensity() {
    Random rand = new Random();
    int intensity = 1 + rand.nextInt(13);
    if(intensity > 1 && intensity < 11) {
      return "$intensity";
    } else if(intensity == 1)
      return "A";
    else if(intensity == 11)
      return "J";
    else if(intensity == 12)
      return "Q";
    else if(intensity == 13)
      return "K";

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
