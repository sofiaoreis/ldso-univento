function start(){

   $.ajax({
        url: "https://script.google.com/macros/s/AKfycbxpb6ghoFH5Hyllkaq6DbmEepHU-nizHO6ukrOcJgLX4BRCAmM/exec",
    	type: "get",
    	dataType: "json",
    	data: {nome: "nomeEnviado"}
    }).done(function (data) {
      	console.log(data);
    });
}


$(start);