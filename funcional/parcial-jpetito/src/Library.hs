module Library where
import PdePreludat
import Data.List (isInfixOf, Foldable (length))


--PARTE UNO

data Relleno = DulceDeLeche | Mousse | Fruta deriving (Eq, Show)

data Alfajor = Alfajor {
    relleno :: [Relleno],
    peso :: Number,
    dulzor :: Number,
    nombre :: String
} deriving (Eq, Show)

--a) 
jorgito :: Alfajor
jorgito = Alfajor {relleno = [DulceDeLeche], peso = 80, dulzor = 8, nombre = "Jorgito"}

havanna :: Alfajor
havanna = Alfajor {relleno = [Mousse, Mousse], peso = 60, dulzor = 12, nombre = "Havanna"}

capitanDelEspacio :: Alfajor
capitanDelEspacio = Alfajor {relleno = [DulceDeLeche], peso = 40 , dulzor = 12 , nombre = "Capitán del espacio"}

--b)
--i
coeficienteDulzor :: Alfajor -> Number
coeficienteDulzor alfajor = (dulzor alfajor) / (peso alfajor)
--ii
precio :: Alfajor -> Number
precio alfajor = (peso alfajor) *2 + sum (map precioRelleno (relleno alfajor))

precioRelleno :: Relleno -> Number
precioRelleno DulceDeLeche = 12
precioRelleno Mousse = 15
precioRelleno Fruta = 10
--iii
potable :: Alfajor -> Bool
potable alfajor = alMenosUnaCapa alfajor && capasMismoSabor alfajor && coerficienteDulzorMayorOIgual alfajor

alMenosUnaCapa :: Alfajor -> Bool
alMenosUnaCapa (Alfajor relleno _ _ _) = not (null relleno)

capasMismoSabor :: Alfajor -> Bool
capasMismoSabor (Alfajor relleno _ _ _) = all (== head relleno) relleno

coerficienteDulzorMayorOIgual :: Alfajor -> Bool
coerficienteDulzorMayorOIgual alfajor = coeficienteDulzor alfajor >= 0.1

--PARTE DOS

--a
abaratar :: Alfajor -> Alfajor
abaratar (Alfajor relleno peso dulzor nombre) = Alfajor relleno (peso - 10) (dulzor - 7) nombre
--b
renombrar :: String -> Alfajor -> Alfajor
renombrar nuevo (Alfajor relleno peso dulzor _) = Alfajor relleno peso dulzor nuevo
--c
agregarCapa :: Relleno -> Alfajor -> Alfajor
agregarCapa nuevoRelleno (Alfajor relleno peso dulzor nombre) = Alfajor (relleno ++ [nuevoRelleno]) peso dulzor nombre
--d
-- premium :: Alfajor -> Alfajor
-- premium (Alfajor relleno peso dulzor nombre)
--     | potable (Alfajor relleno peso dulzor nombre) = Alfajor (relleno ++ [head relleno]) peso dulzor (nombre ++ " premium")
--     | otherwise = Alfajor relleno peso dulzor nombre
--e
premium :: Alfajor -> Alfajor
premium alfajor
    | potable alfajor = (agregarCapa (head (relleno alfajor)) . renombrar (nombre alfajor ++ " premium")) alfajor
    | otherwise = alfajor

premiumDeGrado ::  Number -> Alfajor -> Alfajor
premiumDeGrado 0 alfajor = alfajor
premiumDeGrado 1 alfajor = premium alfajor
premiumDeGrado n alfajor = premiumDeGrado (n-1) (premium alfajor)

--f) i
jorgitito :: Alfajor
jorgitito = (renombrar "Jorgitito" . abaratar) jorgito
--ii
jorgelin :: Alfajor
jorgelin = (renombrar "Jorgelín" . agregarCapa DulceDeLeche) jorgito
--iii
capitanDelEspacioDeCostaACosta :: Alfajor
capitanDelEspacioDeCostaACosta = (premiumDeGrado 4 . renombrar "Capitán del espacio de costa a costa". abaratar) capitanDelEspacio

--PARTE TRES
--a

type Criterio = Alfajor -> Bool

data Cliente= Cliente {
    nombree :: String,
    dinero :: Number,
    leGusta :: Criterio,
    alfajoresComprados :: [Alfajor]
}
--i
leGustaAEmi :: Criterio
leGustaAEmi (Alfajor _ _ _ nombre) = "Capitán del espacio" `isInfixOf` nombre

emi :: Cliente
emi = Cliente {nombree = "Emi", dinero = 120, leGusta = leGustaAEmi, alfajoresComprados = []}
--ii
leGustaATomi :: Criterio
leGustaATomi alfajor = ("premium" `isInfixOf` (nombre alfajor)) && (coeficienteDulzor alfajor > 0.15)

tomi :: Cliente
tomi = Cliente {nombree = "Tomi", dinero = 100, leGusta = leGustaATomi, alfajoresComprados = []}
--iii
leGustaADante :: Criterio
leGustaADante alfajor = not (any (== DulceDeLeche) (relleno alfajor)) && not (potable alfajor)

dante :: Cliente
dante = Cliente {nombree = "Dante", dinero = 200, leGusta = leGustaADante, alfajoresComprados = []}
--iv
leGustaAJuan :: Criterio
leGustaAJuan alfajor = not (any (== Mousse) (relleno alfajor)) && ("Jorgito" `isInfixOf` (nombre alfajor))

juan :: Cliente
juan = Cliente {nombree = "Juan", dinero = 500, leGusta = leGustaAJuan, alfajoresComprados = []}

--b
leGustaA :: Cliente -> Criterio -> [Alfajor] -> [Alfajor]
leGustaA cliente criterio alfajores = filter criterio alfajores
--c
comprar :: Cliente -> Alfajor -> Cliente
comprar (Cliente nombre dinero leGusta alfajoresComprados) alfajor
    | puedeComprar (Cliente nombre dinero leGusta alfajoresComprados) alfajor =  (Cliente nombre (dinero - precio alfajor) leGusta (alfajoresComprados ++ [alfajor]))
    | otherwise = (Cliente nombre dinero leGusta alfajoresComprados)

puedeComprar :: Cliente -> Alfajor -> Bool
puedeComprar cliente alfajor = (dinero cliente) > (precio alfajor)
--d
comprarFavoritos :: Cliente -> Criterio -> [Alfajor] -> Cliente
comprarFavoritos cliente criterio alfajores = foldl (comprar) cliente (leGustaA cliente criterio alfajores)