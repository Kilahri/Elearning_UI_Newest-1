import 'package:flutter/material.dart';

// --- Enhanced Book Data Model with Full Content ---
class Book {
  final String title;
  final String image;
  final String summary;
  final String theme;
  final List<BookChapter> chapters;
  final String author;
  final int readTime;
  final String funFact;

  Book({
    required this.title,
    required this.image,
    required this.summary,
    required this.theme,
    required this.chapters,
    required this.author,
    required this.readTime,
    required this.funFact,
  });
}

class BookChapter {
  final String title;
  final String content;
  final List<String> keyPoints;
  final String didYouKnow;
  final List<QuizQuestion> quizQuestions;

  BookChapter({
    required this.title,
    required this.content,
    required this.keyPoints,
    required this.didYouKnow,
    required this.quizQuestions,
  });
}

class QuizQuestion {
  final String question;
  final List<String> options;
  final int correctAnswer;
  final String explanation;

  QuizQuestion({
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.explanation,
  });
}

// --- Sample Book Data ---
final List<Book> scienceBooks = [
  Book(
    title: "Amazing Changes of Matter! 🔬",
    image: "lib/assets/statesofmatter.jpg",
    summary:
        "Discover the super cool properties of matter and how it magically changes between solid, liquid, and gas states!",
    theme: "Chemistry",
    author: "Prof. Alex Chen",
    readTime: 15,
    funFact:
        "Did you know? Water is the only substance on Earth that naturally exists in all three states at the same time!",
    chapters: [
      BookChapter(
        title: "🧊 Three States of Matter",
        content:
            """Imagine everything around you - your desk, the air you breathe, even the water you drink - they're all made of something called MATTER! Matter is like the building blocks of everything in the universe.

Matter comes in three main forms, kind of like ice cream comes in different flavors:

**Solids are Super Strong! 💪**
Solids keep their shape no matter what! Think about a rock, a book, or an ice cube. The tiny particles (we call them atoms and molecules) inside solids are packed together really tight, like students standing in a crowded hallway. They can only wiggle a tiny bit in place. That's why you can pick up a solid and it doesn't flow through your fingers!

**Liquids Love to Flow! 💧**
Liquids are the relaxed cousins of solids. They have a set volume (amount), but they'll take the shape of any container you put them in. Pour water into a cup - it becomes cup-shaped! Pour it into a bowl - now it's bowl-shaped! The particles in liquids are still close together, but they can slide past each other like people dancing at a party.

**Gases are Free Spirits! 💨**
Gases are the ultimate free spirits - they spread out to fill up any space they're in! The air around you is full of gases, but you can't see most of them. Gas particles zoom around super fast with lots of space between them, like kids running around in a huge playground.

The coolest part? The difference between these three states is all about how much energy the particles have and how close together they are!""",
        keyPoints: [
          "Solid = Particles packed tight, keeps its shape",
          "Liquid = Particles slide past each other, flows freely",
          "Gas = Particles spread far apart, fills any space",
          "It's all about particle arrangement and energy!",
        ],
        didYouKnow:
            "🌟 Fun Fact: Your pencil is a solid, but the graphite inside is made of the same element (carbon) as diamonds! The only difference is how the atoms are arranged.",
        quizQuestions: [
          QuizQuestion(
            question: "What happens to particles in a solid?",
            options: [
              "They fly around freely",
              "They vibrate in place",
              "They disappear",
              "They turn into liquid",
            ],
            correctAnswer: 1,
            explanation:
                "Great job! Solid particles are packed tightly and can only vibrate in their fixed positions.",
          ),
          QuizQuestion(
            question: "Which state of matter takes the shape of its container?",
            options: ["Solid", "Liquid", "Gas", "Both liquid and gas"],
            correctAnswer: 3,
            explanation:
                "Awesome! Both liquids and gases take the shape of their container - liquids flow to fit, and gases expand to fill the entire space!",
          ),
        ],
      ),
      BookChapter(
        title: "🔥 Melting and Freezing Magic!",
        content:
            """Have you ever watched an ice cube melt on a hot day? Or seen water freeze in the freezer? That's matter changing states right before your eyes! It's like magic, but it's actually science!

**When Solids Melt into Liquids 🍦**
Melting happens when you add heat energy to a solid. Imagine giving the particles a energy drink - they start moving faster and faster! Eventually, they break free from their fixed positions and start sliding around. That's when your solid becomes a liquid!

Think about butter on hot toast. The heat from the toast gives the butter particles energy, they start moving more, break free from their solid form, and - whoosh - you've got melted butter! The temperature where this magic happens is called the melting point.

**When Liquids Freeze into Solids ❄️**
Freezing is like melting in reverse! When you take away heat energy (by putting something in the freezer), the particles slow down. They get slower and slower until they lock into fixed positions - and boom, you've got a solid!

Water freezes at 0°C (32°F). When you make ice cubes, you're taking heat energy away from water, the particles slow down and lock together in a crystal pattern, creating solid ice!

**The Cool Temperature Trick 🌡️**
Here's something weird: the melting point and freezing point are the SAME temperature! Water melts at 0°C and freezes at 0°C. The difference is whether you're adding heat (melting) or taking it away (freezing).

Even weirder: while something is melting or freezing, the temperature doesn't change! All the energy is being used to change the state, not to change the temperature. It's like the particles are too busy transforming to get hotter or colder!""",
        keyPoints: [
          "Melting = Adding heat turns solid → liquid",
          "Freezing = Removing heat turns liquid → solid",
          "Melting point = Freezing point (same temperature!)",
          "Temperature stays constant during the change",
        ],
        didYouKnow:
            "🌟 Fun Fact: Chocolate melts at about 34°C (93°F) - just below your body temperature! That's why it melts in your hand and in your mouth!",
        quizQuestions: [
          QuizQuestion(
            question: "What causes a solid to melt?",
            options: [
              "Removing heat",
              "Adding heat",
              "Adding water",
              "Shaking it",
            ],
            correctAnswer: 1,
            explanation:
                "Correct! Adding heat gives particles more energy to move and break free from their solid positions.",
          ),
          QuizQuestion(
            question: "At what temperature does water freeze?",
            options: ["100°C", "50°C", "0°C", "-10°C"],
            correctAnswer: 2,
            explanation: "Perfect! Water freezes (and melts) at 0°C or 32°F.",
          ),
        ],
      ),
      BookChapter(
        title: "💨 Evaporation and Condensation",
        content:
            """Did you know water can turn into a gas WITHOUT boiling? It's true! This amazing process is happening all around you, all the time!

**Evaporation: The Great Escape! 🌊→💨**
Evaporation is when a liquid turns into a gas, even when it's not boiling. Think about a puddle after rain - where does it go? It evaporates! The water particles at the surface get enough energy from the sun to escape into the air as water vapor (an invisible gas).

Not all particles have the same energy - some are like super athletes with extra energy. These energetic particles can break free from the liquid and zoom off into the air. That's evaporation!

**Ways to Speed Up Evaporation:**
- 🔥 **Heat it up!** More heat = more energy = faster evaporation
- 📏 **Spread it out!** Larger surface area = more escape routes for particles
- 💨 **Add wind!** Wind carries away the escaped particles, making room for more
- ☀️ **Lower humidity!** If the air is already full of water vapor, there's less room for more

**Condensation: Coming Back Together 💧**
Condensation is evaporation's opposite twin! It's when a gas turns back into a liquid. This happens when gas particles lose energy and slow down enough to stick together again.

Have you ever noticed water droplets on a cold glass of juice? That's condensation! The water vapor in the air touches the cold glass, loses energy, slows down, and sticks together as liquid drops.

**The Water Cycle Connection 🌍**
Evaporation and condensation are the stars of Earth's water cycle! Water evaporates from oceans and lakes, rises up into the sky, cools down and condenses into clouds, then falls back down as rain. It's like nature's recycling program!""",
        keyPoints: [
          "Evaporation = Liquid → Gas (doesn't need boiling!)",
          "Happens faster with: heat, large surface, wind, dry air",
          "Condensation = Gas → Liquid (particles lose energy)",
          "These processes drive Earth's water cycle!",
        ],
        didYouKnow:
            "🌟 Fun Fact: Your body uses evaporation to cool you down! When you sweat, the sweat evaporates from your skin, taking heat energy with it and making you feel cooler!",
        quizQuestions: [
          QuizQuestion(
            question: "What is evaporation?",
            options: [
              "Solid turning to liquid",
              "Liquid turning to gas",
              "Gas turning to liquid",
              "Solid turning to gas",
            ],
            correctAnswer: 1,
            explanation:
                "Yes! Evaporation is when a liquid changes into a gas, even below its boiling point.",
          ),
          QuizQuestion(
            question:
                "When you see water droplets on a cold drink, that's called...",
            options: ["Evaporation", "Melting", "Condensation", "Freezing"],
            correctAnswer: 2,
            explanation:
                "Excellent! That's condensation - water vapor in the air cooling down and turning back into liquid water.",
          ),
        ],
      ),
      BookChapter(
        title: "🔄 Reversible Changes - You Can Undo Them!",
        content:
            """Some changes are like playing with LEGO blocks - you can build something, then take it apart and go back to how it was! These are called reversible changes.

**What Makes a Change Reversible? 🔁**
A reversible change is one where you can get back to where you started. The material doesn't become something completely new - it just changes form or gets mixed up, but it's still the same stuff underneath!

**Cool Examples of Reversible Changes:**

**1. The Ice-Water-Ice Trick ❄️→💧→❄️**
Freeze water to make ice, then melt the ice back into water. The water hasn't become something new - it's still H₂O! You can keep going back and forth forever.

**2. The Sugar Vanishing Act 🍬**
Dissolve sugar in water and it seems to disappear! But it's still there, just spread out really tiny. If you leave the water in the sun, it evaporates and - tada! - your sugar is back!

**3. The Crumpled Paper Experiment 📄**
Crumple up a piece of paper. Now smooth it out. It's not perfectly flat anymore, but it's still paper! You didn't create a new material.

**4. The Magnetic Mix-Up 🧲**
Mix iron filings with sand. Looks like one thing, right? But use a magnet and you can pull out all the iron, separating them again. Nothing changed into something new!

**Why Are Reversible Changes Cool? 🎯**
Reversible changes are super useful! We can melt metal to shape it, then let it harden. We can dissolve salt in water to cook with, knowing the salt is still there. We can freeze and thaw food. All these everyday activities depend on reversible changes!

Remember: If you can go backwards and get the same material back, it's a reversible change!""",
        keyPoints: [
          "Reversible changes CAN be undone",
          "The material stays the same (no new substance)",
          "Examples: melting, freezing, dissolving, mixing",
          "Super useful in everyday life!",
        ],
        didYouKnow:
            "🌟 Fun Fact: Your body uses reversible changes! Oxygen reversibly binds to hemoglobin in your blood, carries to your cells, then releases. If it wasn't reversible, you could only breathe once!",
        quizQuestions: [
          QuizQuestion(
            question: "Which of these is a reversible change?",
            options: [
              "Burning paper",
              "Baking a cake",
              "Melting ice",
              "Cooking an egg",
            ],
            correctAnswer: 2,
            explanation:
                "Correct! Melting ice is reversible - you can freeze the water back into ice. The others create new substances that can't be undone.",
          ),
          QuizQuestion(
            question:
                "When you dissolve sugar in water, is the sugar gone forever?",
            options: [
              "Yes, it disappeared",
              "No, it's still there, just dissolved",
              "It turned into water",
              "It evaporated",
            ],
            correctAnswer: 1,
            explanation:
                "Right! The sugar is still there, just broken into tiny pieces and mixed with water. You can get it back by evaporating the water!",
          ),
        ],
      ),
      BookChapter(
        title: "⚠️ Irreversible Changes - No Going Back!",
        content:
            """Some changes are like breaking a raw egg - once it's done, you can't unbreak it! These are called irreversible changes, and they create brand new substances.

**What Makes a Change Irreversible? 🚫🔙**
An irreversible change creates something completely new with different properties. You can't just reverse it and get back what you started with. The original material is gone forever!

**Epic Examples of Irreversible Changes:**

**1. Burning - The Ultimate Transformation 🔥**
When you burn wood, it turns into ash, smoke, and gases. Can you turn ash back into wood? Nope! The wood is gone forever. Burning is a chemical reaction that creates completely new substances.

**2. Cooking - Delicious Chemistry! 🍳**
Crack an egg and cook it. The runny egg white turns solid and white. Can you "uncook" it back to being runny? No way! The proteins in the egg have changed their structure permanently. Same with baking a cake, toasting bread, or frying bacon - once cooked, always cooked!

**3. Rusting - Iron's Transformation 🔴**
Leave an iron nail outside in the rain. Over time, it turns reddish-brown and crusty - that's rust! The iron has combined with oxygen to create a new substance called iron oxide. You can't just wipe the rust off and get shiny iron back.

**4. The Baking Soda & Vinegar Volcano! 🌋**
Mix baking soda and vinegar and watch it fizz and bubble! That bubbling is carbon dioxide gas being created. The baking soda and vinegar have chemically reacted to create completely new substances. You can't unmix them!

**How to Spot Irreversible Changes: 🔍**
- Color changes (like rusting)
- Temperature changes (getting hot or cold)
- Bubbles or gas being produced
- Light being produced
- New smells
- Can't easily separate what you started with

**Why They're Important! 💡**
Irreversible changes give us cooked food, hardened concrete for buildings, and even the energy from batteries. They're permanent, but super useful!""",
        keyPoints: [
          "Irreversible changes CANNOT be undone",
          "Create brand new substances with different properties",
          "Examples: burning, cooking, rusting, chemical reactions",
          "Look for: color change, gas, heat, light, new smells",
        ],
        didYouKnow:
            "🌟 Fun Fact: When you digest food, it's an irreversible change! Your body breaks down food into energy and other substances. Good thing too - you wouldn't want to undigest your lunch!",
        quizQuestions: [
          QuizQuestion(
            question: "Why can't you 'uncook' an egg?",
            options: [
              "Because it's too hot",
              "Because the proteins changed permanently",
              "Because it tastes bad",
              "Because it's in a pan",
            ],
            correctAnswer: 1,
            explanation:
                "Perfect! Cooking causes irreversible chemical changes in the egg proteins. Once changed, they can't go back!",
          ),
          QuizQuestion(
            question: "Which is a sign of an irreversible change?",
            options: [
              "Water freezing",
              "Sugar dissolving",
              "Gas bubbles forming",
              "Ice melting",
            ],
            correctAnswer: 2,
            explanation:
                "Excellent! Gas bubbles forming often means a chemical reaction is happening, creating new substances - that's irreversible!",
          ),
        ],
      ),
    ],
  ),
  Book(
    title: "Earth Day Every Day 🌍",
    image: "lib/assets/earthScience.png",
    summary:
        "Explore our amazing planet Earth from the inside out! Learn about its layers, rotation, seasons, and our place in the universe!",
    theme: "Earth Science",
    author: "Dr. Maria Stone",
    readTime: 20,
    funFact:
        "Earth is the only planet not named after a god - its name comes from the Old English word 'ertha' meaning ground!",
    chapters: [
      BookChapter(
        title: "🌍 Earth's Amazing Layers",
        content:
            """Imagine Earth is like a giant jawbreaker candy - it has different layers! Let's dig deep and discover what's under our feet.

**The Crust: Where We Live! 🏠**
The crust is Earth's outer shell - the ground you walk on! It's like the skin of an apple, super thin compared to the rest of Earth. Under the oceans, it's only about 5 kilometers thick, but under continents it can be up to 70 kilometers thick. All life on Earth lives on this thin rocky crust!

**The Mantle: Earth's Gooey Middle! 🌋**
Below the crust is the mantle - the thickest layer of Earth! It's made of hot, dense rock that's so hot it flows veeeery slowly, like super thick honey or lava lamp fluid. The mantle is about 2,900 kilometers thick! Even though it flows, it's not liquid - it's more like silly putty that moves over millions of years.

The mantle's movement is super important because it causes the crust above to shift and move, creating mountains, earthquakes, and volcanoes!

**The Outer Core: Liquid Metal! 💧🔥**
Deeper down is the outer core - a layer of liquid metal! It's mostly made of iron and nickel, and it's incredibly hot (about 4,500°C to 5,500°C). Even though it's super hot, it stays liquid because of the pressure.

Here's the coolest part: the outer core flows and swirls around, and this movement creates Earth's magnetic field! That's what makes compasses point north and protects us from harmful radiation from space!

**The Inner Core: The Solid Center! ⚪**
At the very center of Earth is the inner core - a solid ball of iron and nickel about the size of the Moon! It's the hottest part of Earth (about 5,200°C - as hot as the surface of the Sun!), but it's solid because the pressure from all the layers above squeezes it so hard.

**How Did These Layers Form? 🤔**
Billions of years ago, Earth was completely molten (melted). Heavy materials like iron sank to the center, while lighter materials floated to the top. Over time, Earth cooled and the layers formed - like when you let hot chocolate cool and different layers settle!""",
        keyPoints: [
          "Crust: Thin outer layer where we live (5-70 km)",
          "Mantle: Thickest layer, hot flowing rock (2,900 km)",
          "Outer Core: Liquid metal, creates magnetic field",
          "Inner Core: Solid metal ball at the center, super hot!",
        ],
        didYouKnow:
            "🌟 Fun Fact: If Earth were shrunk to the size of an apple, the crust would be thinner than the apple's skin! We literally live on a paper-thin shell!",
        quizQuestions: [
          QuizQuestion(
            question: "Which layer of Earth do we live on?",
            options: ["Mantle", "Crust", "Outer Core", "Inner Core"],
            correctAnswer: 1,
            explanation:
                "Correct! We live on the crust, the thin outer layer of Earth.",
          ),
          QuizQuestion(
            question: "What creates Earth's magnetic field?",
            options: [
              "The crust",
              "The mantle",
              "The outer core",
              "The inner core",
            ],
            correctAnswer: 2,
            explanation:
                "Yes! The flowing liquid metal in the outer core creates Earth's magnetic field that protects us!",
          ),
        ],
      ),
      BookChapter(
        title: "🌞 Earth's Rotation: Day and Night",
        content:
            """Get ready for a dizzy fact: You're spinning right now at over 1,600 kilometers per hour! Don't worry, you won't fall off! Let's learn about Earth's amazing rotation.

**Earth is a Giant Spinning Top! 🔄**
Earth is constantly spinning like a top! One complete spin takes 24 hours - that's why we have day and night. We don't feel the spinning because everything around us (the air, the ground, even your school) is spinning at the same speed!

**The Flashlight Experiment 🔦**
Imagine holding a flashlight and shining it at a spinning basketball. The side facing the flashlight is bright (daytime), while the side facing away is in shadow (nighttime). Earth works exactly the same way with the Sun!

When your part of Earth faces the Sun, you experience daytime with bright sunshine. As Earth spins, your location rotates away from the Sun, and you experience nighttime with stars and darkness. About 12 hours later, you've spun back around to face the Sun again - good morning!

**Why Does the Sun "Rise" in the East? 🌅**
Here's a mind-blowing fact: The Sun doesn't actually move across the sky - WE'RE the ones moving! Earth rotates from west to east, which makes the Sun appear to rise in the east and set in the west. It's like when you're in a car looking out the window - the trees seem to move backward, but really YOU'RE moving forward!

**Rotation Affects Everything! 🌀**
Earth's rotation does more than just give us day and night:
- It affects wind patterns (winds curve because of rotation!)
- It influences ocean currents
- It affects the path of flying airplanes
- It makes hurricanes spin in circles

**Different Speeds in Different Places! 🏃**
At the equator (Earth's middle), you're spinning at about 1,670 km/h! But at the North or South Pole, you'd just spin in place like a ballerina. The speed depends on how far you are from Earth's axis (the imaginary line through the poles that Earth spins around).

**What If Earth Stopped Spinning? 🛑**
If Earth suddenly stopped rotating (don't worry, it won't!), one side would always face the Sun (super hot!) and one side would always face away (super cold!). There'd be no day and night cycle, and the weather would be totally different. Good thing Earth keeps spinning!""",
        keyPoints: [
          "Earth rotates once every 24 hours",
          "Rotation causes day (facing Sun) and night (facing away)",
          "We spin from west to east (Sun 'rises' in east)",
          "Rotation affects weather, winds, and ocean currents",
        ],
        didYouKnow:
            "🌟 Fun Fact: Earth's rotation is gradually slowing down! Millions of years ago, a day was only about 23 hours long. Don't worry though - it's slowing so slowly that days won't change noticeably in your lifetime!",
        quizQuestions: [
          QuizQuestion(
            question: "How long does it take Earth to rotate once?",
            options: ["12 hours", "24 hours", "365 days", "1 month"],
            correctAnswer: 1,
            explanation:
                "Perfect! Earth takes 24 hours (one day) to complete one full rotation.",
          ),
          QuizQuestion(
            question: "Why don't we feel Earth spinning?",
            options: [
              "Because it spins slowly",
              "Because we're too small",
              "Because everything moves with us at the same speed",
              "Because of gravity",
            ],
            correctAnswer: 2,
            explanation:
                "Exactly! Everything around us - the ground, air, buildings - spins with Earth at the same speed, so we don't feel the motion!",
          ),
        ],
      ),
      BookChapter(
        title: "🍂 The Seasons: Earth's Tilt",
        content:
            """Why do we have hot summers and cold winters? The answer might surprise you - it's all because Earth is a little bit tilted!

**Earth's Funky Tilt! 🎡**
Earth doesn't spin perfectly straight up and down - it's tilted at an angle of 23.5 degrees. Imagine a spinning top that's leaning to one side. That tilt is the reason we have seasons!

**The Sun and Earth Dance! 💃🕺**
As Earth orbits (travels around) the Sun during the year, its tilt stays pointing in the same direction. This means that different parts of Earth get different amounts of sunlight at different times of the year.

**Summer: Leaning Toward the Sun ☀️**
When the Northern Hemisphere (the top half of Earth) is tilted toward the Sun:
- Sunlight hits more directly (stronger and more concentrated)
- Days are longer (more daylight hours)
- Nights are shorter
- = SUMMER in the north!

At the same time, the Southern Hemisphere (bottom half) is tilted away from the Sun, so they're experiencing WINTER!

**Winter: Leaning Away from the Sun ❄️**
Six months later, Earth has traveled halfway around the Sun. Now the Northern Hemisphere is tilted AWAY from the Sun:
- Sunlight hits at an angle (weaker and spread out)
- Days are shorter (fewer daylight hours)
- Nights are longer
- = WINTER in the north!

Now the Southern Hemisphere is tilted toward the Sun and having summer. This is why Australia has Christmas in summer!

**Spring and Fall: The In-Between Seasons 🌸🍁**
During spring and fall (called equinoxes), Earth's tilt is sideways to the Sun. Both hemispheres get about equal amounts of sunlight. These are the transitional seasons between the extreme heat of summer and cold of winter.

On the equinox days (around March 20 and September 22), day and night are almost exactly equal length everywhere on Earth - about 12 hours each!

**What If Earth Had No Tilt? 🤔**
Without the tilt, there would be NO seasons! Every day would be like spring or fall - same temperature, same day length, all year round. Some places would always be hot (near the equator) and some would always be cold (near the poles), but nothing would change throughout the year. Sounds boring, right?

**Different Seasons in Different Places! 🌍**
Remember: When it's summer in North America, it's winter in Australia. When it's fall in Europe, it's spring in South America. The seasons are opposite in the Northern and Southern Hemispheres!""",
        keyPoints: [
          "Earth is tilted 23.5 degrees on its axis",
          "The tilt + orbit around Sun = seasons!",
          "Tilted toward Sun = summer (warm, long days)",
          "Tilted away from Sun = winter (cold, short days)",
          "Equinoxes = equal day and night (spring & fall)",
        ],
        didYouKnow:
            "🌟 Fun Fact: The planet Uranus is tilted almost 98 degrees - it basically rolls around the Sun on its side! Its seasons last about 21 Earth years each!",
        quizQuestions: [
          QuizQuestion(
            question: "What causes Earth to have seasons?",
            options: [
              "Distance from the Sun",
              "Earth's tilt",
              "Earth's rotation",
              "The Moon",
            ],
            correctAnswer: 1,
            explanation:
                "Correct! Earth's 23.5-degree tilt as it orbits the Sun causes the seasons, not how far we are from the Sun!",
          ),
          QuizQuestion(
            question:
                "When it's summer in the United States, what season is it in Australia?",
            options: ["Summer", "Winter", "Spring", "Fall"],
            correctAnswer: 1,
            explanation:
                "Yes! When the Northern Hemisphere has summer, the Southern Hemisphere has winter. Australia is in the Southern Hemisphere!",
          ),
        ],
      ),
      BookChapter(
        title: "🪐 Our Solar System Family",
        content:
            """Earth isn't alone! We're part of a huge cosmic family called the Solar System. Let's meet our neighbors!

**The Sun: Our Neighborhood Star! ⭐**
At the center of everything is the Sun - a medium-sized star that's absolutely HUGE compared to Earth! The Sun contains 99.86% of all the mass in our solar system. If the Sun were hollow, you could fit about 1.3 million Earths inside it!

The Sun is basically a giant ball of hot gas (mostly hydrogen and helium) where nuclear fusion happens, creating the light and heat that makes life on Earth possible. Its gravity is so strong that it keeps all the planets orbiting around it!

**The Eight Planets: Our Siblings! 🌍🪐**
Moving outward from the Sun, we have eight planets:

**The Rocky Inner Planets** (Close to the Sun, solid surfaces)
1. **Mercury** - Smallest planet, closest to Sun, super hot!
2. **Venus** - Hottest planet (thick atmosphere traps heat), brightest in sky
3. **Earth** - Our home! Only planet with liquid water and life
4. **Mars** - The Red Planet (rust-colored), has the biggest volcano!

**The Gas Giant Outer Planets** (Far from Sun, made of gas/liquid)
5. **Jupiter** - Biggest planet, could fit 1,000+ Earths inside!
6. **Saturn** - Famous for its beautiful rings made of ice and rock
7. **Uranus** - Tilted on its side, blue-green color
8. **Neptune** - Farthest planet, windiest planet, deep blue color

**Other Cool Neighbors! ☄️**
- **The Asteroid Belt**: Between Mars and Jupiter, millions of rocky objects orbit
- **Moons**: Natural satellites that orbit planets (Earth has 1, Jupiter has 79!)
- **Comets**: Icy bodies with beautiful tails when near the Sun
- **Dwarf Planets**: Like Pluto! Smaller than regular planets
- **The Kuiper Belt**: Beyond Neptune, full of icy objects

**Everything Stays in Orbit! 🎯**
Planets don't fly off into space because the Sun's gravity keeps them in orbit. The planets move fast enough to not fall into the Sun, but not so fast that they escape! It's like swinging a ball on a string - the string (gravity) keeps it going in a circle.

**How BIG is Our Solar System? 🚀**
If Earth were the size of a marble:
- The Sun would be a beach ball about 30 meters away
- Jupiter would be a basketball 150 meters away
- Neptune would be a tennis ball about 900 meters away!

Space is REALLY big and mostly empty!""",
        keyPoints: [
          "Sun at center contains 99.86% of solar system mass",
          "8 planets: 4 rocky inner planets, 4 gas giants",
          "Also includes moons, asteroids, comets, dwarf planets",
          "Sun's gravity keeps everything in orbit",
        ],
        didYouKnow:
            "🌟 Fun Fact: Jupiter is so big that all the other planets could fit inside it! It also has a giant storm called the Great Red Spot that's been raging for over 300 years!",
        quizQuestions: [
          QuizQuestion(
            question: "Which planet is the biggest in our solar system?",
            options: ["Earth", "Saturn", "Jupiter", "Neptune"],
            correctAnswer: 2,
            explanation:
                "Correct! Jupiter is the largest planet - you could fit 1,000+ Earths inside it!",
          ),
          QuizQuestion(
            question: "What keeps the planets orbiting around the Sun?",
            options: ["Magnets", "Wind", "Gravity", "Rocket power"],
            correctAnswer: 2,
            explanation:
                "Perfect! The Sun's powerful gravity keeps all the planets in orbit around it!",
          ),
        ],
      ),
      BookChapter(
        title: "🌌 The Universe: Our Biggest Home!",
        content:
            """Ready for your mind to be blown? Our solar system is just a tiny speck in something WAY bigger - the UNIVERSE!

**The Milky Way: Our Galaxy Home! 🌌**
Our solar system lives inside a galaxy called the Milky Way. A galaxy is a HUGE collection of stars, planets, gas, and dust all held together by gravity. How huge? The Milky Way contains somewhere between 100 to 400 BILLION stars! And our Sun is just one ordinary star among billions!

On a clear, dark night away from city lights, you can see a faint, milky band of light across the sky - that's actually millions of stars in our galaxy!

**The Milky Way's Shape: A Cosmic Pinwheel! 🌀**
If you could see the Milky Way from far away, it would look like a giant spiral pinwheel with long arms of stars swirling around a bright center. Our solar system is located in one of the outer arms, about 2/3 of the way from the center.

The whole galaxy is slowly rotating - it takes our solar system about 225-250 million years to make one complete orbit around the galactic center. Imagine - Earth has only orbited the galaxy about 20 times since the dinosaurs appeared!

**But Wait, There's More! 🤯**
The Milky Way is just ONE galaxy. Scientists estimate there are about 100-200 BILLION other galaxies in the observable universe! Some are spiral like ours, some are elliptical (oval-shaped like footballs), and some are irregular (no particular shape).

**Galaxies Come in Different Shapes:**
- **Spiral galaxies**: Have arms that spiral out from the center (like ours!)
- **Elliptical galaxies**: Look like stretched circles or footballs
- **Irregular galaxies**: Have no particular shape, look messy
- **Lenticular galaxies**: Disk-shaped but without spiral arms

**How BIG is the Universe? 📏**
The universe is so incredibly huge that regular measurements don't work. Scientists use "light-years" - the distance light travels in one year. Light moves at 300,000 kilometers per SECOND, and in a year it travels about 9.5 trillion kilometers. That's one light-year!

The nearest star to our Sun (Proxima Centauri) is about 4.2 light-years away. That means the light we see from it left that star 4.2 years ago!

**The Observable Universe** extends about 46.5 billion light-years in every direction. But here's the crazy part - the universe might be even bigger than what we can see! Light from farther away hasn't had time to reach us yet.

**The Universe is Growing! 📈**
Scientists have discovered that the universe is expanding - galaxies are moving away from each other! It's like dots on a balloon - as you blow up the balloon, all the dots move apart from each other.

This expansion tells us something amazing: long ago, the universe was much smaller and hotter. Scientists think the universe began about 13.8 billion years ago in an event called the Big Bang!

**Are We Alone? 👽**
With billions of galaxies, each with billions of stars, and many of those stars having planets... could there be life somewhere else? Scientists are searching! So far, Earth is the only place we know of with life. We're pretty special!

**Our Address in the Universe! 📮**
- Planet: Earth
- Solar System: The Sun and its 8 planets
- Galaxy: The Milky Way
- Galaxy Group: The Local Group (our galaxy + nearby galaxies)
- Supercluster: Laniakea Supercluster
- Observable Universe: Everything we can see!""",
        keyPoints: [
          "Our solar system is in the Milky Way galaxy",
          "Milky Way has 100-400 billion stars!",
          "Universe has 100-200 billion galaxies",
          "Universe is 13.8 billion years old and expanding",
        ],
        didYouKnow:
            "🌟 Fun Fact: The light from some stars we see at night left those stars before humans even existed! When you look at stars, you're actually looking back in time!",
        quizQuestions: [
          QuizQuestion(
            question: "What is the name of our galaxy?",
            options: [
              "The Universe",
              "The Solar System",
              "The Milky Way",
              "The Big Dipper",
            ],
            correctAnswer: 2,
            explanation:
                "Correct! We live in the Milky Way galaxy, which contains billions of stars!",
          ),
          QuizQuestion(
            question: "About how old is the universe?",
            options: [
              "1 million years",
              "100 million years",
              "1 billion years",
              "13.8 billion years",
            ],
            correctAnswer: 3,
            explanation:
                "Perfect! Scientists estimate the universe is about 13.8 billion years old!",
          ),
        ],
      ),
    ],
  ),
];

