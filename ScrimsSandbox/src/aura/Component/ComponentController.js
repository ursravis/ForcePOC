({
	doneRendering : function(component, event, helper) {
		var articles =  document.getElementsByTagName("ARTICLE");
        for(i=0;i<articles.length;i++){
           articles[i].style.background="#FFFFFF";
        }
    }
})