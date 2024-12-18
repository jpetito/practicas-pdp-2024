
module Library where
import PdePreludat
import Data.List (isInfixOf, Foldable (length))

data Turista = Turista {
    estres :: Number,
    cansancio :: Number,
    estaSolo :: Bool,
    idioma :: [String]
} deriving (Eq, Show)

type Excursion = Turista -> Turista

playa :: Excursion
playa (Turista estres cansancio estaSolo idioma)
    | estaSolo = Turista estres (cansancio  - 5) estaSolo idioma
    | otherwise = Turista (estres - 1) estaSolo idioma

apreciar :: String -> Excursion
apreciar elemento (Turista estres cansancio estaSolo idioma) = Turista (estres - length elemento) cansancio estaSolo idioma

salirAHablar :: String -> Excursion
salirAHablar idiomaNuevo (Turista estres cansancio estaSolo idioma) = Turista estres cansancio (not estaSolo) (idioma ++ [idiomaNuevo])

caminar :: Number -> Excursion
caminar minutos (Turista estres cansancio estaSolo idioma) = Turista (estres - minutos/4) (cansancio - minutos/4) estaSolo idioma

paseoEnBarco :: String -> Excursion
paseoEnBarco marea turista
    | merea == "fuerte" = (estres + 6) turista && (cansancio + 10) turista
    | marea == "moderada" = turista
    | marea == "tranquila" = (caminar 10 . apreciar "mar" . salirAHablar "Aleman") turista

--1) a
 
--2) a

efectosExcursion ::  Excursion -> Turista -> Turista
efectosExcursion excursion turista = reducirEstres10 (excursion turista)

reducirEstres10 :: Turista -> Turista
reducirEstres10 (Turista estres cansancio estaSolo idioma) = Turista (estres - estres*0.1) cansancio estaSolo idioma
--b
--deltaSegun :: (a -> Int) -> a -> a -> Int
--deltaSegun f algo1 algo2 = f algo1 - f algo2

deltaExcursionSegun :: (Turista -> Number) -> Turista -> Excursion -> Number
deltaExcursionSegun indice turista turistaDpsExcursion = indice turista - indice turistaDpsExcursion
--c) i. 

esEducativa :: Excursion -> Turista -> Bool
esEducativa excursion turista = deltaExcursionSegun (lenght . idioma) turista (excursion turista) /= 0

--ii.
esEstresante :: Excursion -> Turista -> Bool
esEstresante excursion turista = deltaExcursionSegun estres turista (excursion turista) >= 3

--d
data Tour = Tour {
    excursiones :: [Excursion]
} deriving (Eq, Show)

completo :: Tour
completo = Tour {[apreciar "cascada", caminar 40, playa, salirAHablar "melmacquiano"]}

ladoB :: Excursion -> Tour
ladoB excursionElegida = Tour {[excursionElegida, paseoEnBarco "tranquila", excursionElegida, caminar 120]}

islaVecina :: String -> Tour
islaVecina marea
    | marea == "fuerte" = Tour {[paseoEnBarco "fuerte", apreciar "lago" , paseoEnBarco "fuerte"]}
    | marea == "moderada" = Tour {[paseoEnBarco "moderada", playa , paseoEnBarco "moderada"]}
    | marea == "tranquila" = Tour {[paseoEnBarco "tranquila", playa , paseoEnBarco "tranquila"]}

--Modelar los tours a)

hacerTour :: Turista -> Tour -> Turista
hacerTour turista tour =  foldl efectosExcursion (aumentarEstres tour turista)

aumentarEstres :: Tour -> Turista -> Turista
aumentarEstres (Tour excursiones) (Turista estres cansancio estaSolo idioma) = Turista (estres turista + lenght excursiones) cansancio estaSolo idioma
--b 
toursConvincentes :: [Tour] -> Turista -> [Tour]
toursConvincentes tour turista = filter (esConvincente tour turista) tour

esConvincente :: Tour -> Turista -> Bool
esConvincente (Tour excursiones) turista = any (not esEstresante excursiones turista && not estaSolo (efectosExcursion turista)) excursiones
--c
afectividad :: [Turista] -> Tour -> Number
afectividad turistas tour = sum (map (espiritualidad turistas) turistas)

espiritualidad :: Turista  -> Number
espiritualidad turista = (estres turista - estres (hacerTour turista)) + (cansancio turista - cansancio (hacerTour turista))

--4
--a)
tourInfinitasPlayas :: [Excursion]
tourInfinitasPlayas = repeat playa