$(document).ready(function(){

	$(".star").click(function(e){
		var task_id = $(this).parent("span").attr('id');
		var priority_value = $(this).data('label')
		$.ajax({
			type: "POST",
			url: "/task/priority",
			data: {"id" : task_id, "priority_value" : priority_value}
		}).done(function(data){
			//alert("id: #priority"+priority_value+"_"+task_id+"");
			if(data=""){
				alert("An error is preventing you from setting priorities")
			} else {
				//alert($("input[id=priority"+priority_value+"_"+task_id+"]").value);
			}
		});
	});

});