final List<Book> spaceBooks = [
  Book(
    title: "Plant Power! 🌱",
    image: "lib/assets/plantScience.jpg",
    summary:
        "Discover the amazing world of plants! Learn how they grow, make their own food, and reproduce in super cool ways!",
    theme: "Biology",
    author: "Dr. Green Leaf",
    readTime: 22,
    funFact:
        "The largest living organism on Earth is a fungus in Oregon that covers 2,385 acres - that's bigger than 1,600 football fields!",
    chapters: [
      BookChapter(
        title: "🌿 Plant Parts: A Team That Works Together!",
        content:
            """Plants are like amazing living machines! Each part has its own special job, and they all work together to keep the plant alive and healthy. Let's meet the team!

**Roots: The Underground Heroes! 🦸‍♂️**
Roots live underground where you can't see them, but they're super important! They have two main jobs:

**Job 1 - Anchor the Plant**: Roots spread out underground like an anchor, holding the plant firmly in the soil so wind and rain can't knock it over. Strong roots = strong plant!

**Job 2 - Drink Up!**: Roots are like straws that suck up water and minerals from the soil. They have tiny root hairs (like little fingers) that increase the surface area and help them absorb even more!

Some plants, like carrots and sweet potatoes, also use their roots as storage containers for food!

**The Stem: The Plant's Highway! 🛣️**
The stem is like the plant's backbone - it holds everything up and keeps the plant standing tall. But it's not just for support!

Inside the stem are tiny tubes (like microscopic pipes) that work as a transportation system:
- **Xylem tubes** carry water and minerals UP from the roots to the leaves
- **Phloem tubes** carry food DOWN from the leaves to the rest of the plant

Stems can be soft and bendy (like flowers and grass) or hard and woody (like trees and bushes).

**Leaves: The Food Factories! 🏭**
Leaves are the most important parts for making food! They're like solar panels mixed with a kitchen. Leaves are usually flat and thin so they can catch as much sunlight as possible.

Inside the leaf, something magical happens called photosynthesis (we'll learn more about this in the next chapter!). The leaf uses sunlight, water, and carbon dioxide from the air to make food (sugar) for the whole plant!

Leaves also have tiny holes called stomata that open and close to let gases in and out - like the plant breathing!

**Flowers: The Beauty with a Purpose! 🌸**
Flowers aren't just pretty to look at - they're the plant's baby-making machines! Flowers contain all the parts needed to make seeds:
- **Stamens** (male parts) make pollen
- **Pistil** (female part) contains ovules that become seeds

After pollination happens, the flower transforms into a fruit that protects the seeds!

**Seeds: Baby Plants Waiting to Grow! 🌰**
Seeds are like tiny packages that contain:
- A baby plant (called an embryo)
- Stored food for the baby plant to use when it starts growing
- A protective coat to keep everything safe

When conditions are just right (enough water, warmth, and sometimes light), the seed germinates (sprouts) and grows into a new plant!

**All Parts Work Together! 🤝**
Remember: Each part of the plant is important, and they all depend on each other:
- Roots provide water and support
- Stems transport materials and hold the plant up
- Leaves make food for everyone
- Flowers make seeds
- Seeds grow into new plants

It's teamwork that makes plants survive and thrive!""",
        keyPoints: [
          "Roots: anchor plant + absorb water and minerals",
          "Stem: supports plant + transports water and food",
          "Leaves: make food through photosynthesis",
          "Flowers: reproductive parts that make seeds",
          "Seeds: contain baby plant + stored food",
        ],
        didYouKnow:
            "🌟 Fun Fact: The world's tallest trees (California Redwoods) can grow over 100 meters tall - that's as tall as a 30-story building! Yet they all started from tiny seeds!",
        quizQuestions: [
          QuizQuestion(
            question: "What is the main job of roots?",
            options: [
              "Make food",
              "Anchor plant and absorb water",
              "Make seeds",
              "Catch sunlight",
            ],
            correctAnswer: 1,
            explanation:
                "Correct! Roots anchor the plant in soil and absorb water and minerals that the plant needs!",
          ),
          QuizQuestion(
            question: "Which part of the plant makes food?",
            options: ["Roots", "Stems", "Leaves", "Flowers"],
            correctAnswer: 2,
            explanation:
                "Yes! Leaves are the food factories - they use sunlight, water, and carbon dioxide to make food through photosynthesis!",
          ),
        ],
      ),
      BookChapter(
        title: "☀️ Photosynthesis: Plants' Superpower!",
        content:
            """Get ready to learn about one of the coolest superpowers on Earth - photosynthesis! It's how plants make their own food using just sunlight, water, and air!

**What is Photosynthesis? 🤔**
Photosynthesis is a process where plants capture energy from sunlight and use it to turn water and carbon dioxide (a gas in the air) into glucose (a type of sugar that plants use as food) and oxygen (which they release into the air).

Think of it like a recipe:
**Ingredients**: Sunlight + Water + Carbon Dioxide
**Result**: Glucose (food) + Oxygen

**The Magic Happens in the Leaves! 🍃**
Inside every leaf are millions of tiny cells. And inside those cells are even tinier structures called chloroplasts - these are the photosynthesis machines!

Chloroplasts contain a green pigment called chlorophyll. This is what makes plants green! Chlorophyll is like a solar panel - it captures light energy from the sun and uses it to power the photosynthesis process.

**The Recipe Step-by-Step: 👨‍🍳**

**Step 1 - Gathering Ingredients:**
- Roots absorb water from the soil
- Water travels up through the stem to the leaves
- Tiny holes in the leaves (stomata) open to let carbon dioxide from the air enter
- Chlorophyll in the leaves captures sunlight energy

**Step 2 - The Chemical Reaction:**
Inside the chloroplasts, the sunlight energy is used to split water molecules apart and combine them with carbon dioxide. Through a series of amazing chemical reactions, this creates glucose (sugar)!

**Step 3 - What Happens to the Products:**
- **Glucose** is used by the plant for energy and growth, or stored for later
- **Oxygen** is released into the air as a waste product (lucky for us - we need oxygen to breathe!)

**The Equation (If You Like Science-y Stuff!): 🧪**
Carbon Dioxide + Water + Sunlight Energy → Glucose + Oxygen
(6CO₂ + 6H₂O + Light Energy → C₆H₁₂O₆ + 6O₂)

**Why is Photosynthesis SO Important? 🌍**

**1. Food for the Plant**: It's how plants make their own food! Without photosynthesis, plants would starve.

**2. Food for Us**: We eat plants (fruits, vegetables, grains). Even meat comes from animals that ate plants. ALL food chains start with photosynthesis!

**3. Oxygen for Breathing**: Every breath you take contains oxygen that was made by a plant through photosynthesis! About 70% of Earth's oxygen comes from ocean plants (phytoplankton).

**4. Removes Carbon Dioxide**: Plants take CO₂ out of the air during photosynthesis, which helps keep Earth's atmosphere balanced.

**When Does Photosynthesis Happen? ⏰**
Photosynthesis only happens when there's light! During the day, plants are busy making food. At night, they stop photosynthesizing but continue using the stored glucose for energy to grow and maintain themselves.

On cloudy days, plants still photosynthesize, just more slowly because there's less light energy available.

**What Plants Need to Photosynthesize Well: ✅**
- **Plenty of sunlight**: More light = more food made
- **Enough water**: No water = photosynthesis stops
- **Carbon dioxide**: The stomata need to be open to let it in
- **Healthy chlorophyll**: This requires nutrients from the soil
- **The right temperature**: Too hot or too cold slows it down

**Without Photosynthesis...** 💀
Life on Earth as we know it couldn't exist! No plants would survive, which means no food for animals, no oxygen to breathe, and too much carbon dioxide in the air. Photosynthesis is literally life-giving!""",
        keyPoints: [
          "Photosynthesis = plants making food using sunlight",
          "Needs: sunlight, water, CO₂ → Makes: glucose, oxygen",
          "Happens in chloroplasts (contain green chlorophyll)",
          "Provides food and oxygen for most life on Earth!",
        ],
        didYouKnow:
            "🌟 Fun Fact: A single large tree can produce enough oxygen in one year for two people! That's why forests are called the 'lungs of the Earth'!",
        quizQuestions: [
          QuizQuestion(
            question: "What do plants make during photosynthesis?",
            options: [
              "Water and carbon dioxide",
              "Glucose and oxygen",
              "Chlorophyll and stems",
              "Roots and leaves",
            ],
            correctAnswer: 1,
            explanation:
                "Perfect! Plants make glucose (sugar for food) and oxygen during photosynthesis!",
          ),
          QuizQuestion(
            question: "What makes plants look green?",
            options: ["Water", "Sunlight", "Chlorophyll", "Oxygen"],
            correctAnswer: 2,
            explanation:
                "Correct! Chlorophyll is the green pigment in leaves that captures sunlight for photosynthesis!",
          ),
        ],
      ),
      BookChapter(
        title: "🐝 Plant Reproduction: Making Baby Plants!",
        content:
            """Plants can't walk around to find partners like animals do, but they have amazing ways to make new plants! Let's learn about the fascinating world of plant reproduction!

**It All Starts with Flowers! 🌺**
Flowers are beautiful, but they're not just for looks - they're actually the plant's reproductive organs! Each flower contains special parts for making seeds:

**The Male Parts - Stamens 🎨**
Stamens are usually thin stalks with a knob on top (called the anther). The anther produces pollen - tiny grains that contain the male genetic information. Pollen is like plant sperm!

If you've ever touched a flower and got yellow powder on your finger, that was pollen!

**The Female Parts - Pistil 🌸**
The pistil is usually in the center of the flower. At the bottom of the pistil is the ovary, which contains ovules (these will become seeds). At the top is the stigma, which is often sticky to catch pollen.

**Pollination: The Great Pollen Journey! 🚀**
Pollination is when pollen from one flower reaches the pistil of another flower (or sometimes the same flower). This is the first step in making seeds!

But plants can't move, so how does pollen travel? They get help from:

**1. Insect Pollinators 🐝🦋**
Bees, butterflies, moths, beetles, and even some flies help pollinate! These insects visit flowers looking for sweet nectar to drink. While they're sipping nectar, pollen sticks to their fuzzy bodies. When they visit the next flower, some pollen rubs off onto that flower's stigma!

Flowers have evolved amazing ways to attract pollinators:
- **Bright colors** that insects can see
- **Sweet scents** that smell delicious
- **Nectar** as a reward for visiting
- **Special shapes** that match their pollinator's body

**2. Wind Pollination 💨**
Some plants (like grasses and many trees) don't bother with fancy flowers. They make TONS of very light pollen and just let the wind blow it around! Some of it lands on other plants by chance.

This is why people with pollen allergies have trouble in spring - the air is full of pollen!

**3. Water Pollination 💧**
Some aquatic plants release pollen that floats on water until it reaches another plant.

**4. Bird Pollinators 🐦**
Hummingbirds and some other birds pollinate flowers! These flowers are often red (birds see red well), produce lots of nectar, and have no scent (birds have a poor sense of smell).

**After Pollination: Making Seeds! 🌰**
Once pollen lands on the stigma, something magical happens:

1. The pollen grain grows a tube down through the pistil to the ovary
2. The male genetic information travels down the tube
3. It combines with the ovule (female part) in a process called fertilization
4. The ovule develops into a seed containing a baby plant
5. The ovary grows bigger and becomes a fruit that protects the seed!

**Fruits Help Spread Seeds! 🍎**
Fruits aren't just tasty - they're seed delivery systems! Different fruits spread seeds in different ways:

- **Tasty fruits** (apples, berries, tomatoes): Animals eat them, and the seeds come out in their poop far away!
- **Sticky fruits** (burdock): Stick to animal fur and get carried to new places
- **Flying fruits** (dandelions, maple): Have wings or parachutes so wind carries them
- **Floating fruits** (coconuts): Can float on water to new islands
- **Exploding fruits** (pea pods): Pop open and fling seeds away!

**The Cycle Continues! 🔄**
When a seed lands in a good spot with enough water and warmth, it germinates (starts growing). The baby plant inside uses the stored food in the seed to grow roots, a stem, and leaves. Soon it becomes an adult plant that can make flowers and seeds of its own!""",
        keyPoints: [
          "Flowers have male parts (stamens) and female parts (pistil)",
          "Pollination = pollen reaching the pistil",
          "Pollinators: insects, wind, water, birds",
          "After pollination, seeds form and fruits develop",
          "Fruits help spread seeds to new places",
        ],
        didYouKnow:
            "🌟 Fun Fact: Some plants are super picky! The yucca plant can ONLY be pollinated by one specific type of moth, and that moth can ONLY survive on yucca plants. They depend on each other completely!",
        quizQuestions: [
          QuizQuestion(
            question: "What is the main job of a flower?",
            options: [
              "To look pretty",
              "To make seeds (reproduction)",
              "To make food",
              "To scare away animals",
            ],
            correctAnswer: 1,
            explanation:
                "Correct! Flowers are the reproductive organs of plants - their job is to help make seeds!",
          ),
          QuizQuestion(
            question: "What is a bee doing when it pollinates a flower?",
            options: [
              "Eating the flower",
              "Transferring pollen between flowers",
              "Making honey",
              "Building a nest",
            ],
            correctAnswer: 1,
            explanation:
                "Yes! When bees visit flowers for nectar, pollen sticks to them and they transfer it to other flowers - that's pollination!",
          ),
        ],
      ),
      BookChapter(
        title: "🌱 Other Cool Ways Plants Reproduce!",
        content:
            """Not all plants use flowers and seeds to reproduce! Some plants have developed super clever ways to make copies of themselves. These methods are called vegetative or asexual reproduction!

**What's Asexual Reproduction? 🤔**
In asexual reproduction, plants can make new plants without pollen, flowers, or seeds! The new plant is an exact copy (clone) of the parent plant. It's like the plant making a photocopy of itself!

**Runners: The Traveling Plants! 🏃‍♂️**
Runners (also called stolons) are special stems that grow along the ground horizontally. At certain points along the runner, a new baby plant sprouts and grows roots down into the soil!

**Example**: Strawberry plants are famous for this! One strawberry plant can send out runners in all directions, and each one makes a new strawberry plant. Eventually, the connecting runner dies off, and you have several independent plants!

Spider plants (common houseplants) also make lots of baby plants on runners. You've probably seen them dangling from a parent plant!

**Bulbs: Underground Plant Babies! 🧅**
Bulbs are underground storage structures that look like onions. They're made of thick, fleshy leaves wrapped around a tiny plant in the middle. Bulbs store food for the plant to use later!

Around the main bulb, small baby bulbs (called bulbils or offsets) form. These can be separated and planted to grow new plants!

**Examples**: Onions, garlic, tulips, daffodils, and lilies all grow from bulbs. When you plant one garlic clove, it grows into a whole bulb with many cloves!

**Tubers: The Potato's Secret! 🥔**
Tubers are swollen underground stems that store lots of food (starch). They look like lumpy potatoes... because potatoes ARE tubers!

Have you noticed the "eyes" on a potato? Each eye can sprout and grow into a new potato plant! If you leave potatoes in a dark cupboard too long, they start growing shoots from these eyes.

**How to grow potatoes**: Cut a potato into pieces (each piece needs at least one eye), plant them in soil, and each piece will grow into a whole new potato plant! One potato can become dozens of potatoes!

**Other tubers**: Sweet potatoes, yams, and some other plants also use tubers.

**Cuttings: Growing Plants from Pieces! ✂️**
This is one of the coolest methods! You can cut off a piece of stem, leaf, or even root from a plant, stick it in soil or water, and it will grow roots and become a whole new plant!

**How it works**:
1. Cut a healthy stem from a plant (about 10-15 cm long)
2. Remove the bottom leaves
3. Place it in water or moist soil
4. Wait for roots to grow (usually 2-4 weeks)
5. Once it has roots, plant it in soil!

**Examples**: Many houseplants work great with cuttings - pothos, spider plants, coleus, and succulents. Even some trees like willows can grow from cuttings!

Some plants (like African violets) can grow whole new plants from just a single leaf!

**Grafting: Plant Surgery! 🏥**
Grafting is when you attach part of one plant (called the scion) onto another plant (called the rootstock). The two parts grow together and become one plant!

**Why would you do this?**
- To combine the best traits of two plants
- To grow a plant that produces better fruit
- To help plants survive in poor soil (strong roots from one plant, good fruit from another)
- To repair damaged trees

**Example**: Many fruit trees are grafted! You might have a tree with strong, disease-resistant roots (rootstock) but the top part (scion) is from a tree that makes delicious apples. You get the best of both!

**Layering: Roots While Still Attached! 🌿**
In layering, a stem from a plant is bent down and buried in soil while still attached to the parent plant. The buried part grows roots. Once it has strong roots, you can cut it from the parent and - tada! - you have a new plant!

Blackberry and raspberry plants naturally do this on their own!

**Why Use These Methods? 🎯**
- **Faster than seeds**: You can get a full-sized plant much quicker!
- **Exact copies**: The new plant is identical to the parent (same fruit quality, same flower color)
- **Works for plants that don't make seeds well**: Some plants rarely make seeds or their seeds don't grow well
- **Easy and fun**: You can make lots of plants for free!

**Try it Yourself! 🧪**
Cuttings are super easy to try at home:
- Cut a stem from a pothos, coleus, or spider plant
- Put it in a glass of water on a sunny windowsill
- Change the water every few days
- Watch roots grow in 1-2 weeks!
- Plant it in soil once it has good roots!""",
        keyPoints: [
          "Asexual reproduction = making exact copies without seeds",
          "Runners: stems grow along ground, make new plants",
          "Bulbs & Tubers: underground structures that sprout new plants",
          "Cuttings: grow new plants from stem/leaf pieces",
          "Grafting: attaching parts of two plants together",
        ],
        didYouKnow:
            "🌟 Fun Fact: A single bamboo plant (which spreads through underground runners) can grow into a forest covering many acres - and they're all technically the same plant! Some bamboo forests in Japan are thousands of years old.",
        quizQuestions: [
          QuizQuestion(
            question: "What are the 'eyes' on a potato?",
            options: [
              "Places where new plants can grow",
              "Places where it sees",
              "Rotten spots",
              "Where water enters",
            ],
            correctAnswer: 0,
            explanation:
                "Correct! The eyes on a potato are buds that can sprout and grow into new potato plants!",
          ),
          QuizQuestion(
            question: "What is special about plants grown from cuttings?",
            options: [
              "They grow faster than normal",
              "They are exact copies of the parent plant",
              "They are bigger than normal",
              "They taste better",
            ],
            correctAnswer: 1,
            explanation:
                "Yes! Plants grown from cuttings are genetically identical clones of the parent plant!",
          ),
        ],
      ),
      BookChapter(
        title: "🔬 Investigating Plant Growth Like a Scientist!",
        content:
            """Want to think like a real scientist? Let's learn how to design your own plant experiments and discover what makes plants grow best!

**The Scientific Method for Plant Investigation! 📋**

**Step 1: Ask a Question 🤔**
Every good investigation starts with a question about something you're curious about! Here are some cool questions you could investigate:

- Do plants grow taller in sunlight or shade?
- Does music affect plant growth?
- What type of soil is best for growing tomatoes?
- Do plants grow better with tap water or rainwater?
- How much water do plants need to grow best?
- Does the color of light affect plant growth?
- Do plants grow toward light?

Pick a question that interests YOU - you'll be more excited to find the answer!

**Step 2: Research & Make a Hypothesis 📚**
Before you start experimenting, do some research! Read books, search online (with parent permission), or ask experts what they know about your topic.

Then make a hypothesis - this is your educated guess about what you think will happen and why!

**Example**:
- Question: "Do plants grow taller in sunlight or shade?"
- Hypothesis: "I think plants will grow taller in sunlight because they need light energy for photosynthesis to make food."

**Step 3: Design a Fair Test 🧪**
This is SUPER important! To get reliable results, you must do a FAIR TEST. This means:

**Change Only ONE Variable!** (This is the independent variable - what you're testing)
- If testing light, only change the light
- Keep everything else the SAME (same plant type, same soil, same amount of water, same temperature, same pot size)

**Example Setup for Testing Light**:
- Plant A: Full sunlight (by a window)
- Plant B: Partial shade (indirect light)
- Plant C: Complete darkness (in a closet)
- **Keep the same**: same type of seed, same soil, same pot, same amount of water, same temperature

**Identify Your Variables**:
- **Independent variable**: What YOU change (amount of light)
- **Dependent variable**: What CHANGES as a result - what you measure (plant height, number of leaves, plant health)
- **Controlled variables**: What you keep THE SAME (water, soil, temperature, pot, plant type)

**Use a Control Group**:
This is a plant that gets normal conditions - it's your comparison! All other plants are compared to this one.

**Step 4: Collect Data Carefully 📊**
Now the experiment begins! Here's how to collect good data:

**Make a Data Table**:
Create a table to record your observations. Include:
- Date
- Plant height (measure in cm)
- Number of leaves
- Color (healthy green? yellow? dark green?)
- Notes (anything unusual?)

**Measure Regularly**:
- Take measurements at the SAME TIME each day
- Use the SAME METHOD each time (always measure from soil to top leaf)
- Be as accurate as possible
- Write everything down immediately!

**Take Photos**:
Pictures help you see changes over time!

**Be Patient**:
Good experiments take time! Plan to observe for at least 2-4 weeks.

**Step 5: Analyze Your Results 📈**
After collecting data, it's time to figure out what it means!

**Make Graphs**:
- Bar graphs to compare different groups
- Line graphs to show changes over time
- Graphs make patterns easier to see!

**Look for Patterns**:
- Which plant grew the tallest?
- Which was the healthiest?
- Were there any surprising results?
- Did all the plants in the same condition behave similarly?

**Compare to Your Hypothesis**:
- Was your hypothesis correct?
- If not, why do you think that happened?
- What did you learn?

**Step 6: Draw Conclusions 🎯**
Based on your data, what can you conclude?

**Example Conclusion**:
"Plants in full sunlight grew 15 cm tall on average, plants in partial shade grew 8 cm, and plants in darkness grew only 3 cm and were yellow. This supports my hypothesis that plants need sunlight to grow well because they use light for photosynthesis."

**Consider Limitations**:
- What could have affected your results?
- What would you do differently next time?
- What new questions do you have?

**Step 7: Share Your Findings 📣**
Real scientists share their discoveries! You can:
- Make a poster
- Give a presentation
- Write a report
- Make a video
- Share with your class!

**Plants in Different Habitats 🌍**
Plants have adapted to survive in very different environments:

**Desert Plants 🌵**:
- Need very little water
- Have special features like thick stems (cacti) to store water
- Small or no leaves to reduce water loss
- Deep roots to find underground water

**Rainforest Plants 🌴**:
- Need lots of water and humidity
- Grow well in shade (under the tall trees)
- Have large leaves to catch limited sunlight
- Some grow on other plants to reach sunlight!

**Arctic Plants 🧊**:
- Very short growing season
- Grow low to the ground (protection from wind)
- Can survive freezing temperatures
- Grow and reproduce quickly during short summer

**Aquatic Plants 💧**:
- Live partially or fully in water
- Have special structures to float or anchor
- Can absorb nutrients directly from water
- Some have air pockets in stems to help them float

**Your Experiment Ideas! 💡**
Here are some fun experiments to try:

**Easy**:
- Which liquid makes plants grow best? (water, juice, soda, milk)
- Do beans grow faster in light or dark?
- Can plants grow in different materials? (soil, sand, cotton, rocks)

**Medium**:
- How does fertilizer affect growth?
- Do plants grow toward light (phototropism)?
- What happens if you water plants with salt water?

**Advanced**:
- Does the color of light matter? (use colored cellophane)
- How does crowding affect plant growth?
- Can plants grow without soil? (hydroponics)

Remember: Failed experiments teach us just as much as successful ones! If your results are surprising, that's exciting - you've discovered something new!""",
        keyPoints: [
          "Start with a question and make a hypothesis",
          "Fair test = change only ONE variable at a time",
          "Measure and record data regularly and accurately",
          "Analyze results, draw conclusions, share findings",
          "Different habitats need different plant adaptations",
        ],
        didYouKnow:
            "🌟 Fun Fact: NASA scientists grow plants in space to study how zero gravity affects them! Some astronauts even eat fresh vegetables grown on the International Space Station!",
        quizQuestions: [
          QuizQuestion(
            question: "In a fair test, how many variables should you change?",
            options: ["Zero", "One", "Two", "As many as possible"],
            correctAnswer: 1,
            explanation:
                "Correct! In a fair test, you should only change ONE variable so you know what caused the results!",
          ),
          QuizQuestion(
            question:
                "Why would desert plants need less water than rainforest plants?",
            options: [
              "They don't like water",
              "They adapted to survive with little water",
              "They are smaller",
              "They don't do photosynthesis",
            ],
            correctAnswer: 1,
            explanation:
                "Yes! Desert plants have adapted special features (like storing water, small leaves) to survive in dry environments!",
          ),
        ],
      ),
    ],
  ),
];

