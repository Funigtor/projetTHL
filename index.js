// note that the compiled addon is placed under following path
const {plot} = require('./build/Release/addon');
const {RandTab} = require('./build/Release/addon');
var app = require('express')();
var http = require('http').Server(app);
var io = require('socket.io').listen(http);
var fs = require('fs');

var jquery = fs.readFileSync("node_modules/jquery/dist/jquery.min.js");

app.get('/', function(req, res){
  var client = fs.readFileSync("client.html");
  res.send(client.toString());
});

app.get('/jquery.min.js', function(req,res){
    res.send(jquery.toString());
});

app.get('/client.js', function(req,res){
    var jsClient = fs.readFileSync("client.js");    
    res.send(jsClient.toString());
});

http.listen(3000, function(){
  console.log('listening on *:3000');
});
// `Hello` function returns a string, so we have to console.log it!
//console.log(Hello());

io.sockets.on('connection', function (socket) {
    console.log('Un client est connecté !');

    socket.on('ask', function(message){
        console.log(message);
        socket.emit("message",Hello());
    })

    socket.on('sandwich', function(message){
        //tabJson = RandTab();
        input = JSON.parse(message);
        if (input.debut == input.fin) socket.emit("LolNope",{});
        else {
            tabJson = plot(input.fonction, Number(input.debut), Number(input.fin));
        console.log(tabJson);
        socket.emit("tab",tabJson)
        }
    })
});
