use Espresso;
db.drinks.insertMany([
  {
    _id: ObjectId("627d22e5c4df74966b2fddd2"),
    drink: 'Black Coffee',
    price: 500,
    description: 'A cup of our traditional coffee'
  },
  {
    _id: ObjectId("627d233cc4df74966b2fddd3"),
    drink: 'Orange Juice',
    price: 500,
    description: 'A juice made from our homegrown oranges, directly from Florida'
  },
  {
    _id: ObjectId("627d236bc4df74966b2fddd4"),
    drink: 'White Tea',
    price: 600,
    description: 'A favorite among tea lovers'
  }
]);
