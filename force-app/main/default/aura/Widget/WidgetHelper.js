({
	inputCheck : function(component, event) {
		var action = component.get("c.validInput");
		component.set("v.showSave", false);
	
		action.setParams({ inputText : event.getSource().get('v.value')});
		action.setCallback(this, function(response){
			if (response.getState() === "SUCCESS") {
				var boolResult = response.getReturnValue();
				if(boolResult) component.set("v.showSave", true);
			}else{
				console.log('ERROR --- ' + response.getReturnValue());
			}
		});

		window.setTimeout(
			$A.getCallback(function() {
				$A.enqueueAction(action);
			}), 700
	   	);
	},
	save : function(component, event) {
		var action = component.get("c.saveRecord");
		action.setParams({ inputText : component.find("inputText").get("v.value")});
		action.setCallback(this, function(response){
			if (response.getState() === "SUCCESS") {
				var recordName = response.getReturnValue();
				var resultsToast = $A.get("e.force:showToast");
				resultsToast.setParams({
					"type": 'success',  
					"title": 'Success',
					"message": 'The widget ' + recordName + ' has been created.'

				});
				resultsToast.fire();
			}else{
				console.log('ERROR --- ' + response.getReturnValue());
			}
		});
		$A.enqueueAction(action);       
	}
})