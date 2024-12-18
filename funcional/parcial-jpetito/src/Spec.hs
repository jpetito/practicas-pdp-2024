module Spec where
import PdePreludat
import Library
import Test.Hspec
import Control.Exception (evaluate)
correrTests :: IO ()
correrTests = hspec $ do
    describe "coeficienteDulzor" $ do
        it "indica cuánto dulzor por gramo tiene el alfajor; se calcula dividiendo su dulzor sobre su peso" $ do
            coeficienteDulzor (Alfajor [Mousse, Mousse] 60 12 "Havanna") `shouldBe` 0.2

    describe "precio" $ do
        it "se calcula como el doble de su peso sumado a la sumatoria de los precios de sus rellenos." $ do
            precio (Alfajor [Mousse, Mousse] 60 12 "Havanna") `shouldBe` 150

    describe "potable" $ do
        it "tiene al menos una capa de relleno, todas sus capas son del mismo sabor, y su coeficiente de dulzor es mayor que 0,1." $ do
            potable (Alfajor [Mousse, Mousse] 60 12 "Havanna") `shouldBe` True
        it "no tiene ni una capa de relleno" $ do
            potable (Alfajor [] 60 12 "Havanna") `shouldBe` False
        it "tiene al menos una capa de relleno, todas sus capas son del mismo sabor, y su coeficiente de dulzor es igual que 0,1." $ do
            potable (Alfajor [DulceDeLeche] 80 8 "Jorgito") `shouldBe` True
        it "tiene al menos una capa de relleno, todas sus capas son del mismo sabor, y su coeficiente de dulzor es menor que 0,1." $ do
            potable (Alfajor [DulceDeLeche] 80 2 "Jorgito sin azucar") `shouldBe` False
        it "todas sus capas de distinto sabor" $ do
            potable (Alfajor [DulceDeLeche, Mousse] 80 8 "Jorgito Plus") `shouldBe` False

    describe "abaratar" $ do
        it "reduce su peso en 10g y su dulzor en 7." $ do
            abaratar (Alfajor [Mousse, Mousse] 60 12 "Havanna2.0") `shouldBe` Alfajor [Mousse, Mousse] 50 5 "Havanna2.0"
  
    describe "renombrar" $ do
        it "renombrar un alfajor, que cambia su packaging dándole un nombre completamente nuevo." $ do
            renombrar "Havanna2.0" (Alfajor [Mousse, Mousse] 60 12 "Havanna") `shouldBe` Alfajor [Mousse, Mousse] 60 12 "Havanna2.0"
 
    describe "agregarCapa" $ do
        it "agregar una capa de cierto relleno a un alfajor." $ do
            agregarCapa DulceDeLeche (Alfajor [Mousse, Mousse] 60 12 "Havanna") `shouldBe` Alfajor [Mousse, Mousse, DulceDeLeche] 60 12 "Havanna"

    describe "premium" $ do
        it "le agrega una capa de relleno, y lo renombra a su nombre original + la palabra premium al final." $ do
            premium (Alfajor [Mousse, Mousse] 60 12 "Havanna") `shouldBe` Alfajor [Mousse, Mousse, Mousse] 60 12 "Havanna premium"

    describe "premiumDeGrado" $ do
         it " consiste en hacerlo premium varias veces." $ do
            premiumDeGrado 1 (Alfajor [Mousse, Mousse] 60 12 "Havanna") `shouldBe` Alfajor [Mousse, Mousse, Mousse] 60 12 "Havanna premium"

    describe "leGustaAEmi" $ do
         it "alfajores que contengan en su nombre Capitán del espacio" $ do
            leGustaAEmi (Alfajor [Mousse, Mousse] 60 12 "Havanna") `shouldBe` False
         it "alfajores que contengan en su nombre Capitán del espacio" $ do
            leGustaAEmi (Alfajor [Mousse, Mousse] 60 12 "Capitán del espacio premium") `shouldBe` True

    describe "leGustaATomi" $ do
         it "solo le gustan los alfajores que contienen premium en su nombre" $ do
            leGustaAEmi (Alfajor [Mousse, Mousse] 60 12 "Havanna") `shouldBe` False
         it "le gustan los alfajores cuyo coeficiente de dulzor es mayor a 0,15" $ do
            leGustaAEmi (Alfajor [Mousse, Mousse] 60 12 "Capitán del espacio premium") `shouldBe` True

    describe "leGustaADante" $ do
         it "alfajores que le gustan no deben tener ninguna capa de dulce de leche y no deben ser potables" $ do
            leGustaADante (Alfajor [Mousse, Mousse] 60 12 "Havanna") `shouldBe` False

    describe "leGustaAJuan" $ do
         it "es dulcero, busca marca de Jorgito, pretencioso y anti-mousse." $ do
            leGustaAJuan (Alfajor [Mousse, Mousse] 60 12 "Havanna") `shouldBe` False