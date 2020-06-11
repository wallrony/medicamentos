import Knex from 'knex';

export async function seed(knex: Knex) {
  return knex('medicamentos').insert([
    { name: "Dipirona", description: 'Alivia a dor de cabeça e dores do corpo.', value: 7 },
    { name: "Amoxilina", description: 'Alivia estresse e remove secreções da garganta.', value: 8 }
  ]);
}