-- phpMyAdmin SQL Dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- Client :  127.0.0.1
-- Généré le :  Jeu 24 Août 2017 à 14:29
-- Version du serveur :  5.7.14
-- Version de PHP :  7.0.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `cards_comparator`
--

DELIMITER $$
--
-- Fonctions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `levenshtein` (`s1` VARCHAR(255), `s2` VARCHAR(255)) RETURNS INT(11) BEGIN
DECLARE s1_len, s2_len, i, j, c, c_temp, cost INT;
DECLARE s1_char CHAR;
-- max strlen=255
DECLARE cv0, cv1 VARBINARY(256);
SET s1_len = CHAR_LENGTH(s1), s2_len = CHAR_LENGTH(s2), cv1 = 0x00, j = 1, i = 1, c = 0;
IF s1 = s2 THEN
  RETURN 0;
ELSEIF s1_len = 0 THEN
  RETURN s2_len;
ELSEIF s2_len = 0 THEN
  RETURN s1_len;
ELSE
  WHILE j <= s2_len DO
    SET cv1 = CONCAT(cv1, UNHEX(HEX(j))), j = j + 1;
  END WHILE;
  WHILE i <= s1_len DO
    SET s1_char = SUBSTRING(s1, i, 1), c = i, cv0 = UNHEX(HEX(i)), j = 1;
    WHILE j <= s2_len DO
      SET c = c + 1;
      IF s1_char = SUBSTRING(s2, j, 1) THEN
        SET cost = 0; ELSE SET cost = 1;
      END IF;
      SET c_temp = CONV(HEX(SUBSTRING(cv1, j, 1)), 16, 10) + cost;
      IF c > c_temp THEN SET c = c_temp; END IF;
      SET c_temp = CONV(HEX(SUBSTRING(cv1, j+1, 1)), 16, 10) + 1;
      IF c > c_temp THEN
        SET c = c_temp;
      END IF;
      SET cv0 = CONCAT(cv0, UNHEX(HEX(c))), j = j + 1;
    END WHILE;
    SET cv1 = cv0, i = i + 1;
 END WHILE;
END IF;
RETURN c;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `brands`
--

CREATE TABLE `brands` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `website` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Contenu de la table `brands`
--

