{-# OPTIONS_GHC -Wno-missing-fields #-}

module Library where
import PdePreludat
import GHC.Base (Float)
import GHC.Num (Num)

data Elemento = UnElemento {
    tipo :: String,
    ataque :: Personaje-> Personaje,
    defensa :: Personaje-> Personaje
    } deriving (Eq, Show)

data Personaje = UnPersonaje {
    nombre :: String,
    salud :: Number,
    elementos :: [Elemento],
    anioPresente :: Number
    } deriving (Eq, Show)

pepe :: Personaje
pepe = UnPersonaje { nombre = "Pepe", salud = 100.0, elementos = [UnElemento { tipo = "Malvado"}], anioPresente = 2024 }

--1 a. 
mandarAlAnio :: Number -> Personaje -> Personaje
mandarAlAnio anio (UnPersonaje nombre salud elementos anioPresente) = UnPersonaje nombre salud elementos anio
--b.
meditar :: Personaje -> Personaje
meditar (UnPersonaje nombre salud elementos anioPresente) = UnPersonaje nombre (salud + (salud/2)) elementos anioPresente
--c. 
causarDanio :: Number -> Personaje -> Personaje
causarDanio cantSalud (UnPersonaje nombre salud elementos anioPresente)
    | salud <= cantSalud = UnPersonaje nombre 0 elementos anioPresente
    | otherwise = UnPersonaje nombre (salud - cantSalud) elementos anioPresente

--2 a.
esMalvado :: Personaje -> Bool
esMalvado (UnPersonaje nombre salud [] anioPresente) = False
esMalvado personaje = "Malvado" `elem` map tipoElemento (elementos personaje)

tipoElemento :: Elemento -> String
tipoElemento (UnElemento tipo ataque defensa) = tipo
--b
danioQueProduce :: Personaje -> Elemento -> Number
danioQueProduce personaje elemento = salud personaje - salud (ataque elemento personaje)
--c
enemigosMortales :: Personaje -> [Personaje] -> [Personaje]
enemigosMortales personaje enemigos = filter (llegaAMatarlo personaje enemigos) enemigos

llegaAMatarlo :: Personaje -> Personaje -> Bool
llegaAMatarlo personaje enemigo = salud (ataque (elementos enemigo) enemigo personaje) == 0

--3 a. 
concentracion :: Number -> Personaje -> Elemento
concentracion nivel personaje = UnElemento {tipo = "Magia", defensa = meditarNveces nivel personaje}

meditarNveces :: Number -> Personaje -> Personaje
meditarNveces n personaje = foldr meditar personaje [1..n]
--b. 
esbirrosMalvados :: Number -> [Elemento]
esbirrosMalvados 0 = []
esbirrosMalvados n = map crearEsbirro [1..n]

crearEsbirro :: Number -> Elemento
crearEsbirro n = UnElemento { tipo = "Malvado", ataque = causarDanio 1}

--c
katana :: Elemento 
katana = UnElemento { tipo = "Magia", ataque = causarDanioDanio 1000}

jack :: Personaje 
jack = UnPersonaje { 
    nombre = "Jack",
    salud = 300,
    elementos = [consentracion 3, katana],
    anioPresente = 200
    }
--d
portalAlFuturo :: Int -> Float -> Elemento 
portalAlFuturo anio salud = UnElemento {tipo = "Magia", ataque = mandarAlAnio (2800+anio) personaje, defensa = aku anio salud}

aku :: Int -> Float -> Personaje
aku anio salud = UnPersonaje {
    nombre = "Aku", 
    salud = salud, 
    elementos = [concentracion 4, esbirrosMalvados (anio/100), portalAlFuturo anio salud],
    anioPresente = anio
    }

-- luego de que ambos personajes se vean afectados por el uso de todos los elementos del atacante.
-- O sea que si luchan Jack y Aku siendo Jack el primer atacante, Jack se verá afectado por
-- el poder defensivo de la concentración y Aku se verá afectado por el poder ofensivo de la 
-- katana mágica, y la lucha continuará con Aku (luego del ataque) como atacante y con Jack 
-- (luego de la defensa) como defensor.


--4
luchar :: Personaje -> Personaje -> (Personaje, Personaje)
luchar atacante defensor 
    | llegaAMatarlo atacante defensor = (defensor, atacante)
    | otherwise = luchar (afectado atacante defensor) atacante 

afectado :: Personaje -> Personaje -> Personaje
afectado atacante defensor = foldr (danioQueProduce elementos atacante) defensor (elementos atacante)
