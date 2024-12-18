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
