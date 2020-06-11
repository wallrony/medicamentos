import Knex from 'knex';
import { generateToken } from '../../utils/KeyUtils';

export async function seed(knex: Knex) {
  const token = String(generateToken()).split('.')[2];

  return knex('users').insert([
    {
      name: "Admin",
      user: 'admin',
      pswd: 'admin',
      token
    },
  ]);
}