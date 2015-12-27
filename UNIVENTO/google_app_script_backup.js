function doGet(e){

  if(e.parameter.funcao == "getData"){
    var sheet = SpreadsheetApp.openByUrl(e.parameter.spreadsheet);
    var data = sheet.getDataRange().getValues();
    return ContentService.createTextOutput(JSON.stringify(data)).setMimeType(ContentService.MimeType.JSON);
  
  }else if(e.parameter.funcao == "sendData"){
    var sheet = SpreadsheetApp.openByUrl(e.parameter.spreadsheet);
    var dados = JSON.parse(e.parameter.dados);
    var data = sheet.getDataRange().getValues();
    var email = e.parameter.email;
    for (var i = 0; i < data.length; i++) {
      if(data[i][1]==email){
        sheet.getActiveSheet().getRange(i+1, 1, 1, data[i].length).setValues([dados]);
        return ContentService.createTextOutput(JSON.stringify('done')).setMimeType(ContentService.MimeType.JSON);
      }
    }
    sheet.appendRow(dados);
    return ContentService.createTextOutput(JSON.stringify('done')).setMimeType(ContentService.MimeType.JSON);
  
  }else if(e.parameter.funcao == "newSpreadSheet"){
    var sheet = SpreadsheetApp.create(e.parameter.nome);
    sheet.addEditor(e.parameter.editor);
    sheet.appendRow(JSON.parse(e.parameter.perguntas));
    return ContentService.createTextOutput(JSON.stringify(sheet.getUrl())).setMimeType(ContentService.MimeType.JSON);
  
  }else if(e.parameter.funcao == "getQuestions"){ 
    var sheet = SpreadsheetApp.openByUrl(e.parameter.spreadsheet);
    var data = sheet.getDataRange().getValues();
    return ContentService.createTextOutput(JSON.stringify(data[0])).setMimeType(ContentService.MimeType.JSON);
  
  }else if(e.parameter.funcao == "getFirstInscription"){ 
    var sheet = SpreadsheetApp.openByUrl(e.parameter.spreadsheet);
    var data = sheet.getDataRange().getValues();
    var email = e.parameter.email;
    for (var i = 0; i < data.length; i++) {
      if(data[i][1]==email){
        return ContentService.createTextOutput(JSON.stringify(data[i])).setMimeType(ContentService.MimeType.JSON);
      }
    }
    return ContentService.createTextOutput(JSON.stringify([])).setMimeType(ContentService.MimeType.JSON);
  
  }else if(e.parameter.funcao == "cancelInscription"){ 
    var sheet = SpreadsheetApp.openByUrl(e.parameter.spreadsheet);
    var data = sheet.getDataRange().getValues();
    var email = e.parameter.email;
    for (var i = 0; i < data.length; i++) {
      if(data[i][1]==email){
        sheet.deleteRow(i+1);
        return ContentService.createTextOutput(JSON.stringify(true)).setMimeType(ContentService.MimeType.JSON);
      }
    }
    return ContentService.createTextOutput(JSON.stringify(false)).setMimeType(ContentService.MimeType.JSON);
  }
}