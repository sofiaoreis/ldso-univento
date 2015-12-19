/*  
    Ficheiro com js para a inscrição em eventos:
        - permite criar form personalizado
        - carregar dados das inscrições
        - registar inscrição
        - editar inscrição
        - cancelar inscrição
        - verificar se user já está inscrito
*/


/*  -   vars globais DON'T TOUCH THIS :D  -   */

var scriptLink = "https://script.google.com/macros/s/AKfycbxpb6ghoFH5Hyllkaq6DbmEepHU-nizHO6ukrOcJgLX4BRCAmM/exec";
var PERGUNTAS = ['Carimbo de data/hora',"[\"Email\",[]]"];

var numQuestion = 1;
var numOpcao = 2;

/*----------------------------------------------*//*----------------------------------------------*/

function start(){
    var userEmail ="";
    /* script de criação de formulário personalizado*/
    criarForm();
    /*----------------------------------------------*/

    /*obter dados do evento*/
	$.ajax({
	    url: window.location.href,
	  	type: "get",
	   	dataType: "json",
	   	data: {accao:"getEventInfo"}
	}).done(function (eventInfo) {
		if(eventInfo[2]!=null){
			$("#link").append("<a href=\""+eventInfo[2]+"\"> Ver SpreadSheet no google docs </a>");
		}

        /* botão criar spreadsheet*/
	   	$("#criarSpreadsheet").submit(function(e){
			e.preventDefault();
            //console.log(PERGUNTAS);
		    createSpreadSheet(eventInfo[1]+"_"+eventInfo[0], $("#gmail").val());
		});

        /* botão para mostrar conteudo da spreadsheet*/
		$("#carregarDados").on("click",function(){
		    getData(eventInfo[2]);
		});
		
        /* botão para registar uma inscrição*/
		$('#enviaDados').submit(function(e) {
			var inputs = $( this ).serializeArray();
	    	var values = [];
	    	values.push(getDateTime());
            var lastQuestion="";
	    	$.each(inputs, function (i, input) {
                if(input.name==lastQuestion){
                    if(values[values.length-1]!="")
                        values[values.length-1]=values[values.length-1]+", "+input.value;
                    else values[values.length-1]=input.value;
                }else {
                    lastQuestion=input.name;
                    values.push(input.value);
                }
	    	});
            //console.log(values);
            sendData(values,eventInfo[2],userEmail);
	    	e.preventDefault();
		});  

        $("#Inscrever").hide();
        $("#verificaEmail").on("click",function(){
            userEmail = $("#inscreverEmailInput").val();
            $.ajax({
                url: scriptLink,
                type: "get",
                dataType: "json",
                data: {
                    funcao: "getFirstInscription",
                    spreadsheet: eventInfo[2],
                    email: userEmail
                }
            }).done(function (firstInscription) {
                console.log(firstInscription);
                $.ajax({
                    url: scriptLink,
                    type: "get",
                    dataType: "json",
                    data: {
                        funcao: "getQuestions",
                        spreadsheet: eventInfo[2]
                    }
                }).done(function (data) {
                    mostrarForm(data);
                    console.log(data);
                    if(firstInscription.length==0){
                        $("#Inscrever").show();
                        $('input[name="p1"]').val(userEmail);
                    }else {
                        $("#Inscrever").val("Atualizar Inscrição");
                        $("#enviaDados").append("<button class=\"btn btn-default\" id=\"cancelar\"> Cancelar Inscrição </button>");
                        $("#Inscrever").show();
                        $("#cancelar").on("click",function (e){
                            e.preventDefault();
                            $.ajax({
                                url: scriptLink,
                                type: "get",
                                dataType: "json",
                                data: {
                                    funcao: "cancelInscription",
                                    spreadsheet: eventInfo[2],
                                    email: userEmail
                                }
                            }).done(function (data){
                                console.log(data);
                                window.location.reload();
                            });
                        });
                        for (var i = 1; i < firstInscription.length; i++) {
                            var pergunta = JSON.parse(data[i]);
                            if(pergunta[1].length==0){
                                $('input[name="p'+i+'"]').val(firstInscription[i]);
                            }else{
                                if(pergunta[2]){//checkbox
                                    var escolhidas = firstInscription[i].split(/, /);
                                    for (var k = 0; k < escolhidas.length; k++) {
                                        $('input[value="'+escolhidas[k]+'"]').prop('checked',true);
                                    };
                                }else{//radio
                                    $('input[value="'+firstInscription[i]+'"]').prop('checked',true);
                                }
                            }
                        }
                    }
                    $("#inscreverEmailDiv").remove();
                });
            });
        });
	});
}

