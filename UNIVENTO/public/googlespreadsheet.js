var scriptLink = "https://script.google.com/macros/s/AKfycbxpb6ghoFH5Hyllkaq6DbmEepHU-nizHO6ukrOcJgLX4BRCAmM/exec";
var PERGUNTAS = ['Carimbo de data/hora' ,'Nome', 'Faculdade', 'e-mail', 'Telefone', 'dias do evento'];
function start(){
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
			/*
				var inputs = $( this ).serializeArray();
				createSpreadSheet(inputs[1].value+"_"+inputs[0].value);
			*/
			e.preventDefault();
		    createSpreadSheet(eventInfo[1]+"_"+eventInfo[0]);
		});
		$("#carregarDados").on("click",function(){
		    getData(eventInfo[2]);
		});
		
		$('#enviaDados').submit(function(e) {
			var inputs = $( this ).serializeArray();
	    	var values = [];
	    	values.push(getDateTime());
	    	$.each(inputs, function (i, input) {
	    		values.push(input.value);
	    	});
	    	sendData(values,eventInfo[2]);
	    	e.preventDefault();
		});  
	});
}

function createSpreadSheet(name){
	$.ajax({
        url: scriptLink,
    	type: "get",
    	dataType: "json",
    	data: {
    		funcao: "newSpreadSheet",
    		nome: name
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
    //getData(docID);
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