const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');

const app = express();
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());


mongoose.connect("mongodb+srv://shivanshp0418:ByIqDuGWTHPvSmlW@cluster0.d3ramr9.mongodb.net/notes").then(
    () => {
        app.get("/", (req, res) => {
            const response = {message: "API Home Route"};
            res.json(response);
        });

        const noteRouter = require('./routes/Note');
        app.use('/notes', noteRouter);
    }
);

const PORT = process.env.PORT || 2000
app.listen(PORT, () => {
    console.log('Server is running on port '+ PORT);
})