final featuredBook = scienceBooks[0];

// Reading progress tracking
Map<String, Set<int>> readingProgress = {};
Map<String, int> bookPoints = {};

// ------------------------------------------------------------------

class ReadScreen extends StatefulWidget {
  const ReadScreen({super.key});

  @override
  State<ReadScreen> createState() => _ReadScreenState();
}

class _ReadScreenState extends State<ReadScreen> {
  String searchQuery = "";
  String selectedCategory = "All";

  int getTotalPoints() {
    return bookPoints.values.fold(0, (sum, points) => sum + points);
  }

  @override
  Widget build(BuildContext context) {
    List<Book> allBooks = [...scienceBooks, ...spaceBooks];
    List<Book> filteredBooks =
        allBooks.where((book) {
          bool matchesSearch =
              book.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
              book.theme.toLowerCase().contains(searchQuery.toLowerCase());
          bool matchesCategory =
              selectedCategory == "All" || book.theme == selectedCategory;
          return matchesSearch && matchesCategory;
        }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFF0D102C),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D102C),
        automaticallyImplyLeading: false,
        title: const Text(
          "📚 READ & LEARN",
          style: TextStyle(
            fontWeight: FontWeight.w900,
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        actions: [
          // Points badge
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFFFC107),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Icon(Icons.star, color: Colors.white, size: 16),
                const SizedBox(width: 4),
                Text(
                  '${getTotalPoints()} pts',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: TextField(
              onChanged: (value) => setState(() => searchQuery = value),
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Search books...",
                hintStyle: const TextStyle(color: Colors.white54),
                prefixIcon: const Icon(Icons.search, color: Colors.white70),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: const Color(0xFF1C1F3E),
              ),
            ),
          ),

          // Category Filters
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children:
                  ["All", "Chemistry", "Biology", "Earth Science"]
                      .map(
                        (category) => Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ChoiceChip(
                            label: Text(category),
                            selected: selectedCategory == category,
                            onSelected: (selected) {
                              setState(() => selectedCategory = category);
                            },
                            selectedColor: const Color(0xFF7B4DFF),
                            backgroundColor: const Color(0xFF1C1F3E),
                            labelStyle: TextStyle(
                              color:
                                  selectedCategory == category
                                      ? Colors.white
                                      : Colors.white70,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                      .toList(),
            ),
          ),

          const SizedBox(height: 10),

          // Featured Book
          if (searchQuery.isEmpty) _featuredBookBanner(context, featuredBook),

          // Fun Fact Card
          if (searchQuery.isEmpty)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF4CAF50), Color(0xFF66BB6A)],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const Icon(Icons.lightbulb, color: Colors.white, size: 32),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      featuredBook.funFact,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          // Books Grid
          if (filteredBooks.isEmpty)
            const Padding(
              padding: EdgeInsets.all(40),
              child: Center(
                child: Text(
                  "No books found",
                  style: TextStyle(color: Colors.white54, fontSize: 16),
                ),
              ),
            )
          else
            _bookGrid(context, filteredBooks),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _featuredBookBanner(BuildContext context, Book book) {
    return GestureDetector(
      onTap: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (ctx) => BookReaderScreen(book: book)),
        );
        if (result == true) setState(() {});
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        padding: const EdgeInsets.all(16),
        height: 150,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF7B4DFF), Color(0xFF9E7CFF)],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                book.image,
                height: 120,
                width: 80,
                fit: BoxFit.cover,
                errorBuilder:
                    (context, error, stackTrace) => Container(
                      height: 120,
                      width: 80,
                      color: const Color(0xFF9E7CFF),
                      child: const Icon(
                        Icons.star,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "⭐ Featured Read",
                    style: TextStyle(
                      color: Color(0xFFFFC107),
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    book.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        color: Colors.white70,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "${book.readTime} min read",
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18),
          ],
        ),
      ),
    );
  }

  Widget _bookGrid(BuildContext context, List<Book> books) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.70,
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return _bookCard(context, book);
        },
      ),
    );
  }

  Widget _bookCard(BuildContext context, Book book) {
    return InkWell(
      onTap: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (ctx) => BookReaderScreen(book: book)),
        );
        if (result == true) setState(() {});
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1C1F3E),
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: Image.asset(
                book.image,
                height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder:
                    (context, error, stackTrace) => Container(
                      height: 160,
                      color: Colors.grey.shade700,
                      child: const Center(
                        child: Icon(
                          Icons.menu_book,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.theme,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: _getThemeColor(book.theme),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    book.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        color: Colors.white54,
                        size: 12,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "${book.readTime} min",
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getThemeColor(String theme) {
    switch (theme) {
      case "Biology":
        return Colors.lightGreenAccent;
      case "Chemistry":
        return Colors.purpleAccent;
      case "Earth Science":
        return Colors.blueAccent;
      default:
        return Colors.white70;
    }
  }
}

// ------------------------------------------------------------------
// --- Interactive Book Reader Screen ---
// ------------------------------------------------------------------

class BookReaderScreen extends StatefulWidget {
  final Book book;

  const BookReaderScreen({super.key, required this.book});

  @override
  State<BookReaderScreen> createState() => _BookReaderScreenState();
}

class _BookReaderScreenState extends State<BookReaderScreen> {
  int currentChapterIndex = 0;
  double fontSize = 16.0;
  bool showKeyPoints = false;
  int currentQuizIndex = 0;
  int? selectedAnswer;
  bool showExplanation = false;

  @override
  void initState() {
    super.initState();
    // Initialize reading progress for this book
    if (!readingProgress.containsKey(widget.book.title)) {
      readingProgress[widget.book.title] = {};
    }
    if (!bookPoints.containsKey(widget.book.title)) {
      bookPoints[widget.book.title] = 0;
    }
  }

  void markChapterAsRead() {
    setState(() {
      if (!readingProgress[widget.book.title]!.contains(currentChapterIndex)) {
        readingProgress[widget.book.title]!.add(currentChapterIndex);
        bookPoints[widget.book.title] = bookPoints[widget.book.title]! + 10;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final chapter = widget.book.chapters[currentChapterIndex];
    final progress = (currentChapterIndex + 1) / widget.book.chapters.length;
    final isChapterRead =
        readingProgress[widget.book.title]?.contains(currentChapterIndex) ??
        false;

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, true);
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0D102C),
        appBar: AppBar(
          backgroundColor: const Color(0xFF0D102C),
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(
            widget.book.title,
            style: const TextStyle(color: Colors.white, fontSize: 16),
            overflow: TextOverflow.ellipsis,
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.text_fields),
              onPressed: () => _showFontSizeDialog(),
            ),
          ],
        ),
        body: Column(
          children: [
            // Progress Bar
            LinearProgressIndicator(
              value: progress,
              backgroundColor: const Color(0xFF1C1F3E),
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFF7B4DFF),
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Chapter completion badge
                    if (isChapterRead)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4CAF50),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: Colors.white,
                              size: 16,
                            ),
                            SizedBox(width: 4),
                            Text(
                              "Completed!",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(height: 10),

                    // Chapter Info
                    Text(
                      "Chapter ${currentChapterIndex + 1} of ${widget.book.chapters.length}",
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      chapter.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Content
                    Text(
                      chapter.content,
                      style: TextStyle(
                        fontSize: fontSize,
                        height: 1.7,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Did You Know Card
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFF6B6B), Color(0xFFFF8E8E)],
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.emoji_objects,
                            color: Colors.white,
                            size: 28,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              chapter.didYouKnow,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Key Points Section
                    ExpansionTile(
                      title: const Text(
                        "🔑 Key Points",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      iconColor: Colors.white,
                      collapsedIconColor: Colors.white54,
                      children:
                          chapter.keyPoints.map((point) {
                            return ListTile(
                              leading: const Icon(
                                Icons.check_circle,
                                color: Color(0xFF7B4DFF),
                                size: 20,
                              ),
                              title: Text(
                                point,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                            );
                          }).toList(),
                    ),

                    const SizedBox(height: 20),

                    // Quiz Section
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1C1F3E),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFF7B4DFF),
                          width: 2,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(
                                Icons.quiz,
                                color: Color(0xFF7B4DFF),
                                size: 28,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "Test Your Knowledge!",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          _buildQuizQuestion(
                            chapter.quizQuestions[currentQuizIndex],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),

            // Navigation Bar
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Color(0xFF1C1F3E),
                border: Border(top: BorderSide(color: Color(0xFF2A2D4E))),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton.icon(
                    onPressed:
                        currentChapterIndex > 0
                            ? () {
                              setState(() {
                                currentChapterIndex--;
                                currentQuizIndex = 0;
                                selectedAnswer = null;
                                showExplanation = false;
                              });
                            }
                            : null,
                    icon: const Icon(Icons.arrow_back),
                    label: const Text("Previous"),
                    style: TextButton.styleFrom(
                      foregroundColor:
                          currentChapterIndex > 0
                              ? Colors.white
                              : Colors.white38,
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "${currentChapterIndex + 1} / ${widget.book.chapters.length}",
                        style: const TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (!isChapterRead)
                        TextButton(
                          onPressed: markChapterAsRead,
                          style: TextButton.styleFrom(
                            backgroundColor: const Color(0xFF4CAF50),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                          ),
                          child: const Text(
                            "Mark Complete +10pts",
                            style: TextStyle(color: Colors.white, fontSize: 11),
                          ),
                        ),
                    ],
                  ),
                  TextButton.icon(
                    onPressed:
                        currentChapterIndex < widget.book.chapters.length - 1
                            ? () {
                              setState(() {
                                currentChapterIndex++;
                                currentQuizIndex = 0;
                                selectedAnswer = null;
                                showExplanation = false;
                              });
                            }
                            : null,
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text("Next"),
                    style: TextButton.styleFrom(
                      foregroundColor:
                          currentChapterIndex < widget.book.chapters.length - 1
                              ? Colors.white
                              : Colors.white38,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuizQuestion(QuizQuestion question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Question ${currentQuizIndex + 1}:",
          style: const TextStyle(
            color: Color(0xFF7B4DFF),
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          question.question,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        ...List.generate(question.options.length, (index) {
          final isSelected = selectedAnswer == index;
          final isCorrect = index == question.correctAnswer;
          Color buttonColor = const Color(0xFF2A2D4E);

          if (showExplanation) {
            if (isCorrect) {
              buttonColor = const Color(0xFF4CAF50);
            } else if (isSelected && !isCorrect) {
              buttonColor = const Color(0xFFF44336);
            }
          } else if (isSelected) {
            buttonColor = const Color(0xFF7B4DFF);
          }

          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: ElevatedButton(
              onPressed:
                  showExplanation
                      ? null
                      : () {
                        setState(() {
                          selectedAnswer = index;
                        });
                      },
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                padding: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Row(
                children: [
                  if (showExplanation && isCorrect)
                    const Icon(
                      Icons.check_circle,
                      color: Colors.white,
                      size: 20,
                    )
                  else if (showExplanation && isSelected && !isCorrect)
                    const Icon(Icons.cancel, color: Colors.white, size: 20),
                  if (showExplanation) const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      question.options[index],
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
        const SizedBox(height: 16),
        if (!showExplanation && selectedAnswer != null)
          ElevatedButton(
            onPressed: () {
              setState(() {
                showExplanation = true;
                if (selectedAnswer == question.correctAnswer) {
                  bookPoints[widget.book.title] =
                      bookPoints[widget.book.title]! + 5;
                }
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF7B4DFF),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              "Check Answer",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        if (showExplanation) ...[
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color:
                  selectedAnswer == question.correctAnswer
                      ? const Color(0xFF4CAF50).withOpacity(0.2)
                      : const Color(0xFFF44336).withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color:
                    selectedAnswer == question.correctAnswer
                        ? const Color(0xFF4CAF50)
                        : const Color(0xFFF44336),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      selectedAnswer == question.correctAnswer
                          ? Icons.celebration
                          : Icons.info_outline,
                      color: Colors.white,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      selectedAnswer == question.correctAnswer
                          ? "Correct! +5 pts"
                          : "Not quite!",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  question.explanation,
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          if (currentQuizIndex <
              widget.book.chapters[currentChapterIndex].quizQuestions.length -
                  1)
            ElevatedButton(
              onPressed: () {
                setState(() {
                  currentQuizIndex++;
                  selectedAnswer = null;
                  showExplanation = false;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7B4DFF),
                padding: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Next Question",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                ],
              ),
            )
          else
            ElevatedButton(
              onPressed: () {
                setState(() {
                  currentQuizIndex = 0;
                  selectedAnswer = null;
                  showExplanation = false;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CAF50),
                padding: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.refresh, color: Colors.white, size: 20),
                  SizedBox(width: 8),
                  Text(
                    "Retry Quiz",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ],
    );
  }

  void _showFontSizeDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: const Color(0xFF1C1F3E),
            title: const Text(
              "Text Size",
              style: TextStyle(color: Colors.white),
            ),
            content: StatefulBuilder(
              builder: (context, setDialogState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Sample Text",
                      style: TextStyle(
                        fontSize: fontSize,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Slider(
                      value: fontSize,
                      min: 12,
                      max: 24,
                      divisions: 12,
                      activeColor: const Color(0xFF7B4DFF),
                      label: fontSize.round().toString(),
                      onChanged: (value) {
                        setDialogState(() => fontSize = value);
                        setState(() => fontSize = value);
                      },
                    ),
                  ],
                );
              },
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "Done",
                  style: TextStyle(color: Color(0xFF7B4DFF)),
                ),
              ),
            ],
          ),
    );
  }
}