/*----------------------------------------------*//*----------------------------------------------*/

/* nova spreadsheet*/
function createSpreadSheet(name, email){

    /*criar spreadsheet*/
	$.ajax({
        url: scriptLink,
    	type: "get",
    	dataType: "json",
    	data: {
    		funcao: "newSpreadSheet",
    		nome: name,
            editor: email,
            perguntas: JSON.stringify(PERGUNTAS)
    	}
    }).done(function (doc) {
        /* guardar o url da spreadsheet*/
      	$.ajax({
	        url: window.location.href,
	    	type: "get",
	    	dataType: "json",
	    	data: {accao:"saveDocsID", docsID:doc}
	    }).done(function (data) {
	    	window.location.reload();
	    });
    });
}

/*----------------------------------------------*//*----------------------------------------------*/

/*obter conteudo da spreadsheet*/
function getData(docID){
	$.ajax({
        url: scriptLink,
    	type: "get",
    	dataType: "json",
    	data: {
    		funcao: "getData",
    		spreadsheet: docID
    	}
    }).done(function (data) {
      	$("#spreadsheet").html("");
      	var table = "<table class=\"table\">";
      	for (var i = 0; i < data.length; i++) {
      		table+="<tr>";
      		for (var k = 0; k < data[i].length; k++) {
      			table+="<td>"+data[i][k]+"</td>";
      		};
      		table+="</tr>";
      	};
      	table+="</table";
      	$("#spreadsheet").append(table);
    });
}

/*----------------------------------------------*//*----------------------------------------------*/

/*inserir dados da inscrição*/
function sendData(values,docID, user_email){
	$.ajax({
        url: scriptLink,
    	type: "get",
    	crossDomain: true,
    	dataType: 'jsonp',
    	data: {
    		funcao: "sendData",
    		dados: JSON.stringify(values),
    		spreadsheet: docID, 
            email:user_email
    	}
    });
    window.alert("Inscrição submetida");
    window.location.replace("/");
}

/*----------------------------------------------*//*----------------------------------------------*/

/*calcular dada e hora atual*/
function getDateTime() {
    var now     = new Date(); 
    var year    = now.getFullYear();
    var month   = now.getMonth()+1; 
    var day     = now.getDate();
    var hour    = now.getHours();
    var minute  = now.getMinutes();
    var second  = now.getSeconds(); 
    if(month.toString().length == 1) {
        var month = '0'+month;
    }
    if(day.toString().length == 1) {
        var day = '0'+day;
    }   
    if(hour.toString().length == 1) {
        var hour = '0'+hour;
    }
    if(minute.toString().length == 1) {
        var minute = '0'+minute;
    }
    if(second.toString().length == 1) {
        var second = '0'+second;
    }   
    var dateTime = year+'/'+month+'/'+day+' '+hour+':'+minute+':'+second;   
     return dateTime;
}

/*----------------------------------------------*//*----------------------------------------------*/