INSERT INTO `brands` (`id`, `name`, `slug`, `description`, `website`, `deleted_at`) VALUES
(1, 'Bicycle', 'bicycle', 'The United States Playing Card Company creates the world’s best playing cards. For over 125 years, they have been called ‘First in Fun’ for bringing people together in the name of good games and great company.', 'http://www.bicyclecards.com/', NULL),
(2, 'Ellusionist', 'ellusionist', 'Ellusionist was founded on January 1st, 2001 by Brad Christian.\n\nHis goal was simple — to create the best online training environment for people who want to learn high-impact, effective magic tricks. Ellusionist\'s growth has been unprecedented.', 'http://www.ellusionist.com/', NULL),
(3, 'Theory11', 'theory11', 'Since 2007, theory11 has propelled forward to become the largest community of magic creators, with over 1,500 registered artists and hundreds of thousands of members around the world.', 'https://www.theory11.com/', NULL),
(4, 'Art of Play', 'art-of-play', NULL, 'https://www.artofplay.com/', NULL),
(5, 'Dan and Dave', 'dan-and-dave', NULL, 'https://www.dananddave.com/', NULL),
(6, 'Steve Minty', 'steve-minty', 'Raised on the mean streets of L.A., Minty has spent all of his life in the pursuit of the arts. So much in fact, that he graduated with a double major BFA in illustration and Awesomeness. With multiple design and illustration awards to his name, Minty is out to dominate the world one design at a time.', 'https://www.steveminty.com/', NULL),
(9, 'David Blaine', 'david-blaine', '“David Blaine is the greatest magician who ever lived.” Howard Stern made that on-air proclamation, a sentiment echoed by Penn Jillette of Penn and Teller, who referred to Blaine’s Street Magic as “the best TV magic special ever done.”', 'https://shop.davidblaine.com/', NULL),
(10, 'Bee', 'bee', 'A premium-quality playing card. Bee brand playing cards are preferred by casinos and industry-professionals alike. Considered more durable than the average paper playing card, Bee brand playing cards can maintain their shape and feel for a longer amount of time, providing increased play and use.', 'http://www.usplayingcard.com/bee/', NULL),
(11, 'Black Ink Playing Cards', 'black-ink-playing-cards', NULL, 'https://blackinkplayingcards.com/', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `cards`
--

CREATE TABLE `cards` (
  `id` int(10) UNSIGNED NOT NULL,
  `brand_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Contenu de la table `cards`
--

INSERT INTO `cards` (`id`, `brand_id`, `name`, `slug`, `description`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 'Standard Index', 'standard-index', 'The Deck that Started It All\n\nDo you remember learning your first card game? How about winning at an old-fashioned game of solitaire? Or that holiday tradition of Gin Rummy after dinner? Since 1885, Bicycle playing cards have been a part of household gaming. Known for its quality and rich heritage, Bicycle® playing cards have been bringing people together for generations.', '2017-05-23 10:34:20', '2017-05-23 10:34:20', NULL),
(6, 1, 'Little Atlantis', 'little-atlantis', 'Bicycle® Little Atlantis is a completely custom deck designed by Devina of Yellow Dice Studio. The aquatic theme features cute sea creatures divided into four suits representing Wisdom (Spade), Power (Club), Love (Heart), and Justice (Diamond). Together they make their little world peaceful and prosperous.\nPrinted by the U.S. Playing Card Co. Limited Edition of 2,500.', '2017-05-24 13:15:54', '2017-05-24 13:15:54', NULL),
(7, 1, 'Bone Riders', 'bone-riders', 'These spooky limited edition playing cards are the perfect way to put the “trick” back in “trick or treat" this Halloween season.\nKids will love the jack o’lanterns, bats and skeletons that dance across the backs of the cards. Adults will appreciate the playful Halloween spin on Bicycle\'s classic Rider Back design. Ghoulish custom illustrations adorn the Joker and Ace of Spades to make this deck a memorable party favor or festive way to celebrate the season at your next card game.\nPackaged inside a festive tuck box featuring premium matte card stock with embossed typography.\nAvailable while supplies last. Printed by the U.S. Playing Card Co.', '2017-05-24 13:15:54', '2017-05-24 13:15:54', NULL),
(8, 1, '8-Bit', '8-bit', 'Inspired by the Bicycle® Rider Back, this unique deck from Home Run Games transforms the entire deck into 8-bit pixel art.\nRelease your inner-nerd. Available in blue and red. Printed by the U.S. Playing Card Co.', '2017-05-24 13:15:54', '2017-05-24 13:15:54', NULL),
(9, 1, 'Chainless', 'chainless', 'Introduced in 1899 as #18 and discontinued in 1917. Bicycle® Chainless was only offered in red or blue and was meant to celebrate the technological advancement made on the bicycle at the turn of the century.\nThe unique tuck case design for this deck was inspired by the back side of the first ever Bicycle® brand product packaging. Originally printed in 1885, the Bicycle® brand has become an American icon, still printing decks 130+ years later. This deck features a vellum tuck stock with embossed elements.\nThis beautiful reproduction was released in 2015 exclusively at Target retail centers across the US. We managed to get ahold of a limited supply and are thrilled to offer them to you now.', '2017-05-24 13:15:54', '2017-05-24 13:15:54', NULL),
(10, 1, 'Peacock Deck', 'peacock-deck', 'The Bicycle® Peacock Deck features the iconic pattern of peacock feathers for a sophisticated yet fun deck of playing cards.\nAvailable in purple and green with a repeating pattern of peacock feathers, this deck makes a subtly stylish addition to your collection.\nThe Peacock Deck features original artwork on the front and backs of the cards, including the Ace of Spades. These decks were printed in the USA at the United States Playing Card Company and printed on premium stock with a quality finish.', '2017-05-24 13:15:55', '2017-05-24 13:15:55', NULL),
(11, 1, 'Leaf Back', 'leaf-back', 'The Leaf Back design was originally released in 1947, making these cards historic as well as holiday-appropriate. This all new Limited Edition reproduction incorporates the original leaf pattern with metallic gold accents.\nPrinted by the United States Playing Card Co.', '2017-05-24 13:15:55', '2017-05-24 13:15:55', NULL),
(12, 1, 'Sideshow Freaks', 'sideshow-freaks', 'This deck is all about a classic sideshow experience. You\'ll see face card characters like the bearded lady, contortionists, fire-breather, sword swallower, lobster boy, and even more on the intricate back. The ring master and monkey round out the deck as the joker cards, all in a tuck that looks like a circus tent.\nThe Sideshow Freaks Deck features original artwork on the front and backs of the cards, including the face cards and jokers. These decks were printed in the USA at the United States Playing Card Company and printed on premium stock with a quality finish.', '2017-05-24 13:15:55', '2017-05-24 13:15:55', NULL),
(13, 1, '130th Anniversary', '130th-anniversary', 'The Wheel No. 1 card back design was originally introduced in 1887. This was one of the first few designs used under the Bicycle® brand name. This design was available in red, blue, green, and brown. It remained in print until 1907, when the three-pronged symbol in the center was replaced with a 4-pronged symbol that made the card symmetrical.\nEvery Bicycle® playing card deck is specially crafted so that you can trust Bicycle® cards performance hand after hand. Great for all card games. Great for all players. Available in both Red and Blue.', '2017-05-24 13:15:55', '2017-05-24 13:15:55', NULL),
(14, 1, 'Aves', 'aves', 'This beautiful deck of playing cards is inspired by birds from all over the world.\nThe name comes from the proper scientific classification for birds. "Aves" is also Latin and Spanish for "Birds."\nThese fine art playing cards were hand drawn by a world-class artist before being turned into digital art prior to being transformed into gorgeous playing cards, just for you.', '2017-05-24 13:15:55', '2017-05-24 13:15:55', NULL),
(15, 1, 'Golden Spike', 'golden-spike', 'A unique set of playing cards by Jody Eklund inspired by the building of the 1st Transcontinental Railroad.\nGolden Spike Playing Cards are inspired by the completion of the 1st Transcontinental Railroad On May 10th, 1869. It was the first rail line that connected the east to the west and revolutionized transportation and commerce in a post Civil War United States. A Golden Spike was created as a commemorative piece to celebrate the completion of the 1st transcontinental railroad and was driven into the ground where the Union Pacific met the Central Pacific Railroad at Promontory Point, Utah. When the hammer rang out and the golden spike was driven into the ground, a new era of industry and expansion rang out across the United States.\nEach playing card deck has been illustrated using a cross hatch technique to mimic the style of engraving and lithographs that were common to the time period. Each card has been researched and given ample time to create and refine each illustration.', '2017-05-24 13:15:55', '2017-05-24 13:15:55', NULL),
(16, 1, 'Frontier', 'frontier', 'Inspired by tales from pioneers of the American Frontier and the wildlife illustrations sketched in their journals as they made their way out west. Bicycle® Frontier playing cards feature a nostalgic design reminiscent of cards from the late 19th century, and capture the vitality of North America\'s wilderness with drawings of animals found across the continent.\nIllustrated by Will Pitney and printed by The United States Playing Card Company.', '2017-05-24 13:15:55', '2017-05-24 13:15:55', NULL),
(17, 1, 'Cupid Back', 'cupid-back', 'A 120-year-old design returns in the 21st century.\nThe Cupid Back Deck was originally introduced to the Bicycle® Brand family in 1894, and continued in production until its discontinuation in 1943. Featuring interlocked wheels with the ever-cycling cherub, this deck makes Cupid the central figure. Now this historic deck makes a return so that collectors and fans everywhere can get the chance to own this original design.\nThe Cupid Back Deck contains original artwork on the back of each card and the tuck. Made in the USA at The United States Playing Card Company on premium stock with a quality finish.', '2017-05-24 13:15:55', '2017-05-24 13:15:55', NULL),
(18, 1, 'Madison Back', 'madison-back', 'This deck is more than just a way to play cards; it\'s practically d̩ecor, inspired by the likes of Jonathan Adler and Vera Bradley. It looks great in your hand and in the tuck, and is available in turquoise or gold.\nThe Madison Deck features original artwork on the front and backs of the cards. These decks were printed in the USA at the United States Playing Card Company and printed on premium stock with a quality finish.', '2017-05-24 13:15:55', '2017-05-24 13:15:55', NULL),
(19, 1, 'Dragon Back', 'dragon-back', 'Each Bicycle® Dragon deck features an intricate, mirror image dragon design on the card backs with vibrant colors, coordinated with face cards.\nThe vintage Bicycle® Dragon design, with attention to detail and vivid color, makes this deck truly unique and one of a kind. Available in three unique color combinations.', '2017-05-24 13:15:55', '2017-05-24 13:15:55', NULL),
(20, 1, 'Tangent Back', 'tangent-back', 'Today we offer a limited supply of Bicycle® Tangent Back playing cards from the Vintage Design series. Printed almost a decade ago at the U.S. Playing Card Company\'s old Cinncinati factory, the edition has been out of print and difficult to find for a few years now. They are blue seal, a mark of nostalgic quality desired by cardicians.\nFor our 25 Days of Christmas promotion, we dug into our collection for a very limited supply to offer you. Today only, they are available again, in both colors, red and blue.\nThe Tangent Back was originally in production from 1907 to 1939 and features intricate details, and includes the original Ace of Spades design from the period.\nThe Vintage Design series revisited several out of print designs from Bicycle\'s vast catalog of past editions. There were several reprinted for the series. The Tangent Back has always been one of our favorites and we\'re happy to offer it up for sale again.', '2017-05-24 13:15:56', '2017-05-24 13:15:56', NULL),
(21, 1, 'Thistle Back', 'thistle-back', 'This Bicycle Vintage Design Series recreates historic Bicycle playing card designs from the last 120 years. Thistle back design: the elves were taken from designs used by the New York Consolidated Company who merged with The United States Playing Card Company.', '2017-05-24 13:15:56', '2017-05-24 13:15:56', NULL),
(22, 1, 'Lumberjack', 'lumberjack', 'Embrace your inner woodsmen with these beautiful Bicycle® Lumberjack inspired playing cards. Custom designed from front to back and printed by the United States Playing Card Company.', '2017-05-24 13:15:56', '2017-05-24 13:15:56', NULL),
(23, 1, 'Robocycle', 'robocycle', 'Who doesn\'t love robots? From the Twilight Zone to C-3PO to Cylons, robots are an iconic part of pop culture. That\'s why Bicycle® Playing Cards created the Robocycle Deck, a one-of-a-kind deck featuring a circuit-inspired back and all-robot court cards. In red, black, gray, and metallic gold, these cards are a unique addition to any collection.\nThe Robocycle Deck contains original artwork on the back of each card, the court cards, the Ace of Spades, and the tuck. Made in the USA at The United States Playing Card Company on premium stock with a quality finish.', '2017-05-24 13:15:56', '2017-05-24 13:15:56', NULL),
(24, 1, 'Steampunk', 'steampunk', 'Steampunk is both a literary sub-genre as well as an artistic, social, and fashion movement. Although the movement gained momentum in the late 1980s, it draws on design elements dating back over 100 years.\nThis unique deck feature pays homage to the movement. Produced by Theory11 for the US Playing Card Co. with Romanian artist Alex Beltechi. Bicycle® Steampunk playing cards are available in both bronze and silver editions. These cards are made to very exacting standards and come in an embossed box with polished metallic contours.', '2017-05-24 13:15:56', '2017-05-24 13:15:56', NULL),
(25, 1, 'Eco', 'eco', '"Go green" with this new environmentally friendly and recyclable deck of cards crafted from sustainable forest paper, starch-based laminating glue, and vegetable-based printing inks. On top of that, the back design and red faces have been replaced with a nice desaturated forest-green color.', '2017-05-24 13:15:56', '2017-05-24 13:15:56', NULL),
(26, 1, 'Rider Back', 'rider-back', 'Still the undisputed king of current popular cards with working professionals, Rider backs are seen in more books, on more videos and DVDs, and in the hands of more top card guys than any other brand. The back design is probably the most recognizable in the world, having been in constant production since 1887. They were originally produced in red, blue, green and brown, but the green and brown decks were dropped in 1927.\nAlthough most magicians mean Rider backs when they say "Bicycles," it is important to note that over 80 different back designs have been made under the Bicycle name. This was the second, the first being the Old Fan backs produced in 1885.', '2017-05-24 13:15:56', '2017-05-24 13:15:56', NULL),
(29, 3, 'NPH Playing Cards', 'nph-playing-cards', 'Neil Patrick Harris Playing Cards are elegant, intricate, and visually stunning. Every aspect was handcrafted with relentless, unrivaled attention to detail.\nWith a combination of artistic influences, NPH Playing Cards are a tribute to Neil\'s love of mystery, magic, games, and theater.\nThe cards feature a custom Ace of Spades, Joker, box design, and modified court card typography. Even the inside of the box has a custom, elegant gold foil pattern.\nPrinted by the U.S. Playing Card Co.', '2017-05-25 13:36:40', '2017-05-25 13:36:40', NULL),
(30, 3, 'Monarchs', 'monarchs', 'An easy contender for the most elegant deck of boutique playing cards currently available, Monarchs are housed in gold foil embossed navy blue boxes. Produced in 2012 by Theory11 and printed on Q1 grade paper by the USPCC, there is little question that Monarchs are fit for a King! A silver edition that is equally beautiful is also available.', '2017-05-25 13:36:41', '2017-05-25 13:36:41', NULL),
(31, 3, 'Citizens', 'citizens', 'Citizens from Theory11 are the most intricate, breathtaking playing cards they\'ve ever produced. Illustrated in America by Kevin Cantrell, every aspect was handcrafted with relentless, unrivaled attention to detail.', '2017-05-25 13:36:41', '2017-05-25 13:36:41', NULL),
(32, 3, 'Union', 'union', 'Patriotic playing cards inspired by American history.\nWithin this unique deck of cards discover iconography of colonial America and patriotic symbols of peace, prosperity, and potential. Union Playing Cards are Made in America, using FSC-certified paper, vegetable-based inks, and starch-based laminates.\nTheory11 in collaboration with artist Jay Fletcher spent over a year developing this deck, every aspect of the design was created from scratch - from the breathtaking court cards to the back design and Ace of Spades.', '2017-05-25 13:36:41', '2017-05-25 13:36:41', NULL),
(33, 3, 'NoMad Playing Cards', 'nomad-playing-cards', 'NoMad Playing Cards were produced in collaboration with The NoMad Hotel in New York City and Theory11. In the 19th century, The NoMad District of New York was the meeting place of the era\'s elite - from Oscar Wilde to Charles Dickens, Mark Twain to Nikola Tesla. The vision was to create a deck of cards that would serve as a monument to The NoMad. The result is a timeless blend of beauty and elegance.\nDesigned by Chad Michael Studio\'s. Produced by Theory11 in collaboration with The NoMad Hotel in New York City. Made in America.', '2017-05-25 13:36:41', '2017-05-25 13:36:41', NULL),
(34, 3, 'MailChimp Playing Cards', 'mailchimp-playing-cards', 'A collaboration between MailChimp, Fuzzco, and Theory11. Sure to satisfy apes and humans alike.\nMailChimp playing cards are a perfect blend of organic elements and iconic imagery - featuring custom court cards and ultra thin borders. Available in vibrant red and deep black.', '2017-05-25 13:36:41', '2017-05-25 13:36:41', NULL),
(35, 3, 'Bad Robot Playing Cards', 'bad-robot-playing-cards', 'Each deck of Bad Robot Playing Cards is sealed with a kraft paper, letterpress wrap that inspires intrigue and endless wonder. Keep it closed, tear it open, or share the experience with a friend. The choice is yours.\nThe Playing cards feature a minimal back design with playful robot characters depicted on each court card.\nDesigned by Bad Robot Production in association with JJ Abrams and Theory11. Printed by the US Playing Cards Co.', '2017-05-25 13:36:41', '2017-05-25 13:36:41', NULL),
(36, 3, 'Rarebit Playing Cards', 'rarebit-playing-cards', 'Inspired by a vintage speakeasy restaurant called The Rarebit in Charleston, South Carolina. The new Copper Edition features copper metallic ink on the card backs and faces, all custom court cards, and elegant, simple design by Jay Fletcher.\nAlso available in a limited gold foil back edition.', '2017-05-25 13:36:42', '2017-05-25 13:36:42', NULL),
(37, 3, 'Tycoon', 'tycoon', 'For this deck, professional magician Steve Cohen teamed up with Theory11 to create a deck of playing cards fit for display at the legendary Waldorf Astoria, the gathering place for royalty and the ultra-wealthy.\nFor the past 14 years Cohen has performed Chamber Magic there, in a private Waldorf Towers suite, for sold-out audiences including Warren Buffett, David Rockefeller, and the Queen of Morocco. In 2012, Cohen became the first magician in a half-century to sell out Carnegie Hall. That said, having his own deck of playing cards seems rather appropriate.\nAvailable in Crimson Red and Ming Blue, the cards are produced in the USA using FSC-certified papers derived from sustainable forests, vegetable-based inks, and starch-based laminates.\nFeaturing court cards licensed from Fournier in Villareal de ÌÛlava, Spain, the Jacks, Queens, and Kings have skin tone faces - joined by an elegant, debonair Joker and Ace of Spades.', '2017-05-25 13:36:42', '2017-05-25 13:36:42', NULL),
(38, 3, 'Medallions', 'medallions', 'A blend of sheer elegance and striking beauty. A timeless object infused with supreme luxury from the Victorian era.\nThe deep brown tuck case features the new ultra-lux matte paper found on our Red Monarchs. It\'s covered top to bottom in a striking gold foil.\nThe design is accented by embossed stitch elements in the front and sealed with a precision printed gold foil sticker seal. It doesn\'t stop there. Theory11 used metallic ink on the back and hand-illustrated custom court cards.\nDesigned in Paris, France by JC Desevre.', '2017-05-25 13:36:42', '2017-05-25 13:36:42', NULL),
(39, 3, 'Charity: Water', 'charity-water', 'You can make a difference. You can save a life. You can change the world.\ncharity: water is a non-profit organization bringing clean and safe drinking water to people in developing nations. Over the past five years, charity: water has raised $50 million and funded 4,282 water projects.\nUnsafe water and lack of basic sanitation kill more people every year than all forms of violence, including war. 30,000 people die every week from unsafe water, and 90% of those deaths are under the age of five. With your support, we can make a difference.\nProceeds from this deck of playing cards go directly to charity: water.\nThese funds will be used to further develop and grow their organization, providing essential support for their operations worldwide. charity: water has already provided water to over 2,000,000 people in 19 countries. On average, each well built costs $5,000 and serves a community of up to 250 people.\nProduced by theory11 and manufactured by The United States Playing Card Company, these are playing cards for a cause. You\'re not just purchasing a deck, you\'re providing a solution to those in need. You\'re leading the way to help end the water crisis.\nDesigned by charity: water in collaboration with theory11, these playing cards are produced using paper made from hydroelectric power and renewable energy sources.', '2017-05-25 13:36:42', '2017-05-25 13:36:42', NULL),
(40, 3, 'Animal Kingdom', 'animal-kingdom', 'Animal Kingdom Playing Cards feature hand-illustrated custom artwork - even the court cards were designed by hand from scratch.\nMade in the USA on FSC-certified paper derived from sustainable forests, starch-based laminates, and vegetable-based inks. Illustrated by Hatch Design in San Francisco for Theory11.', '2017-05-25 13:36:42', '2017-05-25 13:36:42', NULL),
(41, 3, 'Love Me', 'love-me', 'Hand-illustrated playing cards by artist Curtis Kulig.\nCurtis Kulig\'s signature statement \'Love Me\' can be seen in galleries and rooftops around the world, as well as collaborations with major brands including OBEY, Vans, and Urban Outfitters. The message is timeless and universal.\nThe cards feature an original Ace of Spades, Joker, Back Design, Box Design, Sticker Seal, and Ace of Hearts - renamed the Ace of Love. The box is striking, with vibrant red foil accents on premium linen paper.\nPrinted by the U.S. Playing Card Co.', '2017-05-25 13:36:42', '2017-05-25 13:36:42', NULL),
(42, 3, 'DeckONE', 'deckone', 'How could one of the world\'s finest coin magicians design such a fantastic deck of cards? Because Homer Liwag is first and foremost an artist. He created all of the images including the box, back design, Jokers, face cards and the Ace of Spades himself and insisted on using one of the highest grades of paper (Q1 quality) from USPCC. The result is a truly wonderful deck taking inspirations from Homer\'s 30-plus years of design and art experience as well as his unabashed love of a specific series of movies set in a galaxy far, far away.', '2017-05-25 13:36:42', '2017-05-25 13:36:42', NULL),
(43, 3, 'Artisans', 'artisans', 'Designed by South African artist Simon Frouws, Artisans are one of the more ornate decks on the market. No less than David Copperfield has described them as the best playing cards ever produced. Available in both black and white editions, Artisans are beautiful, elegant and made to the highest standards possible by the USPCC.', '2017-05-25 13:36:42', '2017-05-25 13:36:42', NULL),
(44, 4, 'Flourish', 'flourish', 'In collaboration with Column Five comes our first release of 2017. A whisk of original design with a familiar playing card aesthetic, Flourish is a sweet new deck unlike any we\'ve produced before. The bakery theme delights with every card and is sure to leave you wanting more. From the original pink back design to the illustrated court cards and custom faces, Flourish is full of flavor and an irresistible addition to our collection.\nLike fine chocolate, the luxurious packaging is only a hint at the delectable cards inside. The gorgeous tuck case features foil and embossing on a rich paper to excite your senses. Printed by the US Playing Card Co. on our trademark thin-stock preferred by cardists.\nLimited Edition of 2,500. Don\'t miss out on this sweet opportunity to own a pack of Flourish playing cards.', '2017-05-25 13:40:09', '2017-05-25 13:40:09', NULL),
(45, 4, 'Jungle Deck', 'jungle-deck', 'Bursting with vibrant colors and raw animal magnetism, the savage design of this deck was inspired by the lush jungles of Africa. \nEach custom illustrated card features iconic flora and fauna from the Zulu wilderness. Monkeys, parrots and jungle cats run wild throughout the pack. \nThe jungle tuck case was printed on an antique Heidelberg letterpress to give the colors a vintage "washed" look that compliments the eye-catching graphics inside. \nDesigned by Muti in South Africa.', '2017-05-25 13:40:09', '2017-05-25 13:40:09', NULL),
(46, 4, 'ED', 'ed', 'Designed for ED by Ellen, this lovely pack of playing cards showcases a rich black, red and white color pallet with vintage-inspired artwork throughout.\nPrinted by the U.S Playing Card Co. and packaged inside a craft-paper tuck with black foil and embossed accents.', '2017-05-25 13:40:10', '2017-05-25 13:40:10', NULL),
(47, 4, 'Memento Mori', 'memento-mori', 'In this stunning deck designed by Michael Mateyko of KOMBOH CREATIVE, traditional suits have been reimagined to create stars, swords, flies, and feathers: symbols of order, aspiration, chaos, and scavenging respectively. The imagery adorning both the cards and ominous embossed tuck call attention to medieval existentialism, the occult, and divine mathematics; and believe us when we say, when we first saw them we were speechless.\nPrinted by The United States Playing Card Company and packaged inside a custom tuck box featuring foil accents and a unique die-cut window with clear-plastic covering.\nLimited edition of only 2,500 decks.', '2017-05-25 13:40:10', '2017-05-25 13:40:10', NULL),
(48, 4, 'Lost Wax', 'lost-wax', 'Take a step back-in-time to Fifteenth century Africa, a land untouched by the western world. A Nation where arts and entertainment were more than a vehicle of self expression, they were a way of life. \nLost Wax playing cards are a tribute to the West African land of intrigue-kingdoms, where wonder was traded in place of gold.\nThis unique deck designed by Olutade Abidoye features a vibrant color palette and back-design that emulates gorgeous tapestries from the era. In addition, art connoisseurs and history buffs alike will delight in a set of custom court cards that honor native paintings and etchings of the period.\nPrinted by the U.S. Playing Card Co. and packaged inside a custom box featuring gold foil and embossed accents. ', '2017-05-25 13:40:10', '2017-05-25 13:40:10', NULL),
(49, 4, 'Odd Bods', 'odd-bods', 'When they first appeared in 2012 for the exclusive enjoyment of members of the prestigious Folio Society, the design world fell in love. Odd Bods were playful, charming, elegant, and above all else, a joy for the eyes.\nToday they are so much more.\nWe’re pleased to offer the new Odd Bods featuring an all-new back design and gold-foil embossed box. Each playing card, hand illustrated by Jonathan Burton, is nothing short of stunning. Every image proves its own quirk and oddity, but is never ostentatious-- Odd Bods are the epitome of refined indulgence.\nPrinted by the U.S. Playing Card Co.', '2017-05-25 13:40:10', '2017-05-25 13:40:10', NULL),
(50, 4, 'Cardistry-Con 2016', 'cardistry-con-2016', 'Meet the official 2016 deck of Cardistry-Con playing cards. Designed in collaboration with Benji Taylor of Next Exit. The result is truly unique. Printed on a premium stock with thin borders and metallic inks. The cards feature a custom back design and Ace of Spades with standard court cards in a complementary color palette.\nMade exclusively for the backers and attendees of Cardistry-Con in Berlin Germany. As a sponsor of the event we are excited to offer a limited supply. Don\'t miss out! Own history and commemorate the 3rd annual Cardistry-Con with this unique deck of playing cards.', '2017-05-25 13:40:10', '2017-05-25 13:40:10', NULL),
(51, 4, 'DKNG Playing Cards', 'dkng-playing-cards', 'Created in partnership with California based creative studio, DKNG Playing Cards offer a fresh interpretation of the classic Bicycle Rider Back. The updated design is crisp and playful in both red and blue.\nFeaturing 54 custom illustrated playing cards printed by the US Playing Card Co. on our trademark thin-stock preferred by cardists. Housed inside a foil-stamped and embossed tuck case.', '2017-05-25 13:40:10', '2017-05-25 13:40:10', NULL),
(52, 4, 'Third Man Records', 'third-man-records', 'In collaboration with Third Man Records, we are excited to offer a unique set of playing cards designed by the creative hive behind the independent record label founded by Jack White in Detroit, Michigan.\nThis fully-custom deck comes encased in a beautifully printed black-on-black tuck case, embossed with foil accents that looks like a record.\nThe cards feature a borderless back-design and an all black background with yellow, grey and white accents throughout the deck.\nPrinted at the US Playing Card Co. in 2015.', '2017-05-25 13:40:10', '2017-05-25 13:40:10', NULL),
(53, 5, 'AVIATOR® Heritage Ed.', 'aviator-heritage-ed', 'A century ago man first soared into the clouds and reached beyond the impossible. Today, we venture further skyward and invite you aboard as a classic is reimagined.\nIntroduced in 1927 to commemorate Charles Lindbergh\'s transatlantic flight aboard the Spirit of St. Louis, AVIATOR® Playing Cards have been available in stores around the world ever since.\nNearly 90 years after their initial release, we\'re proud to present a new edition of AVIATOR® playing cards, inspired by Howard Hughes. Hughes, the pioneering airman of the 20th century, turned his H-1 racer into a beacon of innovation as it flew across the night sky. Within the vintage tuck-case, each card features Hughes\'s racer, high above the earth -- boldly exploring all places unknown. So grab a pack, strap in, and come fly with us.\nClassically designed by D&D in collaboration with the US Playing Card Co. AVIATOR® Heritage Edition are a timeless tribute to the iconic brand.', '2017-05-25 13:40:10', '2017-05-25 13:40:10', NULL),
(54, 4, 'Alice in Wonderland', 'alice-in-wonderland', 'These limited edition playing cards, designed by Steven Watson of Turnstyle, are inspired by Lewis Caroll\'s classic fairy tale.\nModern styling combined with lavish Art Nouveau and Art Deco ornamentation transport us down the rabbit hole to a surreal world presided over by the Queen of Hearts.', '2017-05-25 13:40:10', '2017-05-25 13:40:10', NULL),
(55, 4, 'Revelation Deck', 'revelation-deck', 'Inspired by medieval cathedrals, this hand-illustrated deck features gothic details from the catacombs, and beautiful stained glass ornamentations.\nIn tribute to the hand-drawn blueprints sketched by Medieval builders, Revelation is entirely illustrated with a fine-tipped ink pen and the simplest of universal color palettes: Crimson as blood. Black as iron. White as virgin snow.\nAs a crisp, contemporary take on the grandeur of bygone cathedrals, Revelation contains all the opulence of the Medieval church and the minimalism of the workmen and monks who lived their whole lives toiling and never saw the fruits of their labors.\nIn addition to an original box, joker, ace of spades, and back design - all inspired by cathedral stained glass - Revelation also features fully custom skeleton court cards, an homage to the silent skeletons of Norwegian royalty still resting in Nidaros catacombs.', '2017-05-25 13:40:11', '2017-05-25 13:40:11', NULL),
(56, 4, 'Prime Playing Cards', 'prime-playing-cards', 'Prime Playing Cards is our first custom deck designed and illustrated by Ben Newman in the United Kingdom. Using only primary colors and simple shapes, this deck is striking and simple.\nThe borderless design is ideal for Cardistry techniques such as card fans and display cuts, something our founders know a thing or two about.\nTurn the deck over and you will find a collection of custom illustrations featuring minimal court cards designed from nothing more than shapes and colors.', '2017-05-25 13:40:11', '2017-05-25 13:40:11', NULL),
(57, 4, 'Flesh & Bones', 'flesh-bones', 'Flesh & Bones is a completely custom, hand illustrated deck of playing cards, designed in London by Dual Originals.\nEach card has been rigorously designed to create a unique deck that combines digital precision with illustrative flair.\nThe court cards feature detailed, hand-drawn illustrations based on mythical creatures like the Kraken and a Nymph, and ancient gods, such as Triton and Medusa.\nDesigners, Chris and Marylou have always had a passion for the weird and wonderful and wanted to express their take on it through this deck.\nContrastingly, the tuck box and back designs are precise and minimal, consisting of illusional line patterns and geometric shapes.', '2017-05-25 13:40:11', '2017-05-25 13:40:11', NULL),
(58, 4, 'Borderline', 'borderline', 'If you\'re looking for adventure, open a pack of Borderline Playing Cards, start the Gran Torino, and gun it south. Roads become dirt paths, and the lone and level sands stretch far away. The wind howls, and lines etched in the ground by countless boot-heels disappear as two worlds intermingle and dance to the songs of years past.\nCreated by Triana Design, Borderlines were produced to celebrate the rich and vibrant cultures on both sides of the US-Mexico border. Every tuck-case has been specially crafted to feature distinct gold-foil embossing on a brown backdrop. The results are nothing short of phenomenal. In addition, each deck boasts 26 custom illustrations that encapsulate both worlds beyond the borders.\nSo pack a bag, crack open a deck of Borderlines, and head south for the winter.', '2017-05-25 13:40:11', '2017-05-25 13:40:11', NULL),
(59, 4, 'Thick Lines', 'thick-lines', 'Aaron\'s Thick Lines hypnotically transport us to an atmosphere that smells like Boogie Nights, American Hustle, funky disco music, thick lapels and lot\'s of partying.\nA playful design that almost spits out waves of funky sound when you shuffle, cut, and deal.\nBorderless and soulful, allows for beautiful card fans and ribbon spreads, making every card blend into an indefinite number of different patterns. As an added bonus, they also match your favorite seventies disco wallpaper or the most ridiculous print button down shirt you\'ve never worn.\nAaron Draplin is a beast and this is one of our new favorite decks. It looks beautiful in motion for cardistry, but it also goes well next to a half-full glass of bourbon at the poker table. An instant favorite.\nDraplin completely revamped all the face cards by incorporating his obsession with THICK LINES while staying true to the classic design of modern playing cards. We think they look fan-tastic!\nWhether you use this playing card set for passing hard time, card houses, throwing, cardistry, loose magic, dimwitted cons, shuffling stunts, solitaire, poker, war, euchre, gin rummy, go fish, blackjack, pinochle, spoke flickers or sketchy sleights of hands, Aaron Draplin has one thing to offer, Good Luck!', '2017-05-25 13:40:11', '2017-05-25 13:40:11', NULL),
(60, 4, 'DeckStarter® Brand Deck', 'deckstarter-brand-deck', 'Promotional deck for DeckStarter*, a platform that allowed designers to create their own playing cards.\nBack in 2012 when we began working on the concept of DeckStarter we designed and printed an exclusive deck of brand playing cards. Only a limited number was printed and once they sell out here they will be gone forever.\n*DeckStarter launched in 2013 with a mission to offer a dedicated funding platform for custom designed playing cards. Supported by friends, fans and the public, it was the easiest way to get your own deck into the hands of playing card enthusiasts all over the world. With the help of the community, they successfully funded 7 original decks of playing cards. In January 2015 we decided to close DeckStarter in order to focus our attention on Art of Play.', '2017-05-25 13:40:11', '2017-05-25 13:40:11', NULL),
(66, 5, 'DTS Playing Cards', 'dts-playing-cards', 'Produced exclusively for Avant Card: The Sights and Sounds of Cardistry, a video collaboration between DTS and Dan & Dave, and also featuring Andrew Avila. The project showcases abstract cardistry and visuals mixed with DTS Headphone:X technology for the first ever immersive cardistry experience. \nThe cards, as used in the video, feature a minimal back design incorporating the DTS brand icon. Printed by the United States Playing Card Company to Dan and Dave\'s expert specifications with their trademark crushed paper for a super-thin stock preferred by cardists.\nIn addition to being used in the video by Dan, Dave and Andrew, the cards were handed out during the world premiere after-party. Only a limited number of them remain and will not be reprinted.', '2017-05-25 13:47:49', '2017-05-25 13:47:49', NULL),
(67, 5, 'MAKERS', 'makers', 'Luxury playing cards made true by The D&D Playing Card Co. MAKERS are the most intricate and luxurious deck in their catalogue.\nEach tuck case has been embossed and stamped with layers of gold-foiling. The result is nothing short of breathtaking. Out of the box, conjurors and collectors alike will enjoy 14 custom illustrated court-cards representing the foundational “makers” civilization has been built on. To us, these individuals are the pillars of unparalleled craftsmanship: something that we hold in the highest regard. MAKERS are both a tribute and a celebration.\nPrinted by the U.S. Playing Card Co. using an exclusive “crushed stock” process to create a more refined and lighter deck of playing cards.\nFor the diehard collector, enjoy 1 of 500 limited edition box sets crafted from solid oak lined with leather and finished with antique hardware that features a working lock and key. Available exclusively at dananddave.com.', '2017-05-25 13:47:49', '2017-05-25 13:47:49', NULL),
(68, 5, 'Sons of Liberty, Patriot Blue', 'sons-of-liberty-patriot-blue', 'A time before the United States existed, a time when we were subjects of a King across an ocean. The Sons of Liberty operated in the shadows, leaving secret signals, passing hidden messages, and meeting in the dead of night. However, people soon rallied with them, and their cause to resist British oppression quickly spread throughout the colonies.\nJoin us as we commemorate this first group of Patriots with the return of our acclaimed Sons of Liberty Playing Cards in an all new colorway. The tuck box is among the most exquisite we\'ve ever produced, featuring sculptural embossing in both bronze and pewter foil. The cards themselves feature a plethora of masonic imagery, a Liberty Tree ace of spades, and a tax stamp seal. A handful of the Son\'s most patriotic members are represented on the court cards in 18th century style etching. Furthermore, the stock itself has undergone our unique crushing procedure, in order to guarantee a thin and snappy deck that handles magnificently.\nFor the revolutionary, the history buff, or the everlasting patriot, these cards are a necessity in the hands of those who raise the flag and embody the spirit of a better tomorrow.', '2017-05-25 13:47:49', '2017-05-25 13:47:49', NULL),
(69, 5, 'Vintage Plaid, Arizona Red', 'vintage-plaid-arizona-red', 'By far one of our favorite decks, Vintage Plaids have become a staple in every card man\'s collection, and has been highly sought after since we sold out years ago. Inspired by our camping trips as children, each deck pays homage to the great outdoors. We\'re proud to say that while the original Vintage Plaids hold a special place in our hearts, our new updated design of the deck takes the cake. They are something to behold.\nEach deck features a brand new embossed box complete with gold-lettering, and in addition, all around back-design printing within. Not only have we recreated the box, but we\'ve gone a step further and created an all new Ace of Spades along with two Jokers. If this wasn\'t enough, we raised the bar even further and included an all new typeface that adds a sleek component to the deck\'s already rugged yet refined feel.\nThe new Vintage Plaids change the game of playing card design, and for that we recommend you act quickly as these are bound to go fast.\nMasterfully printed by the United States Playing Cards Company on our trademark "Thin Stock."', '2017-05-25 13:47:49', '2017-05-25 13:47:49', NULL),
(70, 5, 'Hollingworths, Emerald Ed.', 'hollingworths-emerald-ed', 'Designed by Guy Hollingworth and printed by D&D exclusively for The Hollingworth Collection. Until now, this classy deck of playing cards, inspired by Art Deco, has not been made available on its own outside the Collection.\nIn addition to the metallic gold foil printing the cards feature a unique quality that, as far as we know, has never been done before. The deck is an astonishing eight cards thinner than a standard deck of Bicycle playing cards yet manages to maintain the same "snappy" quality of traditional playing cards.', '2017-05-25 13:47:49', '2017-05-25 13:47:49', NULL),
(71, 5, 'Antler Limited Edition', 'antler-limited-edition', 'Born from the wild forests, rolling hills, and snow-capped mountains of Northern California, the Antler Playing Cards showcase the majestic beauty of the great outdoors.\nThis Limited Edition features two fully colored back-designs: Hunter Green and Deep Maroon. The attention to detail in both hand illustration, coloring, and presentation are extraordinary. Twin Bucks are enshrined within beautiful flourishes that mimic the lush greenery found within Yosemite National Park. The Ace of Spades features a noble Buck with herbaceous ornamentation crowning his dignified antlers, and each Joker offers the Antler name.\nEach Limited Edition deck is hand-wrapped in parchment paper before boxing and is sealed within by a perforated stamp for easy opening.\nThe composition of both the cards and box marries the spirit of Nature with the substance of Modernity. Whether they\'re in a canvas tent or a chalet nestled in the valley, they\'re essential in the pockets of anyone who seeks adventure.\nPrinted by The USPCC to our specifications.', '2017-05-25 13:47:50', '2017-05-25 13:47:50', NULL),
(72, 5, 'Antler Playing Cards', 'antler-playing-cards', 'Born from the wild forests, rolling hills, and snow-capped mountains of Northern California, the Antler Playing Cards embody the majestic beauty of the great outdoors.\nThis Standard Edition features two monochromatic back-designs: Hunter Green and Deep Maroon. Twin Bucks are enshrined within beautiful flourishes that mimic the lush greenery found within Yosemite National Park. The Ace of Spades features a noble Buck with herbaceous ornamentation crowning his dignified antlers, and each Joker offers the Antler name. The tuck-case features rich embossing and metallic accents all around.\nEach deck handles beautifully, but we encourage you to embrace them as much for their superb handling as for the sense of adventure that they inspire. These are as perfect for formal performance as they are for an evening enjoyed around the campfire.\nPrinted by the USPCC to our specifications.', '2017-05-25 13:47:50', '2017-05-25 13:47:50', NULL),
(73, 5, 'Voltige', 'voltige', 'After over two years of production, you can now wander down the Champs-elysées with a pack of our Voltige playing cards in hand. Designed in collaboration with Henri de Saint Julien & Jacques Denain, the creators behind Tungstene, a deck that\'s become not only a rarity, but a paragon in the collections of those lucky enough to own a pack. We are confident that in the same way as its fabled predecessor, Voltige will quickly become a modern classic.\nVoltige, a name stemming from the french word for aerial often used to describe the apex gesture of a flourish, is a true testament to our creative ingenuity and drive to constantly push the boundaries of custom playing cards. Not unlike Georges Haussmann\'s reconstruction of the streets of Paris, each deck features a design that\'s innovative, modern, and exceptionally bourgeois.\nThe back design is a display of two separate hands working in tandem to reach a singular goal. To us, this is the epitome of not only our life story, but of our brand as a whole. Today we work in tandem to bring you the next chapter in the future of playing cards.', '2017-05-25 13:47:50', '2017-05-25 13:47:50', NULL),
(74, 5, 'Ultimate Deck', 'ultimate-deck', 'The Ultimate Deck is a one-of-a-kind, luxury deck of playing cards showcasing stunning works of art on every card. Produced in collaboration with award-winning design firm, Stranger & Stranger.\nThe Ultimate Deck features 54 unique works of art, each with an elaborate back design. Every single card in the Ultimate Deck is represented with a story, incorporating classical art, as well as works from todays leading illustrators.\nPackaged in a gorgeous tuck-case of extraordinary detail featuring embossed elements and foil accents. Each deck is carefully packaged and sealed with a vintage-inspired tax stamp.', '2017-05-25 13:47:50', '2017-05-25 13:47:50', NULL),
(75, 5, 'Smoke & Mirrors', 'smoke-mirrors', 'Back by popular demand, the entire selection of Smoke & Mirror Playing Cards available now for individual purchase.\nSmoke & Mirrors brand playing cards were designed to be a personal deck for Dan and Dave. They were custom tailored to their taste with original art by Si Scott. That was back in 2007. The cards quickly sold out so they printed more, and more, and more. Eventually they changed the color and altered the design to fit their minimal style. For five straight years they released a new "version" of the brand until 2012 when they decided to revamp the entire series and release them all in a limited edition box set.', '2017-05-25 13:47:50', '2017-05-25 13:47:50', NULL),
(76, 5, 'Vintage Plaid, 1st Printing', 'vintage-plaid-1st-printing', 'Similar in design to the recently reprinted Vintage Plaid, Arizona red. These older editions were printed in 2012.\nAvailable in Striking Arizona Red and Casual California Blue, our Vintage Plaid playing cards offer themselves as the missing piece in every gentleman\'s rucksack. Although perfect for everyday use, Vintage Plaid begs to accompany you in all aspects of adventure. Whether it be traversing great rivers, hunting big game, or traveling into the strange, no journey is complete without a pack on hand. So pull up a seat to the fire, pour yourself a drink, and remember, Bad luck is bad play.\n"For us, these cards bring back fond memories of childhood camping trips with our grandfather. Watching him pitch a tent, reel in a fish, and bring fire ablaze under a starry night were magical moments we never forgot. In honor of those days by the river and nights under the stars, we are proud to offer these new playing cards."\nPrinted by the US Playing Card Company on premium stock with a cambric finish. Incorporating a leatherette tuck case, off-white faces, and an organic array of colors, no detail has been spared. Packaged in a bespoke carton for orders of a dozen or more.', '2017-05-25 13:47:50', '2017-05-25 13:47:50', NULL),
(77, 5, 'Fantastique', 'fantastique', 'Fantastique is a beautiful deck of playing cards inspired by the apparatus of magic\'s golden age and the automatons of Robert-Houdin. It also happens to hold a secret of its own.\nWhen the cards are riffled through like a flip book, the illustrations come to life, animating two of magic\'s most famous illusions. An orange tree blossoms from an acrobats top hat while a women, having been sawed in half, is pulled apart.\nDesigned by Sveta Dorosheva, each illustration was meticulously altered to achieve the spectacular animation. Accompanied by two unique Jokers and The Turk, a mechanical chess player from the 18th century whom many believed possessed artificial intelligence, represented on the Ace of Spades.\nNever before has the mystique of magic been showcased on a deck of cards like this. A wonderful tribute to the art and a fun addition to your collection.', '2017-05-25 13:47:50', '2017-05-25 13:47:50', NULL),
(78, 4, 'Red Stripe', 'red-stripe', 'From LA based designer and magician Omar Renfro we are excited to offer his debut deck, Red Stripe playing cards. Inspired by the work of Pablo Picasso each card was hand-drawn before being digitally cleaned-up and presented in its final rendering shown here.\nThe design comes from the concept of wanting a bold solid stripe in the middle to accent the dynamic movements in cardistry. \n"The deck is fully customized from the geometric back design to the custom arrangement of the spot cards, right down to the custom court cards and jokers. Even the tuck interior is customized!"\nPrinted in Taiwan by the Hanson Chien Playing Card Co.', '2017-05-25 13:58:43', '2017-05-25 13:58:43', NULL),
(79, 4, 'The Three Little Pigs', 'the-three-little-pigs', 'Inspired by the classic fable, The Three Little Pigs playing cards borrow from the tale’s lesson on diligence with an ornate design that feels as timeless as the story. Produced by Pure Imagination Projects and designed by Joe White of Ye Olde Studio.\nFeaturing original hand-drawn artwork, The Three Little Pigs playing cards were printed by the U.S. Playing Card Co. in a limited edition of 2,500. Be ware of the big bad wolf.', '2017-05-25 13:58:43', '2017-05-25 13:58:43', NULL),
(80, 4, 'EDGE Playing Cards', 'edge-playing-cards', 'Designed in Prague by the extremely-popular design agency Creative Mints, known for their beautiful and user-orientated graphic style.\nTheir latest project, EDGE Playing Cards, produced by the TCC Playing Card Co. brims with an aura of creativity and ingenuity. The design is all but a simple array of colorful shapes that have been organized into a graphically pleasing pattern that just feels right. \nEvery single card in EDGE has been designed from the ground-up and the court cards are some of our favorite to date. \nPrinted by the U.S. Playing Card Co.', '2017-05-25 13:58:43', '2017-05-25 13:58:43', NULL),
(81, 4, 'Flora', 'flora', 'After the well received, and now sold out, Casual playing cards released last year Paul Robaia is back with another original deck. Flora offers a vibrant floral design featuring a Hawaiian-style bouquet of flowers and leaves against a tropical colorway that is sure to brighten up any situation, whether it be a friendly game of Go Fish at the beach or in your next cardistry video.\nLimited Edition of 2,500. Printed by the US Playing Card Co.', '2017-05-25 13:58:43', '2017-05-25 13:58:43', NULL),
(82, 4, 'Les Méliès: Voyagers Ed.', 'les-melies-voyagers-ed', 'This unique deck of playing cards was inspired by the iconic film A Trip to The Moon directed by the French filmmaker and magician George Méliès. \nLes Méliès: Voyagers Ed. playing cards were designed and produced by Derek Mckee and Michael Blau. Features include a custom back design, ace of spades and two jokers.\nLimited Edition of 1,111. Printed in Taiwan by Legends Playing Card Co. ', '2017-05-25 13:58:44', '2017-05-25 13:58:44', NULL);
INSERT INTO `cards` (`id`, `brand_id`, `name`, `slug`, `description`, `created_at`, `updated_at`, `deleted_at`) VALUES
(83, 4, 'Vanda, Violet Edition', 'vanda-violet-edition', 'Vanda is the only rotationally symmetric deck of playing cards ever designed - every single card looks exactly the same right-side-up as it does upside-down.\nPrinted by the US Playing Card Co. Limited Edition of 2,500 decks printed.', '2017-05-25 13:58:44', '2017-05-25 13:58:44', NULL),
(84, 4, 'Sleepy Hollow', 'sleepy-hollow', 'In 1820 American author Irving Washington first published his short story The Legend Of Sleepy Hollow. Nearly 200 years later, this story continues to resonate around the world as one of the most popular American fiction stories of all time and is now captured in this beautifully illustrated deck of custom playing cards.\nOver a year in the making, The Legend Of Sleepy Hollow Playing Cards were conceived by playing card designer Derek McKee and masterfully illustrated in France by J.C. Desevre. This incredibly intricate and detailed deck of playing cards depicts artwork and characters from the famous Sleepy Hollow legend including Ichabod Crane & the Headless Horseman.\nFrom the brilliant gold metallic inks to the custom court cards, this deck captures the true essence of The Legend of Sleepy Hollow.', '2017-05-25 13:58:44', '2017-05-25 13:58:44', NULL),
(85, 4, 'Les Printemps', 'les-printemps', 'Our dear friends Laurel Brandstetter and Ricky Smith created these cards as a tribute to Robert-Houdin in celebration of their wedding. Originally produced as wedding favors, only a small number of Les Printemps playing cards are now being offered to the public.\nRobert-Houdin was the father of modern magic and is known for many original inventions. One of his most famous is the Orange Tree, a marvelous illusion in which an orange tree blossoms and then gives fruit right before your eyes. The effect ultimately reveals a borrowed ring inside one of the oranges, and is what inspired the way in which Ricky proposed to Laurel.\nLes Printemps playing cards were designed by Mika Machida for Ricky (King of Hearts) and Laurel (Queen of Hearts) and feature a charming illustration of the Orange Tree illusion and a facsimile of Robert-Houdin\'s signature.\nPrinted by The Expert Playing Card Company.', '2017-05-25 13:58:44', '2017-05-25 13:58:44', NULL),
(86, 4, 'Mustache Playing Cards', 'mustache-playing-cards', 'In celebration of Movember we are thrilled to offer this whimsical 4-color deck featuring mustaches on every pip - perfect for poker, bridge, or any other standard card games. Produced by Vanda Cards and backed by Kickstarter this limited edition deck won\'t be around for long so pick one up while you still can and join the Movember movement!', '2017-05-25 13:58:44', '2017-05-25 13:58:44', NULL),
(87, 4, 'A.Bandit', 'abandit', 'These playing cards were produced by art collective A.Bandit (Derek DelGaudio and Glenn Kaino) for their show, The Space Between, in 2011. The back design is based on a sketch by Ren̩ Descartes, which illustrated the phenomenon of Alexander\'s band, the space between a double rainbow.\nOriginally these cards were only available at their show, however, a small supply of them were eventually distributed and quickly sold out. In 2012, they were featured in Dan and Dave\'s Variety Box, a curated collection featuring 12 of the finest decks of playing cards in the world.', '2017-05-25 13:58:44', '2017-05-25 13:58:44', NULL),
(88, 4, 'Arrco® U.S. Regulation', 'arrco-us-regulation', 'Although historically not as highly regarded as the Tahoe No. 84 decks, the Arrco® U.S. Regulation cards are an excellent card favored by several famous magicians. These cards were usually produced with a full color Joker and a black and white Joker. Other than color, the Jokers were identical. Most of the decks seen today still say Arrco on the boxes, even though the company was acquired by USPCC in the late 1980s.\nPrinted in Cincinnati, Ohio at the old USPCC factory.', '2017-05-25 13:58:44', '2017-05-25 13:58:44', NULL),
(89, 4, 'Arrco® Tahoe', 'arrco-tahoe', 'In the late 1970s and early 1980s the Arrco® Tahoe\'s were some of the finest cards available anywhere in the world. \nWhen USPCC purchased Arrco® in the late 1980s, production of Arrco® cards ceased. They became highly sought-after collectibles and still command high prices on the secondary market. A few years ago, the Tahoe back design was faithfully reproduced by a private company. Get them while you can.', '2017-05-25 13:58:44', '2017-05-25 13:58:44', NULL),
(90, 4, 'A Typographer\'s Deck', 'a-typographers-deck', 'In collaboration with Turkish artist Furkan Şener we are pleased to present A Typographer\'s Deck. This unique deck of playing cards features 54 custom playing cards represented through the art of typography. The detailed back design and easy-to-read pips ensure that game play is both practical and fun. Packaged inside a matching tuck case.\nLimited Edition of 2,500. Printed by the U.S. Playing Card Co.', '2017-06-13 07:28:28', '2017-06-13 07:28:28', NULL),
(92, 9, 'Black Lions', 'black-lions', 'We are proud to introduce The Black Lions, printed on the highest-quality stock the United States Playing Card Company offers. \nOur soft-touch box features a two-tone black finish and silver foil stamping on top of a fully detailed quality embossing.  Each deck contains a number of hidden features that are greatly enhanced by the new design.', '2017-07-30 00:18:05', '2017-07-30 00:18:05', NULL),
(93, 9, 'White Lions', 'white-lions', 'The Series B White Lions are a product of nearly a year\'s worth of collaboration with the United States Playing Card Company. Numerous factors are considered when creating a deck of playing cards, including printing press type, paper moisture, card stock, and embossing pressure. No expense was spared in creating Series B, as is evident the moment they are in your hands.\n\nOur box design includes silver foil stamping, detailed embossing, and a matte white finish never before seen on any deck of cards.  Due to the difficult and time-consuming process required to print and package this new box paper type, the USPC is no longer able to provide this finish.  The cards themselves are printed on the highest quality stock to produce a feel so good you won\'t want to put them down.', '2017-07-30 00:21:08', '2017-07-30 00:21:08', NULL),
(94, 11, 'Inception - Intellectus Standard', 'inception-intellectus-standard', 'The Intellectus Playing cards are printed by the Legends Playing Card Co. Each court, Ace and Joker cards will have original illustrations, capturing the feel of the era.  The Cards will be printed on the Classic Finish, which is the highest quality card stock that Legends has to offer.  The Tuck will feature copper foiling and embossing.', '2017-07-30 01:24:57', '2017-07-30 01:24:57', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `categories`
--

CREATE TABLE `categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `crawling_card_data`
--

CREATE TABLE `crawling_card_data` (
  `id` int(10) UNSIGNED NOT NULL,
  `card_page_id` int(10) UNSIGNED NOT NULL,
  `card_id` int(10) UNSIGNED DEFAULT NULL,
  `brand_id` int(10) UNSIGNED DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `in_stock` tinyint(1) DEFAULT '1',
  `price` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `variation_id` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Contenu de la table `crawling_card_data`
--

INSERT INTO `crawling_card_data` (`id`, `card_page_id`, `card_id`, `brand_id`, `name`, `description`, `in_stock`, `price`, `created_at`, `updated_at`, `deleted_at`, `variation_id`) VALUES
(2, 457, NULL, 11, 'Inception - Signature Series', 'The Signature Series 3 deck pack includes all 3 decks in the series. The pack is made of the same material as the individual tuck cases and will feature a stunning copper foil design on 5 sides.', 1, 70, '2017-06-14 09:42:46', '2017-07-30 01:24:49', NULL, NULL),
(3, 458, 15, 11, 'Golden Spike - Bicycle Edition', 'Golden Spike Playing Cards are inspired by the completion of the 1st Transcontinental Railroad On May 10th, 1869. It was the first rail line that connected the east to the west and revolutionized transportation and commerce in a post Civil War United States. A Golden Spike was created as a commemorative piece to celebrate the completion of the 1st transcontinental railroad and was driven into the ground where the Union Pacific met the Central Pacific Railroad at Promontory Point, Utah. When the hammer rang out and the golden spike was driven into the ground, a new era of industry and expansion rang out across the United States.', 1, 14, '2017-06-14 09:42:46', '2017-07-30 01:24:49', NULL, 19),
(4, 459, 15, 11, 'Golden Spike - Gold Edition', 'Golden Spike Playing Cards are inspired by the completion of the 1st Transcontinental Railroad On May 10th, 1869. It was the first rail line that connected the east to the west and revolutionized transportation and commerce in a post Civil War United States. A Golden Spike was created as a commemorative piece to celebrate the completion of the 1st transcontinental railroad and was driven into the ground where the Union Pacific met the Central Pacific Railroad at Promontory Point, Utah. When the hammer rang out and the golden spike was driven into the ground, a new era of industry and expansion rang out across the United States.', 1, 15, '2017-06-14 09:42:47', '2017-07-30 01:24:50', NULL, 95),
(17, 442, NULL, 9, 'GOLD FOIL GATORBACKS', 'In a class by themselves, the unique Gold Foil Gatorbacks (Édition Dorée) are the newest luxury deck added to the Gatorback series. For the first time, David has chosen to use the advanced MetalLuxe® Technology Foil printing on the back of each card, showcasing the intricate design, color and luminescence while keeping the highest level of flexibility. Every card is printed on the highest quality premium casino cardstock that USPC has to offer. All face cards are printed in metallic ink.The radiant white smooth tuck box is finely embossed and stamped exquisitely with white and gold foil.\nThe Gold Foil Gatorbacks with the MetalLuxe® Technology are destined to become collectors’ items whose value is sure to increase in the future.', 1, 20, '2017-06-14 06:23:27', '2017-06-14 06:30:11', NULL, NULL),
(18, 443, NULL, 9, 'BLACK GATORBACKS', 'No expense was spared in creating the Black Gatorbacks. The cards themselves are printed on the highest quality casino stock that USPC has to offer. The embossing pressure, printing press type, and direction of cut were also carefully chosen by David. \nThe deck\'s black on black foil stamped tuck case is embossed and finely detailed, on both the inside and the outside. The seal ensures that the cards have not been opened or tampered with and serve to retain the deck\'s value for collectors. Designed uncompromisingly for performance and style, the Gatorbacks are destined to be sought after for years to come.', 1, 20, '2017-06-14 06:23:28', '2017-06-14 06:30:12', NULL, NULL),
(19, 444, 92, 9, 'BLACK LIONS', 'We are proud to introduce The Black Lions, printed on the highest-quality stock the United States Playing Card Company offers. \nOur soft-touch box features a two-tone black finish and silver foil stamping on top of a fully detailed quality embossing.  Each deck contains a number of hidden features that are greatly enhanced by the new design.', 1, 10, '2017-06-14 06:23:28', '2017-07-30 00:18:06', NULL, 96),
(20, 446, 92, 9, 'BLACK LIONS RED EDITION', 'We are proud to introduce the Black Lions Red Edition, printed on the highest-quality stock the United States Playing Card Company offers.\nOur soft-touch box features a metallic red finish and silver foil stamping on top of a fully detailed quality embossing.  Each deck contains a number of hidden features that are greatly enhanced by the new design.', 1, 10, '2017-06-14 06:23:28', '2017-07-30 00:18:35', NULL, 97),
(21, 447, 92, 9, 'BLACK LIONS BLUE EDITION', 'We are proud to introduce the Black Lions Blue Edition, printed on the highest-quality stock the United States Playing Card Company offers.\nOur soft-touch box features a metallic blue finish and silver foil stamping on top of a fully detailed quality embossing.  Each deck contains a number of hidden features that are greatly enhanced by the new design.', 1, 10, '2017-06-14 06:23:29', '2017-07-30 00:18:59', NULL, 98),
(22, 450, 93, 9, 'WHITE LIONS SERIES B (BLUE)', 'Our box design includes silver foil stamping, detailed embossing, and a matte white finish never before seen on any deck of cards. The printing and packaging process needed for this box was so time consuming and difficult that the USPC isn\'t able to offer this box finish type to anyone in the future. The cards themselves are printed on a casino quality stock and are traditionally cut to allow for an easy weave during your shuffles. \n\nThere are many hidden features built into the deck that we will leave for you to discover. The cards also come stacked in the Tamariz stack with the Ace of Spades on the face ready to be unleashed.', 1, 12, '2017-06-14 06:23:29', '2017-07-30 00:21:21', NULL, 100),
(23, 452, NULL, 9, 'Mystery Box', 'Extremely rare decks from David\'s Personal collection, sealed and unused. Outer-Boxes have been used on the road and/or during shows and show some dents and scratches.\nThe Mystery Boxes include some of the most sought after decks, carefully handpicked favorites from David\'s personal collection. All 12 decks are sealed and unused. One of the decks is autographed by David.\nThe outer-boxes also come straight from David\'s personal collection, and have been used on the road and/or during shows. Some boxes will show this more than others, by dents and scratches.', 1, 300, '2017-06-14 06:30:13', '2017-06-14 06:30:13', NULL, NULL),
(24, 453, NULL, 9, 'BLACK LIONS SECONDS', 'We are excited to introduce our BLACK LIONS SECONDS, at the LOWEST PRICE of any deck we have ever produced.\nDue to a slight misalignment on the cards, we are able to offer these to you at a price that can never be matched otherwise.\nThe deck contains all of the great features and secrets of our latest series BLACK LIONS with the highest quality card stock produced by The UNITED STATES PLAYING CARD COMPANY.\nWhether you are a seasoned pro or just getting started in magic, these are the decks for you. In fact, this is the specific deck that David Blaine has been using during the filming of his newest television special. Their premium texture and incredible durability make them perfect for performing or practicing.', 1, 5, '2017-06-14 06:30:14', '2017-06-14 06:30:14', NULL, NULL),
(25, 454, 93, 9, 'WHITE LIONS BLACK LABEL', 'The Series B White Lions are a product of nearly a year\'s worth of collaboration with the United States Playing Card Company. Numerous factors are considered when creating a deck of playing cards, including printing press type, paper moisture, card stock, and embossing pressure. No expense was spared in creating Series B, as is evident the moment they are in your hands.\n\nOur box design includes silver foil stamping, detailed embossing, and a matte white finish never before seen on any deck of cards.  Due to the difficult and time-consuming process required to print and package this new box paper type, the USPC is no longer able to provide this finish.  The cards themselves are printed on the highest quality stock to produce a feel so good you won\'t want to put them down.', 1, 12, '2017-06-14 06:30:14', '2017-07-30 00:21:08', NULL, 99),
(26, 455, 93, 9, 'WHITE LIONS SERIES B (RED)', 'Our box design includes silver foil stamping, detailed embossing, and a matte white finish never before seen on any deck of cards. The printing and packaging process needed for this box was so time consuming and difficult that the USPC isn\'t able to offer this box finish type to anyone in the future. The cards themselves are printed on a casino quality stock and are traditionally cut to allow for an easy weave during your shuffles.\nThe White Lions feature an accumulation of several years worth of ideas. There are many hidden features, valuable to magicians, built into the deck that we will leave for you to discover. The cards also come stacked in the Tamariz stack with the Ace of Spades on the face ready to be unleashed.', 1, 12, '2017-06-14 06:30:14', '2017-07-30 00:21:37', NULL, 101),
(27, 589, 29, 3, 'Neil Patrick Harris Playing Cards', 'Premium playing cards produced in collaboration with Neil Patrick Harris. Proceeds benefit (RED)\'s fight against AIDS.', NULL, 9.95, '2017-06-22 01:00:56', '2017-06-22 01:01:22', NULL, 32),
(28, 590, NULL, 3, 'Mystery Box', 'The choice to open the box, or not, is yours. Mystery Box Playing Cards were designed and developed as a monument to mystery: a tribute to our love of magic, wo', NULL, 9.95, '2017-06-22 01:08:55', '2017-06-22 01:08:55', NULL, NULL),
(29, 591, 37, 3, 'Ivory Tycoon', 'Luxury has no limits. Premium, designer playing cards produced in collaboration with Steve Cohen, "The Millionaires’ Magician" at the prestigious Waldorf Astoria in NYC.', NULL, 9.95, '2017-06-22 01:08:55', '2017-06-22 01:10:27', NULL, NULL),
(30, 592, 31, 3, 'Citizen Playing Cards', 'Citizens are the most intricate, breathtaking playing cards we’ve ever produced. Illustrated in America by Kevin Cantrell, every aspect was handcrafted with relentless, unrivaled attention to detail.', NULL, 9.95, '2017-06-22 01:08:56', '2017-06-22 01:12:20', NULL, 34),
(31, 593, 30, 3, 'Monarchs', 'We didn\'t set out to raise the bar for quality playing cards. Our goal was to make playing cards fit for a king. The world\'s finest. The best. Featured #1 in th', NULL, 9.95, '2017-06-22 01:08:56', '2017-06-22 01:12:26', NULL, NULL),
(32, 594, NULL, 3, 'National Playing Cards', 'National Playing Cards are Made in the USA using FSC-certified paper derived from sustainable forests, vegetable-based inks, and starch-based laminates. Shielde', NULL, 9.95, '2017-06-22 01:08:56', '2017-06-22 01:08:56', NULL, NULL),
(33, 595, 36, 3, 'Rarebit Gold', 'In 2013, we released the original Rarebit Playing Cards. They sold out in 13 HOURS! Today, we’re excited to announce an all-new limited edition: Rarebit Gold.', NULL, 9.95, '2017-06-22 01:08:56', '2017-06-22 01:12:48', NULL, NULL),
(34, 596, 30, 3, 'Monarch - Now You See Me Playing Cards', 'A new LIMITED edition of Monarch Playing Cards: Now You See Me 2 Special Edition. In theaters June 10th. In your hands today.', NULL, 9.95, '2017-06-22 01:08:57', '2017-06-22 01:13:36', NULL, NULL),
(35, 597, NULL, 3, '5th & Laurel Playing Cards', 'Designed and inspired by 5th &amp; Laurel, a historic building in San Diego, California dating back to 1965. Each playing card box is made of soft but sturdy of', NULL, 9.95, '2017-06-22 01:08:57', '2017-06-22 01:08:57', NULL, NULL),
(36, 598, 30, 3, 'Gold Monarch Playing Cards', 'The FIRST gold foil custom playing cards ever printed by the United States Playing Card Company. Limited Edition Gold—on—Gold The box is just as breathtaking as', NULL, 0, '2017-06-22 01:10:14', '2017-06-22 01:13:56', NULL, NULL),
(37, 599, NULL, 3, 'Union Playing Cards', 'Union Playing Cards are filled with imagery of the American Revolution — with a message of freedom, hope, and independence.', NULL, 9.95, '2017-06-22 01:10:14', '2017-06-22 01:10:14', NULL, NULL),
(38, 600, NULL, 3, 'Green Monarch Playing Cards', 'Featured #1 in the GQ Holiday Gift Guide. Green Monarchs feature brilliant gold foil on an embossed, forest green tuck case.', NULL, 9.95, '2017-06-22 01:10:14', '2017-06-22 01:10:14', NULL, NULL),
(39, 601, NULL, 3, 'JAQK Blue Edition Playing Cards', 'Rare. Limited. Breathtaking. Beautiful. JAQK Cellars Playing Cards are Limited Edition - and they\'re BACK in BLUE. A Collector\'s Item The Finest JAQKs in Print', NULL, 9.95, '2017-06-22 01:10:14', '2017-06-22 01:10:14', NULL, NULL),
(40, 602, NULL, 3, 'Black Tycoon Playing Cards', 'Luxury has no limits. Premium, designer playing cards produced in collaboration with Steve Cohen, "The Millionaires’ Magician" at the prestigious Waldorf Astoria in NYC.', NULL, 9.95, '2017-06-22 01:10:15', '2017-06-22 01:10:15', NULL, NULL),
(41, 603, NULL, 3, 'MailChimp Summer Edition', 'A special Summer Edition of our popular MailChimp Playing Cards. Featuring a bright orange tuck case with gold foil, and all neon inks — the brightest, and flas', NULL, 9.95, '2017-06-22 01:10:15', '2017-06-22 01:10:15', NULL, NULL),
(42, 604, NULL, 3, 'NoMad Playing Cards', 'Produced in collaboration with The NoMad Hotel in New York City. NoMad Playing Cards were inspired by actual architectural elements of The NoMad Hotel.', NULL, 9.95, '2017-06-22 01:10:15', '2017-06-22 01:10:15', NULL, NULL),
(43, 605, NULL, 3, 'MailChimp Playing Cards', 'A collaboration between MailChimp, Fuzzco, and theory11. Custom playing cards sure to satisfy apes and humans alike.', NULL, 9.95, '2017-06-22 01:10:15', '2017-06-22 01:10:15', NULL, NULL),
(44, 460, 81, NULL, 'A Typographer\'s Deck', 'In collaboration with&nbsp;Turkish artist&nbsp;Furkan &#350;ener we are pleased to present&nbsp;A Typographer\'s Deck. This unique deck of playing cards features 54 custom&nbsp;playing cards represented through the art of typography. The detailed back design and&nbsp;easy-to-read pips ensure that&nbsp;game play is both practical and fun. Packaged inside a matching tuck case.\nLimited Edition of 2,500. Printed by the U.S. Playing Card Co.', 1, 12, '2017-07-18 03:44:53', '2017-07-18 04:10:40', NULL, 84),
(45, 461, NULL, NULL, 'VISA', 'A unique collaboration between magicians Alex Pandrea and Patrick Kun. VISA Playing Cards pay tribute to adventure, and invite you to "escape, discover and journey", a motto printed on the back of every card.\nThe cards were successfully funded on KickStarter last year and we are pleased to offer a limited quantity in our catalogue.\nAvailable in red, blue and a limited edition gold. VISA playing cards were printed by the United States Playing Card Company.', 1, 10, '2017-07-18 03:44:53', '2017-07-18 04:10:41', NULL, NULL),
(46, 462, 79, NULL, 'The Three Little Pigs', 'Inspired by the classic fable, The Three Little Pigs playing cards borrow from the tale&rsquo;s lesson on diligence with an ornate design that feels as timeless as the story. Produced by Pure Imagination Projects and designed by Joe White of Ye Olde Studio.\nFeaturing original hand-drawn artwork, The Three Little Pigs playing cards were&nbsp;printed by the U.S. Playing Card Co. in a limited edition&nbsp;of 2,500. Be ware of the big bad wolf.', 1, 12, '2017-07-18 03:44:54', '2017-07-18 04:10:42', NULL, 82),
(47, 463, 80, NULL, 'EDGE Playing Cards', 'Designed in Prague by the extremely-popular design agency Creative Mints, known for their beautiful and user-orientated graphic style.\nTheir latest project, EDGE&nbsp;Playing Cards, produced by the TCC Playing Card Co. brims with an aura of creativity and ingenuity. The design is all but a&nbsp;simple array&nbsp;of colorful shapes that have been organized into a graphically pleasing pattern that just feels right.&nbsp;\nEvery single card in EDGE has been designed from the&nbsp;ground-up and the court cards are some of our favorite to date.&nbsp;\nPrinted by the U.S. Playing Card Co.', 1, 12, '2017-07-18 03:44:55', '2017-07-18 04:10:43', NULL, 83),
(48, 464, 81, NULL, 'Flora', 'After the well received, and now sold out, Casual playing cards released last year Paul Robaia is back with another original&nbsp;deck. Flora offers a&nbsp;vibrant floral design featuring a Hawaiian-style bouquet of&nbsp;flowers and leaves against a tropical colorway that is sure to brighten up any situation, whether it be a friendly game of Go Fish at the beach or in your next cardistry video.\nLimited Edition of 2,500. Printed by the US Playing Card Co.', 0, 10, '2017-07-18 04:04:46', '2017-07-18 04:12:14', NULL, 84),
(49, 465, NULL, NULL, 'Triple Vision', 'Triple Vision playing cards were&nbsp;born from childhood memories. &lsquo;Nerding out&rsquo; over &lsquo;old-school&rsquo; 3D comics and cereal box promotions that used 3D art. You know, the ones where you had to wear those cheesy&nbsp;red and blue paper glasses.\nLast year the folks over at One Widow decided to launch the idea on Kickstarter to see what the playing card community thought. If that &lsquo;old-school&rsquo; comic book style and 3D anaglyphic treatment pulled anyone else&rsquo;s heartstring like it did theirs. Luckily, it did and we\'re excited to offer this unique deck to our catalogue. 3D glasses included!\nPrinted in Taiwan by Legends Playing Card Co.', 1, 15, '2017-07-18 04:04:47', '2017-07-18 04:10:45', NULL, NULL),
(50, 466, NULL, NULL, 'Fournier 505', 'From the Spanish playing card company Fournier we are pleased to offer their signature deck, Fournier 505. The cards feature an elegant victorian-style back design, a stiff card-stock ideal for cardistry, a smooth plastic-like finish, and colorful court cards. Packaged inside a recycled-paper tuck box.\nAlthough readily available in Spain we are pleased the offer the Fournier 505 playing&nbsp;cards exclusively on Art of Play for U.S. customers.', 1, 8, '2017-07-18 04:04:48', '2017-07-18 04:10:46', NULL, NULL),
(51, 467, NULL, NULL, 'Mondrian Playing Cards', 'Inspired by the work of Dutch artist, Piet Mondrian. Mondrian playing cards pay tribute to the artists grid-based paintings he produced in Paris in the 1920s, and that which he is most known for.\nMondrian playing cards were pieced together by playing card designer Toomas Pintson and produced by GotMagic? They were printed by The United States Playing Card Company in a limited edition of 5,000.', 0, 15, '2017-07-18 04:04:48', '2017-07-18 04:10:46', NULL, NULL),
(52, 468, NULL, NULL, 'Stripe Playing Cards', 'The debut deck from the highly popular cardistry brand, dealersgrip. Stripe Playing Cards sold out within days of release last fall so we could not be more excited to offer them to you now. Available here is the final remaining supply of Stripe Playing Cards. With an initial production&nbsp;run of only 2,500 the quantity&nbsp;we have left isn\'t much and these will likely sell out fast.\nStripe is a minimalistic deck of playing cards featuring a three-dimensional optical illusion formed by curved stripes. Printed by the U.S. Playing Card Co. on a crushed stock that handles as well as our own line of playing cards.\nClick on the Video tab&nbsp;below to see Stripe playing cards in action.', 0, 45, '2017-07-18 04:04:49', '2017-07-18 04:10:47', NULL, NULL),
(53, 469, NULL, NULL, 'LUXX&reg; Greille Back', 'Greille is a gorgeous blend of modern design and traditional playing card elements. The repeating pattern, showcasing the shimmering embedded foil on the backs, makes this a unique and stunning addition to any collection.\nFeaturing&nbsp;custom aces, jokers and court cards. Each deck is housed in a superb tuck with embossed foil accidents.\nLimited Edition of 1,000 decks. Printed in Taiwan by the Legends Playing Card Co.', 1, 15, '2017-07-18 04:04:50', '2017-07-18 04:10:48', NULL, NULL),
(54, 470, NULL, NULL, 'STARDECK', 'STARDECK is a set of sci-fi themed playing cards designed by the creative folks over at Lunar Saloon. Each suit represents a classic sci-fi trope: Space Marines, Robots, Aliens, and a dastardly Mega Corporation.\nPrinted by the U.S. Playing Card Co. on premium Bicycle&reg; paper stock.', 1, 15, '2017-07-18 04:04:51', '2017-07-18 04:10:49', NULL, NULL),
(55, 471, 6, NULL, 'Bicycle&reg; Little Atlantis', 'Bicycle&reg; Little Atlantis is a completely&nbsp;custom deck designed by Devina of Yellow Dice Studio. The aquatic theme features cute sea creatures divided into four suits representing Wisdom (Spade), Power (Club), Love (Heart), and Justice (Diamond).&nbsp;Together they make their little world peaceful and prosperous.\nPrinted by the U.S. Playing Card Co. Limited Edition of 2,500.', 1, 12, '2017-07-18 04:04:52', '2017-07-18 04:22:01', NULL, 10),
(56, 472, NULL, NULL, 'Superior: Classic Back', 'Developed by sleight of hand expert Bill Kalush after years of research trying to seek out a better-handling deck.\nSuperior Brand playing cards from The Expert Playing Card Co. feature a soft card stock, perfectly-registered&nbsp;printing and traditionally-cut edges preferred by professional magicians and card players. Housed inside a tear-resistant synthetic tuck case&nbsp;designed to&nbsp;improve the overall lifespan of your deck.\nPrinted in Taiwan by The Expert Playing Card Co.', 0, 5, '2017-07-18 04:04:53', '2017-07-18 04:10:50', NULL, NULL),
(57, 473, 44, NULL, 'Flourish', 'In collaboration with&nbsp;Column Five&nbsp;comes our first release of 2017. A whisk of original design with a familiar playing card aesthetic, Flourish is a sweet new deck unlike any we\'ve produced&nbsp;before. The bakery theme delights with every card and is sure to leave you wanting more. From the original pink back design to the illustrated court cards and custom faces, Flourish is full of flavor and an irresistible addition to our collection.\nLike fine chocolate, the luxurious packaging is only a hint at the delectable cards inside. The gorgeous tuck case features foil and embossing on a rich paper to excite your senses.&nbsp;Printed by the US Playing Card Co. on our trademark thin-stock preferred by cardists.\nLimited Edition of 2,500. Don\'t miss out on this sweet opportunity to own a pack of Flourish playing cards.', 1, 15, '2017-07-18 04:04:53', '2017-07-18 04:22:16', NULL, 47),
(58, 474, NULL, NULL, 'Cocktail Hour', 'Cocktail Hour is a custom, illustrated deck of playing cards that celebrates the craft of the cocktail &ndash; offering a playful and modern twist to the classic deck through original art.\nDesigned by Sarah Ferone in her&nbsp;signature illustration style. Each playing card features bold brushwork and graphic lines &ndash; the face cards feature unique characters crafting a variety of drinks, the number cards incorporate subtle hand-painted textures and pips that vary slightly in size for added charm, and the cards are packaged in an artful tuck box to showcase the deck.\nPrinted by the Legends Playing Card Co. in Taiwan.', 1, 15, '2017-07-18 04:04:54', '2017-07-18 04:10:52', NULL, NULL),
(59, 475, NULL, NULL, 'Glamor Nugget', 'Glamor Nugget playing cards are a fun tribute to the original Golden Nugget Casino playing cards last printed in the 1970\'s. Today, they are some of the most sought after cards - cherished&nbsp;by collectors&nbsp;and magicians for their retro-style and unique feel.\nTo our luck, and from an unknown source, this new parody edition features a near-identical recreation of the originals... and in all 8 colors.\nPrinted&nbsp;to emulate a similar feel as the originals the Glamor Nugget playing cards, they feature a quality card stock which feels and handles great!\nLimited Edition of 1,000. Due to copyright restrictions these will not be re-printed.', 1, 16, '2017-07-18 04:04:55', '2017-07-18 04:10:53', NULL, NULL),
(60, 476, 29, NULL, 'NPH Playing Cards', 'Neil Patrick Harris Playing Cards are elegant, intricate, and visually stunning. Every aspect was handcrafted with relentless, unrivaled attention to detail.\nWith a combination of artistic influences, NPH Playing Cards are a tribute to Neil\'s love of mystery, magic, games, and theater.\nThe cards feature&nbsp;a&nbsp;custom Ace of Spades, Joker, box design, and modified court card typography. Even the inside&nbsp;of the box has a custom, elegant gold foil pattern.\nPrinted by the U.S. Playing Card Co.', 1, 10, '2017-07-18 04:04:56', '2017-07-18 04:22:37', NULL, 32),
(61, 477, 45, NULL, 'Jungle Deck', 'Bursting with vibrant colors and raw animal magnetism, the savage design of this deck was inspired by the lush jungles of Africa.&nbsp;\nEach custom illustrated card features iconic flora and fauna from the Zulu wilderness. Monkeys, parrots and jungle cats run wild throughout the pack.&nbsp;\nThe jungle tuck case was printed on an antique Heidelberg letterpress to give the colors a vintage "washed" look that compliments the eye-catching graphics inside.&nbsp;\nDesigned by Muti in South Africa.', 1, 15, '2017-07-18 04:04:57', '2017-07-18 04:22:56', NULL, 48),
(62, 478, NULL, NULL, 'MAKERS', 'Luxury playing cards made true by The D&amp;D Playing Card Co. MAKERS are the most intricate and luxurious deck in their catalogue.\nEach tuck case has been embossed and stamped with layers of gold-foiling. The result is nothing short of breathtaking. Out of the box, conjurors and collectors alike will enjoy 14 custom illustrated court-cards representing the foundational &ldquo;makers&rdquo; civilization has been built on. To us, these individuals are the pillars of unparalleled craftsmanship: something that we hold in the highest regard. MAKERS are both a tribute and a celebration.\nPrinted by the U.S. Playing Card Co. using an exclusive&nbsp;&ldquo;crushed stock&rdquo; process to create a more refined and lighter deck of playing cards.\nFor the diehard collector, enjoy 1 of 500 limited edition box sets crafted from solid oak lined with leather and finished with antique&nbsp;hardware that features a working lock and key. Available exclusively at&nbsp;dananddave.com.', 1, 15, '2017-07-18 04:04:58', '2017-07-18 04:10:55', NULL, NULL),
(63, 479, NULL, NULL, 'ED', 'Designed for ED by Ellen, this lovely&nbsp;pack of playing cards showcases a rich black, red and white color pallet with vintage-inspired artwork throughout.\nPrinted by the U.S Playing Card Co. and packaged inside a craft-paper tuck with black foil and embossed&nbsp;accents.', 1, 10, '2017-07-18 04:04:58', '2017-07-18 04:10:56', NULL, NULL),
(64, 480, NULL, NULL, 'Memento Mori', 'In this stunning deck designed by Michael Mateyko of KOMBOH CREATIVE, traditional suits have been reimagined to create stars, swords, flies, and feathers: symbols of order, aspiration, chaos, and scavenging respectively. The imagery adorning both the cards and ominous embossed tuck call attention to medieval existentialism, the occult, and divine mathematics; and believe us when we say, when we first saw them we were speechless.\nPrinted by The United States Playing Card Company and packaged inside a custom tuck box featuring foil accents and a unique die-cut window with clear-plastic covering.\nLimited edition of only 2,500 decks.', 0, 15, '2017-07-18 04:04:59', '2017-07-18 04:10:57', NULL, NULL),
(65, 481, NULL, NULL, 'Lost Wax', 'Take a step&nbsp;back-in-time to&nbsp;Fifteenth century Africa, a&nbsp;land untouched by the western world. A Nation where arts and entertainment were more than a vehicle of self expression, they were a way of life.&nbsp;\nLost Wax playing cards are a tribute to the West African land of intrigue-kingdoms, where wonder was traded in place of gold.\nThis unique deck designed by Olutade Abidoye features a vibrant color palette and back-design that emulates gorgeous tapestries from the era. In addition, art connoisseurs and history buffs alike will delight in a set of custom court cards that honor native paintings and etchings of the period.\nPrinted by the U.S. Playing Card Co. and packaged&nbsp;inside a custom&nbsp;box featuring gold foil and embossed accents.&nbsp;', 1, 15, '2017-07-18 04:05:00', '2017-07-18 04:10:58', NULL, NULL),
(66, 482, NULL, NULL, 'Carbon Clip', 'The Carbon Clip, much like our popular Classic Clip, is an&nbsp;indispensable utility item that will add months of life to your playing cards. Precision crafted from aluminum in the USA. This unique edition is wrapped with synthetic carbon fiber made from industrial-strength vinyl.\nDesigned to protect a pack of 52 poker-size playing cards in their tuck case, the clip measures approximately 3.5 x 2.5 x .5 inches.', 1, 40, '2017-07-18 04:05:01', '2017-07-18 04:10:59', NULL, NULL),
(67, 483, NULL, NULL, 'Bicycle&reg; Bone Riders', 'These spooky limited edition playing cards are the perfect way to put the &ldquo;trick&rdquo; back in &ldquo;trick or treat" this Halloween season.\nKids will love the jack o&rsquo;lanterns, bats and skeletons that dance across the backs of the cards. Adults will appreciate the playful Halloween spin on Bicycle\'s classic Rider Back design. Ghoulish custom illustrations adorn the Joker and Ace of Spades to make this deck a memorable party favor or festive way to celebrate the season at your next card game.\nPackaged inside a festive tuck box featuring premium matte card stock with embossed typography.\nAvailable while supplies last. Printed by the U.S. Playing Card Co.', 1, 10, '2017-07-18 04:05:01', '2017-07-18 04:10:59', NULL, NULL),
(68, 484, NULL, NULL, 'White Lions, Series A', 'Produced by David Blaine and Mark Stutzman, these decks offer superior quality and excellent durability. They are used by David whenever he performs.\nLong out of print, we are pleased to offer a limited batch of the original&nbsp;White Lions, Series A playing cards. Available in Blue.\nFor the serious card collector or diehard fan of David Blaine.', 1, 40, '2017-07-18 04:05:02', '2017-07-18 04:11:00', NULL, NULL),
(69, 485, NULL, NULL, 'Chicken Nugget', 'A delicious&nbsp;rendition of the highly sought after&nbsp;Jerry\'s Nugget playing cards. Meet the Chicken Nuggets.\nMagician Hanson Chien brings new life to the long out-of-print legendary deck admired by magicians all over the world for its unique feel that is often imitated&nbsp;but never duplicated. Working with a graphic designer Hanson&nbsp;spent&nbsp;over a&nbsp;year mulling over every detail - from selection of the right material to precise color adjustments. All the effort was devoted to recreate a deck of cards that resembles the legendary Jerry\'s Nugget&nbsp;as closely as possible.\nFrom the nearly identical Ace of Spades and Joker to the crooked tax stamp and red&nbsp;security tear-strip the Chicken Nugget\'s are indeed a close match to the originals. But don\'t take Hanson too seriously, the court cards feature a collection of junk-food-junkies devouring everything&nbsp;from donuts to french fries.\nLimited Edition. Printed in Taiwan.', 1, 15, '2017-07-18 04:05:03', '2017-07-18 04:11:01', NULL, NULL),
(70, 486, NULL, NULL, 'Russian Folk Art', 'Russian Folk Art is a beautiful deck of playing cards inspired by Russian Folklore.\nThe deck features 54 original designs from Natalia Silva who took inspiration from her Russian heritage and culture. "Traditional folk art has always played an intrinsic part of domestic culture across Russia and represents the rooted artistic perceptions, traditions and practices of the citizens."\nAvailable in Green and Red. Each deck features its own unique&nbsp;artwork. Printed by the United States Playing Card Co. Limited Edition of 2,500.', 1, 10, '2017-07-18 04:05:04', '2017-07-18 04:11:02', NULL, NULL),
(71, 487, NULL, NULL, 'Joker and the Thief', 'Now available in a stunning new red&nbsp;colorway.&nbsp;The&nbsp;Joker and the Thief&nbsp;series evokes a story of life and mortality - riffle the cards and peek inside the thievery, lies, and deceit that transforms this deck for an enchanting game of play.\nThe back-design has been meticulously designed. It effortlessly draws you in to a gathering of 12 court cards, dressed with charisma and distinct in character - royalty ready for battle.\nFollowing the custom court cards are weathered spot cards, a striking Ace of Spades and two Jokers depict a harlequin and a bandit, hence the name.\nThis masterpiece is packaged within a sensational tuck case, embossed and wrapped in shiny gold&nbsp;foil. Bold and powerful - a true testament to the Joker and the Thief brand.\nAvailable in Red, Blue and Gold. Limited print run by The Expert Playing Card Co.', 0, 16, '2017-07-18 04:05:05', '2017-07-18 04:11:03', NULL, NULL),
(72, 488, NULL, NULL, 'Bicycle&reg; 8-Bit', 'Inspired by the Bicycle&reg; Rider Back, this unique deck from Home Run&nbsp;Games transforms the entire deck into 8-bit pixel art.\nRelease your inner-nerd. Available in blue and red. Printed by the U.S. Playing Card Co.', 1, 12, '2017-07-18 04:05:06', '2017-07-18 04:11:03', NULL, NULL),
(73, 489, NULL, NULL, 'Odd Bods', 'When they first appeared in 2012 for the exclusive enjoyment of members of the prestigious Folio Society, the design world fell in love. Odd Bods were playful, charming, elegant, and above all else, a joy for the eyes.\nToday they are so much more.\nWe&rsquo;re pleased to offer the new Odd Bods featuring an all-new back design and gold-foil embossed box. Each playing card, hand illustrated by Jonathan Burton, is nothing short of stunning. Every image proves its own quirk and oddity, but is never ostentatious-- Odd Bods are the epitome of refined indulgence.\nPrinted by the U.S. Playing Card Co.', 1, 15, '2017-07-18 04:05:07', '2017-07-18 04:11:04', NULL, NULL),
(74, 490, NULL, NULL, 'Les M&eacute;li&egrave;s: Voyagers Ed.', 'This unique deck of playing cards was inspired by the iconic film&nbsp;A Trip to The Moon directed by the French filmmaker&nbsp;and magician George M&eacute;li&egrave;s.&nbsp;\nLes M&eacute;li&egrave;s: Voyagers&nbsp;Ed.&nbsp;playing cards were designed and produced by Derek Mckee and Michael Blau. Features include a custom back design, ace of spades and two jokers.\nLimited Edition of 1,111. Printed in Taiwan by Legends&nbsp;Playing Card Co.&nbsp;', 1, 15, '2017-07-18 04:05:08', '2017-07-18 04:11:05', NULL, NULL),
(75, 491, NULL, NULL, 'Sons of Liberty, Patriot Blue', 'A time before the United States existed, a time when we were subjects of a King across an ocean. The Sons of Liberty operated in the shadows, leaving secret signals, passing hidden messages, and meeting in the dead of night. However, people soon rallied with them, and their cause to resist British oppression quickly spread throughout the colonies.\nJoin us as we commemorate this first group of Patriots with the return of our acclaimed Sons of Liberty Playing Cards in an all new colorway. The tuck box is among the most exquisite we\'ve ever produced, featuring sculptural embossing in both bronze and pewter foil. The cards themselves feature a plethora of masonic imagery, a Liberty Tree ace of spades, and a tax stamp seal. A handful of the Son\'s most patriotic members are represented on the court cards in 18th century style etching. Furthermore, the stock itself has undergone our unique crushing procedure, in order to guarantee a thin and snappy deck that handles magnificently.\nFor the revolutionary, the history buff, or the everlasting patriot, these cards are a necessity in the hands of those who raise the flag and embody the spirit of a better tomorrow.', 1, 12, '2017-07-18 04:05:08', '2017-07-18 04:11:05', NULL, NULL),
(76, 492, NULL, NULL, 'Vintage Plaid, Arizona Red', 'By far one of our favorite decks, Vintage Plaids have become a staple in every card man\'s collection, and has been highly sought after since we sold out years ago. Inspired by our camping trips as children, each deck pays homage to the great outdoors. We\'re proud to say that while the original Vintage Plaids hold a special place in our hearts, our new updated design of the deck takes the cake. They are something to behold.\nEach deck features a brand new embossed box complete with gold-lettering, and in addition, all around back-design printing within. Not only have we recreated the box, but we\'ve gone a step further and created an all new Ace of Spades along with two Jokers. If this wasn\'t enough, we raised the bar even further and included an all new typeface that adds a sleek component to the deck\'s already rugged yet refined feel.\nThe new Vintage Plaids change the game of playing card design, and for that we recommend you act quickly as these are bound to go fast.\nMasterfully printed by the United States Playing Cards Company on our trademark "Thin Stock."', 1, 10, '2017-07-18 04:05:09', '2017-07-18 04:11:06', NULL, NULL),
(77, 493, NULL, NULL, 'Draconian, Brimstone Ed.', 'Inspired by the Dragons of lore, Draconian, Brimstone Edition is a premium deck of custom playing cards. Designed by Randy Butterfield and beautifully printed by the Legends Playing Card Co.\nThe back design features a borderless optical illusion formed from Dragon Scales. The face-cards incorporate a clean design that keeps them functional and provides the highest level of playability. Each card-back and face contains elements of borderless fire fissures throughout. The details are crisp and the colours are striking!\nThe tuck box is highlighted by the symmetrical dragon scales design. Printed on a black matte paper stock, features an orangish-red foil, grey and a high gloss UV overlay overlay.\nThe Draconian Brimstone Deck is perfect for any collector, card player, magician, cardist or fan of Dragons!', 1, 15, '2017-07-18 04:05:10', '2017-07-18 04:11:07', NULL, NULL),
(78, 494, NULL, NULL, 'Bicycle&reg; Chainless', 'Introduced in 1899 as #18 and discontinued in 1917. Bicycle&reg; Chainless was only offered in red or blue and was meant to celebrate the technological advancement made on the bicycle at the turn of the century.\nThe unique tuck case design for this deck was inspired by the back side of the first ever Bicycle&reg; brand product packaging. Originally printed in 1885, the Bicycle&reg; brand has become an American icon, still printing decks 130+ years later. This deck features a vellum tuck stock with embossed elements.\nThis beautiful reproduction was released in 2015 exclusively at Target retail centers across the US. We managed to get ahold of a limited supply and are thrilled to offer them to you now.', 1, 7, '2017-07-18 04:05:11', '2017-07-18 04:11:08', NULL, NULL),
(79, 495, NULL, NULL, 'Citizens', 'Citizens from Theory11 are the most intricate, breathtaking playing cards they\'ve ever produced. Illustrated in America by Kevin Cantrell, every aspect was handcrafted with relentless, unrivaled attention to detail.', 1, 10, '2017-07-18 04:05:12', '2017-07-18 04:11:09', NULL, NULL),
(80, 496, NULL, NULL, 'Piff the Magic Dragon', 'A fully custom designed deck of playing cards suitable for use by magical dragons and other wannabes. Designed by Piff, Chris Chelko and artist Claire Blackledge, each deck comes in its own mini Tacular with fold out legs and features a bunch of very special magic tricks built into the deck that you can learn direct from Piff.', 1, 20, '2017-07-18 04:05:13', '2017-07-18 04:11:09', NULL, NULL),
(81, 497, NULL, NULL, 'Vanda, Violet Edition', 'Vanda is the only rotationally symmetric deck of playing cards ever designed - every single card looks exactly the same right-side-up as it does upside-down.\nPrinted by the US Playing Card Co. Limited Edition of 2,500 decks printed.', 1, 7.5, '2017-07-18 04:05:14', '2017-07-18 04:11:10', NULL, NULL),
(82, 498, NULL, NULL, 'Triplicate No.18', 'The Triplicate No.18 deck was the first of its kind. Andrew Dougherty was granted a U.S. Patent for the Triplicate feature which was a miniature card placed in the top left and bottom right corners. It was a revolution in the way cards could be held and viewed.\nHome Run Games, in collaboration with the U.S. Playing Card Company, have done a beautiful job with the restoration of these playing cards. Hundreds of hours were put into re-drawing the art for these cards to bring this treasure back to life.\nThe tuck box, back design and ace of spades have been approved by the U.S. Playing Card Company as the restored art work for the deck.', 1, 12, '2017-07-18 04:05:14', '2017-07-18 04:11:11', NULL, NULL),
(83, 499, NULL, NULL, 'Uusi Classic', 'The latest deck from Uusi is another hand-painted classic that will make your heart beat a little faster.\nThis unique deck features original hand-painted artwork that makes them ideal for magic and card games, yet at the same time very familiar and immediately recognizable by players and spectators alike.\nPrinted by the US Playing Card Co.', 1, 25, '2017-07-18 04:05:15', '2017-07-18 04:11:12', NULL, NULL),
(84, 500, NULL, NULL, 'Kings of India', 'Playing cards inspired by India\'s four greatest dynasties - Maurya, Gupta, Chola and Mughal.\nMeticulously illustrated by the design team at Humble Raja. No detail was left untouched - from the typography and suits to the weapons and chest hairs of the Kings, revealing the marvels and monarchs of India\'s story.\nPrinted by the US Playing Card Co on Bicycle&reg; stock. The tuck case features a thick stock with gold foil print and embossed details.', 0, 15, '2017-07-18 04:05:16', '2017-07-18 04:11:13', NULL, NULL),
(85, 501, NULL, NULL, 'Union', 'Patriotic playing cards inspired by American history.\nWithin this unique deck of cards discover iconography of colonial America and patriotic symbols of peace, prosperity, and potential. Union Playing Cards are Made in America, using FSC-certified paper, vegetable-based inks, and starch-based laminates.\nTheory11 in collaboration with artist Jay Fletcher spent over a year developing this deck, every aspect of the design was created from scratch - from the breathtaking court cards to the back design and Ace of Spades.', 1, 10, '2017-07-18 04:05:17', '2017-07-18 04:11:13', NULL, NULL),
(86, 502, NULL, NULL, 'Blossom Playing Cards', 'From the design studio that illustrated the beautiful Peafowl deck comes their next deck of playing cards, themed after a flower blossom.\nPrinted by the US Playing Card Co. on an embossed stock featuring 56 original designs.\nAvailable in two colors - Ivory (Spring) or Cream (Fall).', 1, 14, '2017-07-18 04:05:18', '2017-07-18 04:11:14', NULL, NULL),
(87, 503, NULL, NULL, 'DKNG Playing Cards', 'Created in partnership with California based creative studio,&nbsp;DKNG Playing Cards offer a fresh interpretation of the classic Bicycle Rider Back. The updated design is crisp and playful in both red and blue.\nFeaturing 54 custom illustrated playing cards printed by the US Playing Card Co. on our trademark thin-stock preferred by cardists. Housed inside a foil-stamped and embossed tuck case.', 1, 12, '2017-07-18 04:05:18', '2017-07-18 04:11:15', NULL, NULL),
(88, 504, NULL, NULL, 'Luxx&reg; Palme Ed.', 'Palme is the second design in the Luxx&aring;&uml; series of playing cards and a beautiful follow-up to the first edition.\nDesigned by Rick Davidison, Palme is a deck inspired by the beautiful Paisley pattern, which has roots and heritage across the globe.\nA full bleed, borderless back design gives this deck a unique look and style which is carried through the deck and onto the stunning tuck box.\nThe deck is housed in a stunning tuck box with a wrap-around design and embossing complete with matte foiled Luxx&reg; logo.\nLimited to 2,000 of each color. Printed by the Legends Playing Card Co.', 1, 15, '2017-07-18 04:05:19', '2017-07-18 04:11:16', NULL, NULL),
(89, 505, NULL, NULL, 'Made by Children', 'Playing cards with a purpose. Designed and illustrated by children in Korea.\nWhat we love most about this deck, besides the adorable artwork, is that for every deck sold a portion of proceeds benefits children in developing countries -&nbsp;Designed by children, for children.\nPrinted by the US Playing Card Co.', 1, 12, '2017-07-18 04:05:20', '2017-07-18 04:11:17', NULL, NULL),
(90, 506, NULL, NULL, 'Crown Deck', 'Signature playing cards from magic superstore The Blue Crown, creators of the insanely popular NOC Decks. Printed by the US Playing Card Co. on Bicycle&reg; stock. Limited quantity available.', 1, 6, '2017-07-18 04:05:21', '2017-07-18 04:11:17', NULL, NULL),
(91, 507, NULL, NULL, 'Sleepy Hollow', 'In 1820 American author Irving Washington first published his short story The Legend Of Sleepy Hollow. Nearly 200 years later, this story continues to resonate around the world as one of the most popular American fiction stories of all time and is now captured in this beautifully illustrated deck of custom playing cards.\nOver a year in the making, The Legend Of Sleepy Hollow Playing Cards were conceived by playing card designer Derek McKee&nbsp;and masterfully illustrated in France by J.C. Desevre. This incredibly intricate and detailed deck of playing cards depicts artwork and characters from the famous Sleepy Hollow legend including Ichabod Crane &amp; the Headless Horseman.\nFrom the brilliant gold metallic inks to the custom court cards, this deck captures the true essence of The Legend of Sleepy Hollow.', 1, 12, '2017-07-18 04:05:22', '2017-07-18 04:11:19', NULL, NULL),
(92, 508, NULL, NULL, 'Third Man Records', 'In collaboration with Third Man Records, we are excited to offer a unique set of playing cards designed by the creative hive behind the independent record label founded by Jack White in Detroit, Michigan.\nThis fully-custom deck comes encased in a beautifully printed black-on-black tuck case, embossed with foil accents that looks like a record.\nThe cards feature a borderless back-design and an all black background with yellow, grey and white accents throughout the deck.\nPrinted at the US Playing Card Co. in 2015.', 1, 12, '2017-07-18 04:05:23', '2017-07-18 04:11:20', NULL, NULL),
(93, 509, NULL, NULL, 'Playing Arts Deck, v2', 'After the successful Playing Arts Deck, v1 Digital Abstracts is back with another edition packed with 55 brand new artists.\nFrom the two of clubs to the ace of spades, each card in this deck has been individually designed by one of the 55 selected international artists in their distinct style and technique.\nProduced by Digital Abstracts and printed by the US Playing Card Co. on Bicycle&reg; paper. Inside you will find 54 unique playing cards, 2 jokers, 1 ad card and an info card with the names of all fifty-five artists.', 1, 12, '2017-07-18 04:05:23', '2017-07-18 04:11:20', NULL, NULL),
(94, 510, NULL, NULL, 'AVIATOR&reg; Heritage Ed.', 'A century ago man first soared into the clouds and reached beyond the impossible. Today, we venture further skyward and invite you aboard as a classic is reimagined.\nIntroduced in 1927 to commemorate Charles Lindbergh\'s transatlantic flight aboard the Spirit of St. Louis, AVIATOR&reg; Playing Cards have been available in stores around the world ever since.\nNearly 90 years after their initial release, we\'re proud to present a new edition of AVIATOR&reg; playing cards, inspired by Howard Hughes. Hughes, the pioneering airman of the 20th century, turned his H-1 racer into a beacon of innovation as it flew across the night sky. Within the vintage tuck-case, each card features Hughes\'s racer, high above the earth -- boldly exploring all places unknown. So grab a pack, strap in, and come fly with us.\nClassically designed by D&amp;D in collaboration with the US Playing Card Co. AVIATOR&reg; Heritage Edition are a timeless tribute to the iconic brand.', 1, 7, '2017-07-18 04:05:24', '2017-07-18 04:11:21', NULL, NULL),
(95, 511, NULL, NULL, 'Luxx&reg; Shadow Ed.', 'From designer Randy Butterfield comes the latest edition in the Luxx&reg; series of playing cards. The Shadow Edition, available in both Gold and Silver, features some unique design traits.\n\nThe playing cards feature subtle elements of either gold or silver metallic ink across a monotone design. A combination that actually goes really well together. The face cards feature the same design as the original Luxx&reg;&nbsp;playing cards - traditional with a twist. The cards themselves are much stiffer than a traditional Bicycle&reg; deck yet surprisingly thinner. We think they are great for Cardistry.\nThe tuck box, at first glance, is simply striking. From the shinny gold and silver accents on the outside to the laminated coating on the inside this box not only looks classy but features a durable card stock meant to protect&nbsp;the cards inside.\n\nPrinted by the Legends Playing Card Co.', 1, 15, '2017-07-18 04:05:25', '2017-07-18 04:11:22', NULL, NULL),
(96, 512, NULL, NULL, 'Bicycle&reg; Peacock Deck', 'The Bicycle&reg; Peacock Deck features the iconic pattern of peacock feathers for a sophisticated yet fun deck of playing cards.\nAvailable in purple and green with a repeating pattern of peacock feathers, this deck makes a subtly stylish addition to your collection.\nThe Peacock Deck features original artwork on the front and backs of the cards, including the Ace of Spades. These decks were printed in the USA at the United States Playing Card Company and printed on premium stock with a quality finish.', 1, 5, '2017-07-18 04:05:26', '2017-07-18 04:11:23', NULL, NULL),
(97, 513, NULL, NULL, 'Hollingworths, Emerald Ed.', 'Designed by Guy Hollingworth and printed by D&amp;D exclusively for The Hollingworth Collection. Until now, this classy deck of playing cards, inspired by Art Deco, has not been made available on its own outside the Collection.\nIn addition to the metallic gold foil printing the cards feature a unique quality that, as far as we know, has never been done before. The deck is an astonishing eight cards thinner than a standard deck of Bicycle playing cards yet manages to maintain the same "snappy" quality of traditional playing cards.', 1, 25, '2017-07-18 04:05:27', '2017-07-18 04:11:24', NULL, NULL);
INSERT INTO `crawling_card_data` (`id`, `card_page_id`, `card_id`, `brand_id`, `name`, `description`, `in_stock`, `price`, `created_at`, `updated_at`, `deleted_at`, `variation_id`) VALUES
(98, 514, NULL, NULL, 'NoMad Playing Cards', 'NoMad Playing Cards were produced in collaboration with The NoMad Hotel in New York City and Theory11. In the 19th century, The NoMad District of New York was the meeting place of the era\'s elite - from Oscar Wilde to Charles Dickens, Mark Twain to Nikola Tesla. The vision was to create a deck of cards that would serve as a monument to The NoMad. The result is a timeless blend of beauty and elegance.\nDesigned by Chad Michael Studio\'s. Produced by Theory11 in collaboration with The NoMad Hotel in New York City. Made in America.', 1, 10, '2017-07-18 04:05:28', '2017-07-18 04:11:24', NULL, NULL),
(99, 515, NULL, NULL, 'NOC DECK, v3s', 'Bold, simple, and elegant. Perfect for any occasion.\nThe NOC deck by the Blue Crown gets to the heart of the cards themselves and eliminates distractions. The deck has a striking back with a solid bar of color and a thin white border. This puts the emphasis on the work you do with the cards, not on the cards themselves. The original NOC decks were released a few years ago and have become a true modern classic. Now with version 3s produced by the Expert Playing Card company NOC users can benefit from the fun and functional sideways tuck and superior fit and finish of these great cards. Special features include a special reveal inside the tuck flap. A suit marking system and the soon to be classic sideways tuck. The Ace of Spades and Jokers also carry a minimalistic yet attractive design.\nAvailable in 5 striking colors - Collect them all!\nWhether you\'re into a weekly poker game, performing magic tricks, cardistry, or collecting, the NOC deck is a perfect option. The NOC v3s deck is available in 5 vibrant colors to match any mood, wardrobe, or style.', 1, 5, '2017-07-18 04:05:29', '2017-07-18 04:11:25', NULL, NULL),
(100, 516, NULL, NULL, 'Alice in Wonderland', 'These limited edition playing cards, designed by Steven Watson of Turnstyle, are inspired by Lewis Caroll\'s classic fairy tale.\nModern styling combined with lavish Art Nouveau and Art Deco ornamentation transport us down the rabbit hole to a surreal world presided over by the Queen of Hearts.', 0, 15, '2017-07-18 04:05:30', '2017-07-18 04:11:26', NULL, NULL),
(101, 517, NULL, NULL, 'Revelation Deck', 'Inspired by medieval cathedrals, this hand-illustrated deck features gothic details from the catacombs, and beautiful stained glass ornamentations.\nIn tribute to the hand-drawn blueprints sketched by Medieval builders, Revelation is entirely illustrated with a fine-tipped ink pen and the simplest of universal color palettes: Crimson as blood. Black as iron. White as virgin snow.\nAs a crisp, contemporary take on the grandeur of bygone cathedrals, Revelation contains all the opulence of the Medieval church and the minimalism of the workmen and monks who lived their whole lives toiling and never saw the fruits of their labors.\nIn addition to an original box, joker, ace of spades, and back design - all inspired by cathedral stained glass - Revelation also features fully custom skeleton court cards, an homage to the silent skeletons of Norwegian royalty still resting in Nidaros catacombs.', 1, 10, '2017-07-18 04:05:31', '2017-07-18 04:11:27', NULL, NULL),
(102, 518, NULL, NULL, 'MailChimp Playing Cards', 'A collaboration between MailChimp, Fuzzco, and Theory11. Sure to satisfy apes and humans alike.\nMailChimp playing cards are a perfect blend of organic elements and iconic imagery - featuring custom court cards and ultra thin borders. Available in vibrant red and deep black.', 1, 10, '2017-07-18 04:05:31', '2017-07-18 04:11:28', NULL, NULL),
(103, 519, NULL, NULL, 'Antler Limited Edition', 'Born from the wild forests, rolling hills, and snow-capped mountains of Northern California, the Antler Playing Cards showcase the majestic beauty of the great outdoors.\nThis Limited Edition features two fully colored back-designs: Hunter Green and Deep Maroon. The attention to detail in both hand illustration, coloring, and presentation are extraordinary. Twin Bucks are enshrined within beautiful flourishes that mimic the lush greenery found within Yosemite National Park. The Ace of Spades features a noble Buck with herbaceous ornamentation crowning his dignified antlers, and each Joker offers the Antler name.\nEach Limited Edition deck is hand-wrapped in parchment paper before boxing and is sealed within by a perforated stamp for easy opening.\nThe composition of both the cards and box marries the spirit of Nature with the substance of Modernity. Whether they\'re in a canvas tent or a chalet nestled in the valley, they\'re essential in the pockets of anyone who seeks adventure.\nPrinted by The USPCC to our specifications.', 1, 12, '2017-07-18 04:05:32', '2017-07-18 04:11:29', NULL, NULL),
(104, 520, NULL, NULL, 'Antler Playing Cards', 'Born from the wild forests, rolling hills, and snow-capped mountains of Northern California, the Antler Playing Cards embody the majestic beauty of the great outdoors.\nThis Standard Edition features two monochromatic back-designs: Hunter Green and Deep Maroon. Twin Bucks are enshrined within beautiful flourishes that mimic the lush greenery found within Yosemite National Park. The Ace of Spades features a noble Buck with herbaceous ornamentation crowning his dignified antlers, and each Joker offers the Antler name. The tuck-case features rich embossing and metallic accents all around.\nEach deck handles beautifully, but we encourage you to embrace them as much for their superb handling as for the sense of adventure that they inspire. These are as perfect for formal performance as they are for an evening enjoyed around the campfire.\nPrinted by the USPCC to our specifications.', 1, 10, '2017-07-18 04:05:33', '2017-07-18 04:11:29', NULL, NULL),
(105, 521, NULL, NULL, 'Bicycle&reg; Leaf Back', 'The Leaf Back design was originally released in 1947, making these cards historic as well as holiday-appropriate. This all new Limited Edition reproduction incorporates the original leaf pattern with metallic gold accents.\nPrinted by the United States Playing Card Co.', 1, 10, '2017-07-18 04:05:34', '2017-07-18 04:11:30', NULL, NULL),
(106, 522, NULL, NULL, 'Bicycle&reg; Sideshow Freaks', 'This deck is all about a classic sideshow experience. You\'ll see face card characters like the bearded lady, contortionists, fire-breather, sword swallower, lobster boy, and even more on the intricate back. The ring master and monkey round out the deck as the joker cards, all in a tuck that looks like a circus tent.\nThe Sideshow Freaks Deck features original artwork on the front and backs of the cards, including the face cards and jokers. These decks were printed in the USA at the United States Playing Card Company and printed on premium stock with a quality finish.', 0, 10, '2017-07-18 04:05:35', '2017-07-18 04:11:31', NULL, NULL),
(107, 523, NULL, NULL, 'Bicycle&reg; 130th Anniversary', 'The Wheel No. 1 card back design was originally introduced in 1887. This was one of the first few designs used under the Bicycle&reg; brand name. This design was available in red, blue, green, and brown. It remained in print until 1907, when the three-pronged symbol in the center was replaced with a 4-pronged symbol that made the card symmetrical.\nEvery Bicycle&reg; playing card deck is specially crafted so that you can trust Bicycle&reg; cards performance hand after hand. Great for all card games. Great for all players. Available in both Red and Blue.', 1, 5, '2017-07-18 04:05:36', '2017-07-18 04:11:32', NULL, NULL),
(108, 524, NULL, NULL, 'The Design Deck', 'Learn graphic design while playing poker!\nThe Design Deck is a deck of playing cards that doubles as a practical guide to graphic design. Each of the 52 faces contains a useful piece of information about graphic design, including typography, color theory, design techniques, history, and more, with beautiful visual examples.\nPrinted in rich, full color on high-quality Bicycle&reg; stock with air-cushion finish.', 1, 20, '2017-07-18 04:05:37', '2017-07-18 04:11:32', NULL, NULL),
(109, 525, NULL, NULL, 'Bulldog Squeezers&reg;', 'Prior to the mid 1860\'s there were no suits or values in the corners of playing cards. If a player wanted to see his or her entire hand, the cards had to be widely spread or moved from the front of the hand to the back one at a time.\nIn about 1864, card manufacturers came up with a couple of ways to solve this problem. The only ones still popular today are the suit and value indicators that we\'re all familiar with. When this innovation was first introduced, the decks that featured it were called Squeezers.&nbsp;This name came from the fact that players could now squeeze the cards into a small fan to see their entire hand.\nThe name Squeezers&nbsp;is still around as a brand of the US Playing Card Co. which have been in production on and off since 1877. To our knowledge, the USPCC discontinued the brand in 2010. We were lucky to acquire the last of their inventory.', 1, 7, '2017-07-18 04:05:38', '2017-07-18 04:11:33', NULL, NULL),
(110, 526, NULL, NULL, 'Bad Robot Playing Cards', 'Each deck of Bad Robot Playing Cards is sealed with a kraft paper, letterpress wrap that inspires intrigue and endless wonder. Keep it closed, tear it open, or share the experience with a friend. The choice is yours.\nThe Playing cards feature a minimal back design with playful robot characters depicted on each court card.\nDesigned by Bad Robot Production in association with JJ Abrams and Theory11. Printed by the US Playing Cards Co.', 1, 10, '2017-07-18 04:05:39', '2017-07-18 04:11:33', NULL, NULL),
(111, 527, NULL, NULL, 'Bicycle&reg; Aves', 'This beautiful deck of playing cards is inspired by birds from all over the world.\nThe name comes from the proper scientific classification for birds. "Aves" is also Latin and Spanish for "Birds."\nThese fine art playing cards were hand drawn by a world-class artist before being turned into digital art prior to being transformed into gorgeous playing cards, just for you.', 1, 14, '2017-07-18 04:05:39', '2017-07-18 04:11:33', NULL, NULL),
(112, 528, NULL, NULL, 'Rarebit Playing Cards', 'Inspired by a vintage speakeasy restaurant called The Rarebit in Charleston, South Carolina. The new Copper Edition features copper metallic ink on the card backs and faces, all custom court cards, and elegant, simple design by Jay Fletcher.\nAlso available in a limited gold foil back edition.', 1, 15, '2017-07-18 04:05:41', '2017-07-18 04:11:34', NULL, NULL),
(113, 529, NULL, NULL, 'Mechanics, Optricks', '\nThe new Mechanic Optricks deck has been stripped of all embellishments and showcases what "less is more" really means. Composed of simple black and white lines structured in a geometric retro style pattern, just looking at a card starts causing mayhem for your eyes! Riffle through the cards to really make the magic happen.\nKitted out with a hypnotizing and mesmerizing animation that will enhance and give narrative to your magic performances, as well as just looking damn cool!', 1, 10, '2017-07-18 04:05:41', '2017-07-18 04:11:34', NULL, NULL),
(114, 530, NULL, NULL, 'Les Printemps', 'Our dear friends Laurel Brandstetter and Ricky Smith created these cards as a tribute to Robert-Houdin in celebration of their wedding. Originally produced as wedding favors, only a small number of Les Printemps playing cards are now being offered to the public.\nRobert-Houdin was the father of modern magic and is known for many original inventions. One of his most famous is the Orange Tree, a marvelous illusion in which an orange tree blossoms and then gives fruit right before your eyes. The effect ultimately reveals a borrowed ring inside one of the oranges, and is what inspired the way in which Ricky proposed to Laurel.\nLes Printemps playing cards were designed by Mika Machida for Ricky (King of Hearts) and Laurel (Queen of Hearts) and feature a charming illustration of the Orange Tree illusion and a facsimile of Robert-Houdin\'s signature.\nPrinted by The Expert Playing Card Company.', 1, 15, '2017-07-18 04:05:42', '2017-07-18 04:11:34', NULL, NULL),
(115, 531, NULL, NULL, 'Prime Playing Cards', 'Prime Playing Cards is&nbsp;our first custom deck designed and illustrated by Ben Newman in the United Kingdom. Using only primary colors and simple shapes, this deck is striking and simple.\nThe borderless design is ideal for Cardistry techniques such as card fans and display cuts, something our founders know a thing or two about.\nTurn the deck over and you will find a collection of custom illustrations featuring minimal court cards designed from nothing more than shapes and colors.', 0, 12, '2017-07-18 04:05:43', '2017-07-18 04:11:35', NULL, NULL),
(116, 532, NULL, NULL, 'Bicycle&reg; Golden Spike', 'A unique set of playing cards by Jody Eklund inspired by the building of the 1st Transcontinental Railroad.\nGolden Spike Playing Cards are inspired by the completion of the 1st Transcontinental Railroad On May 10th, 1869. It was the first rail line that connected the east to the west and revolutionized transportation and commerce in a post Civil War United States. A Golden Spike was created as a commemorative piece to celebrate the completion of the 1st transcontinental railroad and was driven into the ground where the Union Pacific met the Central Pacific Railroad at Promontory Point, Utah. When the hammer rang out and the golden spike was driven into the ground, a new era of industry and expansion rang out across the United States.\nEach playing card deck has been illustrated using a cross hatch technique to mimic the style of engraving and lithographs that were common to the time period. Each card has been researched and given ample time to create and refine each illustration.', 1, 12, '2017-07-18 04:05:44', '2017-07-18 04:11:35', NULL, NULL),
(117, 533, NULL, NULL, 'Bicycle&reg; Frontier', 'Inspired by tales from pioneers of the American Frontier and the wildlife illustrations sketched in their journals as they made their way out west. Bicycle&reg; Frontier playing cards feature a nostalgic design reminiscent of cards from the late 19th century, and capture the vitality of North America\'s wilderness with drawings of animals found across the continent.\nIllustrated by Will Pitney and printed by The United States Playing Card Company.', 1, 15, '2017-07-18 04:05:45', '2017-07-18 04:11:35', NULL, NULL),
(118, 534, NULL, NULL, 'Tycoon', 'For this deck, professional magician Steve Cohen teamed up with Theory11 to create a deck of playing cards fit for display at the legendary Waldorf Astoria, the gathering place for royalty and the ultra-wealthy.\nFor the past 14 years Cohen has performed Chamber Magic there, in a private Waldorf Towers suite, for sold-out audiences including Warren Buffett, David Rockefeller, and the Queen of Morocco. In 2012, Cohen became the first magician in a half-century to sell out Carnegie Hall. That said, having his own deck of playing cards seems rather appropriate.\nAvailable in Crimson Red and Ming Blue, the cards are produced in the USA using FSC-certified papers derived from sustainable forests, vegetable-based inks, and starch-based laminates.\nFeaturing court cards licensed from Fournier in Villareal de &Igrave;&Ucirc;lava, Spain, the Jacks, Queens, and Kings have skin tone faces - joined by an elegant, debonair Joker and Ace of Spades.', 1, 8, '2017-07-18 04:05:46', '2017-07-18 04:11:36', NULL, NULL),
(119, 535, NULL, NULL, 'Flesh & Bones', 'Flesh &amp; Bones is a completely custom, hand illustrated deck of playing cards, designed in London by Dual Originals.\nEach card has been rigorously designed to create a unique deck that combines digital precision with illustrative flair.\nThe court cards feature detailed, hand-drawn illustrations based on mythical creatures like the Kraken and a Nymph, and ancient gods, such as Triton and Medusa.\nDesigners, Chris and Marylou have always had a passion for the weird and wonderful and wanted to express their take on it through this deck.\nContrastingly, the tuck box and back designs are precise and minimal, consisting of illusional line patterns and geometric shapes.', 0, 12, '2017-07-18 04:05:47', '2017-07-18 04:11:36', NULL, NULL),
(120, 536, NULL, NULL, 'Borderline', 'If you\'re looking for adventure, open a pack of Borderline Playing Cards, start the Gran Torino, and gun it south. Roads become dirt paths, and the lone and level sands stretch far away. The wind howls, and lines etched in the ground by countless boot-heels disappear as two worlds intermingle and dance to the songs of years past.\nCreated by Triana Design, Borderlines were produced to celebrate the rich and vibrant cultures on both sides of the US-Mexico border. Every tuck-case has been specially crafted to feature distinct gold-foil embossing on a brown backdrop. The results are nothing short of phenomenal. In addition, each deck boasts 26 custom illustrations that encapsulate both worlds beyond the borders.\nSo pack a bag, crack open a deck of Borderlines, and head south for the winter.', 1, 12, '2017-07-18 04:05:48', '2017-07-18 04:11:37', NULL, NULL),
(121, 537, NULL, NULL, 'Deck Stays', 'A revolutionary device created by Dan and Dave that provides structural support to the sides of any card box. Think of them as collar stays for a deck of playing cards: laser cut metal supports that reinforce the weakest area of the card box and prevent the inevitable creasing that leaves your tuck case looking old and disheveled.\nEach pair of Deck Stays comes pre-scored with an adhesive backing. Assembly is as easy as snapping them apart, peeling off the backing and sticking the metal struts inside your card box.\nFor ultimate protection, use Deck Stays with a Classic Clip. Your cards will look and feel like new long after you break the seal.', 1, 5, '2017-07-18 04:05:49', '2017-07-18 04:11:37', NULL, NULL),
(122, 538, NULL, NULL, 'Hotcakes', 'Hotcakes is the fifth Limited Edition deck in Uusi\'s six-deck series. With every deck they create Ussi uses a new medium so each one has it\'s own distinctive look. For Hotcakes they chose tempera paints and markers to compliment the spontaneity and playfulness of it\'s full-figured, burlesque monarchy and the Pop Art style of this deck.', 1, 15, '2017-07-18 04:05:50', '2017-07-18 04:11:37', NULL, NULL),
(123, 539, NULL, NULL, 'Framed Deck', 'These custom playing cards were designed with an industrial look by Oliver Schiebener in Germany and printed at the US Playing Card Co.\nLimited edition of 3,000 decks.', 1, 8, '2017-07-18 04:05:51', '2017-07-18 04:11:38', NULL, NULL),
(124, 540, NULL, NULL, 'Voltige', 'After over two years of production, you can now wander down the Champs-elys&eacute;es with a pack of our Voltige playing cards in hand. Designed in collaboration with Henri de Saint Julien &amp; Jacques Denain, the creators behind Tungstene, a deck that\'s become not only a rarity, but a paragon in the collections of those lucky enough to own a pack. We are confident that in the same way as its fabled predecessor, Voltige will quickly become a modern classic.\nVoltige, a name stemming from the french word for aerial often used to describe the apex gesture of a flourish, is a true testament to our creative ingenuity and drive to constantly push the boundaries of custom playing cards. Not unlike Georges Haussmann\'s reconstruction of the streets of Paris, each deck features a design that\'s innovative, modern, and exceptionally bourgeois.\nThe back design is a display of two separate hands working in tandem to reach a singular goal. To us, this is the epitome of not only our life story, but of our brand as a whole. Today we work in tandem to bring you the next chapter in the future of playing cards.', 1, 12, '2017-07-18 04:05:52', '2017-07-18 04:11:38', NULL, NULL),
(125, 541, NULL, NULL, 'Boardwalk Papers', 'Open a sealed pack of nostalgia with each new deck of Boardwalk Papers playing cards. With every shuffle, every cut, and every deal, you\'ll find this deck harkening back to the days when fortunes were won or lost with the turn of a card, and Atlantic City held itself the capital of the Western World.\nPrinted by The Expert Playing Card Company, Boardwalk Papers sport hand-drawn artwork and metallic foil embossings that reflect the golden age of the USA. You\'ll quickly discover that much like the American spirit of yesteryear, they\'re built to last.', 1, 8, '2017-07-18 04:05:53', '2017-07-18 04:11:38', NULL, NULL),
(126, 542, NULL, NULL, 'Bicycle&reg; Cupid Back', 'A 120-year-old design returns in the 21st century.\nThe Cupid Back Deck was originally introduced to the Bicycle&reg; Brand family in 1894, and continued in production until its discontinuation in 1943. Featuring interlocked wheels with the ever-cycling cherub, this deck makes Cupid the central figure. Now this historic deck makes a return so that collectors and fans everywhere can get the chance to own this original design.\nThe Cupid Back Deck contains original artwork on the back of each card and the tuck. Made in the USA at The United States Playing Card Company on premium stock with a quality finish.', 1, 6, '2017-07-18 04:05:54', '2017-07-18 04:11:39', NULL, NULL),
(127, 543, NULL, NULL, 'Bicycle&reg; Madison Back', 'This deck is more than just a way to play cards; it\'s practically d&#809;ecor, inspired by the likes of Jonathan Adler and Vera Bradley. It looks great in your hand and in the tuck, and is available in turquoise or gold.\nThe Madison Deck features original artwork on the front and backs of the cards. These decks were printed in the USA at the United States Playing Card Company and printed on premium stock with a quality finish.', 1, 6, '2017-07-18 04:05:55', '2017-07-18 04:11:39', NULL, NULL),
(128, 544, NULL, NULL, 'Pagan', 'Pagan is the fourth deck in Uusi\'s six deck series. With every deck Uusi create\'s they try to use a new medium so each one has it\'s own distinctive look. For Pagan, Uusi returned to one of the oldest mediums in art and oil paint. All the imagery in the deck was hand painted using traditional oils that give a rich and elegant feel to the courts, card backs and tuck design and add new meaning to the term "wild card"!', 1, 25, '2017-07-18 04:05:56', '2017-07-18 04:11:39', NULL, NULL),
(129, 545, NULL, NULL, 'Private Reserve', 'Individually inspected. Signed, dated and numbered. Sealed with a stamp of authenticity. Supreme&nbsp;luxury. Refined for the card collector.\nThese special edition Private Reserve playing cards from Dan and Dave are breathtaking. Carefully produced to their highest standards, each deck is then individually inspected with a signed and dated Ace of Spades authenticating their true quality.\nFeaturing a gold foil back design imprinted on the cards for a luxurious finish unlike any deck we&rsquo;ve seen before, this Private Reserve deck of playing cards looks and feels as exclusive as they are.\nElegantly packaged with a numbered stamp and sealed with wax for timeless authenticity. Manufactured by the United States Playing Card Company.&nbsp;This is one deck you\'ll be proud to display.', 1, 52, '2017-07-18 04:05:56', '2017-07-18 04:11:40', NULL, NULL),
(130, 546, NULL, NULL, 'Shifters', 'With the help of Canadian graphic artist Curt Shoultz and American illustrator Tiffany Harvey, magician Theron Schaub set out to produce a deck of playing cards he\'d be proud to use in his performances &amp; share with his sleight of hand buddies.\nPrinted at United States Playing Card Company in 2012, these cards were manufactured on Bicycle card stock with an embossed finish. Each deck contains a clear tamper-resistant security strip as well as an authentic USPCC sticker seal which helps maintain packaging integrity.\nWith a standard index face style, these Shifter decks contain a custom Ace of Spades which boasts a tastefully understated fine filigree of swirls &amp; spirals.\nAlso includes two fully custom jokers, a Shifter\'s \'S\' identification card as well as a Shifters ambigram card.', 1, 7, '2017-07-18 04:05:57', '2017-07-18 04:11:40', NULL, NULL),
(131, 547, NULL, NULL, 'Bicycle&reg; Dragon Back', 'Each Bicycle&reg; Dragon deck features an intricate, mirror image dragon design on the card backs with vibrant colors, coordinated with face cards.\nThe vintage Bicycle&reg; Dragon design, with attention to detail and vivid color, makes this deck truly unique and one of a kind. Available in three unique color combinations.', 1, 7, '2017-07-18 04:05:58', '2017-07-18 04:11:40', NULL, NULL),
(132, 548, NULL, NULL, 'Nautical Playing Cards', 'The Nautical Deck is the brainchild of artist Edo Huang, and is reminiscent of a classic bordered Bee design. Everything about the deck is inspired by the sea. From the rope-like pattern &amp; life preservers integrated into the back design, to the rope border on the court cards, and the impressive ship joker.\nThe cards are printed on a thin, flexible, and durable stock that\'s manufactured and hand-finished in Shanghai. The more they are used, the better these cards perform! The cards have a fine embossed texture, with a feel and handling unlike any other deck we\'ve produced to date!', 1, 7, '2017-07-18 04:05:59', '2017-07-18 04:11:41', NULL, NULL),
(133, 549, NULL, NULL, 'Mustache Playing Cards', 'In celebration of Movember&nbsp;we are thrilled to offer this whimsical 4-color deck featuring mustaches on every pip - perfect for poker, bridge, or any other standard card games. Produced by Vanda Cards and backed by Kickstarter this limited edition deck won\'t be around for long so pick one up while you still can and join the Movember movement!', 1, 10, '2017-07-18 04:06:00', '2017-07-18 04:11:41', NULL, NULL),
(134, 550, NULL, NULL, 'DeckStarter&reg; Brand Deck', 'Promotional deck for&nbsp;DeckStarter*,&nbsp;a platform that&nbsp;allowed designers to create their own playing cards.\nBack in 2012 when we&nbsp;began working on the concept of DeckStarter we&nbsp;designed and printed an exclusive deck of brand playing cards.&nbsp;Only a limited number was printed and once they sell out here they will be gone forever.\n*DeckStarter launched in 2013 with a mission to offer a dedicated funding platform for custom designed playing cards. Supported by friends, fans and the public, it was the easiest way to get your own deck into the hands of playing card enthusiasts all over the world. With the&nbsp;help of the community, they successfully funded 7 original decks of playing cards.&nbsp;In January 2015 we decided to close DeckStarter in order to focus our attention on Art of Play.', 1, 7, '2017-07-18 04:06:01', '2017-07-18 04:11:41', NULL, NULL),
(135, 551, NULL, NULL, 'Texan', 'Made to look like an authentic "Texan" playing cards from the wild west. The cards are tinted a yellow color, the pips and face-cards have an antique design, and the backs have a "lone star" emblem to make them look as though they had been pulled directly out of a nineteenth century, El Paso saloon.\nPrinted in Cincinnati&nbsp;at the old U.S. Playing Card Co.&nbsp;', 1, 12, '2017-07-18 04:06:01', '2017-07-18 04:11:42', NULL, NULL),
(136, 552, NULL, NULL, 'Medallions', 'A blend of sheer elegance and striking beauty. A timeless object infused with supreme luxury from the Victorian era.\nThe deep brown tuck case features the new ultra-lux matte paper found on our Red Monarchs. It\'s covered top to bottom in a striking gold foil.\nThe design is accented by embossed stitch elements in the front and sealed with a precision printed gold foil sticker seal. It doesn\'t stop there. Theory11 used metallic ink on the back and hand-illustrated custom court cards.\nDesigned in Paris, France by JC Desevre.', 1, 10, '2017-07-18 04:06:02', '2017-07-18 04:11:42', NULL, NULL),
(137, 553, NULL, NULL, 'Bicycle&reg; Tangent Back', 'Today we offer a limited supply of Bicycle&reg; Tangent Back playing cards from the Vintage Design series. Printed almost a decade ago&nbsp;at the U.S. Playing Card Company\'s old Cinncinati factory, the edition has been out of print and difficult to find for a few years now. They are blue seal, a mark of nostalgic quality desired by cardicians.\nFor our 25 Days of Christmas promotion, we dug into our collection for a very limited supply to offer you. Today only, they are available again, in both colors, red and blue.\nThe Tangent Back was originally in production from 1907 to 1939 and features intricate details, and includes the original Ace of Spades design from the period.\nThe Vintage Design series revisited several out of print designs from Bicycle\'s vast catalog of past editions. There were several reprinted for the series. The Tangent Back has always been one of our favorites and we\'re happy to offer it up for sale again.', 1, 12, '2017-07-18 04:06:03', '2017-07-18 04:11:42', NULL, NULL),
(138, 554, NULL, NULL, 'Bicycle&reg; Thistle Back', 'This Bicycle Vintage Design Series recreates historic Bicycle playing card designs from the last 120 years. Thistle back design: the elves were taken from designs used by the New York Consolidated Company who merged with The United States Playing Card Company.', 1, 12, '2017-07-18 04:06:04', '2017-07-18 04:11:43', NULL, NULL),
(139, 555, NULL, NULL, 'Classic Clip', 'The Classic Clip is an indispensable utility item that will add months of life to your playing cards. Our exclusive design is precision crafted to balance function with style and we&rsquo;re confident you&rsquo;ll find this clip to be the best on the market.\nDesigned to protect a pack of 52 poker-size playing cards in their tuck case, the clip measures approximately 3.5 x 2.5 x .5 inches. Available in black and silver.', 1, 30, '2017-07-18 04:06:05', '2017-07-18 04:11:43', NULL, NULL),
(140, 556, NULL, NULL, 'Madison Dealers', 'When Daniel began designing the Madison Dealers, the borderless design was an imperative element for him, not for the single advantage it lends to certain gambling sleights, but also because of how beautiful the deck looks when the design bleeds the side of the entire deck.\nIn creating this new edition of the Dealers, he didn\'t just want to offer a new color, but instead wanted to do something different. He was very intrigued to see how the Dealers would look with a thin border, and when the test deck arrived, he had to get these out there.\nWe love these as much as we love the Green Dealers and think that they compliment each other perfectly, and now, you have the best of both worlds with an edition fit for the table, as well as one fit for magic.', 1, 80, '2017-07-18 04:06:06', '2017-07-18 04:11:43', NULL, NULL),
(141, 557, NULL, NULL, 'Erdnase Smith Back No. 2', 'This deck is named Smith in honor of Marshall D. Smith the illustrator of The Expert at the Card Table. The overall Bee-like pattern is actually made up of tiny reproductions of the hands in the illustrations of the great card classic.', 1, 7, '2017-07-18 04:06:06', '2017-07-18 04:11:44', NULL, NULL),
(142, 558, NULL, NULL, 'Bicycle&reg; Lumberjack', 'Embrace your inner woodsmen with these beautiful Bicycle&reg; Lumberjack inspired playing cards. Custom designed from front to back and printed by the United States Playing Card Company.', 1, 12, '2017-07-18 04:06:07', '2017-07-18 04:11:44', NULL, NULL),
(143, 559, NULL, NULL, 'Erdnaseum', 'These cards were produced by Dan and Dave Buck in collaboration with Bill Kalush and the Conjuring Arts Research Center for the Erdnaseum event held in August of 2011 in Montana. The back design logo is an ambigram of S.W. Erdnase and W. E. Sanders, a possible (albeit unlikely) candidate for Erdnase himself. The overall back design is commonly referred to as the Bee Worm back.', 1, 8, '2017-07-18 04:06:08', '2017-07-18 04:11:44', NULL, NULL),
(144, 560, NULL, NULL, 'Bumble Bee&reg;', 'These cards were initially used to satisfy casino clients that either couldn\'t afford or hadn\'t yet designed and ordered their own branded decks. The quality is typically excellent, as are all Bee&reg; cards. They don\'t come up for sale often and have occasionally been restricted from public sales at USPCC-owned retail outlets.\nPrinted in Cincinnati, Ohio at the old USPCC factory.', 1, 12, '2017-07-18 04:06:09', '2017-07-18 04:11:45', NULL, NULL),
(145, 561, NULL, NULL, 'Bicycle&reg; Robocycle', 'Who doesn\'t love robots? From the Twilight Zone to C-3PO to Cylons, robots are an iconic part of pop culture. That\'s why Bicycle&reg; Playing Cards created the Robocycle Deck, a one-of-a-kind deck featuring a circuit-inspired back and all-robot court cards. In red, black, gray, and metallic gold, these cards are a unique addition to any collection.\nThe Robocycle Deck contains original artwork on the back of each card, the court cards, the Ace of Spades, and the tuck. Made in the USA at The United States Playing Card Company on premium stock with a quality finish.', 1, 6, '2017-07-18 04:06:10', '2017-07-18 04:11:45', NULL, NULL),
(146, 562, NULL, NULL, 'Charity: Water', 'You can make a difference. You can save a life. You can change the world.\ncharity: water&nbsp;is a non-profit organization bringing clean and safe drinking water to people in developing nations. Over the past five years, charity: water has raised&nbsp;$50 million&nbsp;and funded 4,282 water projects.\nUnsafe water and lack of basic sanitation kill more people every year than all forms of violence, including war.&nbsp;30,000 people&nbsp;die every week from unsafe water, and 90% of those deaths are under the age of five. With your support, we can make a difference.\nProceeds from this deck of playing cards go directly to charity: water.\nThese funds will be used to further develop and grow their organization, providing essential support for their operations worldwide. charity: water has already provided water to over&nbsp;2,000,000 people&nbsp;in 19 countries. On average, each well built costs $5,000 and serves a community of up to 250 people.\nProduced by theory11 and manufactured by The United States Playing Card Company, these are playing cards for a cause. You\'re not just purchasing a deck, you\'re providing a solution to those in need. You\'re leading the way to help&nbsp;end the water crisis.\nDesigned by charity: water in collaboration with theory11, these playing cards are produced using paper made from&nbsp;hydroelectric power&nbsp;and renewable energy sources.', 1, 10, '2017-07-18 04:06:11', '2017-07-18 04:11:45', NULL, NULL),
(147, 563, NULL, NULL, 'Misc. Goods Co.', 'Designed by Tyler Deeb and launched on Kickstarter in 2012 to unprecedented success. From this deck, Misc. Goods Co. was formed.\nOffered are all three versions of the deck, including the first edition white deck, which is the original deck released on Kickstarter. It is limited to only 10,000 decks and will never be reproduced.', 1, 12, '2017-07-18 04:06:12', '2017-07-18 04:11:46', NULL, NULL),
(148, 564, NULL, NULL, 'Bohemia', 'Bohemia is the second deck in Uusi\'s eventual six deck series. The artwork for Bohemia was inspired by the unlikely pairing of 17th-century Baroque style with contemporary, urban street art. Each have a flair for drama, tension and grandeur that when mixed together create one lush, combustible style!\nAll imagery in the deck is taken from entirely hand-painted, gouache illustrations. Every single card, right down to the pips and indices is painted in varying shades of luminous blue for the dark suits of Spades and Clubs and lushly romantic red for the light suits of Hearts and Diamonds.\nFifty-two playing cards and two jokers, all with unique art that makes it ideal for magic and card games due to being unique and eye-catching, yet at the same time very familiar and immediately recognizable by players and spectators alike. Bohemia is a true original.', 1, 25, '2017-07-18 04:06:13', '2017-07-18 04:11:46', NULL, NULL),
(149, 565, NULL, NULL, 'A.Bandit', 'These playing cards were produced by art collective A.Bandit (Derek DelGaudio and Glenn Kaino) for their show, The Space Between, in 2011. The back design is based on a sketch by Ren&#809; Descartes, which illustrated the phenomenon of Alexander\'s band, the space between a double rainbow.\nOriginally these cards were only available at their show, however, a small supply of them were eventually distributed and quickly sold out. In 2012, they were featured in Dan and Dave\'s Variety Box, a curated collection featuring 12 of the finest decks of playing cards in the world.', 1, 30, '2017-07-18 04:06:14', '2017-07-18 04:11:46', NULL, NULL),
(150, 566, NULL, NULL, 'Animal Kingdom', 'Animal Kingdom&nbsp;Playing Cards feature hand-illustrated custom artwork - even the court cards were designed by hand from scratch.\nMade in the USA on FSC-certified paper derived from sustainable forests, starch-based laminates, and vegetable-based inks. Illustrated by&nbsp;Hatch Design&nbsp;in San Francisco for Theory11.', 1, 10, '2017-07-18 04:06:15', '2017-07-18 04:11:47', NULL, NULL),
(151, 567, NULL, NULL, 'Love Me', 'Hand-illustrated playing cards by artist Curtis Kulig.\nCurtis Kulig\'s signature statement \'Love Me\' can be seen in galleries and rooftops around the world, as well as collaborations with major brands including&nbsp;OBEY, Vans, and Urban Outfitters. The message is timeless and universal.\nThe cards feature an original Ace of Spades, Joker, Back Design, Box Design, Sticker Seal, and Ace of Hearts - renamed the Ace of Love. The box is striking, with vibrant red foil accents on premium linen paper.\nPrinted by the U.S. Playing Card Co.', 1, 10, '2017-07-18 04:06:15', '2017-07-18 04:11:47', NULL, NULL),
(152, 568, NULL, NULL, 'Steamboat 999', 'The Steamboat 999 was first introduced in 1883 by the Russell, Morgan &amp; Company, now the US Playing Card Co. The brand lasted for over a century before being discontinued. As one of our favorite decks we convinced the USPCC to allow us to reprint them to their original specification with a smooth finish on ultra thin paper.\nWe think the outcome is better than the original. New features include an updated case box with embossed elements and an off-white bleed on the face cards for a vintage aesthetic. Available in the original Red and Blue colors.', 1, 8, '2017-07-18 04:06:16', '2017-07-18 04:11:47', NULL, NULL),
(153, 569, NULL, NULL, 'Tally-Ho&reg; Fan Back', 'Playing card manufacturer Andrew Dougherty began printing Tally-Ho cards in approximately 1885. Although there have been at least a half-dozen back designs over the years, the Fan Backs and Circle Backs are the only ones to survive today.\nMost top professionals consider a deck of Tally-Ho cards to be among the best cards ever produced. For the price, we think so too!', 1, 4, '2017-07-18 04:06:17', '2017-07-18 04:11:48', NULL, NULL),
(154, 570, NULL, NULL, 'Ultimate Deck', 'The Ultimate Deck is a one-of-a-kind, luxury deck of playing cards showcasing stunning works of art on every card. Produced in collaboration with award-winning design firm, Stranger &amp; Stranger.\nThe Ultimate Deck features 54 unique works of art, each with an elaborate back design.&nbsp;Every single card in the Ultimate Deck is represented with a story, incorporating classical art, as well as works from todays leading illustrators.\nPackaged in a gorgeous tuck-case of extraordinary detail featuring embossed elements and foil accents. Each deck is carefully packaged and sealed with a vintage-inspired tax stamp.', 1, 25, '2017-07-18 04:06:18', '2017-07-18 04:11:48', NULL, NULL),
(155, 571, NULL, NULL, 'Famous', 'Designed by Best Made in New York, printed in Erlanger, Kentucky by the United States Playing Card Company (legendary makers of the Bicycle and Bee brands). We enlarged the numbers and symbols, streamlined the face cards to geometric bliss, added some lightning bolts or two, and above all we gave our cards the much needed whitespace and breathing room for your eyes (so you can play by the glow of a campfire). Made for us exclusively by America\'s foremost maker of playing cards, the company most trusted by casinos, card sharks, bamboozlers, fabulists, magicians, and maligners the world over.', 1, 10, '2017-07-18 04:06:19', '2017-07-18 04:11:48', NULL, NULL),
(156, 572, NULL, NULL, 'Smoke & Mirrors', 'Back by popular demand, the entire selection of Smoke &amp; Mirror Playing Cards available now for individual purchase.\nSmoke &amp; Mirrors brand playing cards were designed to be a personal deck for Dan and Dave. They were custom tailored to their taste with original art by Si Scott. That was back in 2007. The cards quickly sold out so they printed more, and more, and more. Eventually they changed the color and altered the design to fit their minimal style. For five straight years they released a new "version" of the brand until 2012 when they decided to revamp the entire series and release them all in a limited edition box set.', 1, 20, '2017-07-18 04:06:20', '2017-07-18 04:11:49', NULL, NULL),
(157, 573, NULL, NULL, 'Bicycle&reg; Steampunk', 'Steampunk is both a literary sub-genre as well as an artistic, social, and fashion movement. Although the movement gained momentum in the late 1980s, it draws on design elements dating back over 100 years.\nThis unique deck feature pays homage to the movement. Produced by Theory11 for the US Playing Card Co. with Romanian artist Alex Beltechi. Bicycle&reg;&nbsp;Steampunk playing cards are available&nbsp;in&nbsp;both bronze and silver editions. These cards are made to very exacting standards and come in an embossed box with polished metallic contours.', 1, 10, '2017-07-18 04:06:21', '2017-07-18 04:11:49', NULL, NULL),
(158, 574, NULL, NULL, 'DeckONE', 'How could one of the world\'s finest coin magicians design such a fantastic deck of cards? Because Homer Liwag is first and foremost an artist. He created all of the images including the box, back design, Jokers, face cards and the Ace of Spades himself and insisted on using one of the highest grades of paper (Q1 quality) from USPCC. The result is a truly wonderful deck taking inspirations from Homer\'s 30-plus years of design and art experience as well as his unabashed love of a specific series of movies set in a galaxy far, far away.', 1, 10, '2017-07-18 04:06:22', '2017-07-18 04:11:49', NULL, NULL),
(159, 575, NULL, NULL, 'Fulton\'s Clip Joint', 'Post WWII Los Angeles. In the dead of night you enter Fulton\'s, a clip joint hidden in the murk of downtown. Take your seat and stash your heat; your drink is on its way. Smoke curls along the crown molding and lingers in the air. What little light there is tingles through the vapors as a femme fatale appears between the shadows. She\'ll be by soon. Get cozy, you\'re in for the night - it\'s either that or put up a fight. In a few hours your boys will join you. For now, a deck of cards from inside your coat is tossed on the table and your fedora set aside. As broads sit and sip, gents go for the grift. Are you in?\nFulton\'s Clip Joint Playing Cards celebrate our fascination with cinema, history, and the art of the grift. Taking inspiration from vintage Los Angeles and Film Noir, Fulton\'s captures a time and place where men were men, women were dames, and the next deal could be your last.', 1, 15, '2017-07-18 04:06:22', '2017-07-18 04:11:50', NULL, NULL),
(160, 576, NULL, NULL, 'Arrco&reg; U.S. Regulation', 'Although historically not as highly regarded as the Tahoe No. 84 decks, the Arrco&reg; U.S. Regulation cards are an excellent card favored by several famous magicians. These cards were usually produced with a full color Joker and a black and white Joker. Other than color, the Jokers were identical. Most of the decks seen today still say Arrco on the boxes, even though the company was acquired by USPCC in the late 1980s.\nPrinted in Cincinnati, Ohio at the old USPCC factory.', 1, 15, '2017-07-18 04:06:23', '2017-07-18 04:11:50', NULL, NULL),
(161, 577, NULL, NULL, 'Artisans', 'Designed by South African artist Simon Frouws, Artisans are one of the more ornate decks on the market. No less than David Copperfield has described them as the best playing cards ever produced. Available in both black and white editions, Artisans are beautiful, elegant and made to the highest standards possible by the USPCC.', 1, 10, '2017-07-18 04:06:24', '2017-07-18 04:11:50', NULL, NULL),
(162, 578, NULL, NULL, 'Ask Alexander', 'This unique back design depicts the famous question-mark turban image of Claude Conlin, the vaudeville-era performer better known as Alexander, a well known figure in the world of magic. The deck contains several secrets including a one-way back design that continues to work even when the large, obvious image of Alexander is apparently turned and shuffled haphazardly. Produced by the Conjuring Arts Research Center in New York.', 1, 8, '2017-07-18 04:06:25', '2017-07-18 04:11:51', NULL, NULL),
(163, 579, NULL, NULL, 'Bicycle&reg; Eco', '"Go green" with this new environmentally friendly and recyclable deck of cards crafted from sustainable forest paper, starch-based laminating glue, and vegetable-based printing inks. On top of that, the back design and red faces have been replaced with a nice desaturated forest-green color.', 1, 6, '2017-07-18 04:06:26', '2017-07-18 04:11:51', NULL, NULL),
(164, 580, 26, NULL, 'Bicycle&reg; Rider Back', 'Still the undisputed king of current popular cards with working professionals, Rider backs are seen in more books, on more videos and DVDs, and in the hands of more top card guys than any other brand. The back design is probably the most recognizable in the world, having been in constant production since 1887. They were originally produced in red, blue, green and brown, but the green and brown decks were dropped in 1927.\nAlthough most magicians mean Rider backs when they say "Bicycles," it is important to note that over 80 different back designs have been made under the Bicycle name. This was the second, the first being the Old Fan backs produced in 1885.', 1, 3, '2017-07-18 04:06:27', '2017-07-18 04:33:58', NULL, NULL),
(165, 581, NULL, NULL, 'Game of Death', 'Commemorating Chinese culture in observance of the lunar new year, Fulton\'s Chinatown Playing Cards were inspired by the red envelope tradition and honor&nbsp;The Year of The Dragon, 2012. They\'re the luckiest deck you\'ll ever use.\nThis special Game of Death edition of Fulton\'s Chinatown Playing Cards honor&nbsp;Bruce Lee, a cultural icon and hero of martial arts. Even though his teachings went against tradition, he believed in himself and changed the art forever. His wisdom continues to inspire new generations of athletes, artists, entrepreneurs and professionals in all fields and forms. It is an honor to attribute such a great man with this deck of cards.\nAs a child, Brad Fulton eagerly awaited the coming of Chinese New Year, a holiday where his Aunt Kareen and Uncle Dennis would present a beautiful bright red and gold envelope filled with lucky money. To commemorate those happy feelings and bring luck to you all, we present Fulton\'s Chinatown Playing Cards.\n"Chinatown Los Angeles holds a special place historically and personally. It has always evoked and cultivated an aura of magic, mystery, and vibrant energy. With this deck I pay respect to a holiday and location associated with good luck and endless possibilities."\n- Brad Fulton', 1, 9, '2017-07-18 04:06:28', '2017-07-18 04:11:52', NULL, NULL),
(166, 582, NULL, NULL, 'Bee&reg;', 'Bee&reg; brand playing cards were originally produced in 1892. Although it is one of the oldest designs and it is the only one that\'s been in production since its creation, it wasn\'t the only Bee&reg; card. There are over two-dozen back designs that were produced under the Bee&reg; name by the New York Consolidated Card Company in the late 1800s. Many of these older Bee&reg; designs had white borders and beautiful scrollwork depicting beehives and other bee-related images.\nSometime in the 1960s these cards became the standard playing card in the casino industry - a position they still hold to this day.', 1, 3.5, '2017-07-18 04:06:29', '2017-07-18 04:11:52', NULL, NULL),
(167, 583, NULL, NULL, 'Ace Fulton\'s Casino', 'These souvenir playing cards are inspired by what was once offered complimentary to guests of Ace Fulton\'s Casino in Las Vegas.\nReminiscent of vintage playing cards from casino\'s like Jerry\'s Nugget, the Ace Fulton\'s Casino playing cards combine a retro style with a modern stock and finish. No detail was left unnoticed, including a few "security" measures built into the deck. Ace wouldn\'t tell us though, so we\'ll leave them for you to discover.\nPrinted by the U.S. Playing Card Co. Housed inside a premium embossed tuck box.', 1, 15, '2017-07-18 04:06:29', '2017-07-18 04:11:52', NULL, NULL),
(168, 584, NULL, NULL, 'Tally-Ho&reg; Circle Back', 'Playing card manufacturer Andrew Dougherty began printing Tally-Ho cards in approximately 1885. Although there have been at least a half-dozen back designs over the years, the Fan Backs and Circle Backs are the only ones to survive today.\nMost top professionals consider a deck of Tally-Ho cards to be among the best cards ever produced. For the price, we think so too!', 1, 4, '2017-07-18 04:06:30', '2017-07-18 04:11:52', NULL, NULL);
INSERT INTO `crawling_card_data` (`id`, `card_page_id`, `card_id`, `brand_id`, `name`, `description`, `in_stock`, `price`, `created_at`, `updated_at`, `deleted_at`, `variation_id`) VALUES
(169, 585, NULL, NULL, 'Aviator&reg;', 'These cards were originally produced to commemorate Charles Lindbergh\'s solo flight across the Atlantic. The Standard Playing Card Co. took an existing back design from their catalog (the #914) and renamed it the Aviator brand. The original Aviator boxes showed a silhouette of Lindbergh\'s Spirit of St. Louis aircraft. Later editions depicted a twin-engine propeller-driven craft and today\'s version shows a modern jet airplane.\nAviator cards are thinner and less expensive than most of the mid and high-quality brands. Right out of the box they still handle well and for certain sleights and moves they\'re ideal. The thinner stock means they won\'t hold up as long as a deck of Bicycle or Tally-ho cards but they\'re not designed for that. They\'re an entry-level playing card designed for people that want to play a quick game of solitaire and be done with them. We\'ve found them to be excellent for practicing false deals as the thin stock allows you to buckle and maneuver the cards as you see fit.\nIn August 2015 Dan and Dave, in collaboration with the US Playing Card Co. released a new version titled&nbsp;AVIATOR&reg; Heritage Edition. They are available in our shop.', 1, 3, '2017-07-18 04:06:31', '2017-07-18 04:11:53', NULL, NULL),
(170, 586, NULL, NULL, 'Aristocrat&reg;', 'What magicians refer to as Aristocrats trace their history to the American Banknote Company. They only produced playing cards for a short period but were famous for their superbly intricate scrollwork. ABN sold out to the Russell Card Co. (no relation to the Russell of Russell &amp; Morgan). Production of the ABN cards continued at the Russell Co.\'s Milltown, New Jersey plant. The Aristocrat line was introduced in approximately 1915 and was produced until the early 1980s.\nThe USPCC recently resurrected this old back design and are producing them again. The new versions use a different shade of red and blue on the backs and the face cards, but still have that classically beautiful scrollwork design.', 1, 5, '2017-07-18 04:06:32', '2017-07-18 04:11:53', NULL, NULL),
(171, 587, 89, NULL, 'Arrco&reg; Tahoe', 'In the late 1970s and early 1980s the Arrco&reg; Tahoe\'s were some of the finest cards available anywhere in the world.&nbsp;\nWhen USPCC purchased Arrco&reg; in the late 1980s, production of Arrco&reg; cards ceased. They became highly sought-after collectibles and still command high prices on the secondary market. A few years ago, the Tahoe back design was faithfully reproduced by a private company. Get them while you can.', 1, 13, '2017-07-18 04:06:33', '2017-07-18 04:35:49', NULL, 92),
(172, 588, 76, NULL, 'Vintage Plaid, 1st Printing', 'Similar in design to the&nbsp;recently reprinted Vintage Plaid, Arizona red. These older editions were printed in 2012.\nAvailable in Striking Arizona Red and Casual California Blue, our Vintage Plaid playing cards offer themselves as the missing piece in every gentleman\'s rucksack. Although perfect for everyday use, Vintage Plaid begs to accompany you in all aspects of adventure. Whether it be traversing great rivers, hunting big game, or traveling into the strange, no journey is complete without a pack on hand. So pull up a seat to the fire, pour yourself a drink, and remember, Bad luck is bad play.\n"For us, these cards bring back fond memories of childhood camping trips with our grandfather. Watching him pitch a tent, reel in a fish, and bring fire ablaze under a starry night were magical moments we never forgot. In honor of those days by the river and nights under the stars, we are proud to offer these new playing cards."\nPrinted by the US Playing Card Company on premium stock with a cambric finish. Incorporating a leatherette tuck case, off-white faces, and an organic array of colors, no detail has been spared. Packaged in a bespoke carton for orders of a dozen or more.', 1, 20, '2017-07-18 04:06:34', '2017-07-18 04:36:13', NULL, 79),
(173, 606, NULL, NULL, 'Camp Cards, Ranger Ed.', 'Now in its third print run, the latest edition of our popular Camp Cards&nbsp;feature a new green&nbsp;colorway and updated back design. Additionally, we\'ve added a burnt-orange color tone to the face cards to make identifying&nbsp;the suits easier than ever.\nDesigned for those who venture onward and live adventurously. Illustrated by&nbsp;1924US&nbsp;in collaboration with adventure brand,&nbsp;Bradley Mountain.\nIn each pack you&rsquo;ll enjoy custom designed woodland court-cards amidst hand-lettered spot cards, each laid against a ivory&nbsp;background and precisely printed by the U.S. Playing Card Co. The cards are encased in a beautiful letterpress-printed box that features a map of Yosemite Valley on the inside.\nLimited edition of&nbsp;5,000.', 1, 12, '2017-07-18 04:06:35', '2017-07-18 04:11:54', NULL, NULL),
(174, 607, NULL, NULL, 'Skateboard Deck', 'Ride through the concrete jungle and feel the urban grittiness of skate culture in the palms of your hands. Coming straight out of Canada and the mind of Kevin Yu, is a deck of playing cards that radiate an effortlessly cool vibe.\nFeaturing vibrant, eye-popping colors and a completely custom design, it is clear that Skateboard playing cards are the badass love child of Cardistry and Skater Culture.\nPrinted by the U.S. Playing Card Co. on the raddest quality stock and finish available.', 1, 15, '2017-07-18 04:06:36', '2017-07-18 04:11:54', NULL, NULL),
(175, 608, NULL, NULL, 'Drifters', 'For the ramblers. For the gamblers. For the drifters: The hand that life deals us can never be predicted.\nEvery shuffle and cut of the cards is a reminder to never settle, to chase a life of freedom. The wilderness holds the answers, like the cards held in your hands. For those who seek adventure upon the horizon, be sure to pack a deck of Drifters.\nFeaturing a custom letter-pressed tuck case and beautifully illustrated faces, Drifters was designed by Curtis Jenkins, illustrator of Monarchs playing cards, in collaboration with Dan and Dave. Proudly printed to the highest possible standards by the U.S. Playing Card Company.', 1, 12, '2017-07-18 04:06:36', '2017-07-18 04:11:55', NULL, NULL),
(176, 609, NULL, NULL, 'Cina Deck by Misc. Goods', 'From Misc. Goods Co. we are pleased to present their newest pack of playing cards. The&nbsp;Cina Deck is a completely redesigned edition of their trademark deck done by artist Michael Cina. The illustrations on the cards have been redone; from the tuck case to every symbol, court card and even the typography.\nPrinted by the U.S. Playing Card Co.', 1, 15, '2017-07-18 04:06:37', '2017-07-18 04:11:55', NULL, NULL),
(177, 610, NULL, NULL, 'Classic Clip, Limited Charcoal Ed.', 'Our popular Classic Clip, anodized in a charcoal colorway for D&amp;D provides an industrial-look to the standard black and silver edition.\nThe Class clip is an indispensable utility item that will add months of life to your playing cards. Our exclusive design is precision crafted to balance function with style and we&rsquo;re confident you&rsquo;ll find this clip to be the best on the market.\nUnlike&nbsp;our standard edition clips the interior of these clips are engraved with the D&amp;D logo. Limited Edition&nbsp;of 52.\nDesigned to protect a pack of 52 poker-size playing cards in their tuck case, the clip measures approximately 3.5 x 2.5 x .5 inches. Available in black and silver.', 1, 30, '2017-07-18 04:06:38', '2017-07-18 04:11:55', NULL, NULL),
(178, 611, NULL, NULL, 'Twin Leather Case', 'This unique offering from Misc. Goods Co. is designed to house two decks of poker-size playing cards.\nHandmade in the&nbsp;USA from&nbsp;vegetable tan leather, golden wax coated cotton tread, a red strap and two natural brass O-rings.\nEach case comes equipped with one ivory and one red&nbsp;branded deck of cards.', 1, 88, '2017-07-18 04:06:38', '2017-07-18 04:11:56', NULL, NULL),
(179, 456, 94, 11, 'Inception - Intellectus Standard', 'The Intellectus Playing cards are printed by the Legends Playing Card Co. Each court, Ace and Joker cards will have original illustrations, capturing the feel of the era.  The Cards will be printed on the Classic Finish, which is the highest quality card stock that Legends has to offer.  The Tuck will feature copper foiling and embossing.', 1, 15, '2017-07-30 01:24:49', '2017-07-30 01:24:57', NULL, 102);

-- --------------------------------------------------------

--
-- Structure de la table `crawling_card_pages`
--

CREATE TABLE `crawling_card_pages` (
  `id` int(10) UNSIGNED NOT NULL,
  `crawler_id` int(10) UNSIGNED NOT NULL,
  `card_id` int(10) UNSIGNED DEFAULT NULL,
  `url` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_run_success` tinyint(1) NOT NULL DEFAULT '1',
  `last_run` datetime DEFAULT NULL,
  `last_completion` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Contenu de la table `crawling_card_pages`
--

INSERT INTO `crawling_card_pages` (`id`, `crawler_id`, `card_id`, `url`, `last_run_success`, `last_run`, `last_completion`, `created_at`, `updated_at`, `deleted_at`) VALUES
(2, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/52-plus-joker-deck-gold-edition?limit=100', 1, NULL, NULL, '2017-06-12 07:49:26', '2017-06-12 07:49:26', NULL),
(3, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/v2-absinthe-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:26', '2017-06-12 07:49:26', NULL),
(4, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/aladdin-dome-back-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:26', '2017-06-12 07:49:26', NULL),
(5, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/aladdins-1001-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:26', '2017-06-12 07:49:26', NULL),
(6, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/amour-playing-cards-luxury-edition?limit=100', 1, NULL, NULL, '2017-06-12 07:49:27', '2017-06-12 07:49:27', NULL),
(7, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/red-amour-playingcards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:27', '2017-06-12 07:49:27', NULL),
(8, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/theory11-animal-kingdom-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:27', '2017-06-12 07:49:27', NULL),
(9, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/antler-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:27', '2017-06-12 07:49:27', NULL),
(10, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/Anubis-Osiris-Playing-Cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:27', '2017-06-12 07:49:27', NULL),
(11, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/aquila-limited-edition?limit=100', 1, NULL, NULL, '2017-06-12 07:49:27', '2017-06-12 07:49:27', NULL),
(12, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/arcana-tarot-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:27', '2017-06-12 07:49:27', NULL),
(13, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/arcanum-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:27', '2017-06-12 07:49:27', NULL),
(14, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/Architect-Playing-Cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:27', '2017-06-12 07:49:27', NULL),
(15, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/Aristocrat-V-PlayingCards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:27', '2017-06-12 07:49:27', NULL),
(16, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/green-aristocrat-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:27', '2017-06-12 07:49:27', NULL),
(17, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/arrco-tahoe-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:27', '2017-06-12 07:49:27', NULL),
(18, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/Arrco-US-Regulation-Playing-Cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:27', '2017-06-12 07:49:27', NULL),
(19, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/art-of-cardistry-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:27', '2017-06-12 07:49:27', NULL),
(20, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/artifice-tundra-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:27', '2017-06-12 07:49:27', NULL),
(21, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/artisan-playing-cards-luxury-edition-laser-etched-wood-box-set?limit=100', 1, NULL, NULL, '2017-06-12 07:49:27', '2017-06-12 07:49:27', NULL),
(22, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/AURELIAN-PLAYING-CARDS?limit=100', 1, NULL, NULL, '2017-06-12 07:49:27', '2017-06-12 07:49:27', NULL),
(23, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/aurum-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:27', '2017-06-12 07:49:27', NULL),
(24, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/avante-garde-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:27', '2017-06-12 07:49:27', NULL),
(25, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/aviator-heritage-edition-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:27', '2017-06-12 07:49:27', NULL),
(26, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/aviator-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:27', '2017-06-12 07:49:27', NULL),
(27, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/mystery-deck-theory11-x-jj.abram-collaboration?limit=100', 1, NULL, NULL, '2017-06-12 07:49:27', '2017-06-12 07:49:27', NULL),
(28, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/banshees-cards-for-throwing?limit=100', 1, NULL, NULL, '2017-06-12 07:49:27', '2017-06-12 07:49:27', NULL),
(29, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/bee-standard-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:27', '2017-06-12 07:49:27', NULL),
(30, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/BeePlayingCards-ArtichokeJoeCasinodeck?limit=100', 1, NULL, NULL, '2017-06-12 07:49:27', '2017-06-12 07:49:27', NULL),
(31, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/BeePlayingCards-CamroseResortCasino?limit=100', 1, NULL, NULL, '2017-06-12 07:49:27', '2017-06-12 07:49:27', NULL),
(32, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/bee-titanium-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:27', '2017-06-12 07:49:27', NULL),
(33, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/bee-wpt-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:27', '2017-06-12 07:49:27', NULL),
(34, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/bicycle-52-proof-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:27', '2017-06-12 07:49:27', NULL),
(35, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/biocycle-8bit-playingcards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:27', '2017-06-12 07:49:27', NULL),
(36, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/bicycle-archangel-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:27', '2017-06-12 07:49:27', NULL),
(37, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/black-gold-asura-playingcards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:27', '2017-06-12 07:49:27', NULL),
(38, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/Bicycle-asura-gold-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:27', '2017-06-12 07:49:27', NULL),
(39, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/Bicycle-Autobike-PlayingCards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:27', '2017-06-12 07:49:27', NULL),
(40, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/bicycle-black-ghost-second-edition-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:27', '2017-06-12 07:49:27', NULL),
(41, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/bicycle-black-scorpion-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:27', '2017-06-12 07:49:27', NULL),
(42, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/bicycle-black-spider-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:27', '2017-06-12 07:49:27', NULL),
(43, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/bicycle-black-tiger-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:27', '2017-06-12 07:49:27', NULL),
(44, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/Bicycle-Bone-Riders-PlayingCards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:27', '2017-06-12 07:49:27', NULL),
(45, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/BicycleBridge-PlayingCards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:27', '2017-06-12 07:49:27', NULL),
(46, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/bicycle-cardistry-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:27', '2017-06-12 07:49:27', NULL),
(47, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/bicycle-chainless-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:28', '2017-06-12 07:49:28', NULL),
(48, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/bicycle-civil-war-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:28', '2017-06-12 07:49:28', NULL),
(49, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/bicycle-club-tattoo-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:28', '2017-06-12 07:49:28', NULL),
(50, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/bicycle-collectors-deck?limit=100', 1, NULL, NULL, '2017-06-12 07:49:28', '2017-06-12 07:49:28', NULL),
(51, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/bicycle-denim-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:28', '2017-06-12 07:49:28', NULL),
(52, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/bicycle-divine-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:28', '2017-06-12 07:49:28', NULL),
(53, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/bicycle-dragon-back-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:28', '2017-06-12 07:49:28', NULL),
(54, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/bicycle-dream-playingcards-blackgold?limit=100', 1, NULL, NULL, '2017-06-12 07:49:28', '2017-06-12 07:49:28', NULL),
(55, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/bicycle-dream-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:28', '2017-06-12 07:49:28', NULL),
(56, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/bicycle-excellence-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:28', '2017-06-12 07:49:28', NULL),
(57, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/Bicycle-Flying-Machines-Playing-Cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:28', '2017-06-12 07:49:28', NULL),
(58, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/BicycleGhost-Playing-Cards-LegacyEdition ?limit=100', 1, NULL, NULL, '2017-06-12 07:49:28', '2017-06-12 07:49:28', NULL),
(59, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/bicycle-goat-deco-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:28', '2017-06-12 07:49:28', NULL),
(60, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/bicycle-gold-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:28', '2017-06-12 07:49:28', NULL),
(61, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/bicycle-league-back-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:28', '2017-06-12 07:49:28', NULL),
(62, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/Bicycle-MaidenBack-PlayingCards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:28', '2017-06-12 07:49:28', NULL),
(63, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/bicycle-mandolin-back-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:28', '2017-06-12 07:49:28', NULL),
(64, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/bicycle-one-million-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:28', '2017-06-12 07:49:28', NULL),
(65, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/bicycle-paris-back-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:28', '2017-06-12 07:49:28', NULL),
(66, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/bicycle-porcelain-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:28', '2017-06-12 07:49:28', NULL),
(67, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/bicycle-reverse-back-playing-cards ?limit=100', 1, NULL, NULL, '2017-06-12 07:49:28', '2017-06-12 07:49:28', NULL),
(68, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/bicycle-rider-back-playing-cards-set-of-2-standard-tucks?limit=100', 1, NULL, NULL, '2017-06-12 07:49:28', '2017-06-12 07:49:28', NULL),
(69, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/black-riderback-playingcards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:28', '2017-06-12 07:49:28', NULL),
(70, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/bicycle-metalluxe-playingcards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:28', '2017-06-12 07:49:28', NULL),
(71, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/bicycle-rider-backs-classic?limit=100', 1, NULL, NULL, '2017-06-12 07:49:28', '2017-06-12 07:49:28', NULL),
(72, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/bicycle-shadow-masters-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:28', '2017-06-12 07:49:28', NULL),
(73, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/bicycle-skull-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:28', '2017-06-12 07:49:28', NULL),
(74, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards?product_id=1167&limit=100', 1, NULL, NULL, '2017-06-12 07:49:28', '2017-06-12 07:49:28', NULL),
(75, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/bicycle-titanium-edition?limit=100', 1, NULL, NULL, '2017-06-12 07:49:28', '2017-06-12 07:49:28', NULL),
(76, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/bicycle-warrior-horse-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:28', '2017-06-12 07:49:28', NULL),
(77, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/bicycle-white-ghost-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:28', '2017-06-12 07:49:28', NULL),
(78, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/BicycleWood-PlayingCards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:28', '2017-06-12 07:49:28', NULL),
(79, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/big-boy-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:28', '2017-06-12 07:49:28', NULL),
(80, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/arcane-playing-cards-ellusionist-deck?limit=100', 1, NULL, NULL, '2017-06-12 07:49:28', '2017-06-12 07:49:28', NULL),
(81, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/artisans-black-edition-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:28', '2017-06-12 07:49:28', NULL),
(82, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/BlackCrown-Playing-Cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:28', '2017-06-12 07:49:28', NULL),
(83, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/black-gatorbacks-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:28', '2017-06-12 07:49:28', NULL),
(84, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/Black-HoneyBee-Playing-Cards ?limit=100', 1, NULL, NULL, '2017-06-12 07:49:28', '2017-06-12 07:49:28', NULL),
(85, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/black-jaqk-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:28', '2017-06-12 07:49:28', NULL),
(86, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/black-label-white-lions-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:28', '2017-06-12 07:49:28', NULL),
(87, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/black-lions-blue-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:29', '2017-06-12 07:49:29', NULL),
(88, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/black-lions-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:29', '2017-06-12 07:49:29', NULL),
(89, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/black-lions-playing-cards-seconds?limit=100', 1, NULL, NULL, '2017-06-12 07:49:29', '2017-06-12 07:49:29', NULL),
(90, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/black-lions-red-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:29', '2017-06-12 07:49:29', NULL),
(91, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/madison-rounders?limit=100', 1, NULL, NULL, '2017-06-12 07:49:29', '2017-06-12 07:49:29', NULL),
(92, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/black-market-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:29', '2017-06-12 07:49:29', NULL),
(93, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/black-tally-ho-fan-back?limit=100', 1, NULL, NULL, '2017-06-12 07:49:29', '2017-06-12 07:49:29', NULL),
(94, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/black-tycoon-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:29', '2017-06-12 07:49:29', NULL),
(95, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/black-noc-v3s-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:29', '2017-06-12 07:49:29', NULL),
(96, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/bloodlines-playing-cards-billy-french?limit=100', 1, NULL, NULL, '2017-06-12 07:49:29', '2017-06-12 07:49:29', NULL),
(97, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/blue-ltd-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:29', '2017-06-12 07:49:29', NULL),
(98, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/BlueSteel-Playing-Cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:29', '2017-06-12 07:49:29', NULL),
(99, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/boardwalk-papers-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:29', '2017-06-12 07:49:29', NULL),
(100, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/breaking-bad-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:29', '2017-06-12 07:49:29', NULL),
(101, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/brut-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:29', '2017-06-12 07:49:29', NULL),
(102, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/bulldog-squeezers-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:32', '2017-06-12 07:49:32', NULL),
(103, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/Bumble-Bee-Playing-Cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:32', '2017-06-12 07:49:32', NULL),
(104, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/bumblebee-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:32', '2017-06-12 07:49:32', NULL),
(105, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/buskers-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:32', '2017-06-12 07:49:32', NULL),
(106, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/Cadenza-PlayingCards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:32', '2017-06-12 07:49:32', NULL),
(107, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/CALAVERAS-DE-AZUCAR-PlayingCards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:32', '2017-06-12 07:49:32', NULL),
(108, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/calaveras-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:32', '2017-06-12 07:49:32', NULL),
(109, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/call-of-cthulhu-unlimited-red-deck-with-sigil-seal?limit=100', 1, NULL, NULL, '2017-06-12 07:49:32', '2017-06-12 07:49:32', NULL),
(110, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/acrylic-playing-card-cases?limit=100', 1, NULL, NULL, '2017-06-12 07:49:32', '2017-06-12 07:49:32', NULL),
(111, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/CardistryNINJASplayingcards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:32', '2017-06-12 07:49:32', NULL),
(112, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/cardistry-touch-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:32', '2017-06-12 07:49:32', NULL),
(113, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/CARPE-NOCTEM-PLAYING-CARDS?limit=100', 1, NULL, NULL, '2017-06-12 07:49:32', '2017-06-12 07:49:32', NULL),
(114, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/CasinoRoyale-PlayingCards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:32', '2017-06-12 07:49:32', NULL),
(115, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/chameleons-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:32', '2017-06-12 07:49:32', NULL),
(116, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/chancellor-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:32', '2017-06-12 07:49:32', NULL),
(117, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/charity-water-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:32', '2017-06-12 07:49:32', NULL),
(118, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/cherries-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:32', '2017-06-12 07:49:32', NULL),
(119, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/chicken-nuggets-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:32', '2017-06-12 07:49:32', NULL),
(120, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/chrome-kings-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:32', '2017-06-12 07:49:32', NULL),
(121, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/citizens-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:32', '2017-06-12 07:49:32', NULL),
(122, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/cmyk-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:32', '2017-06-12 07:49:32', NULL),
(123, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/contraband-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:32', '2017-06-12 07:49:32', NULL),
(124, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/crown-deck-playing-card?limit=100', 1, NULL, NULL, '2017-06-12 07:49:32', '2017-06-12 07:49:32', NULL),
(125, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/Dapper-NOC-Playing-Cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:32', '2017-06-12 07:49:32', NULL),
(126, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/darkfall-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:32', '2017-06-12 07:49:32', NULL),
(127, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/Devos-BLADES-BloodSpearCards-EmeraldEdition?limit=100', 1, NULL, NULL, '2017-06-12 07:49:32', '2017-06-12 07:49:32', NULL),
(128, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/deckone-industrial-edition-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:32', '2017-06-12 07:49:32', NULL),
(129, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/delicious-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:32', '2017-06-12 07:49:32', NULL),
(130, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/delirium-prism-playing-cards-NEW?limit=100', 1, NULL, NULL, '2017-06-12 07:49:32', '2017-06-12 07:49:32', NULL),
(131, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/second-edition-dia-de-los-muertos-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:32', '2017-06-12 07:49:32', NULL),
(132, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/diamonds-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:32', '2017-06-12 07:49:32', NULL),
(133, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/DIGITAL-PETROGLYPHS-Playing-Cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:32', '2017-06-12 07:49:32', NULL),
(134, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/dkng-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:33', '2017-06-12 07:49:33', NULL),
(135, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/dominion-specials-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:33', '2017-06-12 07:49:33', NULL),
(136, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/DonQuixote-PlayingCards-Vol1?limit=100', 1, NULL, NULL, '2017-06-12 07:49:33', '2017-06-12 07:49:33', NULL),
(137, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/double-black-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:33', '2017-06-12 07:49:33', NULL),
(138, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/Draconian-Brimstone-Playing-Cards ?limit=100', 1, NULL, NULL, '2017-06-12 07:49:33', '2017-06-12 07:49:33', NULL),
(139, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/draconian-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:33', '2017-06-12 07:49:33', NULL),
(140, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/duel-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:33', '2017-06-12 07:49:33', NULL),
(141, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/dystopia-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:33', '2017-06-12 07:49:33', NULL),
(142, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/EDGE_playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:33', '2017-06-12 07:49:33', NULL),
(143, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/egyptian-legends-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:33', '2017-06-12 07:49:33', NULL),
(144, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/empire-bloodlines-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:33', '2017-06-12 07:49:33', NULL),
(145, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/encarded-standard-first-edition?limit=100', 1, NULL, NULL, '2017-06-12 07:49:33', '2017-06-12 07:49:33', NULL),
(146, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/erdnasemadison-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:33', '2017-06-12 07:49:33', NULL),
(147, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/exquisite-bold-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:33', '2017-06-12 07:49:33', NULL),
(148, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/blue-exquisite-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:33', '2017-06-12 07:49:33', NULL),
(149, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/fanangled-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:33', '2017-06-12 07:49:33', NULL),
(150, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/fathom-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:33', '2017-06-12 07:49:33', NULL),
(151, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/silver-certificate-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:33', '2017-06-12 07:49:33', NULL),
(152, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/white-edition-reserve-note-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:33', '2017-06-12 07:49:33', NULL),
(153, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/fine-line-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:33', '2017-06-12 07:49:33', NULL),
(154, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/legends-playing-cards-1?limit=100', 1, NULL, NULL, '2017-06-12 07:49:33', '2017-06-12 07:49:33', NULL),
(155, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/four-points-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:33', '2017-06-12 07:49:33', NULL),
(156, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/FOX-Targets-Playing-Cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:33', '2017-06-12 07:49:33', NULL),
(157, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/fuego-day-of-the-dead-inspired-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:33', '2017-06-12 07:49:33', NULL),
(158, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/gatorbacks-metallic-green-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:33', '2017-06-12 07:49:33', NULL),
(159, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/Gemini-Casino-Playing-Cards ?limit=100', 1, NULL, NULL, '2017-06-12 07:49:33', '2017-06-12 07:49:33', NULL),
(160, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/GLAMOR-NUGGET-Playing-Cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:33', '2017-06-12 07:49:33', NULL),
(161, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/glitch-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:33', '2017-06-12 07:49:33', NULL),
(162, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/gnostic-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:33', '2017-06-12 07:49:33', NULL),
(163, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/GOLDFOIL-GATORBACKS-Playing-Cards ?limit=100', 1, NULL, NULL, '2017-06-12 07:49:33', '2017-06-12 07:49:33', NULL),
(164, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/gold-standard-bicycle-playing-cards-by-richard-turner?limit=100', 1, NULL, NULL, '2017-06-12 07:49:33', '2017-06-12 07:49:33', NULL),
(165, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/golden-bee-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:33', '2017-06-12 07:49:33', NULL),
(166, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/green-monarchs-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:33', '2017-06-12 07:49:33', NULL),
(167, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/GRINDERS-Playing-Cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:33', '2017-06-12 07:49:33', NULL),
(168, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/GROTESK-MACABRE-Playing-Cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:33', '2017-06-12 07:49:33', NULL),
(169, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/handmade-leather-porper-card-clips?limit=100', 1, NULL, NULL, '2017-06-12 07:49:33', '2017-06-12 07:49:33', NULL),
(170, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/hellsgate-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:33', '2017-06-12 07:49:33', NULL),
(171, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/hotcakes-dark-limited-edition-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:33', '2017-06-12 07:49:33', NULL),
(172, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/ignite-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:33', '2017-06-12 07:49:33', NULL),
(173, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/imperial-playing-cards-GOLD?limit=100', 1, NULL, NULL, '2017-06-12 07:49:34', '2017-06-12 07:49:34', NULL),
(174, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/blue-jaqk-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:34', '2017-06-12 07:49:34', NULL),
(175, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/jetsetter-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:34', '2017-06-12 07:49:34', NULL),
(176, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/jetsetter-playingcards-blue?limit=100', 1, NULL, NULL, '2017-06-12 07:49:34', '2017-06-12 07:49:34', NULL),
(177, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/JONES-PLAYING-CARDS?limit=100', 1, NULL, NULL, '2017-06-12 07:49:34', '2017-06-12 07:49:34', NULL),
(178, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/keepers-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:34', '2017-06-12 07:49:34', NULL),
(179, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/Keepers-Playing-Cards-Red?limit=100', 1, NULL, NULL, '2017-06-12 07:49:34', '2017-06-12 07:49:34', NULL),
(180, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/killer-bee-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:34', '2017-06-12 07:49:34', NULL),
(181, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards?product_id=1007&limit=100', 1, NULL, NULL, '2017-06-12 07:49:34', '2017-06-12 07:49:34', NULL),
(182, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/kings-wild-tally-ho-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:34', '2017-06-12 07:49:34', NULL),
(183, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/knights-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:34', '2017-06-12 07:49:34', NULL),
(184, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/Knowledge-PlayingCards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:34', '2017-06-12 07:49:34', NULL),
(185, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/Latitude-longitude-playingcards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:34', '2017-06-12 07:49:34', NULL),
(186, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/LAURA-LONDON-NOC-DECK?limit=100', 1, NULL, NULL, '2017-06-12 07:49:34', '2017-06-12 07:49:34', NULL),
(187, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/leonardo-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:34', '2017-06-12 07:49:34', NULL),
(188, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/les-melies-voyagers-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:34', '2017-06-12 07:49:34', NULL),
(189, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/light-blue-crown-deck?limit=100', 1, NULL, NULL, '2017-06-12 07:49:34', '2017-06-12 07:49:34', NULL),
(190, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards?product_id=1105&limit=100', 1, NULL, NULL, '2017-06-12 07:49:34', '2017-06-12 07:49:34', NULL),
(191, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/love-me-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:34', '2017-06-12 07:49:34', NULL),
(192, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/LovePromiseVow-PlayingCards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:34', '2017-06-12 07:49:34', NULL),
(193, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/luxx-elliptica-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:34', '2017-06-12 07:49:34', NULL),
(194, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/luxx-gilded-collection?limit=100', 1, NULL, NULL, '2017-06-12 07:49:34', '2017-06-12 07:49:34', NULL),
(195, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/luxx-palme-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:34', '2017-06-12 07:49:34', NULL),
(196, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/LUXXPlaying-Cards-COMPLETE-COLLECTION ?limit=100', 1, NULL, NULL, '2017-06-12 07:49:34', '2017-06-12 07:49:34', NULL),
(197, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/madison-dealers-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:34', '2017-06-12 07:49:34', NULL),
(198, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/madison-gamblers-and-dvd-bundle?limit=100', 1, NULL, NULL, '2017-06-12 07:49:34', '2017-06-12 07:49:34', NULL),
(199, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/madison-revolvers-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:34', '2017-06-12 07:49:34', NULL),
(200, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/Magna-Carta-PlayingCards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:34', '2017-06-12 07:49:34', NULL),
(201, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/mailchimp-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:34', '2017-06-12 07:49:34', NULL),
(202, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/makers-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:37', '2017-06-12 07:49:37', NULL),
(203, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/mana-playing-cards-no.3-sybil?limit=100', 1, NULL, NULL, '2017-06-12 07:49:37', '2017-06-12 07:49:37', NULL),
(204, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/mandalas-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:37', '2017-06-12 07:49:37', NULL),
(205, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/mardi-gras-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:37', '2017-06-12 07:49:37', NULL),
(206, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/marked-vintage-1800-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:37', '2017-06-12 07:49:37', NULL),
(207, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards?product_id=1178&limit=100', 1, NULL, NULL, '2017-06-12 07:49:37', '2017-06-12 07:49:37', NULL),
(208, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/mauger-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:37', '2017-06-12 07:49:37', NULL),
(209, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/medallions-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:37', '2017-06-12 07:49:37', NULL),
(210, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/MementoMori-ArtOfPlay-Deck?limit=100', 1, NULL, NULL, '2017-06-12 07:49:37', '2017-06-12 07:49:37', NULL),
(211, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/memento-mori-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:37', '2017-06-12 07:49:37', NULL),
(212, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/memento-mori-blue-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:37', '2017-06-12 07:49:37', NULL),
(213, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/memento-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:37', '2017-06-12 07:49:37', NULL),
(214, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/Metropol-Dex-Trainer-decks-CARDISTRY?limit=100', 1, NULL, NULL, '2017-06-12 07:49:37', '2017-06-12 07:49:37', NULL),
(215, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/metropol-lux-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:37', '2017-06-12 07:49:37', NULL),
(216, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/metropol-nox-deck?limit=100', 1, NULL, NULL, '2017-06-12 07:49:37', '2017-06-12 07:49:37', NULL),
(217, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/midnight-calaveras-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:37', '2017-06-12 07:49:37', NULL),
(218, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/mirage-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:37', '2017-06-12 07:49:37', NULL),
(219, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/MIRAGE-PLAYING-CARDS-DawnEdition?limit=100', 1, NULL, NULL, '2017-06-12 07:49:37', '2017-06-12 07:49:37', NULL),
(220, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/misc-goods-second-edition-red-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:37', '2017-06-12 07:49:37', NULL),
(221, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/blue-misc-goods-third-edition?limit=100', 1, NULL, NULL, '2017-06-12 07:49:37', '2017-06-12 07:49:37', NULL),
(222, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/misc-goods-co-third-edition-green?limit=100', 1, NULL, NULL, '2017-06-12 07:49:38', '2017-06-12 07:49:38', NULL),
(223, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/misc-goods-third-edition-ivory-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:38', '2017-06-12 07:49:38', NULL),
(224, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/4-pack-monarchs-playing-cards-set?limit=100', 1, NULL, NULL, '2017-06-12 07:49:38', '2017-06-12 07:49:38', NULL),
(225, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/monarchs-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:38', '2017-06-12 07:49:38', NULL),
(226, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/Monarchs-Playing-Cards-NOW-YOU-SEE-ME?limit=100', 1, NULL, NULL, '2017-06-12 07:49:38', '2017-06-12 07:49:38', NULL),
(227, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/mpc-impressions-foil-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:38', '2017-06-12 07:49:38', NULL),
(228, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/MPC-impressions-cardinal-edition?limit=100', 1, NULL, NULL, '2017-06-12 07:49:38', '2017-06-12 07:49:38', NULL),
(229, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/MPC-impressions-racing-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:38', '2017-06-12 07:49:38', NULL),
(230, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/impressions-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:38', '2017-06-12 07:49:38', NULL),
(231, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/muertos-day-of-the-dead-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:38', '2017-06-12 07:49:38', NULL),
(232, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/murphy-varnish-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:38', '2017-06-12 07:49:38', NULL),
(233, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/murphys-magic-NOCDECK?limit=100', 1, NULL, NULL, '2017-06-12 07:49:38', '2017-06-12 07:49:38', NULL),
(234, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/national-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:38', '2017-06-12 07:49:38', NULL),
(235, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/NEWERA-YUTAMARUYAMA-BLACKMAGIC-DECK?limit=100', 1, NULL, NULL, '2017-06-12 07:49:38', '2017-06-12 07:49:38', NULL),
(236, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/nomad-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:38', '2017-06-12 07:49:38', NULL),
(237, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/NPH-Playing-Cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:38', '2017-06-12 07:49:38', NULL),
(238, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/odd-bods-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:38', '2017-06-12 07:49:38', NULL),
(239, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/olympia-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:38', '2017-06-12 07:49:38', NULL),
(240, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/onida-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:38', '2017-06-12 07:49:38', NULL),
(241, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/oracle-mystifying-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:38', '2017-06-12 07:49:38', NULL),
(242, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/the-mana-deck?limit=100', 1, NULL, NULL, '2017-06-12 07:49:38', '2017-06-12 07:49:38', NULL),
(243, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/orange-tally-ho-fan-back-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:38', '2017-06-12 07:49:38', NULL),
(244, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/first-edition-luxx-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:38', '2017-06-12 07:49:38', NULL),
(245, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/second-edition-luxx-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:38', '2017-06-12 07:49:38', NULL),
(246, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/origins-first-edition-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:38', '2017-06-12 07:49:38', NULL),
(247, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/ornate-white-edition-playing-cards-1?limit=100', 1, NULL, NULL, '2017-06-12 07:49:38', '2017-06-12 07:49:38', NULL),
(248, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/pagan-playing-cards-blue?limit=100', 1, NULL, NULL, '2017-06-12 07:49:38', '2017-06-12 07:49:38', NULL),
(249, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/playing-card-plastic-storage-box?limit=100', 1, NULL, NULL, '2017-06-12 07:49:38', '2017-06-12 07:49:38', NULL),
(250, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/playfair-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:38', '2017-06-12 07:49:38', NULL),
(251, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/playing-arts-edition-one?limit=100', 1, NULL, NULL, '2017-06-12 07:49:38', '2017-06-12 07:49:38', NULL),
(252, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/playing-arts-edition-three?limit=100', 1, NULL, NULL, '2017-06-12 07:49:38', '2017-06-12 07:49:38', NULL),
(253, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/playing-arts-editon-two?limit=100', 1, NULL, NULL, '2017-06-12 07:49:38', '2017-06-12 07:49:38', NULL),
(254, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/playing-arts-special-edition?limit=100', 1, NULL, NULL, '2017-06-12 07:49:38', '2017-06-12 07:49:38', NULL),
(255, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/polaris-playing-cards-eclipse-edition?limit=100', 1, NULL, NULL, '2017-06-12 07:49:38', '2017-06-12 07:49:38', NULL),
(256, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/the-porper-playing-card-clip?limit=100', 1, NULL, NULL, '2017-06-12 07:49:38', '2017-06-12 07:49:38', NULL),
(257, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/pr1me-no1r-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:38', '2017-06-12 07:49:38', NULL),
(258, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/pressers-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:38', '2017-06-12 07:49:38', NULL),
(259, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/prime-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:38', '2017-06-12 07:49:38', NULL),
(260, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/prism-dusk-playing-cards ?limit=100', 1, NULL, NULL, '2017-06-12 07:49:38', '2017-06-12 07:49:38', NULL),
(261, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/prism-night-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:38', '2017-06-12 07:49:38', NULL),
(262, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/pro-xcm-passion-deck?limit=100', 1, NULL, NULL, '2017-06-12 07:49:38', '2017-06-12 07:49:38', NULL),
(263, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/artifice-second-edition?limit=100', 1, NULL, NULL, '2017-06-12 07:49:38', '2017-06-12 07:49:38', NULL),
(264, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/purple-ltd-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:38', '2017-06-12 07:49:38', NULL),
(265, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/purple-madison-hustlers-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:38', '2017-06-12 07:49:38', NULL),
(266, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/rarebit-playing-cards-copper-edition?limit=100', 1, NULL, NULL, '2017-06-12 07:49:39', '2017-06-12 07:49:39', NULL),
(267, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/RAREBIT-Playing-Cards-GoldFoil?limit=100', 1, NULL, NULL, '2017-06-12 07:49:39', '2017-06-12 07:49:39', NULL),
(268, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/RAVN-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:39', '2017-06-12 07:49:39', NULL),
(269, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/red-jaqk-cellars-theory11-plaingcards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:39', '2017-06-12 07:49:39', NULL),
(270, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/second-edition-red-monarchs-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:39', '2017-06-12 07:49:39', NULL),
(271, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/regal-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:39', '2017-06-12 07:49:39', NULL),
(272, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/requiem-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:39', '2017-06-12 07:49:39', NULL),
(273, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/revolution-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:39', '2017-06-12 07:49:39', NULL),
(274, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/Roadhouse-Playing-Cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:39', '2017-06-12 07:49:39', NULL),
(275, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/rome-playing-cards-randy-butterfield?limit=100', 1, NULL, NULL, '2017-06-12 07:49:39', '2017-06-12 07:49:39', NULL),
(276, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/royal-optik-limited-edition-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:39', '2017-06-12 07:49:39', NULL),
(277, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/run-playing-cards-standard?limit=100', 1, NULL, NULL, '2017-06-12 07:49:39', '2017-06-12 07:49:39', NULL),
(278, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/russian-folk-art-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:39', '2017-06-12 07:49:39', NULL),
(279, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/russian-folkart-playingcards-black?limit=100', 1, NULL, NULL, '2017-06-12 07:49:39', '2017-06-12 07:49:39', NULL),
(280, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/seasons-inverno-and-verana?limit=100', 1, NULL, NULL, '2017-06-12 07:49:39', '2017-06-12 07:49:39', NULL),
(281, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/seasons-platinum-edition-seronda-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:39', '2017-06-12 07:49:39', NULL),
(282, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/second-edition-bruce-lee-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:39', '2017-06-12 07:49:39', NULL),
(283, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/serpentine-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:39', '2017-06-12 07:49:39', NULL),
(284, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/sharps?limit=100', 1, NULL, NULL, '2017-06-12 07:49:39', '2017-06-12 07:49:39', NULL),
(285, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/sherlock-holmes-playing-cards-baker-street-edition?limit=100', 1, NULL, NULL, '2017-06-12 07:49:39', '2017-06-12 07:49:39', NULL),
(286, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/silver-arrows-playing-cards-jackson-robinson?limit=100', 1, NULL, NULL, '2017-06-12 07:49:39', '2017-06-12 07:49:39', NULL),
(287, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/silver-split-spades-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:39', '2017-06-12 07:49:39', NULL),
(288, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/sleepy-hollow-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:39', '2017-06-12 07:49:39', NULL),
(289, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/smith-no.-3-signature-edition?limit=100', 1, NULL, NULL, '2017-06-12 07:49:39', '2017-06-12 07:49:39', NULL),
(290, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/smoke-and-mirrors-reprints?limit=100', 1, NULL, NULL, '2017-06-12 07:49:39', '2017-06-12 07:49:39', NULL),
(291, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/smoke-and-mirrors-v7-deluxe-box-set?limit=100', 1, NULL, NULL, '2017-06-12 07:49:39', '2017-06-12 07:49:39', NULL),
(292, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/Snow-Leopard-NOC-Deck?limit=100', 1, NULL, NULL, '2017-06-12 07:49:39', '2017-06-12 07:49:39', NULL),
(293, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/Sons-Of-Liberty-Playing-Cards-Blue ?limit=100', 1, NULL, NULL, '2017-06-12 07:49:39', '2017-06-12 07:49:39', NULL),
(294, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/Sons-of-liberty-WHITE?limit=100', 1, NULL, NULL, '2017-06-12 07:49:39', '2017-06-12 07:49:39', NULL),
(295, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/soundboards-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:39', '2017-06-12 07:49:39', NULL),
(296, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/steamboat-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:39', '2017-06-12 07:49:39', NULL);
INSERT INTO `crawling_card_pages` (`id`, `crawler_id`, `card_id`, `url`, `last_run_success`, `last_run`, `last_completion`, `created_at`, `updated_at`, `deleted_at`) VALUES
(297, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/Steeplechase-Park-Playing-Cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:39', '2017-06-12 07:49:39', NULL),
(298, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/Summer-NOC-Deck?limit=100', 1, NULL, NULL, '2017-06-12 07:49:39', '2017-06-12 07:49:39', NULL),
(299, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/superior-brand-silver-arrow?limit=100', 1, NULL, NULL, '2017-06-12 07:49:39', '2017-06-12 07:49:39', NULL),
(300, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/superior-brand-silver-arrow-poker?limit=100', 1, NULL, NULL, '2017-06-12 07:49:39', '2017-06-12 07:49:39', NULL),
(301, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/swe-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:39', '2017-06-12 07:49:39', NULL),
(302, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/black-SWE-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:42', '2017-06-12 07:49:42', NULL),
(303, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/tally-ho-circle-back-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:42', '2017-06-12 07:49:42', NULL),
(304, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/tally-ho-fan-back-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:42', '2017-06-12 07:49:42', NULL),
(305, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/tally-ho-titanium-edition-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:42', '2017-06-12 07:49:42', NULL),
(306, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/tally-ho-viper-fan-back-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:42', '2017-06-12 07:49:42', NULL),
(307, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/tendril-ascendant-and-nightfall-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:42', '2017-06-12 07:49:42', NULL),
(308, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/texan-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:42', '2017-06-12 07:49:42', NULL),
(309, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/TheJungleDeck?limit=100', 1, NULL, NULL, '2017-06-12 07:49:42', '2017-06-12 07:49:42', NULL),
(310, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/other kingdom-playingcards-USPC?limit=100', 1, NULL, NULL, '2017-06-12 07:49:42', '2017-06-12 07:49:42', NULL),
(311, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/the-retro-deck?limit=100', 1, NULL, NULL, '2017-06-12 07:49:42', '2017-06-12 07:49:42', NULL),
(312, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/the-school-of-cardistry-deck?limit=100', 1, NULL, NULL, '2017-06-12 07:49:42', '2017-06-12 07:49:42', NULL),
(313, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/the-star-deck?limit=100', 1, NULL, NULL, '2017-06-12 07:49:42', '2017-06-12 07:49:42', NULL),
(314, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/the-type-deck?limit=100', 1, NULL, NULL, '2017-06-12 07:49:42', '2017-06-12 07:49:42', NULL),
(315, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/the-ultimate-deck-1?limit=100', 1, NULL, NULL, '2017-06-12 07:49:42', '2017-06-12 07:49:42', NULL),
(316, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/three-little-pigs-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:42', '2017-06-12 07:49:42', NULL),
(317, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/triplicate-dragon-restoration-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:42', '2017-06-12 07:49:42', NULL),
(318, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/triplicate-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:42', '2017-06-12 07:49:42', NULL),
(319, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/tycoon-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:42', '2017-06-12 07:49:42', NULL),
(320, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/tycoon-ivory-playingcards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:42', '2017-06-12 07:49:42', NULL),
(321, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/unions-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:42', '2017-06-12 07:49:42', NULL),
(322, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/uusi-classic-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:42', '2017-06-12 07:49:42', NULL),
(323, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/blue-artifice-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:42', '2017-06-12 07:49:42', NULL),
(324, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/v2-blood-kings-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:42', '2017-06-12 07:49:42', NULL),
(325, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/zinfandel-by-mana-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:42', '2017-06-12 07:49:42', NULL),
(326, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/sleepers-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:42', '2017-06-12 07:49:42', NULL),
(327, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/v3-bicycle-samurai-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:42', '2017-06-12 07:49:42', NULL),
(328, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/v3-cherries-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:42', '2017-06-12 07:49:42', NULL),
(329, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/v3-School-of-Cardistry-Deck?limit=100', 1, NULL, NULL, '2017-06-12 07:49:42', '2017-06-12 07:49:42', NULL),
(330, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/v3-noc-deck?limit=100', 1, NULL, NULL, '2017-06-12 07:49:42', '2017-06-12 07:49:42', NULL),
(331, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/vanda-crimosn-deck-playingcards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:42', '2017-06-12 07:49:42', NULL),
(332, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/vanda-golden-edition-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:43', '2017-06-12 07:49:43', NULL),
(333, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/violet-edition-vanda-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:43', '2017-06-12 07:49:43', NULL),
(334, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/velocity-dvd-and-banshees-bundle?limit=100', 1, NULL, NULL, '2017-06-12 07:49:43', '2017-06-12 07:49:43', NULL),
(335, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/velocity-dvd-how-to-throw-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:43', '2017-06-12 07:49:43', NULL),
(336, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/venexiana-dark-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:43', '2017-06-12 07:49:43', NULL),
(337, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/victorian-room-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:43', '2017-06-12 07:49:43', NULL),
(338, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/Vintage-Plaid-Playing-Cards-2016?limit=100', 1, NULL, NULL, '2017-06-12 07:49:43', '2017-06-12 07:49:43', NULL),
(339, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/viridian-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:43', '2017-06-12 07:49:43', NULL),
(340, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/virtuoso-playing-cards-spring-summer-edition?limit=100', 1, NULL, NULL, '2017-06-12 07:49:43', '2017-06-12 07:49:43', NULL),
(341, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/virtuoso-spring-summer-2015-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:43', '2017-06-12 07:49:43', NULL),
(342, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/virtuoso-spring-summer-2016-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:43', '2017-06-12 07:49:43', NULL),
(343, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/VISA-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:43', '2017-06-12 07:49:43', NULL),
(344, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/Vitreous0Playing-Cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:43', '2017-06-12 07:49:43', NULL),
(345, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/VIVA-MEXICO-PlayingCards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:43', '2017-06-12 07:49:43', NULL),
(346, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/voltige-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:43', '2017-06-12 07:49:43', NULL),
(347, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/Wasteland-Playing-Cards ?limit=100', 1, NULL, NULL, '2017-06-12 07:49:43', '2017-06-12 07:49:43', NULL),
(348, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/Westminster-Playing-Cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:43', '2017-06-12 07:49:43', NULL),
(349, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/whispering-imps-black-edition-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:43', '2017-06-12 07:49:43', NULL),
(350, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/series-b-blue-playingcards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:43', '2017-06-12 07:49:43', NULL),
(351, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/white-lions-series-b-red?limit=100', 1, NULL, NULL, '2017-06-12 07:49:43', '2017-06-12 07:49:43', NULL),
(352, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/woodlands-playingcards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:43', '2017-06-12 07:49:43', NULL),
(353, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/zen-pure-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:43', '2017-06-12 07:49:43', NULL),
(354, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/aristocrat-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:43', '2017-06-12 07:49:43', NULL),
(355, 2, NULL, 'http://jpplayingcards.co.uk/buy-playing-cards/guardians-playing-cards?limit=100', 1, NULL, NULL, '2017-06-12 07:49:43', '2017-06-12 07:49:43', NULL),
(356, 1, NULL, 'http://www.kingofcards.co.uk/angry-pussies-cardistry-professionals-handlordz.html', 1, NULL, NULL, '2017-06-12 08:04:53', '2017-06-12 08:04:53', NULL),
(357, 1, NULL, 'http://www.kingofcards.co.uk/aquila-standard-edition-kardify.html', 1, NULL, NULL, '2017-06-12 08:04:53', '2017-06-12 08:04:53', NULL),
(358, 1, NULL, 'http://www.kingofcards.co.uk/aristocrats-red-blue-theory-11.html', 1, NULL, NULL, '2017-06-12 08:04:53', '2017-06-12 08:04:53', NULL),
(359, 1, NULL, 'http://www.kingofcards.co.uk/artifice-tundra-ellusionist.html', 1, NULL, NULL, '2017-06-12 08:04:53', '2017-06-12 08:04:53', NULL),
(360, 1, NULL, 'http://www.kingofcards.co.uk/artisans-theory-11.html', 1, NULL, NULL, '2017-06-12 08:04:53', '2017-06-12 08:04:53', NULL),
(361, 1, NULL, 'http://www.kingofcards.co.uk/babel-deck-card-experiment.html', 1, NULL, NULL, '2017-06-12 08:04:53', '2017-06-12 08:04:53', NULL),
(362, 1, NULL, 'http://www.kingofcards.co.uk/bee-erdnaseum-cards-cambric-finish-dan-dave.html', 1, NULL, NULL, '2017-06-12 08:04:53', '2017-06-12 08:04:53', NULL),
(363, 1, NULL, 'http://www.kingofcards.co.uk/bicycle-alchemy.html', 1, NULL, NULL, '2017-06-12 08:04:53', '2017-06-12 08:04:53', NULL),
(364, 1, NULL, 'http://www.kingofcards.co.uk/bicycle-archangels-theory-11.html', 1, NULL, NULL, '2017-06-12 08:04:53', '2017-06-12 08:04:53', NULL),
(365, 1, NULL, 'http://www.kingofcards.co.uk/bicycle-bacon-lovers.html', 1, NULL, NULL, '2017-06-12 08:04:53', '2017-06-12 08:04:53', NULL),
(366, 1, NULL, 'http://www.kingofcards.co.uk/bicycle-blackout-kingdom-deck-light-shade-numbered-limited-edition-gamblers-warehouse.html', 1, NULL, NULL, '2017-06-12 08:04:53', '2017-06-12 08:04:53', NULL),
(367, 1, NULL, 'http://www.kingofcards.co.uk/bicycle-blackout-kingdom-deck-gamblers-warehouse.html', 1, NULL, NULL, '2017-06-12 08:04:53', '2017-06-12 08:04:53', NULL),
(368, 1, NULL, 'http://www.kingofcards.co.uk/bicycle-brosmind.html', 1, NULL, NULL, '2017-06-12 08:04:53', '2017-06-12 08:04:53', NULL),
(369, 1, NULL, 'http://www.kingofcards.co.uk/bicycle-cupid.html', 1, NULL, NULL, '2017-06-12 08:04:53', '2017-06-12 08:04:53', NULL),
(370, 1, NULL, 'http://www.kingofcards.co.uk/bicycle-dream-silver-edition-card-experiment.html', 1, NULL, NULL, '2017-06-12 08:04:54', '2017-06-12 08:04:54', NULL),
(371, 1, NULL, 'http://www.kingofcards.co.uk/bicycle-eco.html', 1, NULL, NULL, '2017-06-12 08:04:54', '2017-06-12 08:04:54', NULL),
(372, 1, NULL, 'http://www.kingofcards.co.uk/bicycle-everyday-zombie.html', 1, NULL, NULL, '2017-06-12 08:04:54', '2017-06-12 08:04:54', NULL),
(373, 1, NULL, 'http://www.kingofcards.co.uk/bicycle-expert-back.html', 1, NULL, NULL, '2017-06-12 08:04:54', '2017-06-12 08:04:54', NULL),
(374, 1, NULL, 'http://www.kingofcards.co.uk/bicycle-golden-spike-deck.html', 1, NULL, NULL, '2017-06-12 08:04:54', '2017-06-12 08:04:54', NULL),
(375, 1, NULL, 'http://www.kingofcards.co.uk/bicycle-grid-2-0-red-limited-edition-gamblers-warehouse.html', 1, NULL, NULL, '2017-06-12 08:04:54', '2017-06-12 08:04:54', NULL),
(376, 1, NULL, 'http://www.kingofcards.co.uk/bicycle-guardians-theory-11.html', 1, NULL, NULL, '2017-06-12 08:04:54', '2017-06-12 08:04:54', NULL),
(377, 1, NULL, 'http://www.kingofcards.co.uk/bicycle-karnival-1984-big-blind-media.html', 1, NULL, NULL, '2017-06-12 08:04:54', '2017-06-12 08:04:54', NULL),
(378, 1, NULL, 'http://www.kingofcards.co.uk/bicycle-legacy-gamblers-warehouse.html', 1, NULL, NULL, '2017-06-12 08:04:54', '2017-06-12 08:04:54', NULL),
(379, 1, NULL, 'http://www.kingofcards.co.uk/bicycle-made-empire-ultra-limited-edition-deck-crooked-kings.html', 1, NULL, NULL, '2017-06-12 08:04:54', '2017-06-12 08:04:54', NULL),
(380, 1, NULL, 'http://www.kingofcards.co.uk/bicycle-made-kingpin-ultra-limited-edition-deck-crooked-kings.html', 1, NULL, NULL, '2017-06-12 08:04:54', '2017-06-12 08:04:54', NULL),
(381, 1, NULL, 'http://www.kingofcards.co.uk/bicycle-made-stork-club-limited-edition-crooked-kings.html', 1, NULL, NULL, '2017-06-12 08:04:54', '2017-06-12 08:04:54', NULL),
(382, 1, NULL, 'http://www.kingofcards.co.uk/playing-cards/bicycle-mummies-playing-cards-collectable-playing-cards.html', 1, NULL, NULL, '2017-06-12 08:04:54', '2017-06-12 08:04:54', NULL),
(383, 1, NULL, 'http://www.kingofcards.co.uk/bicycle-nautic-deck.html', 1, NULL, NULL, '2017-06-12 08:04:54', '2017-06-12 08:04:54', NULL),
(384, 1, NULL, 'http://www.kingofcards.co.uk/bicycle-pluma.html', 1, NULL, NULL, '2017-06-12 08:04:54', '2017-06-12 08:04:54', NULL),
(385, 1, NULL, 'http://www.kingofcards.co.uk/bicycle-psycho-clowns.html', 1, NULL, NULL, '2017-06-12 08:04:54', '2017-06-12 08:04:54', NULL),
(386, 1, NULL, 'http://www.kingofcards.co.uk/bicycle-red-plastic-cup.html', 1, NULL, NULL, '2017-06-12 08:04:54', '2017-06-12 08:04:54', NULL),
(387, 1, NULL, 'http://www.kingofcards.co.uk/bicycle-skull.html', 1, NULL, NULL, '2017-06-12 08:04:54', '2017-06-12 08:04:54', NULL),
(388, 1, NULL, 'http://www.kingofcards.co.uk/bicycle-sliver-steampunk-theory-11.html', 1, NULL, NULL, '2017-06-12 08:04:54', '2017-06-12 08:04:54', NULL),
(389, 1, NULL, 'http://www.kingofcards.co.uk/bicycle-standard-index-cards.html', 1, NULL, NULL, '2017-06-12 08:04:54', '2017-06-12 08:04:54', NULL),
(390, 1, NULL, 'http://www.kingofcards.co.uk/bicycle-steampunk-bandits-white-gamblers-warehouse.html', 1, NULL, NULL, '2017-06-12 08:04:54', '2017-06-12 08:04:54', NULL),
(391, 1, NULL, 'http://www.kingofcards.co.uk/bicycle-tragic-royalty.html', 1, NULL, NULL, '2017-06-12 08:04:54', '2017-06-12 08:04:54', NULL),
(392, 1, NULL, 'http://www.kingofcards.co.uk/bicycle-zombie.html', 1, NULL, NULL, '2017-06-12 08:04:54', '2017-06-12 08:04:54', NULL),
(393, 1, NULL, 'http://www.kingofcards.co.uk/bicycle-zombified.html', 1, NULL, NULL, '2017-06-12 08:04:54', '2017-06-12 08:04:54', NULL),
(394, 1, NULL, 'http://www.kingofcards.co.uk/blackout-kingdom-deck-limited-side-tuck-gamblers-warehouse.html', 1, NULL, NULL, '2017-06-12 08:04:54', '2017-06-12 08:04:54', NULL),
(395, 1, NULL, 'http://www.kingofcards.co.uk/boardwalk-deck-blue-crown-hopc.html', 1, NULL, NULL, '2017-06-12 08:04:54', '2017-06-12 08:04:54', NULL),
(396, 1, NULL, 'http://www.kingofcards.co.uk/breaking-bad-playing-cards-blue-albino-dragon.html', 1, NULL, NULL, '2017-06-12 08:04:54', '2017-06-12 08:04:54', NULL),
(397, 1, NULL, 'http://www.kingofcards.co.uk/playing-cards/citizen-playing-cards-theory-11.html', 1, NULL, NULL, '2017-06-12 08:04:54', '2017-06-12 08:04:54', NULL),
(398, 1, NULL, 'http://www.kingofcards.co.uk/contraband-theory-11.html', 1, NULL, NULL, '2017-06-12 08:04:54', '2017-06-12 08:04:54', NULL),
(399, 1, NULL, 'http://www.kingofcards.co.uk/playing-cards/darkfall-playing-cards-murphy-s-magic.html', 1, NULL, NULL, '2017-06-12 08:04:54', '2017-06-12 08:04:54', NULL),
(400, 1, NULL, 'http://www.kingofcards.co.uk/de-vo-s-signature-series-card-masters-handlordz.html', 1, NULL, NULL, '2017-06-12 08:04:54', '2017-06-12 08:04:54', NULL),
(401, 1, NULL, 'http://www.kingofcards.co.uk/de-vo-s-signature-series-card-masters-gold-edges-handlordz.html', 1, NULL, NULL, '2017-06-12 08:04:54', '2017-06-12 08:04:54', NULL),
(402, 1, NULL, 'http://www.kingofcards.co.uk/deckone-theory-11.html', 1, NULL, NULL, '2017-06-12 08:04:54', '2017-06-12 08:04:54', NULL),
(403, 1, NULL, 'http://www.kingofcards.co.uk/empire-bloodlines-special-brick-price-kings-crooks.html', 1, NULL, NULL, '2017-06-12 08:04:54', '2017-06-12 08:04:54', NULL),
(404, 1, NULL, 'http://www.kingofcards.co.uk/empire-bloodlines-king-crooks.html', 1, NULL, NULL, '2017-06-12 08:04:54', '2017-06-12 08:04:54', NULL),
(405, 1, NULL, 'http://www.kingofcards.co.uk/executive-ellusionist.html', 1, NULL, NULL, '2017-06-12 08:04:54', '2017-06-12 08:04:54', NULL),
(406, 1, NULL, 'http://www.kingofcards.co.uk/hipster-playing-cards-legends-ed.html', 1, NULL, NULL, '2017-06-12 08:04:54', '2017-06-12 08:04:54', NULL),
(407, 1, NULL, 'http://www.kingofcards.co.uk/playing-cards/hustlers-purple-playing-cards-ellusionist.html', 1, NULL, NULL, '2017-06-12 08:04:54', '2017-06-12 08:04:54', NULL),
(408, 1, NULL, 'http://www.kingofcards.co.uk/ignite-ellusionist.html', 1, NULL, NULL, '2017-06-12 08:04:54', '2017-06-12 08:04:54', NULL),
(409, 1, NULL, 'http://www.kingofcards.co.uk/infinity-ellusionist.html', 1, NULL, NULL, '2017-06-12 08:04:54', '2017-06-12 08:04:54', NULL),
(410, 1, NULL, 'http://www.kingofcards.co.uk/love-me-theory-11.html', 1, NULL, NULL, '2017-06-12 08:04:54', '2017-06-12 08:04:54', NULL),
(411, 1, NULL, 'http://www.kingofcards.co.uk/ltd-blue.html', 1, NULL, NULL, '2017-06-12 08:04:54', '2017-06-12 08:04:54', NULL),
(412, 1, NULL, 'http://www.kingofcards.co.uk/ltd-purple-ellusionist.html', 1, NULL, NULL, '2017-06-12 08:04:54', '2017-06-12 08:04:54', NULL),
(413, 1, NULL, 'http://www.kingofcards.co.uk/maddison-rounders-white-ellusionist.html', 1, NULL, NULL, '2017-06-12 08:04:54', '2017-06-12 08:04:54', NULL),
(414, 1, NULL, 'http://www.kingofcards.co.uk/madison-dealers-erdnase-green-ellusionist.html', 1, NULL, NULL, '2017-06-12 08:04:54', '2017-06-12 08:04:54', NULL),
(415, 1, NULL, 'http://www.kingofcards.co.uk/mechanic-optricks-mechanic-industries.html', 1, NULL, NULL, '2017-06-12 08:04:54', '2017-06-12 08:04:54', NULL),
(416, 1, NULL, 'http://www.kingofcards.co.uk/medallions-theory-11.html', 1, NULL, NULL, '2017-06-12 08:04:54', '2017-06-12 08:04:54', NULL),
(417, 1, NULL, 'http://www.kingofcards.co.uk/mysterybox-black-edition-theory-11.html', 1, NULL, NULL, '2017-06-12 08:04:54', '2017-06-12 08:04:54', NULL),
(418, 1, NULL, 'http://www.kingofcards.co.uk/noc-deck-v3s-the-blue-crown.html', 1, NULL, NULL, '2017-06-12 08:04:54', '2017-06-12 08:04:54', NULL),
(419, 1, NULL, 'http://www.kingofcards.co.uk/ornate-white-edition-playing-cards.html', 1, NULL, NULL, '2017-06-12 08:04:54', '2017-06-12 08:04:54', NULL),
(420, 1, NULL, 'http://www.kingofcards.co.uk/playing-cards/soundboards-playing-cards-legends.html', 1, NULL, NULL, '2017-06-12 08:04:54', '2017-06-12 08:04:54', NULL),
(421, 1, NULL, 'http://www.kingofcards.co.uk/spirit-playing-cards-uspcc-gambler-s-warehouse.html', 1, NULL, NULL, '2017-06-12 08:04:54', '2017-06-12 08:04:54', NULL),
(422, 1, NULL, 'http://www.kingofcards.co.uk/standard-bicycle-cards-twin-pack.html', 1, NULL, NULL, '2017-06-12 08:04:54', '2017-06-12 08:04:54', NULL),
(423, 1, NULL, 'http://www.kingofcards.co.uk/tally-ho-reverse-fan-back-coloured-aloys-studio.html', 1, NULL, NULL, '2017-06-12 08:04:55', '2017-06-12 08:04:55', NULL),
(424, 1, NULL, 'http://www.kingofcards.co.uk/telly-ho-british-monarchy-lux-playing-cards.html', 1, NULL, NULL, '2017-06-12 08:04:55', '2017-06-12 08:04:55', NULL),
(425, 1, NULL, 'http://www.kingofcards.co.uk/playing-cards/tenebre-nero-playing-cards-4pm-designs.html', 1, NULL, NULL, '2017-06-12 08:04:55', '2017-06-12 08:04:55', NULL),
(426, 1, NULL, 'http://www.kingofcards.co.uk/totem-deck-limited-edition-aloys-studio.html', 1, NULL, NULL, '2017-06-12 08:04:55', '2017-06-12 08:04:55', NULL),
(427, 1, NULL, 'http://www.kingofcards.co.uk/playing-cards/union-playing-cards-theory-11.html', 1, NULL, NULL, '2017-06-12 08:04:55', '2017-06-12 08:04:55', NULL),
(428, 1, NULL, 'http://www.kingofcards.co.uk/zen-pure-expert-playing-card-co.html', 1, NULL, NULL, '2017-06-12 08:04:55', '2017-06-12 08:04:55', NULL),
(429, 1, NULL, 'http://www.kingofcards.co.uk/zen-pure-gold-special-edition-expert-playing-card-co.html', 1, NULL, NULL, '2017-06-12 08:04:55', '2017-06-12 08:04:55', NULL),
(442, 3, NULL, 'https://shop.davidblaine.com/collections/playingcards/products/gold-gatorbacks', 1, '2017-06-13 23:30:11', '2017-06-13 23:30:12', '2017-06-13 07:41:42', '2017-06-14 06:30:12', NULL),
(443, 3, NULL, 'https://shop.davidblaine.com/collections/playingcards/products/black-gatorbacks', 1, '2017-06-13 23:30:12', '2017-06-13 23:30:12', '2017-06-13 07:41:42', '2017-06-14 06:30:12', NULL),
(444, 3, NULL, 'https://shop.davidblaine.com/collections/playingcards/products/black-lions', 1, '2017-06-13 23:30:12', '2017-06-13 23:30:12', '2017-06-13 07:41:42', '2017-06-14 06:30:12', NULL),
(446, 3, NULL, 'https://shop.davidblaine.com/collections/playingcards/products/black-lions-metallic-red', 1, '2017-06-13 23:30:12', '2017-06-13 23:30:12', '2017-06-13 07:41:42', '2017-06-14 06:30:12', NULL),
(447, 3, NULL, 'https://shop.davidblaine.com/collections/playingcards/products/black-lions-blue-edition', 1, '2017-06-13 23:30:12', '2017-06-13 23:30:13', '2017-06-13 07:41:42', '2017-06-14 06:30:13', NULL),
(450, 3, NULL, 'https://shop.davidblaine.com/collections/playingcards/products/white-lions-series-b-avail-8-1-12', 1, '2017-06-13 23:30:13', '2017-06-13 23:30:13', '2017-06-13 07:41:42', '2017-06-14 06:30:13', NULL),
(452, 3, NULL, 'https://shop.davidblaine.com/collections/playingcards/products/mystery-box', 1, '2017-06-13 23:30:13', '2017-06-13 23:30:13', '2017-06-13 07:41:42', '2017-06-14 06:30:13', NULL),
(453, 3, NULL, 'https://shop.davidblaine.com/collections/playingcards/products/black-lions-charity-decks', 1, '2017-06-13 23:30:13', '2017-06-13 23:30:14', '2017-06-13 11:23:29', '2017-06-14 06:30:14', NULL),
(454, 3, NULL, 'https://shop.davidblaine.com/collections/playingcards/products/black-label-white-lions-1', 1, '2017-06-13 23:30:14', '2017-06-13 23:30:14', '2017-06-13 11:23:29', '2017-06-14 06:30:14', NULL),
(455, 3, NULL, 'https://shop.davidblaine.com/collections/playingcards/products/white-lions-series-b-red', 1, '2017-06-13 23:30:14', '2017-06-13 23:30:14', '2017-06-13 11:23:29', '2017-06-14 06:30:14', NULL),
(456, 6, NULL, 'https://blackinkplayingcards.com/collections/playing-cards/products/inception-intellectus-standard', 1, '2017-07-29 18:24:48', '2017-07-29 18:24:49', '2017-06-13 11:36:06', '2017-07-30 01:24:49', NULL),
(457, 6, NULL, 'https://blackinkplayingcards.com/collections/playing-cards/products/signature-series', 1, '2017-07-29 18:24:49', '2017-07-29 18:24:49', '2017-06-13 11:36:06', '2017-07-30 01:24:49', NULL),
(458, 6, NULL, 'https://blackinkplayingcards.com/collections/playing-cards/products/golden-spike-playing-cards-bicycle', 1, '2017-07-29 18:24:49', '2017-07-29 18:24:50', '2017-06-13 11:36:06', '2017-07-30 01:24:50', NULL),
(459, 6, NULL, 'https://blackinkplayingcards.com/collections/playing-cards/products/golden-spike-playing-cards-gold-edition', 1, '2017-07-29 18:24:50', '2017-07-29 18:24:50', '2017-06-13 11:36:06', '2017-07-30 01:24:50', NULL),
(460, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/a-typographers-deck', 1, '2017-07-17 21:10:39', '2017-07-17 21:10:40', '2017-06-13 12:37:02', '2017-07-18 04:10:40', NULL),
(461, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/visa-playing-cards', 1, '2017-07-17 21:10:40', '2017-07-17 21:10:42', '2017-06-13 12:37:02', '2017-07-18 04:10:42', NULL),
(462, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/the-three-little-pigs', 1, '2017-07-17 21:10:42', '2017-07-17 21:10:42', '2017-06-13 12:37:02', '2017-07-18 04:10:42', NULL),
(463, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/edge-playing-cards', 1, '2017-07-17 21:10:42', '2017-07-17 21:10:43', '2017-06-13 12:37:03', '2017-07-18 04:10:43', NULL),
(464, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/flora-playing-cards', 1, '2017-07-17 21:10:43', '2017-07-17 21:10:44', '2017-06-13 12:37:03', '2017-07-18 04:10:44', NULL),
(465, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/triple-vision', 1, '2017-07-17 21:10:44', '2017-07-17 21:10:45', '2017-06-13 12:37:03', '2017-07-18 04:10:45', NULL),
(466, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/fournier-505', 1, '2017-07-17 21:10:45', '2017-07-17 21:10:46', '2017-06-13 12:37:03', '2017-07-18 04:10:46', NULL),
(467, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/mondrian-playing-cards', 1, '2017-07-17 21:10:46', '2017-07-17 21:10:46', '2017-06-13 12:37:03', '2017-07-18 04:10:46', NULL),
(468, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/stripe-playing-cards', 1, '2017-07-17 21:10:46', '2017-07-17 21:10:47', '2017-06-13 12:37:03', '2017-07-18 04:10:47', NULL),
(469, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/luxx-greille-back', 1, '2017-07-17 21:10:47', '2017-07-17 21:10:48', '2017-06-13 12:37:03', '2017-07-18 04:10:48', NULL),
(470, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/stardeck', 1, '2017-07-17 21:10:48', '2017-07-17 21:10:49', '2017-06-13 12:37:03', '2017-07-18 04:10:49', NULL),
(471, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/bicycle-little-atlantis', 1, '2017-07-17 21:10:49', '2017-07-17 21:10:49', '2017-06-13 12:37:03', '2017-07-18 04:10:49', NULL),
(472, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/superior-classic-back', 1, '2017-07-17 21:10:49', '2017-07-17 21:10:50', '2017-06-13 12:37:03', '2017-07-18 04:10:50', NULL),
(473, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/flourish', 1, '2017-07-17 21:10:50', '2017-07-17 21:10:51', '2017-06-13 12:37:03', '2017-07-18 04:10:51', NULL),
(474, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/cocktail-hour', 1, '2017-07-17 21:10:51', '2017-07-17 21:10:52', '2017-06-13 12:37:03', '2017-07-18 04:10:52', NULL),
(475, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/glamor-nugget', 1, '2017-07-17 21:10:52', '2017-07-17 21:10:53', '2017-06-13 12:37:03', '2017-07-18 04:10:53', NULL),
(476, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/nph-neil-patrick-harris-playing-cards', 1, '2017-07-17 21:10:53', '2017-07-17 21:10:54', '2017-06-13 12:37:03', '2017-07-18 04:10:54', NULL),
(477, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/jungle-deck', 1, '2017-07-17 21:10:54', '2017-07-17 21:10:55', '2017-06-13 12:37:03', '2017-07-18 04:10:55', NULL),
(478, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/makers', 1, '2017-07-17 21:10:55', '2017-07-17 21:10:56', '2017-06-13 12:37:03', '2017-07-18 04:10:56', NULL),
(479, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/ed-playing-cards', 1, '2017-07-17 21:10:56', '2017-07-17 21:10:56', '2017-06-13 12:37:03', '2017-07-18 04:10:56', NULL),
(480, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/memento-mori', 1, '2017-07-17 21:10:56', '2017-07-17 21:10:57', '2017-06-13 12:37:03', '2017-07-18 04:10:57', NULL),
(481, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/lost-wax', 1, '2017-07-17 21:10:57', '2017-07-17 21:10:58', '2017-06-13 12:37:03', '2017-07-18 04:10:58', NULL),
(482, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/carbon-clip', 1, '2017-07-17 21:10:58', '2017-07-17 21:10:59', '2017-06-13 12:37:03', '2017-07-18 04:10:59', NULL),
(483, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/bicycle-bone-riders-playing-cards', 1, '2017-07-17 21:10:59', '2017-07-17 21:10:59', '2017-06-13 12:37:03', '2017-07-18 04:10:59', NULL),
(484, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/white-lions-series-a', 1, '2017-07-17 21:10:59', '2017-07-17 21:11:00', '2017-06-13 12:37:03', '2017-07-18 04:11:00', NULL),
(485, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/chicken-nugget-playing-cards', 1, '2017-07-17 21:11:00', '2017-07-17 21:11:01', '2017-06-13 12:37:03', '2017-07-18 04:11:01', NULL),
(486, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/russian-folk-art', 1, '2017-07-17 21:11:01', '2017-07-17 21:11:02', '2017-06-13 12:37:03', '2017-07-18 04:11:02', NULL),
(487, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/joker-and-the-thief', 1, '2017-07-17 21:11:02', '2017-07-17 21:11:03', '2017-06-13 12:37:03', '2017-07-18 04:11:03', NULL),
(488, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/bicycle-8-bit', 1, '2017-07-17 21:11:03', '2017-07-17 21:11:03', '2017-06-13 12:37:03', '2017-07-18 04:11:03', NULL),
(489, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/odd-bods', 1, '2017-07-17 21:11:03', '2017-07-17 21:11:04', '2017-06-13 12:37:03', '2017-07-18 04:11:04', NULL),
(490, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/les-melies-playing-cards', 1, '2017-07-17 21:11:04', '2017-07-17 21:11:05', '2017-06-13 12:37:04', '2017-07-18 04:11:05', NULL),
(491, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/sons-of-liberty', 1, '2017-07-17 21:11:05', '2017-07-17 21:11:05', '2017-06-13 12:37:04', '2017-07-18 04:11:05', NULL),
(492, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/vintage-plaid-arizona-red', 1, '2017-07-17 21:11:05', '2017-07-17 21:11:06', '2017-06-13 12:37:04', '2017-07-18 04:11:06', NULL),
(493, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/draconian-brimstone-ed', 1, '2017-07-17 21:11:06', '2017-07-17 21:11:07', '2017-06-13 12:37:04', '2017-07-18 04:11:07', NULL),
(494, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/bicycle-chainless', 1, '2017-07-17 21:11:07', '2017-07-17 21:11:08', '2017-06-13 12:37:04', '2017-07-18 04:11:08', NULL),
(495, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/citizens', 1, '2017-07-17 21:11:08', '2017-07-17 21:11:09', '2017-06-13 12:37:04', '2017-07-18 04:11:09', NULL),
(496, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/piff-the-magic-dragon', 1, '2017-07-17 21:11:09', '2017-07-17 21:11:09', '2017-06-13 12:37:04', '2017-07-18 04:11:09', NULL),
(497, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/vanda-violet-edition', 1, '2017-07-17 21:11:10', '2017-07-17 21:11:10', '2017-06-13 12:37:04', '2017-07-18 04:11:10', NULL),
(498, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/triplicate', 1, '2017-07-17 21:11:10', '2017-07-17 21:11:11', '2017-06-13 12:37:04', '2017-07-18 04:11:11', NULL),
(499, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/uusi-classic', 1, '2017-07-17 21:11:11', '2017-07-17 21:11:12', '2017-06-13 12:37:04', '2017-07-18 04:11:12', NULL),
(500, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/kings-of-india', 1, '2017-07-17 21:11:12', '2017-07-17 21:11:13', '2017-06-13 12:37:04', '2017-07-18 04:11:13', NULL),
(501, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/union-playing-cards', 1, '2017-07-17 21:11:13', '2017-07-17 21:11:13', '2017-06-13 12:37:04', '2017-07-18 04:11:13', NULL),
(502, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/blossom-playing-cards', 1, '2017-07-17 21:11:13', '2017-07-17 21:11:14', '2017-06-13 12:37:04', '2017-07-18 04:11:14', NULL),
(503, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/dkng-playing-cards', 1, '2017-07-17 21:11:14', '2017-07-17 21:11:15', '2017-06-13 12:37:04', '2017-07-18 04:11:15', NULL),
(504, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/luxx-palme-ed', 1, '2017-07-17 21:11:15', '2017-07-17 21:11:16', '2017-06-13 12:37:04', '2017-07-18 04:11:16', NULL),
(505, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/made-by-children', 1, '2017-07-17 21:11:16', '2017-07-17 21:11:17', '2017-06-13 12:37:04', '2017-07-18 04:11:17', NULL),
(506, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/crown-deck', 1, '2017-07-17 21:11:17', '2017-07-17 21:11:18', '2017-06-13 12:37:04', '2017-07-18 04:11:18', NULL),
(507, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/sleepy-hollow', 1, '2017-07-17 21:11:18', '2017-07-17 21:11:19', '2017-06-13 12:37:04', '2017-07-18 04:11:19', NULL),
(508, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/third-man-records', 1, '2017-07-17 21:11:19', '2017-07-17 21:11:20', '2017-06-13 12:37:04', '2017-07-18 04:11:20', NULL),
(509, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/playing-arts-deck-v2', 1, '2017-07-17 21:11:20', '2017-07-17 21:11:20', '2017-06-13 12:37:04', '2017-07-18 04:11:20', NULL),
(510, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/aviator-heritage-edition', 1, '2017-07-17 21:11:20', '2017-07-17 21:11:21', '2017-06-13 12:37:04', '2017-07-18 04:11:21', NULL),
(511, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/luxx-playing-cards', 1, '2017-07-17 21:11:21', '2017-07-17 21:11:22', '2017-06-13 12:37:04', '2017-07-18 04:11:22', NULL),
(512, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/bicycle-peacock-deck', 1, '2017-07-17 21:11:22', '2017-07-17 21:11:23', '2017-06-13 12:37:04', '2017-07-18 04:11:23', NULL),
(513, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/hollingworths-emerald-ed', 1, '2017-07-17 21:11:23', '2017-07-17 21:11:24', '2017-06-13 12:37:04', '2017-07-18 04:11:24', NULL),
(514, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/nomad-playing-cards', 1, '2017-07-17 21:11:24', '2017-07-17 21:11:24', '2017-06-13 12:37:04', '2017-07-18 04:11:24', NULL),
(515, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/noc-playing-cards', 1, '2017-07-17 21:11:25', '2017-07-17 21:11:25', '2017-06-13 12:37:04', '2017-07-18 04:11:25', NULL),
(516, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/alice-in-wonderland', 1, '2017-07-17 21:11:25', '2017-07-17 21:11:26', '2017-06-13 12:37:04', '2017-07-18 04:11:26', NULL),
(517, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/revelation-deck', 1, '2017-07-17 21:11:26', '2017-07-17 21:11:27', '2017-06-13 12:37:04', '2017-07-18 04:11:27', NULL),
(518, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/mailchimp-playing-cards', 1, '2017-07-17 21:11:27', '2017-07-17 21:11:28', '2017-06-13 12:37:05', '2017-07-18 04:11:28', NULL),
(519, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/antler-limited-edition-playing-cards', 1, '2017-07-17 21:11:28', '2017-07-17 21:11:29', '2017-06-13 12:37:05', '2017-07-18 04:11:29', NULL),
(520, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/antler-playing-cards', 1, '2017-07-17 21:11:29', '2017-07-17 21:11:29', '2017-06-13 12:37:06', '2017-07-18 04:11:29', NULL),
(521, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/bicycle-leaf-back', 1, '2017-07-17 21:11:29', '2017-07-17 21:11:30', '2017-06-13 12:37:06', '2017-07-18 04:11:30', NULL),
(522, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/bicycle-sideshow-freaks', 1, '2017-07-17 21:11:30', '2017-07-17 21:11:31', '2017-06-13 12:37:06', '2017-07-18 04:11:31', NULL),
(523, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/bicycle-130th-anniversary-ed', 1, '2017-07-17 21:11:31', '2017-07-17 21:11:32', '2017-06-13 12:37:06', '2017-07-18 04:11:32', NULL),
(524, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/the-design-deck', 1, '2017-07-17 21:11:32', '2017-07-17 21:11:32', '2017-06-13 12:37:06', '2017-07-18 04:11:32', NULL),
(525, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/bulldog-squeezers', 1, '2017-07-17 21:11:32', '2017-07-17 21:11:33', '2017-06-13 12:37:06', '2017-07-18 04:11:33', NULL),
(526, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/bad-robot-playing-cards', 1, '2017-07-17 21:11:33', '2017-07-17 21:11:33', '2017-06-13 12:37:06', '2017-07-18 04:11:33', NULL),
(527, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/bicycle-aves', 1, '2017-07-17 21:11:33', '2017-07-17 21:11:33', '2017-06-13 12:37:06', '2017-07-18 04:11:33', NULL),
(528, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/rarebit-playing-cards', 1, '2017-07-17 21:11:33', '2017-07-17 21:11:34', '2017-06-13 12:37:06', '2017-07-18 04:11:34', NULL),
(529, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/mechanics-optricks', 1, '2017-07-17 21:11:34', '2017-07-17 21:11:34', '2017-06-13 12:37:06', '2017-07-18 04:11:34', NULL),
(530, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/les-printemps', 1, '2017-07-17 21:11:34', '2017-07-17 21:11:34', '2017-06-13 12:37:06', '2017-07-18 04:11:34', NULL),
(531, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/prime', 1, '2017-07-17 21:11:34', '2017-07-17 21:11:35', '2017-06-13 12:37:06', '2017-07-18 04:11:35', NULL),
(532, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/bicycle-golden-spike', 1, '2017-07-17 21:11:35', '2017-07-17 21:11:35', '2017-06-13 12:37:06', '2017-07-18 04:11:35', NULL),
(533, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/bicycle-frontier', 1, '2017-07-17 21:11:35', '2017-07-17 21:11:36', '2017-06-13 12:37:06', '2017-07-18 04:11:36', NULL),
(534, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/tycoon', 1, '2017-07-17 21:11:36', '2017-07-17 21:11:36', '2017-06-13 12:37:06', '2017-07-18 04:11:36', NULL),
(535, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/flesh-bones', 1, '2017-07-17 21:11:36', '2017-07-17 21:11:36', '2017-06-13 12:37:06', '2017-07-18 04:11:36', NULL),
(536, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/borderline', 1, '2017-07-17 21:11:36', '2017-07-17 21:11:37', '2017-06-13 12:37:06', '2017-07-18 04:11:37', NULL),
(537, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/deck-stays', 1, '2017-07-17 21:11:37', '2017-07-17 21:11:37', '2017-06-13 12:37:06', '2017-07-18 04:11:37', NULL),
(538, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/hotcakes', 1, '2017-07-17 21:11:37', '2017-07-17 21:11:37', '2017-06-13 12:37:06', '2017-07-18 04:11:37', NULL),
(539, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/framed-deck', 1, '2017-07-17 21:11:37', '2017-07-17 21:11:38', '2017-06-13 12:37:06', '2017-07-18 04:11:38', NULL),
(540, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/voltige', 1, '2017-07-17 21:11:38', '2017-07-17 21:11:38', '2017-06-13 12:37:06', '2017-07-18 04:11:38', NULL),
(541, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/boardwalk-papers', 1, '2017-07-17 21:11:38', '2017-07-17 21:11:38', '2017-06-13 12:37:06', '2017-07-18 04:11:38', NULL),
(542, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/bicycle-cupid-back', 1, '2017-07-17 21:11:38', '2017-07-17 21:11:39', '2017-06-13 12:37:06', '2017-07-18 04:11:39', NULL),
(543, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/bicycle-madison-playing-cards', 1, '2017-07-17 21:11:39', '2017-07-17 21:11:39', '2017-06-13 12:37:06', '2017-07-18 04:11:39', NULL),
(544, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/pagan', 1, '2017-07-17 21:11:39', '2017-07-17 21:11:39', '2017-06-13 12:37:07', '2017-07-18 04:11:39', NULL),
(545, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/private-reserve', 1, '2017-07-17 21:11:39', '2017-07-17 21:11:40', '2017-06-13 12:37:07', '2017-07-18 04:11:40', NULL),
(546, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/shifters', 1, '2017-07-17 21:11:40', '2017-07-17 21:11:40', '2017-06-13 12:37:07', '2017-07-18 04:11:40', NULL),
(547, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/bicycle-gold-dragon-back', 1, '2017-07-17 21:11:40', '2017-07-17 21:11:40', '2017-06-13 12:37:07', '2017-07-18 04:11:40', NULL),
(548, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/nautical-playing-cards', 1, '2017-07-17 21:11:40', '2017-07-17 21:11:41', '2017-06-13 12:37:07', '2017-07-18 04:11:41', NULL),
(549, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/mustache-playing-cards', 1, '2017-07-17 21:11:41', '2017-07-17 21:11:41', '2017-06-13 12:37:07', '2017-07-18 04:11:41', NULL),
(550, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/deckstarter', 1, '2017-07-17 21:11:41', '2017-07-17 21:11:41', '2017-06-13 12:37:07', '2017-07-18 04:11:41', NULL),
(551, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/texan', 1, '2017-07-17 21:11:41', '2017-07-17 21:11:42', '2017-06-13 12:37:07', '2017-07-18 04:11:42', NULL),
(552, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/medallions', 1, '2017-07-17 21:11:42', '2017-07-17 21:11:42', '2017-06-13 12:37:07', '2017-07-18 04:11:42', NULL),
(553, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/bicycle-tangent-back-playing-cards', 1, '2017-07-17 21:11:42', '2017-07-17 21:11:42', '2017-06-13 12:37:07', '2017-07-18 04:11:42', NULL),
(554, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/bicycle-thistle-back-playing-cards', 1, '2017-07-17 21:11:42', '2017-07-17 21:11:43', '2017-06-13 12:37:07', '2017-07-18 04:11:43', NULL),
(555, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/classic-clip', 1, '2017-07-17 21:11:43', '2017-07-17 21:11:43', '2017-06-13 12:37:07', '2017-07-18 04:11:43', NULL),
(556, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/madison-dealers-playing-cards', 1, '2017-07-17 21:11:43', '2017-07-17 21:11:43', '2017-06-13 12:37:07', '2017-07-18 04:11:43', NULL),
(557, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/erdnase-1902-smith-back-no-2-playing-cards', 1, '2017-07-17 21:11:43', '2017-07-17 21:11:44', '2017-06-13 12:37:07', '2017-07-18 04:11:44', NULL),
(558, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/bicycle-lumberjack-playing-cards', 1, '2017-07-17 21:11:44', '2017-07-17 21:11:44', '2017-06-13 12:37:07', '2017-07-18 04:11:44', NULL),
(559, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/erdnaseum-playing-cards', 1, '2017-07-17 21:11:44', '2017-07-17 21:11:44', '2017-06-13 12:37:07', '2017-07-18 04:11:44', NULL),
(560, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/bumble-bee-casino-playing-cards', 1, '2017-07-17 21:11:44', '2017-07-17 21:11:45', '2017-06-13 12:37:07', '2017-07-18 04:11:45', NULL),
(561, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/bicycle-robocycle-playing-cards', 1, '2017-07-17 21:11:45', '2017-07-17 21:11:45', '2017-06-13 12:37:07', '2017-07-18 04:11:45', NULL),
(562, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/charity-water-playing-cards', 1, '2017-07-17 21:11:45', '2017-07-17 21:11:45', '2017-06-13 12:37:07', '2017-07-18 04:11:45', NULL),
(563, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/misc-goods-co-playing-cards', 1, '2017-07-17 21:11:45', '2017-07-17 21:11:46', '2017-06-13 12:37:07', '2017-07-18 04:11:46', NULL),
(564, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/bohemia-playing-cards', 1, '2017-07-17 21:11:46', '2017-07-17 21:11:46', '2017-06-13 12:37:07', '2017-07-18 04:11:46', NULL),
(565, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/a-bandit-playing-cards', 1, '2017-07-17 21:11:46', '2017-07-17 21:11:46', '2017-06-13 12:37:07', '2017-07-18 04:11:46', NULL),
(566, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/animal-kingdom-playing-cards', 1, '2017-07-17 21:11:46', '2017-07-17 21:11:47', '2017-06-13 12:37:07', '2017-07-18 04:11:47', NULL),
(567, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/love-me-playing-cards-curtis-kulig', 1, '2017-07-17 21:11:47', '2017-07-17 21:11:47', '2017-06-13 12:37:07', '2017-07-18 04:11:47', NULL),
(568, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/steamboat-playing-cards', 1, '2017-07-17 21:11:47', '2017-07-17 21:11:47', '2017-06-13 12:37:07', '2017-07-18 04:11:47', NULL),
(569, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/tally-ho-fan-back-playing-cards', 1, '2017-07-17 21:11:47', '2017-07-17 21:11:48', '2017-06-13 12:37:07', '2017-07-18 04:11:48', NULL),
(570, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/ultimate-deck-stranger-and-stranger-playing-cards', 1, '2017-07-17 21:11:48', '2017-07-17 21:11:48', '2017-06-13 12:37:07', '2017-07-18 04:11:48', NULL),
(571, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/best-made-co-famous-playing-cards', 1, '2017-07-17 21:11:48', '2017-07-17 21:11:48', '2017-06-13 12:37:08', '2017-07-18 04:11:48', NULL),
(572, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/smoke-and-mirrors-playing-cards', 1, '2017-07-17 21:11:48', '2017-07-17 21:11:49', '2017-06-13 12:37:08', '2017-07-18 04:11:49', NULL),
(573, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/bicycle-steampunk-playing-cards', 1, '2017-07-17 21:11:49', '2017-07-17 21:11:49', '2017-06-13 12:37:08', '2017-07-18 04:11:49', NULL),
(574, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/deckone-playing-cards', 1, '2017-07-17 21:11:49', '2017-07-17 21:11:49', '2017-06-13 12:37:08', '2017-07-18 04:11:49', NULL),
(575, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/fultons-clip-joint-playing-cards', 1, '2017-07-17 21:11:49', '2017-07-17 21:11:50', '2017-06-13 12:37:08', '2017-07-18 04:11:50', NULL),
(576, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/arrco-us-regulation-playing-cards', 1, '2017-07-17 21:11:50', '2017-07-17 21:11:50', '2017-06-13 12:37:08', '2017-07-18 04:11:50', NULL),
(577, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/artisan-playing-cards', 1, '2017-07-17 21:11:50', '2017-07-17 21:11:50', '2017-06-13 12:37:08', '2017-07-18 04:11:50', NULL),
(578, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/ask-alexander-playing-cards', 1, '2017-07-17 21:11:50', '2017-07-17 21:11:51', '2017-06-13 12:37:08', '2017-07-18 04:11:51', NULL),
(579, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/bicycle-eco-playing-cards', 1, '2017-07-17 21:11:51', '2017-07-17 21:11:51', '2017-06-13 12:37:08', '2017-07-18 04:11:51', NULL),
(580, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/bicycle-rider-back-playing-cards', 1, '2017-07-17 21:11:51', '2017-07-17 21:11:51', '2017-06-13 12:37:09', '2017-07-18 04:11:51', NULL),
(581, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/fultons-chinatown-game-of-death-playing-cards', 1, '2017-07-17 21:11:51', '2017-07-17 21:11:52', '2017-06-13 12:37:09', '2017-07-18 04:11:52', NULL),
(582, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/bee-playing-cards', 1, '2017-07-17 21:11:52', '2017-07-17 21:11:52', '2017-06-13 12:37:09', '2017-07-18 04:11:52', NULL),
(583, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/ace-fultons-casino-playing-cards', 1, '2017-07-17 21:11:52', '2017-07-17 21:11:52', '2017-06-13 12:37:09', '2017-07-18 04:11:52', NULL),
(584, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/tally-ho-circle-back-playing-cards', 1, '2017-07-17 21:11:52', '2017-07-17 21:11:52', '2017-06-13 12:37:09', '2017-07-18 04:11:52', NULL),
(585, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/aviator-playing-cards', 1, '2017-07-17 21:11:53', '2017-07-17 21:11:53', '2017-06-13 12:37:09', '2017-07-18 04:11:53', NULL),
(586, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/aristocrat-playing-cards', 1, '2017-07-17 21:11:53', '2017-07-17 21:11:53', '2017-06-13 12:37:09', '2017-07-18 04:11:53', NULL),
(587, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/arrco-tahoe-playing-cards', 1, '2017-07-17 21:11:53', '2017-07-17 21:11:53', '2017-06-13 12:37:09', '2017-07-18 04:11:53', NULL);
INSERT INTO `crawling_card_pages` (`id`, `crawler_id`, `card_id`, `url`, `last_run_success`, `last_run`, `last_completion`, `created_at`, `updated_at`, `deleted_at`) VALUES
(588, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/vintage-plaid-playing-cards', 1, '2017-07-17 21:11:53', '2017-07-17 21:11:54', '2017-06-13 12:37:09', '2017-07-18 04:11:54', NULL),
(589, 11, NULL, 'https://store.theory11.com/products/neil-patrick-harris-playing-cards', 1, '2017-06-21 18:10:11', '2017-06-21 18:10:12', '2017-06-22 00:45:02', '2017-06-22 01:10:12', NULL),
(590, 11, NULL, 'https://store.theory11.com/products/mysterybox', 1, '2017-06-21 18:10:12', '2017-06-21 18:10:12', '2017-06-22 00:45:02', '2017-06-22 01:10:12', NULL),
(591, 11, NULL, 'https://store.theory11.com/products/ivory-tycoon-playing-cards', 1, '2017-06-21 18:10:12', '2017-06-21 18:10:12', '2017-06-22 00:45:02', '2017-06-22 01:10:12', NULL),
(592, 11, NULL, 'https://store.theory11.com/products/citizens-playing-cards', 1, '2017-06-21 18:10:12', '2017-06-21 18:10:13', '2017-06-22 00:45:02', '2017-06-22 01:10:13', NULL),
(593, 11, NULL, 'https://store.theory11.com/products/monarchs', 1, '2017-06-21 18:10:13', '2017-06-21 18:10:13', '2017-06-22 00:45:03', '2017-06-22 01:10:13', NULL),
(594, 11, NULL, 'https://store.theory11.com/products/national-playing-cards', 1, '2017-06-21 18:10:13', '2017-06-21 18:10:13', '2017-06-22 00:51:09', '2017-06-22 01:10:13', NULL),
(595, 11, NULL, 'https://store.theory11.com/products/rarebit-gold-edition-playing-cards', 1, '2017-06-21 18:10:13', '2017-06-21 18:10:13', '2017-06-22 00:51:09', '2017-06-22 01:10:13', NULL),
(596, 11, NULL, 'https://store.theory11.com/products/now-you-see-me-playing-cards', 1, '2017-06-21 18:10:13', '2017-06-21 18:10:13', '2017-06-22 00:51:09', '2017-06-22 01:10:13', NULL),
(597, 11, NULL, 'https://store.theory11.com/products/5th-and-laurel-playing-cards', 1, '2017-06-21 18:10:13', '2017-06-21 18:10:13', '2017-06-22 00:51:09', '2017-06-22 01:10:13', NULL),
(598, 11, NULL, 'https://store.theory11.com/products/gold-monarch-playing-cards', 1, '2017-06-21 18:10:13', '2017-06-21 18:10:14', '2017-06-22 00:51:09', '2017-06-22 01:10:14', NULL),
(599, 11, NULL, 'https://store.theory11.com/products/union-playing-cards', 1, '2017-06-21 18:10:14', '2017-06-21 18:10:14', '2017-06-22 00:51:09', '2017-06-22 01:10:14', NULL),
(600, 11, NULL, 'https://store.theory11.com/products/green-monarch-playing-cards', 1, '2017-06-21 18:10:14', '2017-06-21 18:10:14', '2017-06-22 00:51:10', '2017-06-22 01:10:14', NULL),
(601, 11, NULL, 'https://store.theory11.com/products/jaqk-blue-edition-playing-cards', 1, '2017-06-21 18:10:14', '2017-06-21 18:10:14', '2017-06-22 00:51:10', '2017-06-22 01:10:14', NULL),
(602, 11, NULL, 'https://store.theory11.com/products/black-tycoon-playing-cards', 1, '2017-06-21 18:10:14', '2017-06-21 18:10:15', '2017-06-22 00:51:10', '2017-06-22 01:10:15', NULL),
(603, 11, NULL, 'https://store.theory11.com/products/mailchimp-summer-edition', 1, '2017-06-21 18:10:15', '2017-06-21 18:10:15', '2017-06-22 00:51:10', '2017-06-22 01:10:15', NULL),
(604, 11, NULL, 'https://store.theory11.com/products/nomad-playing-cards', 1, '2017-06-21 18:10:15', '2017-06-21 18:10:15', '2017-06-22 00:51:10', '2017-06-22 01:10:15', NULL),
(605, 11, NULL, 'https://store.theory11.com/products/mailchimp-playing-cards', 1, '2017-06-21 18:10:15', '2017-06-21 18:10:15', '2017-06-22 00:51:10', '2017-06-22 01:10:15', NULL),
(606, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/camp-cards-ranger-ed', 1, '2017-07-17 21:11:54', '2017-07-17 21:11:54', '2017-07-18 03:40:32', '2017-07-18 04:11:54', NULL),
(607, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/skateboard-deck', 1, '2017-07-17 21:11:54', '2017-07-17 21:11:54', '2017-07-18 03:40:32', '2017-07-18 04:11:54', NULL),
(608, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/drifters', 1, '2017-07-17 21:11:54', '2017-07-17 21:11:55', '2017-07-18 03:40:32', '2017-07-18 04:11:55', NULL),
(609, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/cina-deck-by-misc-goods', 1, '2017-07-17 21:11:55', '2017-07-17 21:11:55', '2017-07-18 03:40:32', '2017-07-18 04:11:55', NULL),
(610, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/classic-clip-limited-charcoal-ed', 1, '2017-07-17 21:11:55', '2017-07-17 21:11:55', '2017-07-18 03:40:32', '2017-07-18 04:11:55', NULL),
(611, 4, NULL, 'https://www.artofplay.com/collections/playing-cards/products/twin-leather-case', 1, '2017-07-17 21:11:55', '2017-07-17 21:11:56', '2017-07-18 03:40:34', '2017-07-18 04:11:56', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `crawling_crawlers`
--

CREATE TABLE `crawling_crawlers` (
  `id` int(10) UNSIGNED NOT NULL,
  `store_id` int(10) UNSIGNED NOT NULL,
  `list_url` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `list_frequency` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0 3 * * *',
  `last_list_run_success` tinyint(1) NOT NULL DEFAULT '1',
  `last_list_run` datetime DEFAULT NULL,
  `last_list_completion` datetime DEFAULT NULL,
  `list_state` enum('RUNNING','ON','OFF') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'OFF',
  `cards_frequency` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0 3 * * *',
  `last_cards_run_success` tinyint(1) NOT NULL DEFAULT '1',
  `last_cards_run` datetime DEFAULT NULL,
  `last_cards_completion` datetime DEFAULT NULL,
  `cards_state` enum('RUNNING','ON','OFF') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'OFF',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `individual_selector` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url_selector` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `brand_selector` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name_selector` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description_selector` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `in_stock_selector` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price_selector` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Contenu de la table `crawling_crawlers`
--

INSERT INTO `crawling_crawlers` (`id`, `store_id`, `list_url`, `list_frequency`, `last_list_run_success`, `last_list_run`, `last_list_completion`, `list_state`, `cards_frequency`, `last_cards_run_success`, `last_cards_run`, `last_cards_completion`, `cards_state`, `created_at`, `updated_at`, `deleted_at`, `individual_selector`, `url_selector`, `brand_selector`, `name_selector`, `description_selector`, `in_stock_selector`, `price_selector`) VALUES
(1, 6, 'http://www.kingofcards.co.uk/playing-cards.html?limit=all', '0 3 * * *', 1, '2017-06-14 02:24:27', '2017-06-14 02:24:32', 'ON', '0 3 * * *', 1, NULL, NULL, 'OFF', '2017-06-11 14:25:59', '2017-06-14 09:24:32', NULL, '.products-grid > .item ', '.product-name > a', NULL, NULL, NULL, NULL, NULL),
(2, 10, 'http://jpplayingcards.co.uk/buy-playing-cards?limit=100&page={page}', '0 3 * * *', 1, '2017-06-13 04:32:02', '2017-06-13 04:32:12', 'ON', '0 3 * * *', 1, NULL, NULL, 'OFF', '2017-06-11 15:07:40', '2017-06-13 11:32:26', NULL, '#content .product-list', '.product-thumb > div > .caption > .product-module-title > a', NULL, NULL, NULL, NULL, NULL),
(3, 5, 'https://shop.davidblaine.com/collections/playingcards', '0 3 * * *', 1, '2017-06-13 23:24:21', '2017-06-13 23:24:22', 'ON', '0 3 * * *', 1, '2017-06-13 23:30:11', '2017-06-13 23:30:14', 'ON', '2017-06-12 09:06:48', '2017-06-14 06:30:14', NULL, 'div[itemtype="http://schema.org/ItemList"] div[itemprop="itemListElement"]', 'a', NULL, NULL, NULL, NULL, NULL),
(4, 3, 'https://www.artofplay.com/collections/playing-cards?page={page}', '0 3 * * *', 1, '2017-07-17 20:40:28', '2017-07-17 20:40:39', 'ON', '0 3 * * *', 1, '2017-07-17 21:10:39', '2017-07-17 21:11:56', 'ON', '2017-06-13 08:00:50', '2017-07-18 04:11:56', NULL, 'ul.collection__grid > .collection__grid-item', 'a.collection__product-link', NULL, '.product__info .product__title div', '.product__info .product__description', NULL, '.product__info .product__price'),
(5, 11, 'http://www.bigblindmedia.com/karnival-inc/?sort=newest&page={page}', '0 3 * * *', 1, NULL, NULL, 'OFF', '0 3 * * *', 1, NULL, NULL, 'OFF', '2017-06-13 08:04:47', '2017-06-13 08:04:47', NULL, '.product-listing-form .product-item-grid', 'a.product-item-link', NULL, NULL, NULL, NULL, NULL),
(6, 8, 'https://blackinkplayingcards.com/collections/playing-cards/playing-cards', '0 3 * * *', 1, '2017-07-29 18:24:44', '2017-07-29 18:24:45', 'ON', '0 3 * * *', 1, '2017-07-29 18:24:48', '2017-07-29 18:24:50', 'ON', '2017-06-13 08:20:06', '2017-07-30 01:24:50', NULL, '#Collection .grid .grid__item', 'a.grid-view-item__link', NULL, '.product-single h1.product-single__title[itemprop="name"]', '.product-single .product-single__description p', NULL, '.product-single p.product-single__price span.product-price__price span[itemprop="price"]'),
(7, 14, 'https://cardvolution.com/shop/page/{page}/?orderby=date', '0 3 * * *', 1, NULL, NULL, 'OFF', '0 3 * * *', 1, NULL, NULL, 'OFF', '2017-06-13 08:45:39', '2017-06-13 08:45:39', NULL, '.products .product', '.box-text .product-title a', NULL, NULL, NULL, NULL, NULL),
(8, 12, 'http://www.heartsandnines.com/product-category/cards/page/{page}', '0 3 * * *', 1, NULL, NULL, 'OFF', '0 3 * * *', 1, NULL, NULL, 'OFF', '2017-06-13 08:50:06', '2017-06-13 08:50:06', NULL, 'ul.products > li.product-small', 'a.woocommerce-LoopProduct-link', NULL, NULL, NULL, NULL, NULL),
(9, 19, 'https://legendsplayingcards.com/collections/playing-cards?page={page}', '0 3 * * *', 1, NULL, NULL, 'OFF', '0 3 * * *', 1, NULL, NULL, 'OFF', '2017-06-13 08:51:57', '2017-06-13 08:51:57', NULL, '.collection-products > .product-list-item', '.product-list-item-details > .product-list-item-title > a', NULL, NULL, NULL, NULL, NULL),
(10, 18, 'https://lvcardistry.com/collections/all?page={page}', '0 3 * * *', 1, NULL, NULL, 'OFF', '0 3 * * *', 1, NULL, NULL, 'OFF', '2017-06-13 08:55:01', '2017-06-13 08:55:01', NULL, '.collection-grid > .element', '.desc > h5 > a', NULL, NULL, NULL, NULL, NULL),
(11, 4, 'https://store.theory11.com/collections/playingcards', '0 3 * * *', 1, '2017-06-21 17:51:09', '2017-06-21 17:51:10', 'ON', '0 3 * * *', 1, '2017-06-21 18:10:11', '2017-06-21 18:10:15', 'ON', '2017-06-22 00:42:18', '2017-06-22 01:10:15', NULL, '#content.products #itemcontainer a.item', '&', NULL, NULL, NULL, NULL, 'form.buy .price');

-- --------------------------------------------------------

--
-- Structure de la table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Contenu de la table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(37, '2017_05_22_194504_brands', 1),
(38, '2017_05_22_194517_categories', 1),
(39, '2017_05_22_194701_cards', 1),
(40, '2017_05_22_194713_variations', 1),
(41, '2017_05_22_195400_pictures', 1),
(42, '2017_05_22_195503_stores', 1),
(43, '2017_05_22_201031_create_store_variation_pivot_table', 1),
(44, '2017_05_25_053248_alter_table_stores_add_default_shipping_column', 2),
(45, '2017_05_25_053354_alter_table_store_variation_add_shipping_column', 2),
(46, '2017_06_11_051419_alter_table_stores_set_description_nullable', 3),
(52, '2017_06_11_064934_create_crawling_table_card_data', 4),
(51, '2017_06_11_064921_create_crawling_table_card_pages', 4),
(50, '2017_06_11_062621_create_crawling_table_crawlers', 4),
(53, '2017_06_12_002011_alter_table_crawlers_add_data_selectors', 5),
(54, '2017_06_14_024144_alter_table_crawling_card_data_nullable_availability', 6),
(55, '2017_06_14_024145_create_levenshtein_function', 7),
(56, '2017_06_21_170808_alter_table_crawling_card_data_add_variation_id', 8);

-- --------------------------------------------------------

--
-- Structure de la table `pictures`
--

CREATE TABLE `pictures` (
  `id` int(10) UNSIGNED NOT NULL,
  `variation_id` int(10) UNSIGNED NOT NULL,
  `type` enum('case','back','front','splash','other') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'other',
  `main` tinyint(1) NOT NULL DEFAULT '0',
  `path` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Contenu de la table `pictures`
--

INSERT INTO `pictures` (`id`, `variation_id`, `type`, `main`, `path`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 'back', 1, '/storage/cards/1-1-back-main.png', '2017-05-23 10:34:20', '2017-05-23 10:34:20', NULL),
(2, 1, 'front', 1, '/storage/cards/1-2-front-main.png', '2017-05-23 10:34:20', '2017-05-23 10:34:20', NULL),
(3, 2, 'back', 1, '/storage/cards/2-3-back-main.png', '2017-05-23 10:34:20', '2017-05-23 10:34:20', NULL),
(4, 2, 'front', 1, '/storage/cards/2-4-front-main.png', '2017-05-23 10:34:20', '2017-05-23 10:34:20', NULL),
(8, 1, 'splash', 1, '/storage/cards/1-8-splash-main.png', NULL, NULL, NULL),
(9, 10, 'back', 1, '/storage/cards/11-back-main.png', '2017-05-24 13:15:54', '2017-05-24 13:15:54', NULL),
(10, 11, 'back', 1, '/storage/cards/12-back-main.png', '2017-05-24 13:15:54', '2017-05-24 13:15:54', NULL),
(11, 12, 'back', 1, '/storage/cards/13-back-main.png', '2017-05-24 13:15:54', '2017-05-24 13:15:54', NULL),
(12, 13, 'back', 1, '/storage/cards/14-back-main.png', '2017-05-24 13:15:54', '2017-05-24 13:15:54', NULL),
(13, 14, 'back', 1, '/storage/cards/15-back-main.png', '2017-05-24 13:15:55', '2017-05-24 13:15:55', NULL),
(14, 15, 'back', 1, '/storage/cards/16-back-main.png', '2017-05-24 13:15:55', '2017-05-24 13:15:55', NULL),
(15, 16, 'back', 1, '/storage/cards/17-back-main.png', '2017-05-24 13:15:55', '2017-05-24 13:15:55', NULL),
(16, 17, 'back', 1, '/storage/cards/18-back-main.png', '2017-05-24 13:15:55', '2017-05-24 13:15:55', NULL),
(17, 18, 'back', 1, '/storage/cards/19-back-main.png', '2017-05-24 13:15:55', '2017-05-24 13:15:55', NULL),
(18, 19, 'back', 1, '/storage/cards/20-back-main.png', '2017-05-24 13:15:55', '2017-05-24 13:15:55', NULL),
(19, 20, 'back', 1, '/storage/cards/21-back-main.png', '2017-05-24 13:15:55', '2017-05-24 13:15:55', NULL),
(20, 21, 'back', 1, '/storage/cards/22-back-main.png', '2017-05-24 13:15:55', '2017-05-24 13:15:55', NULL),
(21, 22, 'back', 1, '/storage/cards/23-back-main.png', '2017-05-24 13:15:55', '2017-05-24 13:15:55', NULL),
(22, 23, 'back', 1, '/storage/cards/24-back-main.png', '2017-05-24 13:15:56', '2017-05-24 13:15:56', NULL),
(23, 24, 'back', 1, '/storage/cards/25-back-main.png', '2017-05-24 13:15:56', '2017-05-24 13:15:56', NULL),
(24, 25, 'back', 1, '/storage/cards/26-back-main.png', '2017-05-24 13:15:56', '2017-05-24 13:15:56', NULL),
(25, 26, 'back', 1, '/storage/cards/27-back-main.png', '2017-05-24 13:15:56', '2017-05-24 13:15:56', NULL),
(26, 27, 'back', 1, '/storage/cards/28-back-main.png', '2017-05-24 13:15:56', '2017-05-24 13:15:56', NULL),
(27, 28, 'back', 1, '/storage/cards/29-back-main.png', '2017-05-24 13:15:56', '2017-05-24 13:15:56', NULL),
(28, 29, 'back', 1, '/storage/cards/30-back-main.png', '2017-05-24 13:15:56', '2017-05-24 13:15:56', NULL),
(29, 30, 'back', 1, '/storage/cards/31-back-main.png', '2017-05-24 13:15:56', '2017-05-24 13:15:56', NULL),
(31, 32, 'back', 1, '/storage/cards/33-back-main.png', '2017-05-25 13:36:41', '2017-05-25 13:36:41', NULL),
(32, 33, 'back', 1, '/storage/cards/34-back-main.png', '2017-05-25 13:36:41', '2017-05-25 13:36:41', NULL),
(33, 34, 'back', 1, '/storage/cards/35-back-main.png', '2017-05-25 13:36:41', '2017-05-25 13:36:41', NULL),
(34, 35, 'back', 1, '/storage/cards/36-back-main.png', '2017-05-25 13:36:41', '2017-05-25 13:36:41', NULL),
(35, 36, 'back', 1, '/storage/cards/37-back-main.png', '2017-05-25 13:36:41', '2017-05-25 13:36:41', NULL),
(36, 37, 'back', 1, '/storage/cards/38-back-main.png', '2017-05-25 13:36:41', '2017-05-25 13:36:41', NULL),
(37, 38, 'back', 1, '/storage/cards/39-back-main.png', '2017-05-25 13:36:42', '2017-05-25 13:36:42', NULL),
(38, 39, 'back', 1, '/storage/cards/40-back-main.png', '2017-05-25 13:36:42', '2017-05-25 13:36:42', NULL),
(39, 40, 'back', 1, '/storage/cards/41-back-main.png', '2017-05-25 13:36:42', '2017-05-25 13:36:42', NULL),
(40, 41, 'back', 1, '/storage/cards/42-back-main.png', '2017-05-25 13:36:42', '2017-05-25 13:36:42', NULL),
(41, 42, 'back', 1, '/storage/cards/43-back-main.png', '2017-05-25 13:36:42', '2017-05-25 13:36:42', NULL),
(42, 43, 'back', 1, '/storage/cards/44-back-main.png', '2017-05-25 13:36:42', '2017-05-25 13:36:42', NULL),
(43, 44, 'back', 1, '/storage/cards/45-back-main.png', '2017-05-25 13:36:42', '2017-05-25 13:36:42', NULL),
(44, 45, 'back', 1, '/storage/cards/46-back-main.png', '2017-05-25 13:36:42', '2017-05-25 13:36:42', NULL),
(45, 46, 'back', 1, '/storage/cards/47-back-main.png', '2017-05-25 13:36:42', '2017-05-25 13:36:42', NULL),
(46, 47, 'back', 1, '/storage/cards/48-back-main.png', '2017-05-25 13:40:09', '2017-05-25 13:40:09', NULL),
(47, 48, 'back', 1, '/storage/cards/49-back-main.png', '2017-05-25 13:40:10', '2017-05-25 13:40:10', NULL),
(48, 49, 'back', 1, '/storage/cards/50-back-main.png', '2017-05-25 13:40:10', '2017-05-25 13:40:10', NULL),
(49, 50, 'back', 1, '/storage/cards/51-back-main.png', '2017-05-25 13:40:10', '2017-05-25 13:40:10', NULL),
(50, 51, 'back', 1, '/storage/cards/52-back-main.png', '2017-05-25 13:40:10', '2017-05-25 13:40:10', NULL),
(51, 52, 'back', 1, '/storage/cards/53-back-main.png', '2017-05-25 13:40:10', '2017-05-25 13:40:10', NULL),
(52, 53, 'back', 1, '/storage/cards/54-back-main.png', '2017-05-25 13:40:10', '2017-05-25 13:40:10', NULL),
(53, 54, 'back', 1, '/storage/cards/55-back-main.png', '2017-05-25 13:40:10', '2017-05-25 13:40:10', NULL),
(54, 55, 'back', 1, '/storage/cards/56-back-main.png', '2017-05-25 13:40:10', '2017-05-25 13:40:10', NULL),
(55, 56, 'back', 1, '/storage/cards/57-back-main.png', '2017-05-25 13:40:10', '2017-05-25 13:40:10', NULL),
(56, 57, 'back', 1, '/storage/cards/58-back-main.png', '2017-05-25 13:40:11', '2017-05-25 13:40:11', NULL),
(57, 58, 'back', 1, '/storage/cards/59-back-main.png', '2017-05-25 13:40:11', '2017-05-25 13:40:11', NULL),
(58, 59, 'back', 1, '/storage/cards/60-back-main.png', '2017-05-25 13:40:11', '2017-05-25 13:40:11', NULL),
(59, 60, 'back', 1, '/storage/cards/61-back-main.png', '2017-05-25 13:40:11', '2017-05-25 13:40:11', NULL),
(60, 61, 'back', 1, '/storage/cards/62-back-main.png', '2017-05-25 13:40:11', '2017-05-25 13:40:11', NULL),
(61, 62, 'back', 1, '/storage/cards/63-back-main.png', '2017-05-25 13:40:11', '2017-05-25 13:40:11', NULL),
(62, 63, 'back', 1, '/storage/cards/64-back-main.png', '2017-05-25 13:40:11', '2017-05-25 13:40:11', NULL),
(67, 68, 'back', 1, '/storage/cards/69-back-main.png', '2017-05-25 13:47:49', '2017-05-25 13:47:49', NULL),
(68, 69, 'back', 1, '/storage/cards/70-back-main.png', '2017-05-25 13:47:49', '2017-05-25 13:47:49', NULL),
(69, 70, 'back', 1, '/storage/cards/71-back-main.png', '2017-05-25 13:47:49', '2017-05-25 13:47:49', NULL),
(70, 71, 'back', 1, '/storage/cards/72-back-main.png', '2017-05-25 13:47:49', '2017-05-25 13:47:49', NULL),
(71, 72, 'back', 1, '/storage/cards/73-back-main.png', '2017-05-25 13:47:49', '2017-05-25 13:47:49', NULL),
(72, 73, 'back', 1, '/storage/cards/74-back-main.png', '2017-05-25 13:47:50', '2017-05-25 13:47:50', NULL),
(73, 74, 'back', 1, '/storage/cards/75-back-main.png', '2017-05-25 13:47:50', '2017-05-25 13:47:50', NULL),
(74, 75, 'back', 1, '/storage/cards/76-back-main.png', '2017-05-25 13:47:50', '2017-05-25 13:47:50', NULL),
(75, 76, 'back', 1, '/storage/cards/77-back-main.png', '2017-05-25 13:47:50', '2017-05-25 13:47:50', NULL),
(76, 77, 'back', 1, '/storage/cards/78-back-main.png', '2017-05-25 13:47:50', '2017-05-25 13:47:50', NULL),
(77, 78, 'back', 1, '/storage/cards/79-back-main.png', '2017-05-25 13:47:50', '2017-05-25 13:47:50', NULL),
(78, 79, 'back', 1, '/storage/cards/80-back-main.png', '2017-05-25 13:47:50', '2017-05-25 13:47:50', NULL),
(79, 80, 'back', 1, '/storage/cards/81-back-main.png', '2017-05-25 13:47:50', '2017-05-25 13:47:50', NULL),
(80, 81, 'back', 1, '/storage/cards/82-back-main.png', '2017-05-25 13:58:43', '2017-05-25 13:58:43', NULL),
(81, 82, 'back', 1, '/storage/cards/83-back-main.png', '2017-05-25 13:58:43', '2017-05-25 13:58:43', NULL),
(82, 83, 'back', 1, '/storage/cards/84-back-main.png', '2017-05-25 13:58:43', '2017-05-25 13:58:43', NULL),
(83, 84, 'back', 1, '/storage/cards/85-back-main.png', '2017-05-25 13:58:44', '2017-05-25 13:58:44', NULL),
(84, 85, 'back', 1, '/storage/cards/86-back-main.png', '2017-05-25 13:58:44', '2017-05-25 13:58:44', NULL),
(85, 86, 'back', 1, '/storage/cards/87-back-main.png', '2017-05-25 13:58:44', '2017-05-25 13:58:44', NULL),
(86, 87, 'back', 1, '/storage/cards/88-back-main.png', '2017-05-25 13:58:44', '2017-05-25 13:58:44', NULL),
(87, 88, 'back', 1, '/storage/cards/89-back-main.png', '2017-05-25 13:58:44', '2017-05-25 13:58:44', NULL),
(88, 89, 'back', 1, '/storage/cards/90-back-main.png', '2017-05-25 13:58:44', '2017-05-25 13:58:44', NULL),
(89, 90, 'back', 1, '/storage/cards/91-back-main.png', '2017-05-25 13:58:44', '2017-05-25 13:58:44', NULL),
(90, 91, 'back', 1, '/storage/cards/92-back-main.png', '2017-05-25 13:58:44', '2017-05-25 13:58:44', NULL),
(91, 92, 'back', 1, '/storage/cards/93-back-main.png', '2017-05-25 13:58:44', '2017-05-25 13:58:44', NULL),
(92, 93, 'back', 1, '/storage/cards/94-back-main.png', '2017-06-13 07:28:29', '2017-06-13 07:28:29', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `stores`
--

CREATE TABLE `stores` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `website` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `default_shipping` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Contenu de la table `stores`
--

INSERT INTO `stores` (`id`, `name`, `slug`, `description`, `website`, `created_at`, `updated_at`, `deleted_at`, `default_shipping`) VALUES
(1, 'Bicycle', 'bicycle', '', 'http://www.bicyclecards.com', NULL, NULL, NULL, 5.99),
(2, 'Ellusionist', 'ellusionist', '', 'http://www.ellusionist.com', NULL, NULL, NULL, 6),
(3, 'Art of Play', 'art-of-play', '', 'https://www.artofplay.com', NULL, NULL, NULL, 4),
(4, 'Theory11', 'theory11', '', 'https://www.theory11.com/', NULL, NULL, NULL, 3.34),
(5, 'David Blaine', 'david-blaine', NULL, 'https://shop.davidblaine.com/', '2017-06-11 12:15:44', '2017-06-11 12:15:44', NULL, NULL),
(6, 'King of Cards', 'king-of-cards', NULL, 'http://www.kingofcards.co.uk/', '2017-06-11 12:17:00', '2017-06-11 12:17:00', NULL, NULL),
(7, 'Steve Minty', 'steve-minty', NULL, 'https://www.steveminty.com/', '2017-06-11 12:19:11', '2017-06-11 12:19:11', NULL, NULL),
(8, 'Black Ink Playing Cards', 'black-ink-playing-cards', NULL, 'https://blackinkplayingcards.com/', '2017-06-11 12:19:30', '2017-06-11 12:19:30', NULL, NULL),
(9, 'Coterie 1902', 'coterie-1902', NULL, 'http://coterie1902.com/', '2017-06-11 12:19:48', '2017-06-11 12:19:48', NULL, NULL),
(10, 'JP Playing Cards', 'jp-playing-cards', NULL, 'http://jpplayingcards.co.uk/', '2017-06-11 12:20:11', '2017-06-11 12:20:11', NULL, NULL),
(11, 'bigblindmedia', 'bigblindmedia', NULL, 'http://www.bigblindmedia.com/', '2017-06-11 12:20:55', '2017-06-11 12:20:55', NULL, NULL),
(12, 'Hearths & Nines', 'hearths-nines', NULL, 'http://www.heartsandnines.com', '2017-06-11 12:21:24', '2017-06-11 12:21:24', NULL, NULL),
(13, 'PlayingCards.Net', 'playingcardsnet', NULL, 'http://www.playingcards.net/', '2017-06-11 12:21:45', '2017-06-11 12:21:45', NULL, NULL),
(14, 'Cardvolution', 'cardvolution', NULL, 'https://cardvolution.com', '2017-06-11 12:22:01', '2017-06-11 12:22:01', NULL, NULL),
(15, 'RarePlayingCards', 'rareplayingcards', NULL, 'https://rareplayingcards.com', '2017-06-11 12:22:13', '2017-06-11 12:22:13', NULL, NULL),
(16, 'Edgy Brothers', 'edgy-brothers', NULL, 'http://edgybrothers.com', '2017-06-11 12:23:07', '2017-06-11 12:23:07', NULL, NULL),
(17, 'Murphy\'s Magic', 'murphys-magic', NULL, 'https://www.murphysmagic.com', '2017-06-11 12:23:26', '2017-06-11 12:23:26', NULL, NULL),
(18, 'LVCardistry', 'lvcardistry', NULL, 'https://lvcardistry.com', '2017-06-11 12:24:59', '2017-06-11 12:24:59', NULL, NULL),
(19, 'Legends Playing Cards', 'legends-playing-cards', NULL, 'https://legendsplayingcards.com', '2017-06-11 12:25:13', '2017-06-11 12:25:13', NULL, NULL),
(20, 'Penguin Magic', 'penguin-magic', NULL, 'http://www.penguinmagic.com', '2017-06-11 12:25:49', '2017-06-11 12:25:49', NULL, NULL),
(21, 'Card Experiment', 'card-experiment', NULL, 'https://www.cardexperiment.com', '2017-06-13 08:11:06', '2017-06-13 08:11:06', NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `store_variation`
--

CREATE TABLE `store_variation` (
  `store_id` int(10) UNSIGNED NOT NULL,
  `variation_id` int(10) UNSIGNED NOT NULL,
  `in_stock` tinyint(1) NOT NULL DEFAULT '1',
  `price` double NOT NULL,
  `url` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `shipping` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Contenu de la table `store_variation`
--

INSERT INTO `store_variation` (`store_id`, `variation_id`, `in_stock`, `price`, `url`, `shipping`) VALUES
(1, 1, 1, 3.99, 'http://www.bicyclecards.com/product/bicycle-standard-index-playing-cards/', 5.99),
(1, 2, 1, 3.99, 'http://www.bicyclecards.com/product/bicycle-standard-index-playing-cards/', NULL),
(2, 1, 1, 3.49, 'http://www.ellusionist.com/bicycle-playing-cards.html', 6),
(3, 1, 1, 3, 'https://www.artofplay.com/collections/playing-cards/products/bicycle-rider-back-playing-cards', 4),
(3, 10, 1, 12, 'https://www.artofplay.com/collections/playing-cards/products/bicycle-little-atlantis', NULL),
(3, 11, 1, 10, 'https://www.artofplay.com/collections/playing-cards/products/bicycle-bone-riders-playing-cards', NULL),
(3, 12, 1, 12, 'https://www.artofplay.com/collections/playing-cards/products/bicycle-8-bit', NULL),
(3, 13, 1, 7, 'https://www.artofplay.com/collections/playing-cards/products/bicycle-chainless', NULL),
(3, 14, 1, 5, 'https://www.artofplay.com/collections/playing-cards/products/bicycle-peacock-deck', NULL),
(3, 15, 1, 10, 'https://www.artofplay.com/collections/playing-cards/products/bicycle-leaf-back', NULL),
(3, 16, 1, 10, 'https://www.artofplay.com/collections/playing-cards/products/bicycle-sideshow-freaks', NULL),
(3, 17, 1, 5, 'https://www.artofplay.com/collections/playing-cards/products/bicycle-130th-anniversary-ed', NULL),
(3, 18, 1, 14, 'https://www.artofplay.com/collections/playing-cards/products/bicycle-aves', NULL),
(3, 19, 1, 12, 'https://www.artofplay.com/collections/playing-cards/products/bicycle-golden-spike', NULL),
(3, 20, 1, 15, 'https://www.artofplay.com/collections/playing-cards/products/bicycle-frontier', NULL),
(3, 21, 1, 6, 'https://www.artofplay.com/collections/playing-cards/products/bicycle-cupid-back', NULL),
(3, 22, 1, 6, 'https://www.artofplay.com/collections/playing-cards/products/bicycle-madison-playing-cards', NULL),
(3, 23, 1, 7, 'https://www.artofplay.com/collections/playing-cards/products/bicycle-gold-dragon-back', NULL),
(3, 24, 1, 12, 'https://www.artofplay.com/collections/playing-cards/products/bicycle-tangent-back-playing-cards', NULL),
(3, 25, 1, 12, 'https://www.artofplay.com/collections/playing-cards/products/bicycle-thistle-back-playing-cards', NULL),
(3, 26, 1, 12, 'https://www.artofplay.com/collections/playing-cards/products/bicycle-lumberjack-playing-cards', NULL),
(3, 27, 1, 6, 'https://www.artofplay.com/collections/playing-cards/products/bicycle-robocycle-playing-cards', NULL),
(3, 28, 1, 10, 'https://www.artofplay.com/collections/playing-cards/products/bicycle-steampunk-playing-cards', NULL),
(3, 29, 1, 6, 'https://www.artofplay.com/collections/playing-cards/products/bicycle-eco-playing-cards', NULL),
(3, 30, 1, 3, 'https://www.artofplay.com/collections/playing-cards/products/bicycle-rider-back-playing-cards', NULL),
(3, 32, 1, 10, 'https://www.artofplay.com/collections/playing-cards/products/nph-neil-patrick-harris-playing-cards', NULL),
(3, 33, 1, 10, 'https://www.artofplay.com/collections/playing-cards/products/monarchs-playing-cards', NULL),
(3, 34, 1, 10, 'https://www.artofplay.com/collections/playing-cards/products/citizens', NULL),
(3, 35, 1, 10, 'https://www.artofplay.com/collections/playing-cards/products/union-playing-cards', NULL),
(3, 36, 1, 10, 'https://www.artofplay.com/collections/playing-cards/products/nomad-playing-cards', NULL),
(3, 37, 1, 10, 'https://www.artofplay.com/collections/playing-cards/products/mailchimp-playing-cards', NULL),
(3, 38, 1, 10, 'https://www.artofplay.com/collections/playing-cards/products/bad-robot-playing-cards', NULL),
(3, 39, 1, 15, 'https://www.artofplay.com/collections/playing-cards/products/rarebit-playing-cards', NULL),
(3, 40, 1, 8, 'https://www.artofplay.com/collections/playing-cards/products/tycoon', NULL),
(3, 41, 1, 10, 'https://www.artofplay.com/collections/playing-cards/products/medallions', NULL),
(3, 42, 1, 10, 'https://www.artofplay.com/collections/playing-cards/products/charity-water-playing-cards', NULL),
(3, 43, 1, 10, 'https://www.artofplay.com/collections/playing-cards/products/animal-kingdom-playing-cards', NULL),
(3, 44, 1, 10, 'https://www.artofplay.com/collections/playing-cards/products/love-me-playing-cards-curtis-kulig', NULL),
(3, 45, 1, 10, 'https://www.artofplay.com/collections/playing-cards/products/deckone-playing-cards', NULL),
(3, 46, 1, 10, 'https://www.artofplay.com/collections/playing-cards/products/artisan-playing-cards', NULL),
(3, 47, 1, 15, 'https://www.artofplay.com/collections/playing-cards/products/flourish', NULL),
(3, 48, 1, 15, 'https://www.artofplay.com/collections/playing-cards/products/jungle-deck', NULL),
(3, 49, 1, 10, 'https://www.artofplay.com/collections/playing-cards/products/ed-playing-cards', NULL),
(3, 50, 1, 15, 'https://www.artofplay.com/collections/playing-cards/products/memento-mori', NULL),
(3, 51, 1, 15, 'https://www.artofplay.com/collections/playing-cards/products/lost-wax', NULL),
(3, 52, 1, 15, 'https://www.artofplay.com/collections/playing-cards/products/odd-bods', NULL),
(3, 53, 1, 25, 'https://www.artofplay.com/collections/playing-cards/products/cardistry-con-2016', NULL),
(3, 54, 1, 12, 'https://www.artofplay.com/collections/playing-cards/products/dkng-playing-cards', NULL),
(3, 55, 1, 12, 'https://www.artofplay.com/collections/playing-cards/products/third-man-records', NULL),
(3, 56, 1, 7, 'https://www.artofplay.com/collections/playing-cards/products/aviator-heritage-edition', NULL),
(3, 57, 1, 15, 'https://www.artofplay.com/collections/playing-cards/products/alice-in-wonderland', NULL),
(3, 58, 1, 10, 'https://www.artofplay.com/collections/playing-cards/products/revelation-deck', NULL),
(3, 59, 1, 12, 'https://www.artofplay.com/collections/playing-cards/products/prime', NULL),
(3, 60, 1, 12, 'https://www.artofplay.com/collections/playing-cards/products/flesh-bones', NULL),
(3, 61, 1, 12, 'https://www.artofplay.com/collections/playing-cards/products/borderline', NULL),
(3, 62, 1, 25, 'https://www.artofplay.com/collections/playing-cards/products/thick-lines', NULL),
(3, 63, 1, 7, 'https://www.artofplay.com/collections/playing-cards/products/deckstarter', NULL),
(3, 68, 1, 12, 'https://www.artofplay.com/collections/playing-cards/products/dts-playing-cards', NULL),
(3, 69, 1, 15, 'https://www.artofplay.com/collections/playing-cards/products/makers', NULL),
(3, 70, 1, 12, 'https://www.artofplay.com/collections/playing-cards/products/sons-of-liberty', NULL),
(3, 71, 1, 10, 'https://www.artofplay.com/collections/playing-cards/products/vintage-plaid-arizona-red', NULL),
(3, 72, 1, 7, 'https://www.artofplay.com/collections/playing-cards/products/aviator-heritage-edition', NULL),
(3, 73, 1, 25, 'https://www.artofplay.com/collections/playing-cards/products/hollingworths-emerald-ed', NULL),
(3, 74, 1, 12, 'https://www.artofplay.com/collections/playing-cards/products/antler-limited-edition-playing-cards', NULL),
(3, 75, 1, 10, 'https://www.artofplay.com/collections/playing-cards/products/antler-playing-cards', NULL),
(3, 76, 1, 12, 'https://www.artofplay.com/collections/playing-cards/products/voltige', NULL),
(3, 77, 1, 25, 'https://www.artofplay.com/collections/playing-cards/products/ultimate-deck-stranger-and-stranger-playing-cards', NULL),
(3, 78, 1, 12, 'https://www.artofplay.com/collections/playing-cards/products/smoke-and-mirrors-playing-cards', NULL),
(3, 79, 1, 20, 'https://www.artofplay.com/collections/playing-cards/products/vintage-plaid-playing-cards', NULL),
(3, 80, 1, 15, 'https://www.artofplay.com/collections/playing-cards/products/fantastique-animated-playing-cards', NULL),
(3, 81, 1, 15, 'https://www.artofplay.com/collections/playing-cards/products/red-stripe', NULL),
(3, 82, 1, 12, 'https://www.artofplay.com/collections/playing-cards/products/the-three-little-pigs', NULL),
(3, 83, 1, 12, 'https://www.artofplay.com/collections/playing-cards/products/edge-playing-cards', NULL),
(3, 84, 1, 10, 'https://www.artofplay.com/collections/playing-cards/products/flora-playing-cards', NULL),
(3, 85, 1, 15, 'https://www.artofplay.com/collections/playing-cards/products/les-melies-playing-cards', NULL),
(3, 86, 1, 7.5, 'https://www.artofplay.com/collections/playing-cards/products/vanda-violet-edition', NULL),
(3, 87, 1, 12, 'https://www.artofplay.com/collections/playing-cards/products/sleepy-hollow', NULL),
(3, 88, 1, 15, 'https://www.artofplay.com/collections/playing-cards/products/les-printemps', NULL),
(3, 89, 1, 10, 'https://www.artofplay.com/collections/playing-cards/products/mustache-playing-cards', NULL),
(3, 90, 1, 30, 'https://www.artofplay.com/collections/playing-cards/products/a-bandit-playing-cards', NULL),
(3, 91, 1, 15, 'https://www.artofplay.com/collections/playing-cards/products/arrco-us-regulation-playing-cards', NULL),
(3, 92, 1, 13, 'https://www.artofplay.com/collections/playing-cards/products/arrco-tahoe-playing-cards', NULL),
(3, 93, 1, 12, 'https://www.artofplay.com/collections/playing-cards/products/a-typographers-deck', NULL),
(4, 1, 1, 2.95, 'https://store.theory11.com/products/bicycle', 3.34),
(4, 32, 1, 9.95, 'https://store.theory11.com/products/neil-patrick-harris-playing-cards', NULL),
(5, 96, 1, 10, 'https://shop.davidblaine.com/collections/playingcards/products/black-lions', NULL),
(5, 97, 1, 10, 'https://shop.davidblaine.com/collections/playingcards/products/black-lions-metallic-red', NULL),
(5, 98, 1, 10, 'https://shop.davidblaine.com/collections/playingcards/products/black-lions-blue-edition', NULL),
(5, 99, 1, 12, 'https://shop.davidblaine.com/collections/playingcards/products/black-label-white-lions-1', NULL),
(5, 100, 1, 12, 'https://shop.davidblaine.com/collections/playingcards/products/white-lions-series-b-avail-8-1-12', NULL),
(5, 101, 1, 12, 'https://shop.davidblaine.com/collections/playingcards/products/white-lions-series-b-red', NULL),
(8, 19, 1, 14, 'https://blackinkplayingcards.com/collections/playing-cards/products/golden-spike-playing-cards-bicycle', NULL),
(8, 95, 1, 15, 'https://blackinkplayingcards.com/collections/playing-cards/products/golden-spike-playing-cards-gold-edition', NULL),
(8, 102, 1, 15, 'https://blackinkplayingcards.com/collections/playing-cards/products/inception-intellectus-standard', NULL),
(17, 32, 0, 9.95, 'https://www.murphysmagic.com/product.aspx?id=58996', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `variations`
--

CREATE TABLE `variations` (
  `id` int(10) UNSIGNED NOT NULL,
  `card_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Contenu de la table `variations`
--

INSERT INTO `variations` (`id`, `card_id`, `name`, `description`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 'Red', 'Red variation of the Bicycle Standard deck', '2017-05-23 10:34:20', '2017-05-23 10:34:20', NULL),
(2, 1, 'Blue', 'Blue variation of the Bicycle Standard deck', '2017-05-23 10:34:20', '2017-05-23 10:34:20', NULL),
(10, 6, 'Little Atlantis', '', '2017-05-24 13:15:54', '2017-05-24 13:15:54', NULL),
(11, 7, 'Bone Riders', '', '2017-05-24 13:15:54', '2017-05-24 13:15:54', NULL),
(12, 8, '8-Bit', '', '2017-05-24 13:15:54', '2017-05-24 13:15:54', NULL),
(13, 9, 'Chainless', '', '2017-05-24 13:15:54', '2017-05-24 13:15:54', NULL),
(14, 10, 'Peacock Deck', '', '2017-05-24 13:15:55', '2017-05-24 13:15:55', NULL),
(15, 11, 'Leaf Back', '', '2017-05-24 13:15:55', '2017-05-24 13:15:55', NULL),
(16, 12, 'Sideshow Freaks', '', '2017-05-24 13:15:55', '2017-05-24 13:15:55', NULL),
(17, 13, '130th Anniversary', '', '2017-05-24 13:15:55', '2017-05-24 13:15:55', NULL),
(18, 14, 'Aves', '', '2017-05-24 13:15:55', '2017-05-24 13:15:55', NULL),
(19, 15, 'Golden Spike', '', '2017-05-24 13:15:55', '2017-05-24 13:15:55', NULL),
(20, 16, 'Frontier', '', '2017-05-24 13:15:55', '2017-05-24 13:15:55', NULL),
(21, 17, 'Cupid Back', '', '2017-05-24 13:15:55', '2017-05-24 13:15:55', NULL),
(22, 18, 'Madison Back', '', '2017-05-24 13:15:55', '2017-05-24 13:15:55', NULL),
(23, 19, 'Dragon Back', '', '2017-05-24 13:15:55', '2017-05-24 13:15:55', NULL),
(24, 20, 'Tangent Back', '', '2017-05-24 13:15:56', '2017-05-24 13:15:56', NULL),
(25, 21, 'Thistle Back', '', '2017-05-24 13:15:56', '2017-05-24 13:15:56', NULL),
(26, 22, 'Lumberjack', '', '2017-05-24 13:15:56', '2017-05-24 13:15:56', NULL),
(27, 23, 'Robocycle', '', '2017-05-24 13:15:56', '2017-05-24 13:15:56', NULL),
(28, 24, 'Steampunk', '', '2017-05-24 13:15:56', '2017-05-24 13:15:56', NULL),
(29, 25, 'Eco', '', '2017-05-24 13:15:56', '2017-05-24 13:15:56', NULL),
(30, 26, 'Rider Back', '', '2017-05-24 13:15:56', '2017-05-24 13:15:56', NULL),
(32, 29, 'NPH Playing Cards', '', '2017-05-25 13:36:41', '2017-05-25 13:36:41', NULL),
(33, 30, 'Monarchs', '', '2017-05-25 13:36:41', '2017-05-25 13:36:41', NULL),
(34, 31, 'Citizens', '', '2017-05-25 13:36:41', '2017-05-25 13:36:41', NULL),
(35, 32, 'Union', '', '2017-05-25 13:36:41', '2017-05-25 13:36:41', NULL),
(36, 33, 'NoMad Playing Cards', '', '2017-05-25 13:36:41', '2017-05-25 13:36:41', NULL),
(37, 34, 'MailChimp Playing Cards', '', '2017-05-25 13:36:41', '2017-05-25 13:36:41', NULL),
(38, 35, 'Bad Robot Playing Cards', '', '2017-05-25 13:36:41', '2017-05-25 13:36:41', NULL),
(39, 36, 'Rarebit Playing Cards', '', '2017-05-25 13:36:42', '2017-05-25 13:36:42', NULL),
(40, 37, 'Tycoon', '', '2017-05-25 13:36:42', '2017-05-25 13:36:42', NULL),
(41, 38, 'Medallions', '', '2017-05-25 13:36:42', '2017-05-25 13:36:42', NULL),
(42, 39, 'Charity: Water', '', '2017-05-25 13:36:42', '2017-05-25 13:36:42', NULL),
(43, 40, 'Animal Kingdom', '', '2017-05-25 13:36:42', '2017-05-25 13:36:42', NULL),
(44, 41, 'Love Me', '', '2017-05-25 13:36:42', '2017-05-25 13:36:42', NULL),
(45, 42, 'DeckONE', '', '2017-05-25 13:36:42', '2017-05-25 13:36:42', NULL),
(46, 43, 'Artisans', '', '2017-05-25 13:36:42', '2017-05-25 13:36:42', NULL),
(47, 44, 'Flourish', '', '2017-05-25 13:40:09', '2017-05-25 13:40:09', NULL),
(48, 45, 'Jungle Deck', '', '2017-05-25 13:40:09', '2017-05-25 13:40:09', NULL),
(49, 46, 'ED', '', '2017-05-25 13:40:10', '2017-05-25 13:40:10', NULL),
(50, 47, 'Memento Mori', '', '2017-05-25 13:40:10', '2017-05-25 13:40:10', NULL),
(51, 48, 'Lost Wax', '', '2017-05-25 13:40:10', '2017-05-25 13:40:10', NULL),
(52, 49, 'Odd Bods', '', '2017-05-25 13:40:10', '2017-05-25 13:40:10', NULL),
(53, 50, 'Cardistry-Con 2016', '', '2017-05-25 13:40:10', '2017-05-25 13:40:10', NULL),
(54, 51, 'DKNG Playing Cards', '', '2017-05-25 13:40:10', '2017-05-25 13:40:10', NULL),
(55, 52, 'Third Man Records', '', '2017-05-25 13:40:10', '2017-05-25 13:40:10', NULL),
(56, 53, 'AVIATOR® Heritage Ed.', '', '2017-05-25 13:40:10', '2017-05-25 13:40:10', NULL),
(57, 54, 'Alice in Wonderland', '', '2017-05-25 13:40:11', '2017-05-25 13:40:11', NULL),
(58, 55, 'Revelation Deck', '', '2017-05-25 13:40:11', '2017-05-25 13:40:11', NULL),
(59, 56, 'Prime Playing Cards', '', '2017-05-25 13:40:11', '2017-05-25 13:40:11', NULL),
(60, 57, 'Flesh & Bones', '', '2017-05-25 13:40:11', '2017-05-25 13:40:11', NULL),
(61, 58, 'Borderline', '', '2017-05-25 13:40:11', '2017-05-25 13:40:11', NULL),
(62, 59, 'Thick Lines', '', '2017-05-25 13:40:11', '2017-05-25 13:40:11', NULL),
(63, 60, 'DeckStarter® Brand Deck', '', '2017-05-25 13:40:11', '2017-05-25 13:40:11', NULL),
(68, 66, 'DTS Playing Cards', '', '2017-05-25 13:47:49', '2017-05-25 13:47:49', NULL),
(69, 67, 'MAKERS', '', '2017-05-25 13:47:49', '2017-05-25 13:47:49', NULL),
(70, 68, 'Sons of Liberty, Patriot Blue', '', '2017-05-25 13:47:49', '2017-05-25 13:47:49', NULL),
(71, 69, 'Vintage Plaid, Arizona Red', '', '2017-05-25 13:47:49', '2017-05-25 13:47:49', NULL),
(72, 53, 'AVIATOR® Heritage Ed.', '', '2017-05-25 13:47:49', '2017-05-25 13:47:49', NULL),
(73, 70, 'Hollingworths, Emerald Ed.', '', '2017-05-25 13:47:50', '2017-05-25 13:47:50', NULL),
(74, 71, 'Antler Limited Edition', '', '2017-05-25 13:47:50', '2017-05-25 13:47:50', NULL),
(75, 72, 'Antler Playing Cards', '', '2017-05-25 13:47:50', '2017-05-25 13:47:50', NULL),
(76, 73, 'Voltige', '', '2017-05-25 13:47:50', '2017-05-25 13:47:50', NULL),
(77, 74, 'Ultimate Deck', '', '2017-05-25 13:47:50', '2017-05-25 13:47:50', NULL),
(78, 75, 'Smoke & Mirrors', '', '2017-05-25 13:47:50', '2017-05-25 13:47:50', NULL),
(79, 76, 'Vintage Plaid, 1st Printing', '', '2017-05-25 13:47:50', '2017-05-25 13:47:50', NULL),
(80, 77, 'Fantastique', '', '2017-05-25 13:47:50', '2017-05-25 13:47:50', NULL),
(81, 78, 'Red Stripe', '', '2017-05-25 13:58:43', '2017-05-25 13:58:43', NULL),
(82, 79, 'The Three Little Pigs', '', '2017-05-25 13:58:43', '2017-05-25 13:58:43', NULL),
(83, 80, 'EDGE Playing Cards', '', '2017-05-25 13:58:43', '2017-05-25 13:58:43', NULL),
(84, 81, 'Flora', '', '2017-05-25 13:58:43', '2017-05-25 13:58:43', NULL),
(85, 82, 'Les Méliès: Voyagers Ed.', '', '2017-05-25 13:58:44', '2017-05-25 13:58:44', NULL),
(86, 83, 'Vanda, Violet Edition', '', '2017-05-25 13:58:44', '2017-05-25 13:58:44', NULL),
(87, 84, 'Sleepy Hollow', '', '2017-05-25 13:58:44', '2017-05-25 13:58:44', NULL),
(88, 85, 'Les Printemps', '', '2017-05-25 13:58:44', '2017-05-25 13:58:44', NULL),
(89, 86, 'Mustache Playing Cards', '', '2017-05-25 13:58:44', '2017-05-25 13:58:44', NULL),
(90, 87, 'A.Bandit', '', '2017-05-25 13:58:44', '2017-05-25 13:58:44', NULL),
(91, 88, 'Arrco® U.S. Regulation', '', '2017-05-25 13:58:44', '2017-05-25 13:58:44', NULL),
(92, 89, 'Arrco® Tahoe', '', '2017-05-25 13:58:44', '2017-05-25 13:58:44', NULL),
(93, 90, 'A Typographer\'s Deck', '', '2017-06-13 07:28:28', '2017-06-13 07:28:28', NULL),
(95, 15, 'Golden Spike - Gold Edition', 'Golden Spike Playing Cards are inspired by the completion of the 1st Transcontinental Railroad On May 10th, 1869. It was the first rail line that connected the east to the west and revolutionized transportation and commerce in a post Civil War United States. A Golden Spike was created as a commemorative piece to celebrate the completion of the 1st transcontinental railroad and was driven into the ground where the Union Pacific met the Central Pacific Railroad at Promontory Point, Utah. When the hammer rang out and the golden spike was driven into the ground, a new era of industry and expansion rang out across the United States.', '2017-07-30 00:03:29', '2017-07-30 00:03:29', NULL),
(96, 92, 'Black Lions', 'We are proud to introduce The Black Lions, printed on the highest-quality stock the United States Playing Card Company offers. \r\nOur soft-touch box features a two-tone black finish and silver foil stamping on top of a fully detailed quality embossing.  Each deck contains a number of hidden features that are greatly enhanced by the new design.', '2017-07-30 00:18:06', '2017-07-30 00:30:11', NULL),
(97, 92, 'Black Lions Red Edition', 'We are proud to introduce the Black Lions Red Edition, printed on the highest-quality stock the United States Playing Card Company offers.\r\nOur soft-touch box features a metallic red finish and silver foil stamping on top of a fully detailed quality embossing.  Each deck contains a number of hidden features that are greatly enhanced by the new design.', '2017-07-30 00:18:35', '2017-07-30 00:34:14', NULL),
(98, 92, 'Black Lions Blue Edition', 'We are proud to introduce the Black Lions Blue Edition, printed on the highest-quality stock the United States Playing Card Company offers.\r\nOur soft-touch box features a metallic blue finish and silver foil stamping on top of a fully detailed quality embossing.  Each deck contains a number of hidden features that are greatly enhanced by the new design.', '2017-07-30 00:18:59', '2017-07-30 00:34:27', NULL),
(99, 93, 'WHITE LIONS BLACK LABEL', 'The Series B White Lions are a product of nearly a year\'s worth of collaboration with the United States Playing Card Company. Numerous factors are considered when creating a deck of playing cards, including printing press type, paper moisture, card stock, and embossing pressure. No expense was spared in creating Series B, as is evident the moment they are in your hands.\n\nOur box design includes silver foil stamping, detailed embossing, and a matte white finish never before seen on any deck of cards.  Due to the difficult and time-consuming process required to print and package this new box paper type, the USPC is no longer able to provide this finish.  The cards themselves are printed on the highest quality stock to produce a feel so good you won\'t want to put them down.', '2017-07-30 00:21:08', '2017-07-30 00:21:08', NULL),
(100, 93, 'WHITE LIONS SERIES B (BLUE)', 'Our box design includes silver foil stamping, detailed embossing, and a matte white finish never before seen on any deck of cards. The printing and packaging process needed for this box was so time consuming and difficult that the USPC isn\'t able to offer this box finish type to anyone in the future. The cards themselves are printed on a casino quality stock and are traditionally cut to allow for an easy weave during your shuffles. \n\nThere are many hidden features built into the deck that we will leave for you to discover. The cards also come stacked in the Tamariz stack with the Ace of Spades on the face ready to be unleashed.', '2017-07-30 00:21:21', '2017-07-30 00:21:21', NULL),
(101, 93, 'WHITE LIONS SERIES B (RED)', 'Our box design includes silver foil stamping, detailed embossing, and a matte white finish never before seen on any deck of cards. The printing and packaging process needed for this box was so time consuming and difficult that the USPC isn\'t able to offer this box finish type to anyone in the future. The cards themselves are printed on a casino quality stock and are traditionally cut to allow for an easy weave during your shuffles.\nThe White Lions feature an accumulation of several years worth of ideas. There are many hidden features, valuable to magicians, built into the deck that we will leave for you to discover. The cards also come stacked in the Tamariz stack with the Ace of Spades on the face ready to be unleashed.', '2017-07-30 00:21:37', '2017-07-30 00:21:37', NULL),
(102, 94, 'Inception - Intellectus Standard', 'The Intellectus Playing cards are printed by the Legends Playing Card Co. Each court, Ace and Joker cards will have original illustrations, capturing the feel of the era.  The Cards will be printed on the Classic Finish, which is the highest quality card stock that Legends has to offer.  The Tuck will feature copper foiling and embossing.', '2017-07-30 01:24:57', '2017-07-30 01:24:57', NULL);

--
-- Index pour les tables exportées
--

--
-- Index pour la table `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `brands_slug_unique` (`slug`);

--
-- Index pour la table `cards`
--
ALTER TABLE `cards`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `cards_slug_unique` (`slug`),
  ADD KEY `cards_brand_id_index` (`brand_id`);

--
-- Index pour la table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `categories_slug_unique` (`slug`);

--
-- Index pour la table `crawling_card_data`
--
ALTER TABLE `crawling_card_data`
  ADD PRIMARY KEY (`id`),
  ADD KEY `crawling_card_data_card_page_id_index` (`card_page_id`),
  ADD KEY `crawling_card_data_card_id_index` (`card_id`),
  ADD KEY `crawling_card_data_brand_id_index` (`brand_id`),
  ADD KEY `crawling_card_data_variation_id_index` (`variation_id`);

--
-- Index pour la table `crawling_card_pages`
--
ALTER TABLE `crawling_card_pages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `crawling_card_pages_url_unique` (`url`),
  ADD KEY `crawling_card_pages_crawler_id_index` (`crawler_id`),
  ADD KEY `crawling_card_pages_card_id_index` (`card_id`);

--
-- Index pour la table `crawling_crawlers`
--
ALTER TABLE `crawling_crawlers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `crawling_crawlers_store_id_index` (`store_id`);

--
-- Index pour la table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `pictures`
--
ALTER TABLE `pictures`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pictures_variation_id_index` (`variation_id`);

--
-- Index pour la table `stores`
--
ALTER TABLE `stores`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `stores_slug_unique` (`slug`);

--
-- Index pour la table `store_variation`
--
ALTER TABLE `store_variation`
  ADD PRIMARY KEY (`store_id`,`variation_id`),
  ADD KEY `store_variation_store_id_index` (`store_id`),
  ADD KEY `store_variation_variation_id_index` (`variation_id`);

--
-- Index pour la table `variations`
--
ALTER TABLE `variations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `variations_card_id_index` (`card_id`);

--
-- AUTO_INCREMENT pour les tables exportées
--

--
-- AUTO_INCREMENT pour la table `brands`
--
ALTER TABLE `brands`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT pour la table `cards`
--
ALTER TABLE `cards`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=95;
--
-- AUTO_INCREMENT pour la table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `crawling_card_data`
--
ALTER TABLE `crawling_card_data`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=180;
--
-- AUTO_INCREMENT pour la table `crawling_card_pages`
--
ALTER TABLE `crawling_card_pages`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=612;
--
-- AUTO_INCREMENT pour la table `crawling_crawlers`
--
ALTER TABLE `crawling_crawlers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT pour la table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;
--
-- AUTO_INCREMENT pour la table `pictures`
--
ALTER TABLE `pictures`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=93;
--
-- AUTO_INCREMENT pour la table `stores`
--
ALTER TABLE `stores`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;
--
-- AUTO_INCREMENT pour la table `variations`
--
ALTER TABLE `variations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=103;
--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `cards`
--
ALTER TABLE `cards`
  ADD CONSTRAINT `cards_brand_id_foreign` FOREIGN KEY (`brand_id`) REFERENCES `brands` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `crawling_card_data`
--
ALTER TABLE `crawling_card_data`
  ADD CONSTRAINT `crawling_card_data_card_id_foreign` FOREIGN KEY (`card_id`) REFERENCES `cards` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `crawling_card_data_card_page_id_foreign` FOREIGN KEY (`card_page_id`) REFERENCES `crawling_card_pages` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `crawling_card_data_ibfk_1` FOREIGN KEY (`brand_id`) REFERENCES `brands` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `crawling_card_data_variation_id_foreign` FOREIGN KEY (`variation_id`) REFERENCES `variations` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `crawling_card_pages`
--
ALTER TABLE `crawling_card_pages`
  ADD CONSTRAINT `crawling_card_pages_card_id_foreign` FOREIGN KEY (`card_id`) REFERENCES `cards` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `crawling_card_pages_crawler_id_foreign` FOREIGN KEY (`crawler_id`) REFERENCES `crawling_crawlers` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `crawling_crawlers`
--
ALTER TABLE `crawling_crawlers`
  ADD CONSTRAINT `crawling_crawlers_store_id_foreign` FOREIGN KEY (`store_id`) REFERENCES `stores` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `pictures`
--
ALTER TABLE `pictures`
  ADD CONSTRAINT `pictures_variation_id_foreign` FOREIGN KEY (`variation_id`) REFERENCES `variations` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `store_variation`
--
ALTER TABLE `store_variation`
  ADD CONSTRAINT `store_variation_store_id_foreign` FOREIGN KEY (`store_id`) REFERENCES `stores` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `store_variation_variation_id_foreign` FOREIGN KEY (`variation_id`) REFERENCES `variations` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `variations`
--
ALTER TABLE `variations`
  ADD CONSTRAINT `variations_card_id_foreign` FOREIGN KEY (`card_id`) REFERENCES `cards` (`id`) ON DELETE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
