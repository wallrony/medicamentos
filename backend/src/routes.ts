import express from 'express';
import MedicamentosController from './controller/MedicamentosController';
import UserController from './controller/UserController';
import AuthController from './controller/AuthController';

const router = express.Router();
const medController = new MedicamentosController();
const userController = new UserController();
const authController = new AuthController();

router.all('*', authController.verifyAuth);

router.get('/medicamentos', medController.index);
router.get('/medicamentos/:id', medController.show);
router.get('/users', userController.index);
router.get('/users/:id', userController.show);

router.post('/medicamentos', medController.add);
router.post('/users', userController.add);
router.post('/login', authController.login);

router.put('/medicamentos', medController.update);
router.put('/users', userController.edit);

router.delete('/medicamentos/:id', medController.delete);
router.delete('/users/:id', userController.delete);

export default router;