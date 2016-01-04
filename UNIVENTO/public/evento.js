var index=1;
function setup(){

    $('select').on('change', function() {
      $("input[name=\"tags[]\"").prop("checked",false);
      $(".cat_options").hide();
      $("#catID_"+this.value).show();
    });

    if($("#eventCategory").length ){
    	$("#category").val($("#eventCategory").val());
    	$("#category").trigger("change");
    	var tags = JSON.parse($("#eventTags").val());
    	$.each(tags, function(key, value){
			$("input[value=\""+value+"\"]").prop("checked",true);
    	});
    }

	setDateTimePicker();
	index = $('.clonedInput').length;

  	$("#btnAdd").on("click",function(){
  		if(index < 8){
	  		$(this).before('<div id="entry'+index+'" class="clonedInput">'
								+ '<h2 id="reference" name="reference" class="heading-reference">'+(index+1)+'º Dia</h2>'
								+ '<fieldset>'
								+  '<div class="row">'
								+     '<div class="col-md-5 column">'
								+       '<div class="form-group">'
								+         '<label class="label_fn control-label" for="data_fim">Data de início</label>'
								+         '<div class="input-group date" id="">'
								+           '<input class="form-control" name="dates['+index+'][startDate]" type="text">'
								+           '<span class="input-group-addon">'
								+             '<span class="glyphicon glyphicon-calendar"></span>'
								+           '</span>'
								+         '</div>'
								+       '</div>'
								+     '</div>'
								+     '<div class="col-md-5 column">'
								+       '<div class="form-group">'
								+         '<label class="label_fn control-label" for="data_fim">Data de fim</label>'
								+         '<div class="input-group date" id="">'
								+           '<input class="form-control" name="dates['+index+'][endDate]" type="text">'
								+           '<span class="input-group-addon">'
								+             '<span class="glyphicon glyphicon-calendar"></span>'
								+           '</span>'
								+         '</div>'
								+       '</div>'
								+     '</div>'
								+   '</div>'
								+   '<div class="row">'
								+     '<div class="col-md-2 column">'
								+       '<div class="form-group">'
								+        '<label class="label_fn control-label" for="event_price">Preço</label>'
								+'<br>'
								+        '<input name="price[]" id="price_" step="0.01" min="0" max="999" type="number"><br>'
								+      '</div>'
								+    '</div>'
								+  '</div>'
								+  '<div class="row">'
								+   '<div class="col-md-10 column">'
								+     '<div class="form-group">'
								+      '<label class="label_fn control-label" for="event_local">Local</label>'
								+      '<fieldset class="gllpLatlonPicker" id="map'+index+'">'
								+      ' <input name="dates['+index+'][address]" value="Porto" class="gllpSearchField form-control" type="text">'
								+       '<input class="gllpSearchButton btn btn-default" value="search" type="button">'
								+       '<div style="position: relative; background-color: rgb(229, 227, 223); overflow: hidden;" class="gllpMap"><div class="gm-style" style="position: absolute; left: 0px; top: 0px; overflow: hidden; width: 100%; height: 100%; z-index: 0;"><div style="position: absolute; left: 0px; top: 0px; overflow: hidden; width: 100%; height: 100%; z-index: 0; cursor: url(&quot;http://maps.gstatic.com/mapfiles/openhand_8_8.cur&quot;), default;"><div style="position: absolute; left: 0px; top: 0px; z-index: 1; width: 100%;"><div style="position: absolute; left: 0px; top: 0px; z-index: 100; width: 100%;"><div style="position: absolute; left: 0px; top: 0px; z-index: 0;"><div aria-hidden="true" style="position: absolute; left: 0px; top: 0px; z-index: 1; visibility: inherit;"><div style="width: 256px; height: 256px; position: absolute; left: 40px; top: -211px;"></div><div style="width: 256px; height: 256px; position: absolute; left: 40px; top: 45px;"></div><div style="width: 256px; height: 256px; position: absolute; left: -216px; top: -211px;"></div><div style="width: 256px; height: 256px; position: absolute; left: -216px; top: 45px;"></div><div style="width: 256px; height: 256px; position: absolute; left: 296px; top: -211px;"></div><div style="width: 256px; height: 256px; position: absolute; left: 296px; top: 45px;"></div></div></div></div><div style="position: absolute; left: 0px; top: 0px; z-index: 101; width: 100%;"></div><div style="position: absolute; left: 0px; top: 0px; z-index: 102; width: 100%;"></div><div style="position: absolute; left: 0px; top: 0px; z-index: 103; width: 100%;"><div style="position: absolute; left: 0px; top: 0px; z-index: -1;"><div aria-hidden="true" style="position: absolute; left: 0px; top: 0px; z-index: 1; visibility: inherit;"><div style="width: 256px; height: 256px; overflow: hidden; position: absolute; left: 40px; top: -211px;"></div><div style="width: 256px; height: 256px; overflow: hidden; position: absolute; left: 40px; top: 45px;"></div><div style="width: 256px; height: 256px; overflow: hidden; position: absolute; left: -216px; top: -211px;"></div><div style="width: 256px; height: 256px; overflow: hidden; position: absolute; left: -216px; top: 45px;"></div><div style="width: 256px; height: 256px; overflow: hidden; position: absolute; left: 296px; top: -211px;"></div><div style="width: 256px; height: 256px; overflow: hidden; position: absolute; left: 296px; top: 45px;"></div></div></div><div style="width: 22px; height: 40px; overflow: hidden; position: absolute; left: 239px; top: 85px; z-index: 125;"><img draggable="false" src="http://maps.gstatic.com/mapfiles/api-3/images/spotlight-poi.png" style="position: absolute; left: 0px; top: 0px; width: 22px; height: 40px; -moz-user-select: none; border: 0px none; padding: 0px; margin: 0px; max-width: none;"></div></div><div style="position: absolute; z-index: 0; left: 0px; top: 0px;"><div style="overflow: hidden; width: 500px; height: 250px;"><img src="http://maps.googleapis.com/maps/api/js/StaticMapService.GetMapImage?1m2&amp;1i498904&amp;2i392403&amp;2e1&amp;3u12&amp;4m2&amp;1u500&amp;2u250&amp;5m5&amp;1e0&amp;5spt-PT&amp;6sus&amp;10b1&amp;12b1&amp;token=45153" style="width: 500px; height: 250px;"></div></div><div style="position: absolute; left: 0px; top: 0px; z-index: 0;"><div aria-hidden="true" style="position: absolute; left: 0px; top: 0px; z-index: 1; visibility: inherit;"><div style="position: absolute; left: 40px; top: -211px; transition: opacity 200ms ease-out 0s;"><img alt="" draggable="false" src="http://mt1.googleapis.com/maps/vt?pb=!1m5!1m4!1i12!2i1949!3i1532!4i256!2m3!1e0!2sm!3i330336060!3m9!2spt-PT!3sUS!5e18!12m1!1e47!12m3!1e37!2m1!1ssmartmaps!4e0" style="position: absolute; left: 0px; top: 0px; width: 256px; height: 256px; -moz-user-select: none; border: 0px none; padding: 0px; margin: 0px; max-width: none;"></div><div style="position: absolute; left: 40px; top: 45px; transition: opacity 200ms ease-out 0s;"><img alt="" draggable="false" src="http://mt1.googleapis.com/maps/vt?pb=!1m5!1m4!1i12!2i1949!3i1533!4i256!2m3!1e0!2sm!3i330336060!3m9!2spt-PT!3sUS!5e18!12m1!1e47!12m3!1e37!2m1!1ssmartmaps!4e0" style="position: absolute; left: 0px; top: 0px; width: 256px; height: 256px; -moz-user-select: none; border: 0px none; padding: 0px; margin: 0px; max-width: none;"></div><div style="position: absolute; left: -216px; top: -211px; transition: opacity 200ms ease-out 0s;"><img alt="" draggable="false" src="http://mt0.googleapis.com/maps/vt?pb=!1m5!1m4!1i12!2i1948!3i1532!4i256!2m3!1e0!2sm!3i330336060!3m9!2spt-PT!3sUS!5e18!12m1!1e47!12m3!1e37!2m1!1ssmartmaps!4e0" style="position: absolute; left: 0px; top: 0px; width: 256px; height: 256px; -moz-user-select: none; border: 0px none; padding: 0px; margin: 0px; max-width: none;"></div><div style="position: absolute; left: -216px; top: 45px; transition: opacity 200ms ease-out 0s;"><img alt="" draggable="false" src="http://mt0.googleapis.com/maps/vt?pb=!1m5!1m4!1i12!2i1948!3i1533!4i256!2m3!1e0!2sm!3i330336060!3m9!2spt-PT!3sUS!5e18!12m1!1e47!12m3!1e37!2m1!1ssmartmaps!4e0" style="position: absolute; left: 0px; top: 0px; width: 256px; height: 256px; -moz-user-select: none; border: 0px none; padding: 0px; margin: 0px; max-width: none;"></div><div style="position: absolute; left: 296px; top: -211px; transition: opacity 200ms ease-out 0s;"><img alt="" draggable="false" src="http://mt0.googleapis.com/maps/vt?pb=!1m5!1m4!1i12!2i1950!3i1532!4i256!2m3!1e0!2sm!3i330343974!3m9!2spt-PT!3sUS!5e18!12m1!1e47!12m3!1e37!2m1!1ssmartmaps!4e0" style="position: absolute; left: 0px; top: 0px; width: 256px; height: 256px; -moz-user-select: none; border: 0px none; padding: 0px; margin: 0px; max-width: none;"></div><div style="position: absolute; left: 296px; top: 45px; transition: opacity 200ms ease-out 0s;"><img alt="" draggable="false" src="http://mt0.googleapis.com/maps/vt?pb=!1m5!1m4!1i12!2i1950!3i1533!4i256!2m3!1e0!2sm!3i330343974!3m9!2spt-PT!3sUS!5e18!12m1!1e47!12m3!1e37!2m1!1ssmartmaps!4e0" style="position: absolute; left: 0px; top: 0px; width: 256px; height: 256px; -moz-user-select: none; border: 0px none; padding: 0px; margin: 0px; max-width: none;"></div></div></div></div><div style="position: absolute; left: 0px; top: 0px; z-index: 2; width: 100%; height: 100%;"></div><div style="position: absolute; left: 0px; top: 0px; z-index: 3; width: 100%;"><div style="position: absolute; left: 0px; top: 0px; z-index: 104; width: 100%;"></div><div style="position: absolute; left: 0px; top: 0px; z-index: 105; width: 100%;"></div><div style="position: absolute; left: 0px; top: 0px; z-index: 106; width: 100%;"><div class="gmnoprint" style="width: 22px; height: 40px; overflow: hidden; position: absolute; opacity: 0.01; left: 239px; top: 85px; z-index: 125;"><img usemap="#gmimap0" draggable="false" src="http://maps.gstatic.com/mapfiles/api-3/images/spotlight-poi.png" style="position: absolute; left: 0px; top: 0px; width: 22px; height: 40px; -moz-user-select: none; border: 0px none; padding: 0px; margin: 0px; max-width: none;"><map id="gmimap0" name="gmimap0"><area style="cursor: pointer;" title="Drag this Marker" shape="poly" coords="8,0,5,1,4,2,3,3,2,4,2,5,1,6,1,7,0,8,0,14,1,15,1,16,2,17,2,18,3,19,3,20,4,21,5,22,5,23,6,24,7,25,7,27,8,28,8,29,9,30,9,33,10,34,10,40,11,40,11,34,12,33,12,30,13,29,13,28,14,27,14,25,15,24,16,23,16,22,17,21,18,20,18,19,19,18,19,17,20,16,20,15,21,14,21,8,20,7,20,6,19,5,19,4,18,3,17,2,16,1,14,1,13,0,8,0" log="miw"></map></div></div><div style="position: absolute; left: 0px; top: 0px; z-index: 107; width: 100%;"></div></div></div><div style="background-color: white; padding: 15px 21px; border: 1px solid rgb(171, 171, 171); font-family: Roboto,Arial,sans-serif; color: rgb(34, 34, 34); box-shadow: 0px 4px 16px rgba(0, 0, 0, 0.2); z-index: 10000002; display: none; width: 256px; height: 148px; position: absolute; left: 100px; top: 35px;"><div style="padding: 0px 0px 10px; font-size: 16px;">Dados do mapa</div><div style="font-size: 13px;">Dados do mapa ©2015 Google</div><div style="width: 13px; height: 13px; overflow: hidden; position: absolute; opacity: 0.7; right: 12px; top: 12px; z-index: 10000; cursor: pointer;"><img draggable="false" src="http://maps.gstatic.com/mapfiles/api-3/images/mapcnt6.png" style="position: absolute; left: -2px; top: -336px; width: 59px; height: 492px; -moz-user-select: none; border: 0px none; padding: 0px; margin: 0px; max-width: none;"></div></div><div style="z-index: 1000001; position: absolute; right: 240px; bottom: 0px; width: 150px;" class="gmnoprint"><div class="gm-style-cc" style="-moz-user-select: none; height: 14px; line-height: 14px;" draggable="false"><div style="opacity: 0.7; width: 100%; height: 100%; position: absolute;"><div style="width: 1px;"></div><div style="background-color: rgb(245, 245, 245); width: auto; height: 100%; margin-left: 1px;"></div></div><div style="position: relative; padding-right: 6px; padding-left: 6px; font-family: Roboto,Arial,sans-serif; font-size: 10px; color: rgb(68, 68, 68); white-space: nowrap; direction: ltr; text-align: right; vertical-align: middle; display: inline-block;"><a style="color: rgb(68, 68, 68); text-decoration: none; cursor: pointer; display: none;">Dados do mapa</a><span style="">Dados do mapa ©2015 Google</span></div></div></div><div style="position: absolute; right: 0px; bottom: 0px;" class="gmnoscreen"><div style="font-family: Roboto,Arial,sans-serif; font-size: 11px; color: rgb(68, 68, 68); direction: ltr; text-align: right; background-color: rgb(245, 245, 245);">Dados do mapa ©2015 Google</div></div><div draggable="false" style="z-index: 1000001; -moz-user-select: none; height: 14px; line-height: 14px; position: absolute; right: 138px; bottom: 0px;" class="gmnoprint gm-style-cc"><div style="opacity: 0.7; width: 100%; height: 100%; position: absolute;"><div style="width: 1px;"></div><div style="background-color: rgb(245, 245, 245); width: auto; height: 100%; margin-left: 1px;"></div></div><div style="position: relative; padding-right: 6px; padding-left: 6px; font-family: Roboto,Arial,sans-serif; font-size: 10px; color: rgb(68, 68, 68); white-space: nowrap; direction: ltr; text-align: right; vertical-align: middle; display: inline-block;"><a target="_blank" href="https://www.google.com/intl/pt-PT_US/help/terms_maps.html" style="text-decoration: none; cursor: pointer; color: rgb(68, 68, 68);">Termos de Utilização</a></div></div><div class="gm-style-cc" style="-moz-user-select: none; height: 14px; line-height: 14px; position: absolute; right: 0px; bottom: 0px;" draggable="false"><div style="opacity: 0.7; width: 100%; height: 100%; position: absolute;"><div style="width: 1px;"></div><div style="background-color: rgb(245, 245, 245); width: auto; height: 100%; margin-left: 1px;"></div></div><div style="position: relative; padding-right: 6px; padding-left: 6px; font-family: Roboto,Arial,sans-serif; font-size: 10px; color: rgb(68, 68, 68); white-space: nowrap; direction: ltr; text-align: right; vertical-align: middle; display: inline-block;"><a href="https://www.google.com/maps/@41.1579438,-8.6291053,12z/data=!10m1!1e1!12b1?source=apiv3&amp;rapsrc=apiv3" style="font-family: Roboto,Arial,sans-serif; font-size: 10px; color: rgb(68, 68, 68); text-decoration: none; position: relative;" title="Comunicar à Google erros nas imagens ou no mapa de estradas" target="_new">Comunicar um erro no mapa</a></div></div><div controlheight="55" controlwidth="28" draggable="false" style="margin: 10px; -moz-user-select: none; position: absolute; bottom: 69px; right: 28px;" class="gmnoprint"><div controlheight="55" controlwidth="28" style="position: absolute; left: 0px; top: 0px;" class="gmnoprint"><div style="-moz-user-select: none; box-shadow: 0px 1px 4px -1px rgba(0, 0, 0, 0.3); border-radius: 2px; cursor: pointer; background-color: rgb(255, 255, 255); width: 28px; height: 55px;" draggable="false"><div style="position: relative; width: 28px; height: 27px; left: 0px; top: 0px;" title="Ampliar"><div style="overflow: hidden; position: absolute; width: 15px; height: 15px; left: 7px; top: 6px;"><img draggable="false" src="http://maps.gstatic.com/mapfiles/api-3/images/tmapctrl.png" style="position: absolute; left: 0px; top: 0px; -moz-user-select: none; border: 0px none; padding: 0px; margin: 0px; max-width: none; width: 120px; height: 54px;"></div></div><div style="position: relative; overflow: hidden; width: 67%; height: 1px; left: 16%; background-color: rgb(230, 230, 230); top: 0px;"></div><div style="position: relative; width: 28px; height: 27px; left: 0px; top: 0px;" title="Reduzir"><div style="overflow: hidden; position: absolute; width: 15px; height: 15px; left: 7px; top: 6px;"><img draggable="false" src="http://maps.gstatic.com/mapfiles/api-3/images/tmapctrl.png" style="position: absolute; left: 0px; top: -15px; -moz-user-select: none; border: 0px none; padding: 0px; margin: 0px; max-width: none; width: 120px; height: 54px;"></div></div></div></div><div style="display: none; position: absolute;" controlheight="0" controlwidth="28" class="gmnoprint"><div title="Rodar mapa 90 graus" style="width: 28px; height: 28px; overflow: hidden; position: absolute; border-radius: 2px; box-shadow: 0px 1px 4px -1px rgba(0, 0, 0, 0.3); cursor: pointer; background-color: rgb(255, 255, 255); display: none;"><img draggable="false" src="http://maps.gstatic.com/mapfiles/api-3/images/tmapctrl4.png" style="position: absolute; left: -141px; top: 6px; width: 170px; height: 54px; -moz-user-select: none; border: 0px none; padding: 0px; margin: 0px; max-width: none;"></div><div class="gm-tilt" style="width: 28px; height: 28px; overflow: hidden; position: absolute; border-radius: 2px; box-shadow: 0px 1px 4px -1px rgba(0, 0, 0, 0.3); top: 0px; cursor: pointer; background-color: rgb(255, 255, 255);"><img draggable="false" src="http://maps.gstatic.com/mapfiles/api-3/images/tmapctrl4.png" style="position: absolute; left: -141px; top: -13px; width: 170px; height: 54px; -moz-user-select: none; border: 0px none; padding: 0px; margin: 0px; max-width: none;"></div></div></div><div style="margin-left: 5px; margin-right: 5px; z-index: 1000000; position: absolute; left: 0px; bottom: 0px;"><a title="Clique para ver esta área no Google Maps" href="https://maps.google.com/maps?ll=41.157944,-8.629105&amp;z=12&amp;t=m&amp;hl=pt-PT&amp;gl=US&amp;mapclient=apiv3" target="_blank" style="position: static; overflow: visible; float: none; display: inline;"><div style="width: 66px; height: 26px; cursor: pointer;"><img draggable="false" src="http://maps.gstatic.com/mapfiles/api-3/images/google4.png" style="position: absolute; left: 0px; top: 0px; width: 66px; height: 26px; -moz-user-select: none; border: 0px none; padding: 0px; margin: 0px;"></div></a></div></div></div>'
								+       '<input name="dates['+index+'][latitude]" class="gllpLatitude" value="41.1579438" type="hidden">'
								+       '<input name="dates['+index+'][longitude]" class="gllpLongitude" value="-8.629105299999992" type="hidden">'
								+       '<input class="gllpZoom" value="12" type="hidden">'
								+     '</fieldset> '
								+   '</div>'
								+ '</div>'
								+'</div>'
								+'<div class="row">'
								+ '<div class="col-md-10 column">'
								+   '<label class="label_fn control-label" for="event_local">Insira uma descrição detalhada</label>'
								+   '<textarea style="visibility: hidden; display: none;" cols="40" name="page[info'+index+']" id="page_info'+index+'"></textarea>'
								+'</script>'
								+ '</div>'
								+'</div>'
								+'</fieldset></div>'
	  		);

	  		setDateTimePicker();
	  		$.getScript("/jquery-gmaps-latlon-picker.js");
			$( '#page_info'+index ).ckeditor({
			    uiColor: '#ffffff',
			    toolbar: 'mini'
			});

	  		index++;
	  		$('#btnDel').attr('disabled', false);
  		} else {
  			$('#btnAdd').attr('disabled', true).prop('value', "You've reached the limit");
  		}
  	});

	$('#btnDel').click(function () {
        if (confirm("Tem a certeza que pretende apagar este dia? Não pode voltar atrás.")){
        	index--;
        	$("#entry"+index).remove();
            $('#btnAdd').attr('disabled', false).prop('value', "add section");
            if(index<2){
				$('#btnDel').attr('disabled', true);
            }  
        }
        return false;
    });

	$('#btnAdd').attr('disabled', !(index < 8));

   	$('#btnDel').attr('disabled', (index < 2));

    

}

function setDateTimePicker(){
	$(function () {
	    $('.date').datetimepicker({
	        format : 'DD/MM/YYYY HH:mm'
	    });
  	});
}
$(setup);