const express = require('express');
const app = new express();
const path = require('path'); 

app.set('views', path.join(__dirname,'views'));
app.set('view engine', 'ejs');
app.use(express.static('public'));

app.get('/user/:id/:username', (req, res)=>{
    let userId = req.params.id;
    let user = req.params.username;

    res.render('index', {id: userId, username: user});
});

app.listen(3000, ()=>{
    console.log('Running on port 3000');
});