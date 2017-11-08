// Gestion du formulaire
$('#clickMe').click(function (event) {
    event.preventDefault();
    var sent = new Object;
    sent.fonction = $('#fonction').val();
    sent.debut = $('#debut').val();
    sent.fin = $('#fin').val();
    //sent.pas = $('#pas').val();
    socket.emit('sandwich', JSON.stringify(sent));
});
// Gestion du réseau
var socket = io.connect(document.location.href);
socket.on("tab", function (data) {
    tab = JSON.parse(data);
    console.log(tab);
    document.getElementById("hello").innerHTML = tab.points;
    // On dessine une courbe
    canvas = document.getElementById('graph');
    if (canvas.getContext) {
        var ctx = canvas.getContext('2d');
        ctx.fillStyle = "white";
        ctx.fillRect(0, 0, document.getElementById("graph").getAttribute('width'), document.getElementById("graph").getAttribute('height'));
        ctx.fillStyle = 'rgb(200, 0, 0)';
        for (i = 0; i < 1000; i++) {
            ctx.fillRect(i, tab.points[i], 1, 1)
        }
    }
})