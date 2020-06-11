import jwt from 'jsonwebtoken';
import fs from 'fs';
import path from 'path';

export function generateToken() {
  const privateKey = fs.readFileSync(path.resolve(__dirname, '..', 'keys', 'private.key'), 'utf8');

  let token;

  try {
    token = jwt.sign({}, privateKey, {});
  }
  catch(error) {
    token = 'error';
  }

  return token;
}