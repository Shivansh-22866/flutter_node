const express = require('express');
const router = express.Router();
const Note = require('../models/note');

router.post("/list", async (req, res) => {
    var notes = await Note.find({userId: req.body.userId});
    res.json(notes);
});

router.post("/add", async(req, res) => {

    await Note.deleteOne({id: req.body.id});

    const note = new Note(
        {
            id: req.body.id,
            userId: req.body.userId,
            title: req.body.title,
            content: req.body.content,
        }
    );

    await note.save();

    const response = {message: "New Note Created!" + `${req.body.id}`};
    res.json(response);
});

router.delete("/delete/", async (req, res) => {
    await Note.deleteOne({id: req.body.id});
    const response = {message: "Note Deleted!" + `${req.body.id}`};
    res.json(response);
});

module.exports = router;