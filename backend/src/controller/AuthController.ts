import { Request, Response, NextFunction } from 'express';
import connection from '../database/connection';

import {
  errorEmptyValue, successAuthenticated, errorAuth, errorInvalidToken, errorTokenDoesntProvided, errorTokenRequired
} from '../utils/ResponseUtils';
import { User } from '../interfaces/User';

class AuthController {
  async login (request: Request, response: Response) {
    const { user, pswd } = request.body;

    if(!user || !pswd || !String(user).length || !String(pswd).length) {
      return response.status(400).json(errorEmptyValue);
    }

    const result = await connection('users')
      .select('*')
      .where('user', '=', user)
      .andWhere('pswd', '=', pswd);

    if(!result.length) {
      return response.status(400).json(errorAuth);
    }

    const userData = result[0] as User;

    return response.status(200).json(successAuthenticated(userData));
  }

  async verifyAuth(request: Request, response: Response, next: NextFunction) {
    if(request.path === '/login' || (request.path === '/users' && request.method === 'POST')) {
      return next();
    }
  
    if(!request.headers['authorization']) {
      return response.status(401).json(errorTokenRequired);
    }
  
    const token = request.headers['authorization'].replace('Token ', '');

    if(token === 'Token') {
      return response.status(401).json(errorTokenDoesntProvided);
    }

    const result = await connection('users').select('user').where('token', '=', token);

    if(result.length) {
      return next();
    }

    return response.status(401).json(errorInvalidToken);
  }
}

export default AuthController;