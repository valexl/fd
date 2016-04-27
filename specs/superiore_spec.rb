require 'superiore'

describe Product do
  before(:all) do
    @default_url = "https://www.superiore.de/Wein/Abruzzen/La-Valentina/Pecorino-Colline-Pescaresi-IGT-2014.html"
  end
  
  let(:product) {  Product.new @url }

  before(:each) do
    @url = @default_url
  end

  context 'methods' do
    context 'product_name' do
      it 'example #1' do
        expect(product.product_name).to eq("Pecorino Colline Pescaresi IGT 2014")
      end

      it 'example #2' do
        @url = "https://www.superiore.de/Wein/Sizilien/Planeta/Dorilli-Cerasuolo-di-Vittoria-Classico-DOCG-2013.html"
        expect(product.product_name).to eq("\"Dorilli\" Cerasuolo di Vittoria Classico DOCG 2013")
      end

      it 'example #3' do
        @url = "https://www.superiore.de/Wein/Piemont/Elvio-Cogno/Barolo-Ravera-DOCG-2011.html"
        expect(product.product_name).to eq("Barolo \"Ravera\" DOCG 2011")
      end

    end

    context 'producer' do
      it 'example#1' do
        expect(product.producer).to eq("Fattoria La Valentina | Abruzzen")
      end

      it 'example#2' do
        @url = "https://www.superiore.de/Wein/Sizilien/Planeta/Dorilli-Cerasuolo-di-Vittoria-Classico-DOCG-2013.html"
        expect(product.producer).to eq("Planeta | Kellerei Dorilli | Sizilien")
      end

      it 'example #3' do
        @url = "https://www.superiore.de/Wein/Piemont/Elvio-Cogno/Barolo-Ravera-DOCG-2011.html"
        expect(product.producer).to eq("Elvio Cogno | Piemont")
      end
    end
    
    context 'address' do
      it 'example #1' do
        expect(product.address).to eq("Fattoria La Valentina S.r.l. | Via della Torretta 52 | IT 65010 Spoltore")
      end

      it 'example #2' do
        @url = "https://www.superiore.de/Wein/Sizilien/Planeta/Dorilli-Cerasuolo-di-Vittoria-Classico-DOCG-2013.html"
        expect(product.address).to eq("Az. Agr. Planeta s.s. | Contrada Dispensa | IT 92013 Menfi")
      end

      it 'example #3' do
        @url = "https://www.superiore.de/Wein/Piemont/Elvio-Cogno/Barolo-Ravera-DOCG-2011.html"
        expect(product.address).to eq("Elvio Cogno Soc. Agr. s.s. | Loc. Ravera 2 | IT 12060 Novello")
      end
    end
    
    context 'description' do
      it 'example#1' do
        expected_description = "Ein fröhlicher Weißer mit überzeugendem Sortencharakter. Schön fruchtig und leicht in Duft und Geschmack von einer feinen Säure getragen. (superiore.de)\r\n\"The 2014 Pecorino is an IGT wine from the Colline Pescaresi appellation in central Italy. This area is becoming well known for the work being done on the increasingly popular Pecorino grape. This is a truly beautiful wine with a surprising measure of complexity. It shows exotic fruit, crushed mineral, sage and even a touch of green olive or caper. It delivers a really nice level of intensity and pleasure.\" Robert Parker\r\n"
        expect(product.description).to eq(expected_description)
      
      end
      
      it 'example#2' do
        @url = "https://www.superiore.de/Wein/Sizilien/Planeta/Dorilli-Cerasuolo-di-Vittoria-Classico-DOCG-2013.html"

        expected_description = "Cerasuolo di Vittoria Classico Dorilli ist benannt nach dem Weinberg Dorilla, von dem die Trauben stammen und dieser wiederum nach dem nahe gelegenen Fluss Dirillo. Fein und elegant mit leichten Holztönen vom Ausbau, saftig frisch bis ins lange Finale. (superiore.de)\r\n\"Planeta's 2013 Cerasuolo di Vittoria Classico Dorilli is a beautifully harmonious and nuanced red wine from the southern part of Sicily. The Dorilli expression offers notes of dark berry fruit and garden herbs with opulent notes of rusty earth, metal and wet terra-cotta at the back. It shows good complexity and an elegant style that is unique to the Cerasuolo di Vittoria appellation. This wine has made an amazing jump in quality in recent years.\" Robert Parker\r\n\"Aromas and flavors of dried cherry, plum and strawberry. Full body, chewy tannins and a savory finish. Opulent red from the appellation but thoroughly real. One of my favorite from here.\" James Suckling\r\n\r\nPREMIUM TIPP bis 22.03.2016 \r\noder solange der Vorrat reicht."
        expect(product.description).to eq(expected_description)
      end

      it 'example #3' do
        @url = "https://www.superiore.de/Wein/Piemont/Elvio-Cogno/Barolo-Ravera-DOCG-2011.html"
        expected_description = "Walter Fissore und Nadia Cogno vinifizieren nicht nur einen der besten Barolo in der Gemeinde Novello, ihr Gut ist für uns auch das schönste und gastfreundlichste in der ganzen Langa. (superiore.de)\r\n\"A soft and velvety wine with blueberry, chocolate, mushroom and bark character. Full body, round tannins and a clean finish.\" James Suckling\r\n\"The 2011 Barolo Ravera emerges from the oldest vines on the property. Dark cherry, plum, spice, new leather and lavender swirl around the glass in a resonant, generous Barolo that captures the generosity of the year as seen through the lens of Ravera. In this vintage, the Ravera is an especially weightless and simply impeccable in its overall balance. Hints of leather, sweet spices add nuance on the soft yet energetic finish. There is so much to like here.\" Antonio Galloni\r\n\"A clean, focused style, this red shows warmth, balance, structure and complexity, offering classic rose, cherry, tar and tobacco aromas and flavors, with plenty of fruit. Features a fine, intense aftertaste of cherry, mineral and tobacco.\" Wine Spectator\r\n\"The 2011 Barolo Ravera does a terrific job of portraying the soft and rich side of the vintage with a slightly more accessible style. The wine opens to dark extraction and bright cherry flavors with spice, tobacco, black truffle, pressed rose petal and licorice. It shows a youthful, vibrant personality with a pristine varietal voice. If you are looking for an opulent, caressing Barolo, this wine fits the bill. The Ravera vineyard is planted to 50-year-old vines that hold up very nicely in warm vintages such as 2011. It has the natural structure and heft necessary for longer aging.\" Robert Parker\r\n\"This is another impressive effort from Cogno, offering aromas of ripe dark-skinned fruit, fragrant flowers, underbrush and menthol. The firm, precise palate offers dried black cherry, cinnamon, anise, clove, cocoa and mineral set against a tannic backbone and brisk acidity. Give this time to develop even more complexity.\" Wine Enthusiast"
        expect(product.description).to eq(expected_description)
      end

    end
    
    context 'price' do
      it 'example #1' do
        expect(product.price).to eq("7.95€")
      end

      it 'example #2' do
        @url = "https://www.superiore.de/Wein/Sizilien/Planeta/Dorilli-Cerasuolo-di-Vittoria-Classico-DOCG-2013.html"
        expect(product.price).to eq("13.95€")
      end

      it 'example #3' do
        @url = "https://www.superiore.de/Wein/Piemont/Elvio-Cogno/Barolo-Ravera-DOCG-2011.html"
        expect(product.price).to eq("43.90€")
      end
    end
    
    
    context 'volume' do
      it 'example #1' do
        expect(product.volume).to eq("0.75l")
      end

      it 'example #2' do
        @url = "https://www.superiore.de/Wein/Sizilien/Planeta/Dorilli-Cerasuolo-di-Vittoria-Classico-DOCG-2013.html"
        expect(product.volume).to eq("0.75l")
      end

      it 'example #3' do
        @url = "https://www.superiore.de/Wein/Piemont/Elvio-Cogno/Barolo-Ravera-DOCG-2011.html"
        expect(product.volume).to eq("0.75l")
      end
    end
    
    context 'availability' do
      it 'example #1' do
        expect(product.availability).to eq("sofort lieferbar")
      end
    
      it 'example #2' do
        @url = "https://www.superiore.de/Wein/Sizilien/Planeta/Dorilli-Cerasuolo-di-Vittoria-Classico-DOCG-2013.html"
        expect(product.availability).to eq("sofort lieferbar")
      end

      it 'example #3' do
        @url = "https://www.superiore.de/Wein/Latium/Falesco/Vitiano-Bianco-Umbria-IGP-2014.html"
        expect(product.availability).to eq("< 24 Stück verfügbar")
      end

      it 'example #4' do
        @url = "https://www.superiore.de/Wein/Piemont/Elvio-Cogno/Barolo-Ravera-DOCG-2011.html"
        expect(product.availability).to eq("< 24 Stück verfügbar")
      end

    end
    
    context 'additional_content' do
      it "example #1" do
        expected_res = []
        expected_res << "Rating Kundenbewertungen: 5"
        expected_res << "Rating Gambero Rosso 2016: 1"
        expected_res << "Rating Duemilavini 2016: 3"
        expected_res << "Rating Vitae 2016: 2"
        expected_res << "Rating Veronelli-Guide 86 Punkte / 2"
        expected_res << "Rating Luca Maroni 2016: 86 Punkte"
        expected_res << "Rating Robert Parker: 90 Punkte"

        expected_res << "Rebsorte: 100% Pecorino"
        expected_res << "Anbau: konventionell"
        expected_res << "Ausbau: Edelstahl"
        expected_res << "Filtration: Ja"
        expected_res << "Alkoholgehalt: 13,00 % vol"
        expected_res << "Verschluss: Naturkorken"
        expected_res << "Trinktemperatur: 8-10°C"
        expected_res << "Lagerpotenzial: 2018"
        expected_res << "Allergenhinweis: enthält Sulfite"

        expect(product.additional_content).to eq(expected_res)
      end

      it "example #2" do
        @url = "https://www.superiore.de/Wein/Sizilien/Planeta/Dorilli-Cerasuolo-di-Vittoria-Classico-DOCG-2013.html"
        expected_res = []
        expected_res << "Rating Gambero Rosso 2016: 3"
        expected_res << "Rating Duemilavini 2016: 5"
        expected_res << "Rating Guide l'Espresso 2016: 4"
        expected_res << "Rating Veronelli-Guide 91 Punkte / 3"
        expected_res << "Rating Vinibuoni 2016: 4"
        expected_res << "Rating Robert Parker: 91 Punkte"
        expected_res << "Rating James Suckling: 94 Punkte"


        expected_res <<"Rebsorten: 70% Nero d'Avola, 30% Frappato"
        expected_res << "Anbau: konventionell"  
        expected_res << "Ausbau: 12 Monate Tonneau"
        expected_res << "Filtration: Ja"  
        expected_res << "Alkoholgehalt: 13,00 % vol"  
        expected_res << "Gesamtextrakt: 29,07 g/l"  
        expected_res << "Gesamtsäure: 5,11 g/l"  
        expected_res << "Restzucker: 2,74 g/l"  
        expected_res << "Sulfit: 112 mg/l"  
        expected_res << "ph-Wert: 3,40"  
        expected_res << "Verschluss: Naturkorken"  
        expected_res << "Trinktemperatur: 18-20°C"  
        expected_res << "Lagerpotenzial: 2019+"  
        expected_res << "Allergenhinweis: enthält Sulfite"  

        expect(product.additional_content).to eq(expected_res)
      end

      it 'example #3' do
        @url = "https://www.superiore.de/Wein/Venetien/Zenato/Custoza-DOC-2014.html"

        expected_res = []
        expected_res << "Rating Kundenbewertungen: 4"

        expected_res << "Rebsorten: 40% Trebbiano, 30% Garganega, 20% Chardonnay, 10% Trebbianello"
        expected_res << "Anbau: konventionell"
        expected_res << "Ausbau: Edelstahl"
        expected_res << "vegane Klärung: ja"
        expected_res << "Alkoholgehalt: 12,50 % vol"
        expected_res << "Gesamtextrakt: 26,40 g/l"
        expected_res << "Gesamtsäure: 6,10 g/l"
        expected_res << "Restzucker: 4,20 g/l"
        expected_res << "Sulfit: 110 mg/l"
        expected_res << "ph-Wert: 3,30"
        expected_res << "Verschluss: Naturkorken"
        expected_res << "Trinktemperatur: 8-10°C"
        expected_res << "Lagerpotenzial: 2017"
        expected_res << "Allergenhinweis: enthält Sulfite"

        expect(product.additional_content).to eq(expected_res)
      end

      it 'example #4' do
        @url = "https://www.superiore.de/Wein/Toskana-Montepulciano/Poderi-Boscarelli/Rosso-Toscana-De-Ferrari-IGT-2014-6-Flaschen-in-Original-Holzkiste.html"
        
        expected_res = []

        expected_res << "Rating Gambero Rosso 2016: 2"
        expected_res << "Rating Duemilavini 2016: 3"
        expected_res << "Rating Guide l'Espresso 2016: 3"


        expected_res << "Rebsorten: 90% Prugnolo Gentile, 5% Merlot, 5% Canaiolo"
        expected_res << "Anbau: konventionell"
        expected_res << "Ausbau: 6 bis 9 Monate Edelstahl und Fässer"
        expected_res << "Filtration: Ja"  
        expected_res << "Alkoholgehalt: 13,50 % vol"  
        expected_res << "Gesamtsäure: 5,70 g/l"  
        expected_res << "Verschluss: Naturkorken"  
        expected_res << "Trinktemperatur: 18-20°C"  
        expected_res << "Lagerpotenzial: 2019"  
        expected_res << "Allergenhinweis: enthält Sulfite"  

        expect(product.additional_content).to eq(expected_res)
      end

      it 'example #5' do
        @url = "https://www.superiore.de/Wein/Piemont/Elvio-Cogno/Barolo-Ravera-DOCG-2011.html"

        expected_res = []

        expected_res << "Rating Gambero Rosso 2016: 3"
        expected_res << "Rating Duemilavini 2016: 4"
        expected_res << "Rating Vitae 2016: 4"
        expected_res << "Rating Guide l'Espresso 2016: 4"
        expected_res << "Rating Veronelli-Guide 93 Punkte / 3"
        expected_res << "Rating Doctor Wine 2016: 90 Punkte"
        expected_res << "Rating Robert Parker: 93 Punkte"
        expected_res << "Rating Antonio Galloni: 93 Punkte"
        expected_res << "Rating Wine Spectator: 95 Punkte"
        expected_res << "Rating James Suckling: 93 Punkte"
        expected_res << "Rating Wine Enthusiast: 95 Punkte"
        expected_res << "Rating Ian d'Agata: 93 Punkte"



        expected_res << "Rebsorte: 100% Nebbiolo"
        expected_res << "Anbau: konventionell"
        expected_res << "Ausbau: 24 Monate großes slawonisches Fass"
        expected_res << "Filtration: Nein"
        expected_res << "Alkoholgehalt: 14,50 % vol"
        expected_res << "Gesamtextrakt: 28,30 g/l"
        expected_res << "Gesamtsäure: 5,80 g/l"
        expected_res << "Restzucker: 0,40 g/l"
        expected_res << "Sulfit: 102 mg/l"
        expected_res << "ph-Wert: 3,53"
        expected_res << "Verschluss: Naturkorken"
        expected_res << "Trinktemperatur: 18-20°C"
        expected_res << "Lagerpotenzial: 2035"
        expected_res << "Allergenhinweis: enthält Sulfite"

        expect(product.additional_content).to eq(expected_res)

      end

    end

  end

end
