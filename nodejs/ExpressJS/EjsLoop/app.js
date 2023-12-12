const express = require('express');
const app = new express();
const path = require('path');

app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

app.get('/questions', (req, res)=>{
    questions = [
        {title: "What is node.js?", user: "john", votes: "41"},
        {title: "What is express.js?", user: "hanna", votes: "11"},
        {title: "Join the django?", user: "john", votes: "1111"}
    ]
    res.render('index', {questions:questions});
});

app.listen(3000, ()=>{
    console.log('Running on port 3000')
});