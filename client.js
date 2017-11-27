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
    if (!(tab.min === tab.max)) {
        var coeff = document.getElementById("graph").getAttribute('height') / tab.max - tab.min;
        // On recalcule 
        var newPoints = new Array();
        for (i = 0; i < 1000; i++) {
            newPoints[i] = tab.points[i] * coeff
        }
        var newMax = Math.max.apply(null, newPoints)
        if (500 - newMax > 1)
            for (i = 0; i < 1000; i++) newPoints[i] += 500 - newMax
        // On divise notre intervale en 10 parties égales
        var ValX = new Array();
        var ValY = new Array(); {
            let debX = $('#debut').val()
            let finX = $('#fin').val()
            let pasX = Number((finX - debX) / 10)
            for (let i = Number(debX); i <= finX; i += pasX) {
                ValX.push(i)
            }
            let debY = tab.min
            let finY = tab.max
            let pasY = (finY - debY) / 10
            for (let j = debY; j <= finY; j += pasY) ValY.push(j);
            console.log(ValX);
            console.log(ValY);
            // On va arrondir les valeurs.
            for (let k = 0; k < ValX.length; k += 1) {
                ValX[k] = Math.round(ValX[k] * 100) / 100
                ValY[k] = Math.round(ValY[k] * 100) / 100
            }
        }
        // On dessine une courbe
        canvas = document.getElementById('graph');
        if (canvas.getContext) {
            var ctx = canvas.getContext('2d');
            ctx.fillStyle = "white";
            ctx.fillRect(0, 0, document.getElementById("graph").getAttribute('width'), document.getElementById("graph").getAttribute('height'));
            // Après avoir nettoyé notre espace, on va ajouter des axes
            ctx.fillStyle = "black";
            //ctx.fillRect(x,y,w,h)
            var longueur = document.getElementById("graph").getAttribute('width');
            var hauteur = document.getElementById("graph").getAttribute('height');
            // On définit la position de l'abscisse et de l'ordonnée
            var abs = 20;//hauteur / 2;
            var ord = 20;//longueur / 2;
            ctx.fillRect(0, abs, longueur, 1);
            ctx.fillRect(ord, 0, 1, hauteur);
            // On trace des petits traits pour faire joli.
            for (var int = 0; int <= 10; int++) {
                ctx.fillRect(int * longueur / 10, abs - 3, 1, 6);
                ctx.fillRect(ord - 3, int * hauteur / 10, 6, 1);
                if (int <= 9) {
                    ctx.transform(1, 0, 0, -1, 0, canvas.height)
                    //ctx.fillText(text,x,y)
                    ctx.fillText(ValX[int].toString(), int * longueur / 10, 500 - abs)
                    ctx.fillText(ValY[int].toString(), ord + 20, (9-int) * hauteur)
                    ctx.transform(1, 0, 0, -1, 0, canvas.height)
                }
            }
            ctx.fillStyle = 'rgb(200, 0, 0)';
            for (i = 0; i < 1000; i++) {
                ctx.fillRect(i, newPoints[i], 1, 1)
            }
        }
    } else {
        alert("Le résultat du calcul est : " + tab.points[0]);
    }

})

socket.on("LolNope", data => alert("Les données d'entrées sont incorrectes."))

let closure = function () {
    // Inversion de l'axe y
    canvas = document.getElementById('graph');
    let ctx = canvas.getContext('2d');
    ctx.transform(1, 0, 0, -1, 0, canvas.height)
    //ctx.translate(0, canvas.height);
    //ctx.scale(1, -1);
}();