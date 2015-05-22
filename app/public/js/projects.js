$(document).ready(function(){


/*
	Class: Projects
	Description: The done click and sidebar populate functions for sidebar: 
*/

	$(".project_done").click(function(e){
		var task_id = $(this).parents('li').attr('id');
		$.ajax({
			type: "POST",
			url: "/project/done",
			data: {id: task_id}
		}).done(function(data){
			if(data.status == 'done'){
				$("#" + data.id + ".done").html('<i class="fa fa-check-square-o fa-2x"></i>');
				//$("#" + data.id + ".task").wrapInner("<del>");
			}
			else {
				$("#" + data.id + ".done").html('<i class="fa fa-square-o fa-2x"></i>');
				//$("#" + data.id + ".task").html(function(i, h){
				//	return h.replace("<del>", ""); });
			}
		});
		e.preventDefault();
	});


	populateSideBar();
	function populateSideBar(){
		$.ajax({
			type: "GET",
			url: "/project/track_data",
			data: {"_action" : "Tasks"}
		}).done(function(data) {
			if(data.length != 0){
				$("#sidebar_items").html(data)
			} else {
				$("#sidebar_items").html("No task to display yet. <p><a href=\"/project/new\">Create new task</a>")
			}

		});
	};
});
