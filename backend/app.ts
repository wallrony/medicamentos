import express from 'express';
import cors from 'cors';
import router from './src/routes';

const app = express();

app.use(cors());
app.use(express.json());
app.use(router);

app.listen(3333, () => {
  console.log("Listening in port 3333");
});
