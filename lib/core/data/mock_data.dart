const count = 50;
const pokemonName = 'bulbasaur';
const pokemonId = '1';
const pokemonUrl = 'https://pokeapi.co/api/v2/pokemon/$pokemonId/';
const pokemonResultJson = {
  'name': pokemonName,
  'url': pokemonUrl,
};
final pokemonListReponseJson = {
  'count': count,
  'next': 'https://pokeapi.co/api/v2/pokemon?offset=25&limit=25',
  'previous': null,
  'results': List.generate(25, (_) => pokemonResultJson),
};
