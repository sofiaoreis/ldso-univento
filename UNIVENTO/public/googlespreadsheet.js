var scriptLink = "https://script.google.com/macros/s/AKfycbxpb6ghoFH5Hyllkaq6DbmEepHU-nizHO6ukrOcJgLX4BRCAmM/exec";
function start(){

	$("#criarSpreadsheet").submit(function(e){
		var inputs = $( this ).serializeArray();
		createSpreadSheet(inputs[1].value+"_"+inputs[0].value);
		e.preventDefault();
	});
	$("#carregarDados").on("click",getData);
	
	$('#enviaDados').submit(function(e) {
		var inputs = $( this ).serializeArray();
    	var values = [];
    	values.push(getDateTime());
    	$.each(inputs, function (i, input) {
    		values.push(input.value);
    	});
    	sendData(values);
    	e.preventDefault();
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
    }).done(function (data) {
      	console.log(data);
      	window.alert(data);
      	$("#novaSpreadsheet").append("<p>Link spreadsheet criada: <a href=\""+data+"\" >NOVA </a></p>");
    });
}

function getData(){
	$.ajax({
        url: scriptLink,
    	type: "get",
    	dataType: "json",
    	data: {
    		funcao: "getData",
    		spreadsheet: "https://docs.google.com/spreadsheets/d/1E6aAOkT-OU2R7MAN0T7v7EBZKuHvQMHYQIUdCDYIZgA/edit#gid=2062161593"
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

function sendData(values){
	$.ajax({
        url: scriptLink,
    	type: "get",
    	crossDomain: true,
    	dataType: 'jsonp',
    	data: {
    		funcao: "sendData",
    		dados: JSON.stringify(values),
    		spreadsheet: "https://docs.google.com/spreadsheets/d/1E6aAOkT-OU2R7MAN0T7v7EBZKuHvQMHYQIUdCDYIZgA/edit#gid=2062161593"
    	}
    });
    window.alert("Inscrição submetida");
    getData();
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