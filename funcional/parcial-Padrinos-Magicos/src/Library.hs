module Library where
import PdePreludat

-- PARTE A: "Concediendo deseos"
--1)
data Chico = UnChico {
    nombre :: String,
    edad :: Number,
    habilidades :: [String],
    deseos :: [String]
} deriving (Show, Eq)

timmy :: Chico
timmy = UnChico {nombre = “Timmy”, edad = 10, habilidades = [“mirar television”, “jugar en la pc”], deseos = [serMayor]}
--a.
aprenderHabilidades :: Chico -> [String] -> Chico
aprenderHabilidades chico habilidadesNuevas = chico {habilidades = habilidades chico ++ habilidadesNuevas}
--b. 
serGrosoEnNeedForSpeed :: Chico -> Chico
serGrosoEnNeedForSpeed chico = aprenderHabilidades chico ["jugar need for speed 1", "jugar need for speed 2"]
--c. 
serMayor :: Chico -> Chico 
serMayor chico = chico {edad = 18}

--2)
type PadrinoMagico = Chico -> Chico
--a
wanda :: PadrinoMagico
wanda chico =  cambiarEdad (+1) && CumplirDeseo

cambiarEdad :: (Number -> Number) -> Chico -> Chico 
cambiarEdad nuevaEdad chico = chico {edad = nuevaEdad (edad chico)}

cumplirDeseo :: Chico -> Chico
cumplirDeseo (UnChico _ _ _ []) =  (UnChico _ _ _ []) 
cumplirDeseo (UnChico _ _ _ (primer : resto)) = UnChico _ _ _ (resto)
--b
cosmo :: PadrinoMagico
cosmo chico = cambiarEdad (/2)
--c
muffinMagico :: PadrinoMagico
muffinMagico chico = fold (cumplirDeseo) chico (deseos chico)

--PARTE B: "En busqueda de pareja"
--1)
--a.
tieneHabilidad :: String -> Chico -> Bool 
tieneHabilidad unaHabilidad unChico = any (== unaHabilidad) (habilidades unChico)
--b. 
esSuperMaduro :: Chico -> Bool 
esSuperMaduro chico = (tieneHabilidad "manejar" . esMayor) chico 
--2)
data Chica = Chica {
    nombre :: String,
    gustos :: Chico -> Bool
} deriving (Show, Eq)

trixie :: Chica
trixie = Chica {nombre = "Trixie Tang", gustos = (noEsTimmy)}

noEsTimmy :: Chico -> Bool
noEsTimmy chico = nombre chico /= "Timmy"

vicky :: Chica 
vicky = Chica {nombre = "Vicky", gustos = (tieneHabilidad "ser un supermodelo noruego")}
--a. 
quienConquistaA :: Chica -> [Chico] -> Chico
quienConquistaA unaChica losPretendientes 
    | algunoLeGusta unaChica losPretendientes = head (losQueLaConquistan unaChica losPretendientes)
    | otherwise = last losPretendientes

losQueLaConquistan :: Chica -> [Chico] -> [Chico]
losQueLaConquistan unaChica losPretendientes = filter (gustos unaChica) losPretendientes

algunoLeGusta :: Chica -> [Chico] -> Bool
algunoLeGusta unaChica chicos = any (tieneHabilidad (gustos unaChica)) chicos 
--b. Dar un ejemplo de consulta para una nueva chica, cuya condición para elegir a
--un chico es que este sepa cocinar.
sarah :: Chica 
sarah = Chica { nombre = "Sarah", gustos = (tieneHabilidad "cocinar")}

-- PARTE C: "Da Rules"
--1) 
infractoresDeDaRules :: [Chico] -> [String]
infractoresDeDaRules chicos = map mostrarNombre (filter deseosProhibidos chicos)

deseosProhibidos :: Chico -> Bool
deseosProhibidos chico = any (`elem` habilidadesProhibidas) (take 5 (habilidades chico))

habilidadesProhibidas :: [String] 
habilidadesProhibidas = ["enamorar", "matar", "dominar el mundo"]

mostrarNombre :: Chico -> String
mostrarNombre chico = nombre chico
