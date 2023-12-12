const express = require('express')
const app = new express();

app.get('/questions/:id/:topic', (req, res)=>{
    res.send('This page handle all topics');
})

app.get('/users/:id/:username', (req, res)=>{
    let userId = req.params.id
    let user = req.params.username
    
    res.send('This page handle user '+user+' with ID: '+userId);
})

app.listen(3000, ()=>{
    console.log('Running on port 3000');
})

