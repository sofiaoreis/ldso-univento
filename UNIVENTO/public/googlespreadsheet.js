var scriptLink = "https://script.google.com/macros/s/AKfycbxpb6ghoFH5Hyllkaq6DbmEepHU-nizHO6ukrOcJgLX4BRCAmM/exec";
var PERGUNTAS = ['Carimbo de data/hora'];

function start(){
    criarForm();
	$.ajax({
	    url: window.location.href,
	  	type: "get",
	   	dataType: "json",
	   	data: {accao:"getEventInfo"}
	}).done(function (eventInfo) {
		if(eventInfo[2]!=null){
			$("#link").append("<a href=\""+eventInfo[2]+"\"> Ver SpreadSheet no google docs </a>");
		}

	   	$("#criarSpreadsheet").submit(function(e){
			e.preventDefault();
            //console.log(JSON.stringify(PERGUNTAS));
		    createSpreadSheet(eventInfo[1]+"_"+eventInfo[0], $("#gmail").val());
		});

		$("#carregarDados").on("click",function(){
		    getData(eventInfo[2]);
		});
		
		$('#enviaDados').submit(function(e) {
			var inputs = $( this ).serializeArray();
	    	var values = [];
	    	values.push(getDateTime());
            var lastQuestion="";
	    	$.each(inputs, function (i, input) {
                if(input.name==lastQuestion){
                    values[values.length-1]=values[values.length-1]+", "+input.value;
                }else {
                    lastQuestion=input.name;
                    values.push(input.value);
                }
	    	});
            sendData(values,eventInfo[2]);
	    	e.preventDefault();
		});  

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
            });
	});
}

function createSpreadSheet(name, email){
	$.ajax({
        url: scriptLink,
    	type: "get",
    	dataType: "json",
    	data: {
    		funcao: "newSpreadSheet",
    		nome: name,
            editor: email
    	}
    }).done(function (doc) {
      	$.ajax({
	        url: window.location.href,
	    	type: "get",
	    	dataType: "json",
	    	data: {accao:"saveDocsID", docsID:doc}
	    }).done(function (data) {
	    	console.log(data);
	    	sendData(PERGUNTAS,doc);
	    	window.location.reload();
	    });
    });
}

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

function sendData(values,docID){
	$.ajax({
        url: scriptLink,
    	type: "get",
    	crossDomain: true,
    	dataType: 'jsonp',
    	data: {
    		funcao: "sendData",
    		dados: JSON.stringify(values),
    		spreadsheet: docID
    	}
    });
    window.alert("Inscrição submetida");
    window.location.replace("/");
}

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

$(start);


var numQuestion = 0;
var numOpcao = 2;
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
        $("#preview").children().last().remove();
        if(numQuestion>0)
            numQuestion--;
    });
}

function clearInputs(){
    numOpcao=2;
    $("#novasOpcoes").html("");
    $("#perguntaNormal").val("");
    $("#perguntaMultipla").val("");
    $("#opcao1").val("");
    $("#opcao2").val("");
}

function mostrarForm(perguntas){
    /*
    [ "Carimbo de data/hora", "["NORMAL",[]]", "["radio",["1","2"],false]", "["check",["3","4","5"],true]" ]
    */

    numQuestion=0;
    for (var i = 1; i < perguntas.length; i++) {
        var pergunta = JSON.parse(perguntas[i]);
        numQuestion++;
        if(pergunta[1].length>0){
            var html = [];
            if(pergunta[2]){//checkbox
                html+="<div class=\"checkbox\">";
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