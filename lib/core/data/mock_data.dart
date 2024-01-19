const count = 50;
const pokemonName = 'bulbasaur';
const pokemonId = 1;
const pokemonHeight = 7;
const pokemonWeight = 69;
const pokemonUrl = 'https://pokeapi.co/api/v2/pokemon/$pokemonId/';
const pokemonResultJson = {
  'name': pokemonName,
  'url': pokemonUrl,
};
const pokemonMoveName = 'razor-wind';
const pokemonBaseStat = 45;
const pokemonEffort = 0;
const pokemonStatName = 'hp';

final pokemonListReponseJson = {
  'count': count,
  'next': 'https://pokeapi.co/api/v2/pokemon?offset=25&limit=25',
  'previous': null,
  'results': List.generate(25, (_) => pokemonResultJson),
};

const getPokemonDetailsJson = {
  'name': pokemonName,
  'id': pokemonId,
  'height': pokemonHeight,
  'weight': pokemonWeight,
  'types': [
    {
      'slot': 1,
      'type': {
        'name': 'grass',
      },
    },
    {
      'slot': 2,
      'type': {
        'name': 'poison',
      },
    },
  ],
  'moves': [
    {
      'move': {
        'name': pokemonMoveName,
      },
    },
    {
      'move': {
        'name': 'swords-dance',
      },
    },
  ],
  'stats': [
    {
      'base_stat': pokemonBaseStat,
      'effort': pokemonEffort,
      'stat': {
        'name': pokemonStatName,
      },
    },
    {
      'base_stat': 49,
      'effort': 0,
      'stat': {
        'name': 'attack',
      },
    },
    {
      'base_stat': 49,
      'effort': 0,
      'stat': {
        'name': 'defense',
      },
    },
    {
      'base_stat': 65,
      'effort': 1,
      'stat': {
        'name': 'special-attack',
      },
    },
    {
      'base_stat': 65,
      'effort': 0,
      'stat': {
        'name': 'special-defense',
      },
    },
    {
      'base_stat': 45,
      'effort': 0,
      'stat': {
        'name': 'speed',
      },
    },
  ],
};