/* cenas para criar e mostrar o formulário personalizado*/
function criarForm () {

    $( "#info" ).mouseenter( function(){$("#infoP").show();} ).mouseleave( function(){$("#infoP").fadeOut()} );

    $("#multiplaDiv").hide();
    $("#tipoPergunta").val("normal");

    $("#tipoPergunta").on("change",function(){
        clearInputs();

        if(this.value=="normal"){
            $("#multiplaDiv").hide();
            $("#normalDiv").show();
        }else {
            $("#multiplaDiv").show();
            $("#normalDiv").hide();
        }
    });

    $("#adicionar").on("click",function(){
        var opcao = $("#tipoPergunta").val();
        var opcaoName = [];
        numQuestion++;
        
        if(opcao=="normal"){
            $("#preview").append("<div class=\"form-group\">"
                                    +"<label for=\"\">"+numQuestion+". "+$("#perguntaNormal").val()+"</label>"
                                    +"   <input name=\"\" type=\"text\" class=\"form-control\" >"
                                    +"</div>");
            PERGUNTAS.push(JSON.stringify([$("#perguntaNormal").val(),[]]));
        }else if (opcao=="multipla"){
            var opcoes = "";
            if($("#variasRespostas").is(':checked')){
                opcoes+="<div class=\"checkbox\">";
                for (var i = 1; i <= numOpcao; i++) {
                    opcaoName.push($("#opcao"+i).val());
                    opcoes+="<label><input type=\"checkbox\" value=\"\">";
                    opcoes+= $("#opcao"+i).val();
                    opcoes+="</label><br>";
                };
                opcoes+="</div>";
            }else {
                opcoes+="<div class=\"radio\">";
                for (var i = 1; i <= numOpcao; i++) {
                    opcaoName.push($("#opcao"+i).val());
                    opcoes+="<label><input type=\"radio\" value=\"\" checked name=\"optionsRadios"+numQuestion+"\">";
                    opcoes+= $("#opcao"+i).val();
                    opcoes+="</label><br>";
                };
                opcoes+="</div>";
            }

            $("#preview").append("<div class=\"form-group\">"
                                    +"<label for=\"\">"+numQuestion+". "+$("#perguntaMultipla").val()+"</label>"
                                    +opcoes
                                    +"</div>");
            PERGUNTAS.push(JSON.stringify([$("#perguntaMultipla").val(),opcaoName,$("#variasRespostas").is(':checked')]));
        }
        clearInputs();
        $("#adicionar").get(0).scrollIntoView();
    });

    $("#adicionarOpcao").on("click",function(){
        numOpcao++;
        $("#novasOpcoes").append("<div><label for=\"\">Opcão "+numOpcao+"</label>"
              +"<input type=\"text\" class=\"form-control\" id=\"opcao"+numOpcao+"\"></div>");
    });
    
    $("#removerOpcao").on("click",function(){
        if(numOpcao>2){
            numOpcao--;
            $("#novasOpcoes").children().last().remove();
        }
    });

    $("#remover").on("click",function(){
        if(numQuestion>1){
            numQuestion--;
            $("#preview").children().last().remove();
            PERGUNTAS.pop();
        }
    });
}

/*----------------------------------------------*//*----------------------------------------------*/

/*funcao auxiliar para limpar texto introduzido*/
function clearInputs(){
    numOpcao=2;
    $("#novasOpcoes").html("");
    $("#perguntaNormal").val("");
    $("#perguntaMultipla").val("");
    $("#opcao1").val("");
    $("#opcao2").val("");
}

/*----------------------------------------------*//*----------------------------------------------*/

/* mostra o formulário para fazer uma inscrição*/
function mostrarForm(perguntas){
    numQuestion=0;
    for (var i = 1; i < perguntas.length; i++) {
        var pergunta = JSON.parse(perguntas[i]);
        numQuestion++;
        if(pergunta[1].length>0){
            var html = [];
            if(pergunta[2]){//checkbox
                html+="<div class=\"checkbox\">";
                 html+="<input name=\"p"+numQuestion+"\" type=\"checkbox\" value=\"\" checked hidden>";
                for (var j = 0; j < pergunta[1].length; j++) {
                    html+="<label><input name=\"p"+numQuestion+"\" type=\"checkbox\" value=\""+pergunta[1][j]+"\">";
                    html+= pergunta[1][j];
                    html+="</label><br>";
                };
                html+="</div>";
            }else {//radio
                html+="<div class=\"radio\">";
                for (var j = 0; j < pergunta[1].length; j++) {
                    html+="<label><input type=\"radio\" value=\""+pergunta[1][j]+"\" checked name=\"p"+numQuestion+"\">";
                    html+= pergunta[1][j];
                    html+="</label><br>";
                };
                html+="</div>";
            }
            $("#enviaDados").children().first().append("<div class=\"form-group\">"
                                    +"<label for=\"\">"+numQuestion+". "+pergunta[0]+"</label>"
                                    +"</div>");
            $("#enviaDados").children().first().append(html);
        }else {// pergunta normal
            $("#enviaDados").children().first().append("<div class=\"form-group\">"
                                    +"<label for=\"\">"+numQuestion+". "+pergunta[0]+"</label>"
                                    +"   <input name=\"p"+numQuestion+"\" type=\"text\" class=\"form-control\" >"
                                    +"</div>");
        }
    };
}

/*----------------------------------------------*//*----------------------------------------------*/

$(start);