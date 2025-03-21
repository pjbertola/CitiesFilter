# CitiesFilter

Storage
Sobre el storage utilicé SwiftData a modo de muestra. Es demasiada estructura para solo guardar favoritos. Con un diccionario de Ids en usersDefault bastaba.



Filtrado
Para el filtrado utilicé un diccionario de Sets<String> (dictionaryKeys) y otro de CityModel (allCitiesDic). Este se va construyendo con la primera letra de cada ciudad y tambien la primera y la segunda. Luego a los Sets de cada entrada se les agrega un string formado por el nombre, país y id del objeto CityModel (a esta key la voy a llamar masterKey). Tambien guardo el array con el que se hace el setup (allCities) y un set de favoritos que se actualiza cuando se favoritea o desfavoritea una ciudad (favoritesSet) usando la masterKey.
Utilicé set y no arrays porque sus elementos son hasheados y eso hace que se filtren más rápido. El único array es allCities porque necesitaba que mantuviera el orden y no lo filtro. 


Ejemplo:
Si se hace el setup con un array con solo este objeto:
    CityModel(name: "Alabama", country: "US", id: 4829764, latitude:32.750408 , longitude: -86.750259, isFavorite: true)
Las estructuras quedarían así
    dictionaryKeys
        - a: ["Alabama, US__4829764"]
        - al: ["Alabama, US__4829764"]
    allCitiesDic
        - Alabama, US__4829764: CityModel(...)
    allCities: [CityModel(...)]
    favoritesSet: ["Alabama, US__4829764"]    

Entonces al filtrarse, primero chequea si el texto esta vacio y si lo está:
    Si no esta marcado Only Favorites, se retorna allCities
    Si está marcado Only Favorites, se recorre el favoritesSet y con las masterKey retorna los objetos de allCitiesDic
Si el texto de busqueda no esta vacio, se construye un prefix utilizando hasta sus 2 primeros caracteres
    Utilizando el prefix en dictionaryKeys obtengo el set de masterKey, chequeo si comienza con el texto, luego obtengo el objeto CityModel de allCitiesDic con la masterKey y chequeo si marcado Only Favorites y si es favorito o no. Si cumple con todo, devuelvo Citymodel, sino lo ignoro.
